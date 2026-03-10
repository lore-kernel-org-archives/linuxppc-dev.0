Return-Path: <linuxppc-dev+bounces-17972-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF724EB1060
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 15:08:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVchN0VBHz3bjb;
	Wed, 11 Mar 2026 02:08:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773155300;
	cv=none; b=lvFI0j8foaDbSL1hy3MImK6D7a/8LZtP81gpATMXp5u1TorDP0EEfgPBBwx+eYNVe/zjIgwr1jHCaePw9kPq4hBwJJnLjJYth9ZmpjIvvsdWGZufLkMwMDcc6j06MwGHCn22BqdIUKM9P8J5yPDu0P5gI9PiY0CR7wQwhsPcBuVZ+RojIwI3ap4V8jcR4c3A1YVdNtsUDYTerp4JZbiXlLUL7GqDSIeYTffysiH3t4aVGRAezwNRpWJE70sVmhoCdwED6X5nOBCQsb89zt/gYIk5UohdcXPxkQaX1sgdTCEYdTDg8Q5pPtXQsjIOOFkH07W8dOKSdZqy6MA/jLhGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773155300; c=relaxed/relaxed;
	bh=XDBIGY8/Xt4fpY7Mp1CJGca+BJyvr3hFvThe7Mb4Kg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SgzsXF1dV9Wpe1f1TtiMz/JNBZJADscQg9GnQ7MDh/ytjEBOVXjtx+OOTSx9GnZPqh7Z1koYr8sd1aEuUIxgtz36aCS5wjOdx3gAkte9FzdAzG2HyhdFGSVMd3zxIGx/82SX/2wZrkmKTt2HbDntxp3/FEPgeUDsXnhDT9/S29zzCdNKm/9qvxA39fhSmJ0tKR9jPgaJFpDGmJ9//+GgYO1Pk1B50mdnBuUQ6/jYTcXsABytTbBHygg4P1R1WoDxu6CUTa4+/o0CAVs1EmbtGrnMUw8rmc+eUI543LKx6LNL7hskb6mlvNfZP0fHsaF6U91AT4g8zYHkOCA+6GvocA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o5FS6g8L; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o5FS6g8L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVchM1zY0z30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 02:08:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 099A4436FD;
	Tue, 10 Mar 2026 15:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C413FC19423;
	Tue, 10 Mar 2026 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773155296;
	bh=qqYMWrM29fKZ0bq5/e1TqlgdXppZ9irTHMV+0rGa9XY=;
	h=From:To:Cc:Subject:Date:From;
	b=o5FS6g8LyNefMnJSHguOW5tuLdFfRIHKBXcEjdN+EA0QLHFNwalNQCBE79sgbBBmR
	 qfKMp2ApyllMLf/owAh4L0Oh1HpdcTGyCaYY7UxCUJe4zYek4LSRCRNResNE2POgQQ
	 PyakZH4flOttFCzVH8kkNJuBzDu98G51Y+ksD82jF1BgtAoMouN/S6lZyxafxQQtDu
	 iLAva3urM8ppBZOmq/7W8Fcv8GCzd4anslAHHuvbJCyRX9gxrD7aalkKqrjkVsbnT+
	 Ze51iPAKyYoga9AViSgK74ZUNyUsI/Uht49nFD/dC0Gd7ul3Tu75HJ2CI5+cExgvzZ
	 bPJz0AR1GxRAQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	audit@vger.kernel.org,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
Date: Tue, 10 Mar 2026 16:08:07 +0100
Message-ID: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6632; i=chleroy@kernel.org; h=from:subject:message-id; bh=U0nKvdJf3YL3PNU5hi1XIC6LU4/nhFywRBRqUPF+Rik=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRuML4xq0m8YsZ0Y0mZ1wt4/p6RVUsTV9SZ8d/1UHRPo VVoVIFZRykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZhI8Q5GhifdSz0Xal+Mfxhz ZtVb2yzXdK+1P7Y/q7aZecsquW/GrZUM/4xTNNVb7qT98+P+4G7lUDUny3PmEacEcb4bwU0yZ1y W8wMA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

