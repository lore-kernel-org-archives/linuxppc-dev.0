Return-Path: <srs0=3as0=4d=au1.ibm.com=andrew.donnellan@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCzWK1MdLzDqFl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 11:14:37 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wCzWK0prsz8sys
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 11:14:37 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wCzWJ3vfCz9s7f
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 11:14:36 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3R18pVq080708
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 21:14:34 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a2xenc3hr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 21:14:34 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 27 Apr 2017 11:14:31 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3R1ELmt29032656
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 11:14:29 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3R1Du5b002032
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 11:13:56 +1000
Subject: Re: [PATCH] cxl: Prevent IRQ storm
To: "Alastair D'Silva" <alastair@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
References: <20170426064053.12009-1-alastair@au1.ibm.com>
 <2354ad5d-e41f-555e-f129-157444973e1c@linux.vnet.ibm.com>
 <1493255351.3426.15.camel@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 27 Apr 2017 11:13:31 +1000
MIME-Version: 1.0
In-Reply-To: <1493255351.3426.15.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3d029d42-853a-d198-5d8a-01bf49964bbf@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/04/17 11:09, Alastair D'Silva wrote:
>> Patch looks good, thanks!
>> It doesn't apply cleanly on the 'next' tree due to the capi2
>> patchset
>> though, so you should probably rebase on that tree. The bits have
>> changed a bit on PSL9, but the approach still works (error type
>> reported
>> in the first byte, and the corresponding masking bits are still
>> right-shifted by 32).
>>
>
> Hmm, both you & the documentation say 8 bits, but the code suggests 9:
> #define CXL_PSL_SERR_An_afuto	(1ull << (63-0))
> #define CXL_PSL_SERR_An_afudis	(1ull << (63-1))
> #define CXL_PSL_SERR_An_afuov	(1ull << (63-2))
> #define CXL_PSL_SERR_An_badsrc	(1ull << (63-3))
> #define CXL_PSL_SERR_An_badctx	(1ull << (63-4))
> #define CXL_PSL_SERR_An_llcmdis	(1ull << (63-5))
> #define CXL_PSL_SERR_An_llcmdto	(1ull << (63-6))
> #define CXL_PSL_SERR_An_afupar	(1ull << (63-7))
> #define CXL_PSL_SERR_An_afudup	(1ull << (63-8))
>
> Referenced from irq.c:cxl_afu_decode_psl_serr()
>
> Thoughts?

The latest version of the (IBM internal) PSL8 workbook which I happen to 
have at hand lists bit 8 as "Reserved" in the bitfield diagram, but 
lists it as "afudup" in the description underneath, so I think it's safe 
to say it's the first 9 bits.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
