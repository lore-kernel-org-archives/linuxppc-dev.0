Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30A1C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 12:49:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D3260F59
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 12:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48D3260F59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HPZ6548PVz3cJQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 23:49:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HPZ4h0yvWz2yZw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Oct 2021 23:48:19 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HPZ4P1hDvz9sVN;
 Wed,  6 Oct 2021 14:48:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B2v-_c4nEVnB; Wed,  6 Oct 2021 14:48:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HPZ4M25FQz9sTH;
 Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2FCC08B77D;
 Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id l9XLego_FhAh; Wed,  6 Oct 2021 14:48:03 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.229])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FCF58B780;
 Wed,  6 Oct 2021 14:48:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 196Clppe579416
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 6 Oct 2021 14:47:52 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 196ChsD8579287;
 Wed, 6 Oct 2021 14:43:54 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v1 07/15] powerpc/nohash: Move setup_kuap out of 8xx.c
Date: Wed,  6 Oct 2021 14:43:40 +0200
Message-Id: <a54264dbf37d5ae21c49bc8ac514f67d11d255af.1633523837.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1633523837.git.christophe.leroy@csgroup.eu>
References: <cover.1633523837.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In order to reuse it on booke/4xx, move KUAP
setup routine out of 8xx.c

Make them usable on SMP by removing the __init tag
as it is called for each CPU.

And use __prevent_user_access() instead of hard
coding initial lock.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/8xx.c    | 21 ---------------------
 arch/powerpc/mm/nohash/Makefile |  2 +-
 arch/powerpc/mm/nohash/kup.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 22 deletions(-)
 create mode 100644 arch/powerpc/mm/nohash/kup.c

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 0df9fe29dd56..e12e41eb91c6 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -8,11 +8,7 @@
  */
 
 #include <linux/memblock.h>
-#include <linux/mmu_context.h>
 #include <linux/hugetlb.h>
-#include <asm/fixmap.h>
-#include <asm/code-patching.h>
-#include <asm/inst.h>
 
 #include <mm/mmu_decl.h>
 
@@ -224,23 +220,6 @@ void __init setup_kuep(bool disabled)
 }
 #endif
 
-#ifdef CONFIG_PPC_KUAP
-struct static_key_false disable_kuap_key;
-EXPORT_SYMBOL(disable_kuap_key);
-
-void __init setup_kuap(bool disabled)
-{
-	if (disabled) {
-		static_branch_enable(&disable_kuap_key);
-		return;
-	}
-
-	pr_info("Activating Kernel Userspace Access Protection\n");
-
-	mtspr(SPRN_MD_AP, MD_APG_KUAP);
-}
-#endif
-
 int pud_clear_huge(pud_t *pud)
 {
 	 return 0;
diff --git a/arch/powerpc/mm/nohash/Makefile b/arch/powerpc/mm/nohash/Makefile
index 0424f6ce5bd8..2ffca5f8a169 100644
--- a/arch/powerpc/mm/nohash/Makefile
+++ b/arch/powerpc/mm/nohash/Makefile
@@ -2,7 +2,7 @@
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
-obj-y				+= mmu_context.o tlb.o tlb_low.o
+obj-y				+= mmu_context.o tlb.o tlb_low.o kup.o
 obj-$(CONFIG_PPC_BOOK3E_64)  	+= tlb_low_64e.o book3e_pgtable.o
 obj-$(CONFIG_40x)		+= 40x.o
 obj-$(CONFIG_44x)		+= 44x.o
diff --git a/arch/powerpc/mm/nohash/kup.c b/arch/powerpc/mm/nohash/kup.c
new file mode 100644
index 000000000000..bbacbd780806
--- /dev/null
+++ b/arch/powerpc/mm/nohash/kup.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file contains the routines for initializing kernel userspace protection
+ */
+
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/jump_label.h>
+#include <linux/printk.h>
+#include <linux/smp.h>
+
+#include <asm/kup.h>
+#include <asm/mmu.h>
+#include <asm/smp.h>
+
+#ifdef CONFIG_PPC_KUAP
+struct static_key_false disable_kuap_key;
+EXPORT_SYMBOL(disable_kuap_key);
+
+void setup_kuap(bool disabled)
+{
+	if (disabled) {
+		if (smp_processor_id() == boot_cpuid)
+			static_branch_enable(&disable_kuap_key);
+		return;
+	}
+
+	pr_info("Activating Kernel Userspace Access Protection\n");
+
+	__prevent_user_access(KUAP_READ_WRITE);
+}
+#endif
-- 
2.31.1

