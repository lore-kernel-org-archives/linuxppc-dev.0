Return-Path: <srs0=6oba=4d=au1.ibm.com=alastair@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCzQJ5yyYzDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 11:10:16 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wCzQJ5GmXz8tPS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 11:10:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wCzQJ13w4z9s4s
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 11:10:15 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3R18pgT080703
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 21:10:13 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a2xenbyk8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 21:10:13 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <alastair@au1.ibm.com>;
 Thu, 27 Apr 2017 11:10:10 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3R1A0GO5046564
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 11:10:08 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3R19YUJ025385
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 11:09:34 +1000
Subject: Re: [PATCH] cxl: Prevent IRQ storm
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: andrew.donnellan@au1.ibm.com
Date: Thu, 27 Apr 2017 11:09:11 +1000
In-Reply-To: <2354ad5d-e41f-555e-f129-157444973e1c@linux.vnet.ibm.com>
References: <20170426064053.12009-1-alastair@au1.ibm.com>
 <2354ad5d-e41f-555e-f129-157444973e1c@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1493255351.3426.15.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-26 at 11:23 +0200, Frederic Barrat wrote:
> 
> Le 26/04/2017 à 08:40, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > In some situations, a faulty AFU slice may create an interrupt
> > storm,
> > rendering the machine unusable. Since these interrupts are
> > informational
> > only, present the interrupt once, then mask it off to prevent it
> > from
> > being retriggered until the card is reset.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> 
> Patch looks good, thanks!
> It doesn't apply cleanly on the 'next' tree due to the capi2
> patchset 
> though, so you should probably rebase on that tree. The bits have 
> changed a bit on PSL9, but the approach still works (error type
> reported 
> in the first byte, and the corresponding masking bits are still 
> right-shifted by 32).
> 

Hmm, both you & the documentation say 8 bits, but the code suggests 9:
#define CXL_PSL_SERR_An_afuto	(1ull << (63-0))
#define CXL_PSL_SERR_An_afudis	(1ull << (63-1))
#define CXL_PSL_SERR_An_afuov	(1ull << (63-2))
#define CXL_PSL_SERR_An_badsrc	(1ull << (63-3))
#define CXL_PSL_SERR_An_badctx	(1ull << (63-4))
#define CXL_PSL_SERR_An_llcmdis	(1ull << (63-5))
#define CXL_PSL_SERR_An_llcmdto	(1ull << (63-6))
#define CXL_PSL_SERR_An_afupar	(1ull << (63-7))
#define CXL_PSL_SERR_An_afudup	(1ull << (63-8))

Referenced from irq.c:cxl_afu_decode_psl_serr()

Thoughts?

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