From: Christophe Leroy <christophe.leroy@csgroup.eu>

Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
targets") added generic support for AUDIT but that didn't include
support for bi-arch like powerpc.

Commit 4b58841149dc ("audit: Add generic compat syscall support")
added generic support for bi-arch.

Convert powerpc to that bi-arch generic audit support.

With this change generated text is similar.

Thomas has confirmed that the previously failing filter_exclude/test
is now successful both without and with this patch, see [1]

[1] https://lore.kernel.org/all/20260306115350-ef265661-6d6b-4043-9bd0-8e6b437d0d67@linutronix.de/

Link: https://github.com/linuxppc/issues/issues/412
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
Venkat, a test result with https://github.com/linux-audit/audit-testsuite would be appreciated.

v3: Rebased on v7.0-rc1

v2: https://lore.kernel.org/all/a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu/
---
 arch/powerpc/Kconfig                |  5 +-
 arch/powerpc/include/asm/unistd32.h |  7 +++
 arch/powerpc/kernel/Makefile        |  3 -
 arch/powerpc/kernel/audit.c         | 87 -----------------------------
 arch/powerpc/kernel/compat_audit.c  | 49 ----------------
 5 files changed, 8 insertions(+), 143 deletions(-)
 create mode 100644 arch/powerpc/include/asm/unistd32.h
 delete mode 100644 arch/powerpc/kernel/audit.c
 delete mode 100644 arch/powerpc/kernel/compat_audit.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 10240cb80904..4bb8cfa37d79 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -188,6 +188,7 @@ config PPC
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if PPC_RADIX_MMU
 	select ARCH_WANTS_MODULES_DATA_IN_VMALLOC	if PPC_BOOK3S_32 || PPC_8xx
 	select ARCH_WEAK_RELEASE_ACQUIRE
+	select AUDIT_ARCH_COMPAT_GENERIC
 	select BINFMT_ELF
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS
@@ -370,10 +371,6 @@ config GENERIC_TBSYNC
 	bool
 	default y if PPC32 && SMP
 
-config AUDIT_ARCH
-	bool
-	default y
-
 config GENERIC_BUG
 	bool
 	default y
diff --git a/arch/powerpc/include/asm/unistd32.h b/arch/powerpc/include/asm/unistd32.h
new file mode 100644
index 000000000000..07689897d206
--- /dev/null
+++ b/arch/powerpc/include/asm/unistd32.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ASM_POWERPC_UNISTD32_H_
+#define _ASM_POWERPC_UNISTD32_H_
+
+#include <asm/unistd_32.h>
+
+#endif /* _ASM_POWERPC_UNISTD32_H_ */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2f0a2e69c607..7bf6b16b2d93 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -149,9 +149,6 @@ obj-$(CONFIG_PCI)		+= pci_$(BITS).o $(pci64-y) \
 				   pci-common.o pci_of_scan.o
 obj-$(CONFIG_PCI_MSI)		+= msi.o
 
-obj-$(CONFIG_AUDIT)		+= audit.o
-obj64-$(CONFIG_AUDIT)		+= compat_audit.o
-
 obj-y				+= trace/
 
 ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
