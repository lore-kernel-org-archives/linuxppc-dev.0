Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVmH54XB8zDqnM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 00:39:13 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rVmH51Pbpz9t0l
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 00:39:13 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5GEY68x140665
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 10:39:11 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kr61fcey-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 10:39:11 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Jun 2016 08:39:09 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>,
 Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
Subject: Re: kernel bug in "Drop WIMG in favour of new constants"?
In-Reply-To: <87wplp8kxh.fsf@skywalker.in.ibm.com>
References: <20160616043340.GB22590@birch.djwong.org>
 <1466054627.5400.5.camel@ellerman.id.au>
 <20160616055746.GC22590@birch.djwong.org>
 <8737oda1lt.fsf@skywalker.in.ibm.com> <87ziql8l93.fsf@skywalker.in.ibm.com>
 <87wplp8kxh.fsf@skywalker.in.ibm.com>
Date: Thu, 16 Jun 2016 20:01:55 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87twgt8ask.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>>
>>> "Darrick J. Wong" <darrick.wong@oracle.com> writes:
>>>
>>>> On Thu, Jun 16, 2016 at 03:23:47PM +1000, Michael Ellerman wrote:
>>>>> On Wed, 2016-06-15 at 21:33 -0700, Darrick J. Wong wrote:
>>>>> 
>>>>> > Hi Aneesh,
>>>>> > 
>>>>> > I noticed when trying out 4.7-rc3 on qemu-2.5 that the kernel no longer
>>>>> > boots.  4.6 booted just fine, so I bisected the kernel to the commit
>>>>> > 30bda41aba4efb2370c97e2cbe7385de93ccc372, which is "powerpc/mm: Drop WIMG in
>>>>> > favour of new constants".  The changelog suggests that the KVM changes need
>>>>> > closer review, and here's an actual crash:
>>>>> > 
>>>>> > (I can send libvirt's machine xml, .config, and full dmesg if that helps.)
>>>>> 
>>>>> Yes please.
>>>>> 
>>>>> I'm successfully booting 4.7-rc's on qemu (2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.1)).
>>>>
>>>> Ok, see attached.  I also sent along the dpkg --status output for qemu
>>>> and qemu-slof; looks like we're running the same Ubuntu packages...
>>>>
>>>> ...my host kernel is 4.6.0 on x64.
>>>
>>> So this is Qemu TCG mode right ? I will try some test and update later.
>>>
>>
>> I am able to reproduce this with
>>
>> qemu-system-ppc64 -kernel vmlinux -machine
>> type=pseries,usb=off -smp 1 -m 1G  -vga none -nographic    -device
>> usb-ehci -device usb-kbd -device usb-mouse
>>
>> Looks like enabling usb device is the issue.
>>
>
> Hmm Qemu  does
>
>         /* Looks like an IO address */
>         /* FIXME: What WIMG combinations could be sensible for IO?
>          * For now we allow WIMG=010x, but are there others? */
>         /* FIXME: Should we check against registered IO addresses? */
>         if ((ptel & (HPTE64_R_W | HPTE64_R_I | HPTE64_R_M)) != HPTE64_R_I) {
>             return H_PARAMETER;
>         }
>


Can you try this patch ?

Ben,

The pHyp part of the comment was added by you in 
3c726f8dee6f55e96475574e9f645327e461884c ([PATCH] ppc64: support 64k
page) really an old commit. I also remember we having the discussion and
concluding that it should be safe to assume that we can always enable
memory coherence. Should we do the below patch of get Qemu fixed up ?
like below

-        if ((ptel & (HPTE64_R_W | HPTE64_R_I | HPTE64_R_M)) != HPTE64_R_I) {
+        wimg_flags = (ptel & (HPTE64_R_W | HPTE64_R_I | HPTE64_R_M));
+
+        if (wimg_flags != HPTE64_R_I && wimg_flags != (HPTE64_R_I | HPTE64_R_M)) {
             return H_PARAMETER;
         }


commit 58f32706f64ee8fe21bbd7d6c211720cedec1292
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Thu Jun 16 19:43:39 2016 +0530

    powerpc/mm/hash: Don't add memory coherence if cache inhibited is set
    
    H_ENTER hcall handling in qemu had assumptions that a cache inhibited
    hpte entry won't have memory conference set. Also older kernel
    mentioned that some version of pHyp required this (look at the comment
    removed by the commit mentioned below).
    
    Fixes: commit 30bda41aba4e("powerpc/mm: Drop WIMG in favour of new constant")
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index fcf676f7f522..89c2791bc510 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -201,9 +201,8 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 	/*
 	 * We can't allow hardware to update hpte bits. Hence always
 	 * set 'R' bit and set 'C' if it is a write fault
-	 * Memory coherence is always enabled
 	 */
-	rflags |=  HPTE_R_R | HPTE_R_M;
+	rflags |=  HPTE_R_R;
 
 	if (pteflags & _PAGE_DIRTY)
 		rflags |= HPTE_R_C;
@@ -216,7 +215,12 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 	if ((pteflags & _PAGE_CACHE_CTL ) == _PAGE_NON_IDEMPOTENT)
 		rflags |= (HPTE_R_I | HPTE_R_G);
 	if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_SAO)
-		rflags |= (HPTE_R_I | HPTE_R_W);
+		rflags |= (HPTE_R_W | HPTE_R_I | HPTE_R_M);
+	/*
+	 * Add memory coherence if cache inhibited is not set
+	 */
+	if (!(rflags & HPTE_R_I))
+		rflags |= HPTE_R_M;
 
 	return rflags;
 }
