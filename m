Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60EEC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 19:32:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13CD20B1F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 19:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="NoI8HzZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13CD20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43r9NR6FBkzDqcY
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 06:32:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="NoI8HzZQ"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43r9Jj5mPZzDqPl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 06:28:53 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43r9Jf259sz9vBJX;
 Thu, 31 Jan 2019 20:28:50 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=NoI8HzZQ; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id aKAkTvAvNTuy; Thu, 31 Jan 2019 20:28:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43r9Jf0wyVz9vBJT;
 Thu, 31 Jan 2019 20:28:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548962930; bh=aQhJWwaN99PD5WVxlF6MWDssLL3WHA0NK46/37sosQM=;
 h=From:Subject:To:Cc:Date:From;
 b=NoI8HzZQz9zT/vPJqWhubnJ0MpROUmj/grZtPXcd9CUhWkj5MHEwKkKyrge0snUQu
 iDJd7lFVFW4qnWGkFJu+5Vi/QhDTDJhfjSYb3aSe/TInYLwtDu6Ym9poNk/4Yb4Qri
 0q0aV6g8P6IkXLxEa/ph5q/+lmGyy718FxQjShh4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A6E78B842;
 Thu, 31 Jan 2019 20:28:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ODhGuRms3wTm; Thu, 31 Jan 2019 20:28:50 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ED3B48B835;
 Thu, 31 Jan 2019 20:28:49 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id EE85F72E25; Thu, 31 Jan 2019 19:28:49 +0000 (UTC)
Message-Id: <a2cf0c09e15a3f8806096df73e41fae0fa10d2bf.1548962883.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: drop page_is_ram() and walk_system_ram_range()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 31 Jan 2019 19:28:49 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Since commit c40dd2f76644 ("powerpc: Add System RAM to /proc/iomem")
it is possible to use the generic walk_system_ram_range() and
the generic page_is_ram().

Fixes: c40dd2f76644 ("powerpc: Add System RAM to /proc/iomem")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig            |  3 ---
 arch/powerpc/include/asm/page.h |  1 -
 arch/powerpc/mm/mem.c           | 33 ---------------------------------
 3 files changed, 37 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0a26e0075ce5..0006ca6a7664 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -479,9 +479,6 @@ config ARCH_CPU_PROBE_RELEASE
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y
 
-config ARCH_HAS_WALK_MEMORY
-	def_bool y
-
 config ARCH_ENABLE_MEMORY_HOTREMOVE
 	def_bool y
 
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 5c5ea2413413..aa4497175bd3 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -326,7 +326,6 @@ struct page;
 extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
 extern void copy_user_page(void *to, void *from, unsigned long vaddr,
 		struct page *p);
-extern int page_is_ram(unsigned long pfn);
 extern int devmem_is_allowed(unsigned long pfn);
 
 #ifdef CONFIG_PPC_SMLPAR
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 33cc6f676fa6..fa9916c2c662 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -80,11 +80,6 @@ static inline pte_t *virt_to_kpte(unsigned long vaddr)
 #define TOP_ZONE ZONE_NORMAL
 #endif
 
-int page_is_ram(unsigned long pfn)
-{
-	return memblock_is_memory(__pfn_to_phys(pfn));
-}
-
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
 {
@@ -176,34 +171,6 @@ int __meminit arch_remove_memory(int nid, u64 start, u64 size,
 #endif
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
-/*
- * walk_memory_resource() needs to make sure there is no holes in a given
- * memory range.  PPC64 does not maintain the memory layout in /proc/iomem.
- * Instead it maintains it in memblock.memory structures.  Walk through the
- * memory regions, find holes and callback for contiguous regions.
- */
-int
-walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
-		void *arg, int (*func)(unsigned long, unsigned long, void *))
-{
-	struct memblock_region *reg;
-	unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long tstart, tend;
-	int ret = -1;
-
-	for_each_memblock(memory, reg) {
-		tstart = max(start_pfn, memblock_region_memory_base_pfn(reg));
-		tend = min(end_pfn, memblock_region_memory_end_pfn(reg));
-		if (tstart >= tend)
-			continue;
-		ret = (*func)(tstart, tend - tstart, arg);
-		if (ret)
-			break;
-	}
-	return ret;
-}
-EXPORT_SYMBOL_GPL(walk_system_ram_range);
-
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 void __init mem_topology_setup(void)
 {
-- 
2.13.3