diff --git a/arch/powerpc/kernel/audit.c b/arch/powerpc/kernel/audit.c
deleted file mode 100644
index 92298d6a3a37..000000000000
--- a/arch/powerpc/kernel/audit.c
+++ /dev/null
@@ -1,87 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/audit.h>
-#include <asm/unistd.h>
-
-#include "audit_32.h"
-
-static unsigned dir_class[] = {
-#include <asm-generic/audit_dir_write.h>
-~0U
-};
-
-static unsigned read_class[] = {
-#include <asm-generic/audit_read.h>
-~0U
-};
-
-static unsigned write_class[] = {
-#include <asm-generic/audit_write.h>
-~0U
-};
-
-static unsigned chattr_class[] = {
-#include <asm-generic/audit_change_attr.h>
-~0U
-};
-
-static unsigned signal_class[] = {
-#include <asm-generic/audit_signal.h>
-~0U
-};
-
-int audit_classify_arch(int arch)
-{
-#ifdef CONFIG_PPC64
-	if (arch == AUDIT_ARCH_PPC)
-		return 1;
-#endif
-	return 0;
-}
-
-int audit_classify_syscall(int abi, unsigned syscall)
-{
-#ifdef CONFIG_PPC64
-	if (abi == AUDIT_ARCH_PPC)
-		return ppc32_classify_syscall(syscall);
-#endif
-	switch(syscall) {
-	case __NR_open:
-		return AUDITSC_OPEN;
-	case __NR_openat:
-		return AUDITSC_OPENAT;
-	case __NR_socketcall:
-		return AUDITSC_SOCKETCALL;
-	case __NR_execve:
-		return AUDITSC_EXECVE;
-	case __NR_openat2:
-		return AUDITSC_OPENAT2;
-	default:
-		return AUDITSC_NATIVE;
-	}
-}
-
-static int __init audit_classes_init(void)
-{
-#ifdef CONFIG_PPC64
-	extern __u32 ppc32_dir_class[];
-	extern __u32 ppc32_write_class[];
-	extern __u32 ppc32_read_class[];
-	extern __u32 ppc32_chattr_class[];
-	extern __u32 ppc32_signal_class[];
-	audit_register_class(AUDIT_CLASS_WRITE_32, ppc32_write_class);
-	audit_register_class(AUDIT_CLASS_READ_32, ppc32_read_class);
-	audit_register_class(AUDIT_CLASS_DIR_WRITE_32, ppc32_dir_class);
-	audit_register_class(AUDIT_CLASS_CHATTR_32, ppc32_chattr_class);
-	audit_register_class(AUDIT_CLASS_SIGNAL_32, ppc32_signal_class);
-#endif
-	audit_register_class(AUDIT_CLASS_WRITE, write_class);
-	audit_register_class(AUDIT_CLASS_READ, read_class);
-	audit_register_class(AUDIT_CLASS_DIR_WRITE, dir_class);
-	audit_register_class(AUDIT_CLASS_CHATTR, chattr_class);
-	audit_register_class(AUDIT_CLASS_SIGNAL, signal_class);
-	return 0;
-}
-
-__initcall(audit_classes_init);
diff --git a/arch/powerpc/kernel/compat_audit.c b/arch/powerpc/kernel/compat_audit.c
deleted file mode 100644
index 57b38c592b9f..000000000000
--- a/arch/powerpc/kernel/compat_audit.c
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#undef __powerpc64__
-#include <linux/audit_arch.h>
-#include <asm/unistd.h>
-
-#include "audit_32.h"
-
-unsigned ppc32_dir_class[] = {
-#include <asm-generic/audit_dir_write.h>
-~0U
-};
-
-unsigned ppc32_chattr_class[] = {
-#include <asm-generic/audit_change_attr.h>
-~0U
-};
-
-unsigned ppc32_write_class[] = {
-#include <asm-generic/audit_write.h>
-~0U
-};
-
-unsigned ppc32_read_class[] = {
-#include <asm-generic/audit_read.h>
-~0U
-};
-
-unsigned ppc32_signal_class[] = {
-#include <asm-generic/audit_signal.h>
-~0U
-};
-
-int ppc32_classify_syscall(unsigned syscall)
-{
-	switch(syscall) {
-	case __NR_open:
-		return AUDITSC_OPEN;
-	case __NR_openat:
-		return AUDITSC_OPENAT;
-	case __NR_socketcall:
-		return AUDITSC_SOCKETCALL;
-	case __NR_execve:
-		return AUDITSC_EXECVE;
-	case __NR_openat2:
-		return AUDITSC_OPENAT2;
-	default:
-		return AUDITSC_COMPAT;
-	}
-}
-- 
2.49.0


