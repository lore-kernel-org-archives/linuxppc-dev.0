Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D660C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 02:38:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE1760FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 02:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AFE1760FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bluescreens.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H5xkt3F8Rz308w
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 12:38:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bluescreens.de (client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=cmr@bluescreens.de;
 receiver=<UNKNOWN>)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H5xkG6rq9z3c6h
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Sep 2021 12:38:14 +1000 (AEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4H5xX35sF5zQkBc;
 Sat, 11 Sep 2021 04:29:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From: "Christopher M. Riedl" <cmr@bluescreens.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 2/4] powerpc: Rework and improve STRICT_KERNEL_RWX patching
Date: Fri, 10 Sep 2021 21:29:02 -0500
Message-Id: <20210911022904.30962-3-cmr@bluescreens.de>
In-Reply-To: <20210911022904.30962-1-cmr@bluescreens.de>
References: <20210911022904.30962-1-cmr@bluescreens.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BDE8826E
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
Cc: linux-hardening@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rework code-patching with STRICT_KERNEL_RWX to prepare for a later patch
which uses a temporary mm for patching under the Book3s64 Radix MMU.
Make improvements by adding a WARN_ON when the patchsite doesn't match
after patching and return the error from __patch_instruction() properly.

Signed-off-by: Christopher M. Riedl <cmr@bluescreens.de>

---

v6:  * Remove the pr_warn() message from unmap_patch_area().

v5:  * New to series.
---
 arch/powerpc/lib/code-patching.c | 35 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 8d61a7d35b89..8d0bb86125d5 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -102,6 +102,7 @@ static inline void stop_using_temporary_mm(struct temp_mm *temp_mm)
 }
 
 static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
+static DEFINE_PER_CPU(unsigned long, cpu_patching_addr);
 
 static int text_area_cpu_up(unsigned int cpu)
 {
@@ -114,6 +115,7 @@ static int text_area_cpu_up(unsigned int cpu)
 		return -1;
 	}
 	this_cpu_write(text_poke_area, area);
+	this_cpu_write(cpu_patching_addr, (unsigned long)area->addr);
 
 	return 0;
 }
@@ -139,7 +141,7 @@ void __init poking_init(void)
 /*
  * This can be called for kernel text or a module.
  */
-static int map_patch_area(void *addr, unsigned long text_poke_addr)
+static int map_patch_area(void *addr)
 {
 	unsigned long pfn;
 	int err;
@@ -149,17 +151,20 @@ static int map_patch_area(void *addr, unsigned long text_poke_addr)
 	else
 		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
 
-	err = map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
+	err = map_kernel_page(__this_cpu_read(cpu_patching_addr),
+			      (pfn << PAGE_SHIFT), PAGE_KERNEL);
 
-	pr_devel("Mapped addr %lx with pfn %lx:%d\n", text_poke_addr, pfn, err);
+	pr_devel("Mapped addr %lx with pfn %lx:%d\n",
+		 __this_cpu_read(cpu_patching_addr), pfn, err);
 	if (err)
 		return -1;
 
 	return 0;
 }
 
-static inline int unmap_patch_area(unsigned long addr)
+static inline int unmap_patch_area(void)
 {
+	unsigned long addr = __this_cpu_read(cpu_patching_addr);
 	pte_t *ptep;
 	pmd_t *pmdp;
 	pud_t *pudp;
@@ -199,11 +204,9 @@ static inline int unmap_patch_area(unsigned long addr)
 
 static int do_patch_instruction(u32 *addr, struct ppc_inst instr)
 {
-	int err;
+	int err, rc = 0;
 	u32 *patch_addr = NULL;
 	unsigned long flags;
-	unsigned long text_poke_addr;
-	unsigned long kaddr = (unsigned long)addr;
 
 	/*
 	 * During early early boot patch_instruction is called
@@ -215,24 +218,20 @@ static int do_patch_instruction(u32 *addr, struct ppc_inst instr)
 
 	local_irq_save(flags);
 
-	text_poke_addr = (unsigned long)__this_cpu_read(text_poke_area)->addr;
-	if (map_patch_area(addr, text_poke_addr)) {
-		err = -1;
+	err = map_patch_area(addr);
+	if (err)
 		goto out;
-	}
 
-	patch_addr = (u32 *)(text_poke_addr + (kaddr & ~PAGE_MASK));
+	patch_addr = (u32 *)(__this_cpu_read(cpu_patching_addr) | offset_in_page(addr));
+	rc = __patch_instruction(addr, instr, patch_addr);
 
-	__patch_instruction(addr, instr, patch_addr);
-
-	err = unmap_patch_area(text_poke_addr);
-	if (err)
-		pr_warn("failed to unmap %lx\n", text_poke_addr);
+	err = unmap_patch_area();
 
 out:
 	local_irq_restore(flags);
+	WARN_ON(!ppc_inst_equal(ppc_inst_read(addr), instr));
 
-	return err;
+	return rc ? rc : err;
 }
 #else /* !CONFIG_STRICT_KERNEL_RWX */
 
-- 
2.32.0

