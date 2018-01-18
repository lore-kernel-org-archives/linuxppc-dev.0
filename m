Return-Path: <srs0=hufw=en=au1.ibm.com=benh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMRlc0c4HzF0W0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 12:51:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zMRlb3gWlz8tNH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 12:51:55 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zMRlZ55Hxz9t32
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2018 12:51:54 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0I1nA0w128096
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 20:51:52 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fjdqdsqv7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 20:51:52 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 18 Jan 2018 01:51:50 -0000
Subject: Re: [PATCH 3/6] KVM: PPC: Book3S HV: Allow HPT and radix on the
 same core for POWER9 v2.2
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Date: Thu, 18 Jan 2018 12:51:44 +1100
In-Reply-To: <20180118012724.GB22300@fergus.ozlabs.ibm.com>
References: <1516182675-25331-1-git-send-email-paulus@ozlabs.org>
 <1516182675-25331-4-git-send-email-paulus@ozlabs.org>
 <1516187685.31850.190.camel@au1.ibm.com>
 <20180118012724.GB22300@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516240304.31850.202.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-01-18 at 12:27 +1100, Paul Mackerras wrote:
> > You need to check that it's a Nimbus using the top nimble of the bottom
> > 16 bits of PVR. For Cumulus, the fixes are either in 1.0 or 1.1 (to
> > check).
> 
> OK, how about this for the check:
> 
>         if (cpu_has_feature(CPU_FTR_ARCH_300)) {
>                 unsigned int pvr = mfspr(SPRN_PVR);
>                 if ((pvr >> 16) == PVR_POWER9 &&
>                     (((pvr & 0xe000) == 0 && (pvr & 0xfff) < 0x202) ||
>                      ((pvr & 0xe000) == 0x2000 && (pvr & 0xfff) < 0x101)))
>                         no_mixing_hpt_and_radix = true;
>         }
> 
> Paul.

Looks good.

Cheers,
Ben.
