Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBA101A029A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 20:22:16 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 02:22:14 -0700
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BD7CB1FF0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 02:10:21 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N9MBBt31129828
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 09:22:11 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N9MBsR001265
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 04:22:11 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 03/18] powerpc/mm: add _PAGE_HASHPTE similar to 4K hash
In-Reply-To: <20160223053847.GA14286@fergus.ozlabs.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160223053847.GA14286@fergus.ozlabs.ibm.com>
Date: Tue, 23 Feb 2016 14:52:07 +0530
Message-ID: <87si0jhjcw.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Tue, Feb 23, 2016 at 10:18:05AM +0530, Aneesh Kumar K.V wrote:
>> The difference between 64K and 4K hash fault handling is confusing
>> with respect to when we set _PAGE_HASHPTE in the linux pte.
>> I was trying to find out whether we miss a hpte flush in any
>> scenario because of this. ie, a pte update on a linux pte, for which we
>> are doing a parallel hash pte insert. After looking at it closer my
>> understanding is this won't happen because pte update also look at
>> _PAGE_BUSY and we will wait for hash pte insert to finish before going
>> ahead with the pte update. But to avoid further confusion keep the
>> hash fault handler for all the page size similar to  __hash_page_4k.
>> 
>> This partially reverts commit 41743a4e34f0 ("powerpc: Free a PTE bit on ppc64 with 64K pages"
>
> In each of the functions you are modifying below, there is already an
> explicit setting of _PAGE_HASHPTE in new_pte.  So I don't think this
> is necessary, or if we do this, we can eliminate the separate setting
> of _PAGE_HASHPTE later on.
>
> In general I think it's better to leave the setting of _PAGE_HASHPTE
> until we know what slot the HPTE is going to go into.  That way we
> have less chance of ending up with _PAGE_HASHPTE set but bogus
> information in _PAGE_F_GIX and _PAGE_F_SECOND.
>

Ok. I will do a variant that remove _PAGE_HASHPTE setting from 4k. ie, 

diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index e3e76b929f33..47d1b26effc6 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -44,7 +44,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		 * a write access. Since this is 4K insert of 64K page size
 		 * also add _PAGE_COMBO
 		 */
-		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE;
+		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
 			new_pte |= _PAGE_DIRTY;
 	} while (old_pte != __cmpxchg_u64((unsigned long *)ptep,
