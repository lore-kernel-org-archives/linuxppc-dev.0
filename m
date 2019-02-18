Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB19C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 12:34:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B2A21773
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VZlmhhZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B2A21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4433Fz5PgKzDqF7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 23:34:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="VZlmhhZK"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44337X2SMKzDqGT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 23:28:40 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44337M6NMVz9v0s0;
 Mon, 18 Feb 2019 13:28:31 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=VZlmhhZK; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Jdr0J7JyLk7t; Mon, 18 Feb 2019 13:28:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44337M58Ybz9v0ry;
 Mon, 18 Feb 2019 13:28:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550492911; bh=HgsrP7lrn19WoaYIr71cWJaJHyd507K1lndsoIlCAnw=;
 h=From:Subject:To:Cc:Date:From;
 b=VZlmhhZKexbXLPcvMDZEWL8DHKHc5W9Q929jLjWCuY/2979bCQLJepD4IckITaH1k
 qBEp1XjL+xSXXQsQTOnKDwiUn8KFNIyzHlVHxBqgtvOluOls24B04jrDEOgdQkFuMQ
 eNfQy3Zx+CJJ5o88JuBCSUscAdFw2kyYC7gIMGAY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 786318B7BC;
 Mon, 18 Feb 2019 13:28:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id gLaohaj11tFX; Mon, 18 Feb 2019 13:28:36 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A7BC8B7B9;
 Mon, 18 Feb 2019 13:28:36 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 4E7B76A4AD; Mon, 18 Feb 2019 12:28:36 +0000 (UTC)
Message-Id: <913780421c7b73d731bbbe04c215e29667f7c938.1550492751.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: Move page table dump files in a dedicated
 subdirectory
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 18 Feb 2019 12:28:36 +0000 (UTC)
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

This patch moves the files related to page table dump in a
dedicated subdirectory.

The purpose is to clean a bit arch/powerpc/mm by regrouping
multiple files handling a dedicated function.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig.debug                                   |  4 ----
 arch/powerpc/mm/Makefile                                     | 10 +---------
 arch/powerpc/mm/ptdump/Makefile                              |  9 +++++++++
 arch/powerpc/mm/{ => ptdump}/dump_bats.c                     |  0
 arch/powerpc/mm/{ => ptdump}/dump_hashpagetable.c            |  0
 arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-8xx.c      |  0
 arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-book3s64.c |  0
 arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-generic.c  |  0
 arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.c          |  0
 arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.h          |  0
 arch/powerpc/mm/{ => ptdump}/dump_sr.c                       |  0
 11 files changed, 10 insertions(+), 13 deletions(-)
 create mode 100644 arch/powerpc/mm/ptdump/Makefile
 rename arch/powerpc/mm/{ => ptdump}/dump_bats.c (100%)
 rename arch/powerpc/mm/{ => ptdump}/dump_hashpagetable.c (100%)
 rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-8xx.c (100%)
 rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-book3s64.c (100%)
 rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-generic.c (100%)
 rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.c (100%)
 rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.h (100%)
 rename arch/powerpc/mm/{ => ptdump}/dump_sr.c (100%)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index f4961fbcb48d..4e00cb0a5464 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -361,10 +361,6 @@ config PPC_PTDUMP
 
 	  If you are unsure, say N.
 
-config PPC_HTDUMP
-	def_bool y
-	depends on PPC_PTDUMP && PPC_BOOK3S_64
-
 config PPC_FAST_ENDIAN_SWITCH
 	bool "Deprecated fast endian-switch syscall"
         depends on DEBUG_KERNEL && PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index d974f7bcb177..ab2ed80d224d 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -47,14 +47,6 @@ obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
 obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
-obj-$(CONFIG_PPC_PTDUMP)	+= dump_linuxpagetables.o
-ifdef CONFIG_PPC_PTDUMP
-obj-$(CONFIG_4xx)		+= dump_linuxpagetables-generic.o
-obj-$(CONFIG_PPC_8xx)		+= dump_linuxpagetables-8xx.o
-obj-$(CONFIG_PPC_BOOK3E_MMU)	+= dump_linuxpagetables-generic.o
-obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o dump_bats.o dump_sr.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o
-endif
-obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
+obj-$(CONFIG_PPC_PTDUMP)	+= ptdump/
 obj-$(CONFIG_PPC_MEM_KEYS)	+= pkeys.o
 obj-$(CONFIG_KASAN)		+= kasan/
diff --git a/arch/powerpc/mm/ptdump/Makefile b/arch/powerpc/mm/ptdump/Makefile
new file mode 100644
index 000000000000..c60578d16ac4
--- /dev/null
+++ b/arch/powerpc/mm/ptdump/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y	+= dump_linuxpagetables.o
+
+obj-$(CONFIG_4xx)		+= dump_linuxpagetables-generic.o
+obj-$(CONFIG_PPC_8xx)		+= dump_linuxpagetables-8xx.o
+obj-$(CONFIG_PPC_BOOK3E_MMU)	+= dump_linuxpagetables-generic.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o dump_bats.o dump_sr.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o dump_hashpagetable.o
diff --git a/arch/powerpc/mm/dump_bats.c b/arch/powerpc/mm/ptdump/dump_bats.c
similarity index 100%
rename from arch/powerpc/mm/dump_bats.c
rename to arch/powerpc/mm/ptdump/dump_bats.c
diff --git a/arch/powerpc/mm/dump_hashpagetable.c b/arch/powerpc/mm/ptdump/dump_hashpagetable.c
similarity index 100%
rename from arch/powerpc/mm/dump_hashpagetable.c
rename to arch/powerpc/mm/ptdump/dump_hashpagetable.c
diff --git a/arch/powerpc/mm/dump_linuxpagetables-8xx.c b/arch/powerpc/mm/ptdump/dump_linuxpagetables-8xx.c
similarity index 100%
rename from arch/powerpc/mm/dump_linuxpagetables-8xx.c
rename to arch/powerpc/mm/ptdump/dump_linuxpagetables-8xx.c
diff --git a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c b/arch/powerpc/mm/ptdump/dump_linuxpagetables-book3s64.c
similarity index 100%
rename from arch/powerpc/mm/dump_linuxpagetables-book3s64.c
rename to arch/powerpc/mm/ptdump/dump_linuxpagetables-book3s64.c
diff --git a/arch/powerpc/mm/dump_linuxpagetables-generic.c b/arch/powerpc/mm/ptdump/dump_linuxpagetables-generic.c
similarity index 100%
rename from arch/powerpc/mm/dump_linuxpagetables-generic.c
rename to arch/powerpc/mm/ptdump/dump_linuxpagetables-generic.c
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/ptdump/dump_linuxpagetables.c
similarity index 100%
rename from arch/powerpc/mm/dump_linuxpagetables.c
rename to arch/powerpc/mm/ptdump/dump_linuxpagetables.c
diff --git a/arch/powerpc/mm/dump_linuxpagetables.h b/arch/powerpc/mm/ptdump/dump_linuxpagetables.h
similarity index 100%
rename from arch/powerpc/mm/dump_linuxpagetables.h
rename to arch/powerpc/mm/ptdump/dump_linuxpagetables.h
diff --git a/arch/powerpc/mm/dump_sr.c b/arch/powerpc/mm/ptdump/dump_sr.c
similarity index 100%
rename from arch/powerpc/mm/dump_sr.c
rename to arch/powerpc/mm/ptdump/dump_sr.c
-- 
2.13.3

