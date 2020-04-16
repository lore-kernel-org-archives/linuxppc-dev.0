Return-Path: <SRS0=XoDJ=6A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E6AC2D0EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 05:06:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE53B2076D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 05:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="CMjVIBuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE53B2076D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492nHw1H8BzDrBc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 15:06:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492nDp6JK8zDr8V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2020 15:03:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=CMjVIBuA; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 492nDp3Rfhz9sSG; Thu, 16 Apr 2020 15:03:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1587013418; bh=ezMMwkByK2qZyRKxM4BFNkkLAWHC+jA69OSNgaQhgbc=;
 h=Date:From:To:Cc:Subject:From;
 b=CMjVIBuASwAcDOMMj7oJiM3jwgXLZge7hHE1uCcAlkF9v6v2mv20mbE8W5cKSaZV9
 ouc+wKbBOOZuAtIhol8gUN6iROYWWiNFtkAILfyEXCJclcYVJ26fyUQMeSz8/8bzjF
 HsrwEbMFAZTjuCI3urNFQTUaWIqBm0t9YZZTWP6LaN4/eAMrstp0pbEU7K9YhCjLez
 nnSAJRdiX5njMqBAvkSHmr/Df3u7eFKEjDwsb3T1AW41iVgiCn9STeyQCdDb1gXT03
 OxLpDiwb8mJPTxc6fMbZnmDuwaa96fKPA2DnLDq4uCINbQiIhP33idhnnwhaq+viwD
 y7KRNUKE4cFXQ==
Date: Thu, 16 Apr 2020 15:03:35 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Handle non-present PTEs in page fault
 functions
Message-ID: <20200416050335.GB10545@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, groug@kaod.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Since cd758a9b57ee "KVM: PPC: Book3S HV: Use __gfn_to_pfn_memslot in HPT
page fault handler", it's been possible in fairly rare circumstances to
load a non-present PTE in kvmppc_book3s_hv_page_fault() when running a
guest on a POWER8 host.

Because that case wasn't checked for, we could misinterpret the non-present
PTE as being a cache-inhibited PTE.  That could mismatch with the
corresponding hash PTE, which would cause the function to fail with -EFAULT
a little further down.  That would propagate up to the KVM_RUN ioctl()
generally causing the KVM userspace (usually qemu) to fall over.

This addresses the problem by catching that case and returning to the guest
instead, letting it fault again, and retrying the whole page fault from
the beginning.

For completeness, this fixes the radix page fault handler in the same
way.  For radix this didn't cause any obvious misbehaviour, because we
ended up putting the non-present PTE into the guest's partition-scoped
page tables, leading immediately to another hypervisor data/instruction
storage interrupt, which would go through the page fault path again
and fix things up.

Fixes: cd758a9b57ee "KVM: PPC: Book3S HV: Use __gfn_to_pfn_memslot in HPT page fault handler"
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1820402
Reported-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
This is a reworked version of the patch David Gibson sent recently,
with the fix applied to the radix case as well. The commit message
is mostly stolen from David's patch.

 arch/powerpc/kvm/book3s_64_mmu_hv.c    | 9 +++++----
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 3aecec8..20b7dce 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -604,18 +604,19 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 */
 	local_irq_disable();
 	ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
+	pte = __pte(0);
+	if (ptep)
+		pte = *ptep;
+	local_irq_enable();
 	/*
 	 * If the PTE disappeared temporarily due to a THP
 	 * collapse, just return and let the guest try again.
 	 */
-	if (!ptep) {
-		local_irq_enable();
+	if (!pte_present(pte)) {
 		if (page)
 			put_page(page);
 		return RESUME_GUEST;
 	}
-	pte = *ptep;
-	local_irq_enable();
 	hpa = pte_pfn(pte) << PAGE_SHIFT;
 	pte_size = PAGE_SIZE;
 	if (shift)
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 134fbc1..7bf94ba 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -815,18 +815,19 @@ int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
 	 */
 	local_irq_disable();
 	ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
+	pte = __pte(0);
+	if (ptep)
+		pte = *ptep;
+	local_irq_enable();
 	/*
 	 * If the PTE disappeared temporarily due to a THP
 	 * collapse, just return and let the guest try again.
 	 */
-	if (!ptep) {
-		local_irq_enable();
+	if (!pte_present(pte)) {
 		if (page)
 			put_page(page);
 		return RESUME_GUEST;
 	}
-	pte = *ptep;
-	local_irq_enable();
 
 	/* If we're logging dirty pages, always map single pages */
 	large_enable = !(memslot->flags & KVM_MEM_LOG_DIRTY_PAGES);
-- 
2.7.4

