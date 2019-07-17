Return-Path: <SRS0=Uyyo=VO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393A0C7618F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jul 2019 23:56:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC3F205ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jul 2019 23:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="blVMsXBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC3F205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=anastas.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45pvLf6c41zDqTY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 09:56:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=anastas.io
 (client-ip=104.248.188.109; helo=alpha.anastas.io;
 envelope-from=shawn@anastas.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=anastas.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=anastas.io header.i=@anastas.io header.b="blVMsXBv"; 
 dkim-atps=neutral
Received: from alpha.anastas.io (alpha.anastas.io [104.248.188.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45pvJW11dkzDqRS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2019 09:54:45 +1000 (AEST)
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alpha.anastas.io (Postfix) with ESMTPSA id 5C0857F917;
 Wed, 17 Jul 2019 18:54:41 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
 t=1563407681; bh=Od3F4GS1YzYjklUkSBXMJPeXtBYiH6cOd05ccsdipgs=;
 h=From:To:Cc:Subject:Date:From;
 b=blVMsXBvMqiSUByq7sUGLZxu+BzGo10d+wAVrJn5Vxp+nNWszUu22vsfjcMZC0p4k
 HYv6oy4TKVv3ZxmW3zTmCrd2uPqICuuRcQRH7VXJapaexwJSCXRaJjapoxCzMAcEUg
 g59zhH80G50WqwyjCLqHJG27CVzQC/9oEBOtLkxUTSJJSPJx0txqBsth+AiXlZNIZ4
 KFrTIHjvO5DIEuEJCkZ2b2UJlekUUywGLbe0X1A8xbIVy8nfzy0+BwmW6xJ9ndrET/
 QpgZypiuiutZ69464IVK1z/lurrKe1gVjzmTnAG69LFGj7Scdp3foJuaSPcAQTXUV4
 g1T9xV4eR2Fag==
From: Shawn Anastasio <shawn@anastas.io>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/dma: Fix invalid DMA mmap behavior
Date: Wed, 17 Jul 2019 18:54:37 -0500
Message-Id: <20190717235437.12908-1-shawn@anastas.io>
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
Cc: aik@ozlabs.ru, sbobroff@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The refactor of powerpc DMA functions in commit 6666cc17d780
("powerpc/dma: remove dma_nommu_mmap_coherent") incorrectly
changes the way DMA mappings are handled on powerpc.
Since this change, all mapped pages are marked as cache-inhibited
through the default implementation of arch_dma_mmap_pgprot.
This differs from the previous behavior of only marking pages
in noncoherent mappings as cache-inhibited and has resulted in
sporadic system crashes in certain hardware configurations and
workloads (see Bugzilla).

This commit restores the previous correct behavior by providing
an implementation of arch_dma_mmap_pgprot that only marks
pages in noncoherent mappings as cache-inhibited. As this behavior
should be universal for all powerpc platforms a new file,
dma-generic.c, was created to store it.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204145
Fixes: 6666cc17d780 ("powerpc/dma: remove dma_nommu_mmap_coherent")
Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 arch/powerpc/Kconfig             |  1 +
 arch/powerpc/kernel/Makefile     |  3 ++-
 arch/powerpc/kernel/dma-common.c | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/kernel/dma-common.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d8dcd8820369..77f6ebf97113 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -121,6 +121,7 @@ config PPC
 	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_MMAP_PGPROT
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 56dfa7a2a6f2..ea0c69236789 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -49,7 +49,8 @@ obj-y				:= cputable.o ptrace.o syscalls.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
-				   of_platform.o prom_parse.o
+				   of_platform.o prom_parse.o \
+				   dma-common.o
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o nvram_64.o firmware.o
diff --git a/arch/powerpc/kernel/dma-common.c b/arch/powerpc/kernel/dma-common.c
new file mode 100644
index 000000000000..5a15f99f4199
--- /dev/null
+++ b/arch/powerpc/kernel/dma-common.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Contains common dma routines for all powerpc platforms.
+ *
+ * Copyright (C) 2019 Shawn Anastasio (shawn@anastas.io)
+ */
+
+#include <linux/mm.h>
+#include <linux/dma-noncoherent.h>
+
+pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
+		unsigned long attrs)
+{
+	if (!dev_is_dma_coherent(dev))
+		return pgprot_noncached(prot);
+	return prot;
+}
-- 
2.22.0

