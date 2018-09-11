Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428gS86rrzzF36x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 20:02:00 +1000 (AEST)
Date: Tue, 11 Sep 2018 20:01:54 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Don't use compound_order to
 determine host mapping size
Message-ID: <20180911100154.GC25158@fergus>
References: <20180904081601.32703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180904081601.32703-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2018 at 06:16:01PM +1000, Nicholas Piggin wrote:
> THP paths can defer splitting compound pages until after the actual
> remap and TLB flushes to split a huge PMD/PUD. This causes radix
> partition scope page table mappings to get out of synch with the host
> qemu page table mappings.
> 
> This results in random memory corruption in the guest when running
> with THP. The easiest way to reproduce is use KVM baloon to free up
> a lot of memory in the guest and then shrink the balloon to give the
> memory back, while some work is being done in the guest.

I'm hitting the WARN_ON you added.  I think I have an old qemu that
doesn't 2M-align the guest ram and so we get to the level = 0 case
because of misalignment.  The patch below on top of yours seems to
work just fine.  In the case where the pte is 2M or 1G but we have
misalignment, it ORs in address bits from hva into the pte so we get
to the specific single page we want.

Care to fold this in and resend?

Paul.

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index c290f59ae925..933c574e1cf7 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -660,11 +660,14 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		level = 1;
 	} else {
 		level = 0;
-
-		/* Can not cope with unknown page shift */
-		if (shift && shift != PAGE_SHIFT) {
-			WARN_ON_ONCE(1);
-			return -EFAULT;
+		if (shift > PAGE_SHIFT) {
+			/*
+			 * If the pte maps more than one page, bring over
+			 * bits from the virtual address to get the real
+			 * address of the specific single page we want.
+			 */
+			unsigned long rpnmask = (1ul << shift) - PAGE_SIZE;
+			pte = __pte(pte_val(pte) | (hva & rpnmask));
 		}
 	}
 
