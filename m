Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0608C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 03:26:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2938B20868
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 03:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2938B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jrPM6p2XzDqJV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 13:26:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jrMP1bPgzDqCV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 13:24:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44jrMN4Svlz8tCq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 13:24:32 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44jrMN40h0z9s55; Tue, 16 Apr 2019 13:24:32 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=68.65.122.24; helo=new-02.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from NEW-02.privateemail.com (new-02.privateemail.com [68.65.122.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44jrMM2vYQz9s00;
 Tue, 16 Apr 2019 13:24:29 +1000 (AEST)
Received: from MTA-06-1.privateemail.com (unknown [10.20.147.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by NEW-02.privateemail.com (Postfix) with ESMTPS id 1D76C60A2C;
 Tue, 16 Apr 2019 03:24:26 +0000 (UTC)
Received: from MTA-06.privateemail.com (localhost [127.0.0.1])
 by MTA-06.privateemail.com (Postfix) with ESMTP id EAF8B6003D;
 Mon, 15 Apr 2019 23:24:25 -0400 (EDT)
Received: from wrwlf0000.attlocal.net (unknown [10.20.151.215])
 by MTA-06.privateemail.com (Postfix) with ESMTPA id 635D460039;
 Tue, 16 Apr 2019 03:24:25 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@informatik.wtf>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4] powerpc/xmon: add read-only mode
Date: Mon, 15 Apr 2019 22:26:38 -0500
Message-Id: <20190416032638.3588-1-cmr@informatik.wtf>
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
Cc: "Christopher M. Riedl" <cmr@informatik.wtf>, oohall@gmail.com,
 andrew.donnellan@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Operations which write to memory and special purpose registers should be
restricted on systems with integrity guarantees (such as Secure Boot)
and, optionally, to avoid self-destructive behaviors.

Add a config option, XMON_DEFAULT_RO_MODE, to set default xmon behavior.
The kernel cmdline options xmon=ro and xmon=rw override this default.

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
Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
---

v3->v4:
	Address Andrew's nitpick.

 arch/powerpc/Kconfig.debug |  8 ++++++++
 arch/powerpc/xmon/xmon.c   | 42 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 4e00cb0a5464..326ac5ea3f72 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -117,6 +117,14 @@ config XMON_DISASSEMBLY
 	  to say Y here, unless you're building for a memory-constrained
 	  system.
 
+config XMON_DEFAULT_RO_MODE
+	bool "Restrict xmon to read-only operations by default"
+	depends on XMON
+	default y
+	help
+          Operate xmon in read-only mode. The cmdline options 'xmon=rw' and
+          'xmon=ro' override this default.
+
 config DEBUGGER
 	bool
 	depends on KGDB || XMON
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a0f44f992360..ce98c8049eb6 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -80,6 +80,7 @@ static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
 #endif
 static unsigned long in_xmon __read_mostly = 0;
 static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
+static bool xmon_is_ro = IS_ENABLED(CONFIG_XMON_DEFAULT_RO_MODE);
 
 static unsigned long adrs;
 static int size = 1;
@@ -202,6 +203,8 @@ static void dump_tlb_book3e(void);
 #define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
 #endif
 
+static const char *xmon_ro_msg = "Operation disabled: xmon in read-only mode\n";
+
 static char *help_string = "\
 Commands:\n\
   b	show breakpoints\n\
@@ -989,6 +992,10 @@ cmds(struct pt_regs *excp)
 				memlocate();
 				break;
 			case 'z':
+				if (xmon_is_ro) {
+					printf(xmon_ro_msg);
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
+				printf(xmon_ro_msg);
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
+				printf(xmon_ro_msg);
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
+		printf(xmon_ro_msg);
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
+		printf(xmon_ro_msg);
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
+			printf(xmon_ro_msg);
+			break;
+		}
 		memmove((void *)mdest, (void *)msrc, mcount);
 		break;
 	case 's':
+		if (xmon_is_ro) {
+			printf(xmon_ro_msg);
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

