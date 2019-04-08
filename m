Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C12C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 03:07:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE6020880
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 03:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE6020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44cwMb42PPzDqK6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 13:07:39 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44cwKc0vMHzDq9Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 13:05:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44cwKZ4zd9z8tDC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 13:05:54 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44cwKZ4316z9sR3; Mon,  8 Apr 2019 13:05:54 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=68.65.122.24; helo=new-02.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from NEW-02.privateemail.com (new-02.privateemail.com [68.65.122.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44cwKY4WB3z9sMx
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Apr 2019 13:05:51 +1000 (AEST)
Received: from MTA-07-1.privateemail.com (unknown [10.20.147.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by NEW-02.privateemail.com (Postfix) with ESMTPS id 83C8F60769;
 Mon,  8 Apr 2019 03:05:48 +0000 (UTC)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
 by MTA-07.privateemail.com (Postfix) with ESMTP id 5E6CB60034;
 Sun,  7 Apr 2019 23:05:48 -0400 (EDT)
Received: from wrwlf0000.attlocal.net (unknown [10.20.151.240])
 by MTA-07.privateemail.com (Postfix) with ESMTPA id E31D060043;
 Mon,  8 Apr 2019 03:05:47 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@informatik.wtf>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/xmon: add read-only mode
Date: Sun,  7 Apr 2019 22:08:04 -0500
Message-Id: <20190408030804.5805-1-cmr@informatik.wtf>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: "Christopher M. Riedl" <cmr@informatik.wtf>, andrew.donnellan@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Operations which write to memory and special purpose registers should be
restricted on systems with integrity guarantees (such as Secure Boot)
and, optionally, to avoid self-destructive behaviors.

Add a config option, XMON_RW, to control default xmon behavior along
with kernel cmdline options xmon=ro and xmon=rw for explicit control.
Use XMON_RW instead of XMON in the condition to set PAGE_KERNEL_TEXT to
allow xmon in read-only mode alongside write-protected kernel text.
XMON_RW defaults to !STRICT_KERNEL_RWX.

The following xmon operations are affected:
memops:
	disable memmove
	disable memset
	disable memzcan
memex:
	no-op'd mwrite
super_regs:
	no-op'd write_spr
bpt_cmds:
	disable
proc_call:
	disable

Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>
---
v1->v2:
	Use bool type for xmon_is_ro flag
	Replace XMON_RO with XMON_RW config option
	Make XMON_RW dependent on STRICT_KERNEL_RWX
	Use XMON_RW to control PAGE_KERNEL_TEXT
	Add printf in xmon read-only mode when dropping/skipping writes
	Disable memzcan (zero-fill memop) in xmon read-only mode

 arch/powerpc/Kconfig.debug                   | 10 +++++
 arch/powerpc/include/asm/book3s/32/pgtable.h |  5 ++-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  5 ++-
 arch/powerpc/include/asm/nohash/pgtable.h    |  5 ++-
 arch/powerpc/xmon/xmon.c                     | 42 ++++++++++++++++++++
 5 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 4e00cb0a5464..0c7f21476018 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -117,6 +117,16 @@ config XMON_DISASSEMBLY
 	  to say Y here, unless you're building for a memory-constrained
 	  system.
 
+config XMON_RW
+	bool "Allow xmon read and write operations"
+	depends on XMON
+	default !STRICT_KERNEL_RWX
+	help
+	  Allow xmon to read and write to memory and special-purpose registers.
+          Conversely, prevent xmon write access when set to N. Read and write
+          access can also be explicitly controlled with 'xmon=rw' or 'xmon=ro'
+          (read-only) cmdline options. Default is !STRICT_KERNEL_RWX.
+
 config DEBUGGER
 	bool
 	depends on KGDB || XMON
diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index aa8406b8f7ba..615144ad667d 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -86,8 +86,9 @@ static inline bool pte_user(pte_t pte)
  * set breakpoints anywhere, so don't write protect the kernel text
  * on platforms where such control is possible.
  */
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
+#if defined(CONFIG_KGDB) || defined(CONFIG_XMON_RW) || \
+	defined(CONFIG_BDI_SWITCH) || defined(CONFIG_KPROBES) || \
+	defined(CONFIG_DYNAMIC_FTRACE)
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
 #else
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 581f91be9dd4..bc4655122f6b 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -168,8 +168,9 @@
  * set breakpoints anywhere, so don't write protect the kernel text
  * on platforms where such control is possible.
  */
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
+#if defined(CONFIG_KGDB) || defined(CONFIG_XMON_RW) || \
+	defined(CONFIG_BDI_SWITCH) || defined(CONFIG_KPROBES) || \
+	defined(CONFIG_DYNAMIC_FTRACE)
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
 #else
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 1ca1c1864b32..c052931bd243 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -22,8 +22,9 @@
  * set breakpoints anywhere, so don't write protect the kernel text
  * on platforms where such control is possible.
  */
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
+#if defined(CONFIG_KGDB) || defined(CONFIG_XMON_RW) || \
+	defined(CONFIG_BDI_SWITCH) || defined(CONFIG_KPROBES) || \
+	defined(CONFIG_DYNAMIC_FTRACE)
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
 #else
 #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a0f44f992360..224ca0b3506b 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -80,6 +80,7 @@ static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
 #endif
 static unsigned long in_xmon __read_mostly = 0;
 static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
+static bool xmon_is_ro = !IS_ENABLED(CONFIG_XMON_RW);
 
 static unsigned long adrs;
 static int size = 1;
@@ -202,6 +203,8 @@ static void dump_tlb_book3e(void);
 #define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
 #endif
 
+static const char *xmon_is_ro_warn = "xmon read-only mode: skipping write\n";
+
 static char *help_string = "\
 Commands:\n\
   b	show breakpoints\n\
@@ -989,6 +992,10 @@ cmds(struct pt_regs *excp)
 				memlocate();
 				break;
 			case 'z':
+				if (xmon_is_ro) {
+					printf(xmon_is_ro_warn);
+					break;
+				}
 				memzcan();
 				break;
 			case 'i':
@@ -1042,6 +1049,10 @@ cmds(struct pt_regs *excp)
 			set_lpp_cmd();
 			break;
 		case 'b':
+			if (xmon_is_ro) {
+				printf(xmon_is_ro_warn);
+				break;
+			}
 			bpt_cmds();
 			break;
 		case 'C':
@@ -1055,6 +1066,10 @@ cmds(struct pt_regs *excp)
 			bootcmds();
 			break;
 		case 'p':
+			if (xmon_is_ro) {
+				printf(xmon_is_ro_warn);
+				break;
+			}
 			proccall();
 			break;
 		case 'P':
@@ -1777,6 +1792,11 @@ read_spr(int n, unsigned long *vp)
 static void
 write_spr(int n, unsigned long val)
 {
+	if (xmon_is_ro) {
+		printf(xmon_is_ro_warn);
+		return;
+	}
+
 	if (setjmp(bus_error_jmp) == 0) {
 		catch_spr_faults = 1;
 		sync();
@@ -2016,6 +2036,12 @@ mwrite(unsigned long adrs, void *buf, int size)
 	char *p, *q;
 
 	n = 0;
+
+	if (xmon_is_ro) {
+		printf(xmon_is_ro_warn);
+		return n;
+	}
+
 	if (setjmp(bus_error_jmp) == 0) {
 		catch_memory_errors = 1;
 		sync();
@@ -2884,9 +2910,17 @@ memops(int cmd)
 	scanhex((void *)&mcount);
 	switch( cmd ){
 	case 'm':
+		if (xmon_is_ro) {
+			printf(xmon_is_ro_warn);
+			break;
+		}
 		memmove((void *)mdest, (void *)msrc, mcount);
 		break;
 	case 's':
+		if (xmon_is_ro) {
+			printf(xmon_is_ro_warn);
+			break;
+		}
 		memset((void *)mdest, mval, mcount);
 		break;
 	case 'd':
@@ -3796,6 +3830,14 @@ static int __init early_parse_xmon(char *p)
 	} else if (strncmp(p, "on", 2) == 0) {
 		xmon_init(1);
 		xmon_on = 1;
+	} else if (strncmp(p, "rw", 2) == 0) {
+		xmon_init(1);
+		xmon_on = 1;
+		xmon_is_ro = false;
+	} else if (strncmp(p, "ro", 2) == 0) {
+		xmon_init(1);
+		xmon_on = 1;
+		xmon_is_ro = true;
 	} else if (strncmp(p, "off", 3) == 0)
 		xmon_on = 0;
 	else
-- 
2.21.0

