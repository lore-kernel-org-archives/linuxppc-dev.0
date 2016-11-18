Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLBgP0JkKzDvyS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 08:57:37 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tLBgN3w5cz9t0q
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2016 08:57:35 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAILrPDW140406
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 16:57:33 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26t4vhcxy8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 16:57:32 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Sat, 19 Nov 2016 07:57:30 +1000
Subject: Re: [PATCH 09/13] KVM: PPC: Book3S HV: Adapt TLB invalidations to
 work on POWER9
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Date: Sat, 19 Nov 2016 08:57:28 +1100
In-Reply-To: <87y40gn941.fsf@linux.vnet.ibm.com>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-10-git-send-email-paulus@ozlabs.org>
 <87y40gn941.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1479506248.27850.18.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-11-18 at 20:11 +0530, Aneesh Kumar K.V wrote:
> > +      * Work out how many sets the TLB has, for the use of
> > +      * the TLB invalidation loop in book3s_hv_rmhandlers.S.
> > +      */
> > +     if (cpu_has_feature(CPU_FTR_ARCH_300))
> > +             kvm->arch.tlb_sets = 256;       /* POWER9 */
> > +     else if (cpu_has_feature(CPU_FTR_ARCH_207S))
> > +             kvm->arch.tlb_sets = 512;       /* POWER8 */
> > +     else
> > +             kvm->arch.tlb_sets = 128;       /* POWER7 */
> > +
> 
> We have 
> 
> #define POWER7_TLB_SETS         128     /* # sets in POWER7 TLB */
> #define POWER8_TLB_SETS         512     /* # sets in POWER8 TLB */
> #define POWER9_TLB_SETS_HASH    256     /* # sets in POWER9 TLB Hash mode */
> #define POWER9_TLB_SETS_RADIX   128     /* # sets in POWER9 TLB Radix mode */
> 
> May be use that instead of opencoding ?

Both are bad and are going to kill us for future backward
compatibility.

These should be a device-tree property. We can fallback to hard wired
values if it doesn't exist but we should at least look for one.

Note: P8 firmwares all have a bug creating a bogus "tlb-sets" property
in the CPU node, so let's create a new one instead, with 2 entries
(hash vs. radix) or 2 new ones, one for hash and one for radix (when
available).

Cheers,
Ben.
