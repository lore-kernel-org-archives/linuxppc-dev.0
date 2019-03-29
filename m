Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61ECC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 04:35:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07508206BA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 04:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07508206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Vpn968FDzDqQd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:35:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VplJ0KqRzDqPM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 15:33:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44VplH4p95z8tDh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 15:33:31 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44VplH4P4zz9sQm; Fri, 29 Mar 2019 15:33:31 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=198.54.127.52; helo=new-02-3.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
X-Greylist: delayed 834 seconds by postgrey-1.36 at bilbo;
 Fri, 29 Mar 2019 15:33:30 AEDT
Received: from NEW-02-3.privateemail.com (new-02-3.privateemail.com
 [198.54.127.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44VplG4X6vz9sPL;
 Fri, 29 Mar 2019 15:33:29 +1100 (AEDT)
Received: from MTA-07-1.privateemail.com (unknown [10.20.147.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by NEW-02.privateemail.com (Postfix) with ESMTPS id 6EFFA604F5;
 Fri, 29 Mar 2019 04:19:31 +0000 (UTC)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
 by MTA-07.privateemail.com (Postfix) with ESMTP id 4D5F160049;
 Fri, 29 Mar 2019 00:19:31 -0400 (EDT)
Received: from wrwlf0000.attlocal.net (unknown [10.20.151.216])
 by MTA-07.privateemail.com (Postfix) with ESMTPA id DE9D26004B;
 Fri, 29 Mar 2019 04:19:30 +0000 (UTC)
From: cmr <cmr@informatik.wtf>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/xmon: add read-only mode
Date: Thu, 28 Mar 2019 23:21:53 -0500
Message-Id: <20190329042153.25698-1-cmr@informatik.wtf>
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
Cc: cmr <cmr@informatik.wtf>, andonnel@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Operations which write to memory should be restricted on secure systems
and optionally to avoid self-destructive behaviors.

Add a config option, XMON_RO, to control default xmon behavior along
with kernel cmdline options xmon=ro and xmon=rw for explicit control.
The default is to enable read-only mode.

The following xmon operations are affected:
memops:
	disable memmove
	disable memset
memex:
	no-op'd mwrite
super_regs:
	no-op'd write_spr
bpt_cmds:
	disable
proc_call:
	disable

Signed-off-by: cmr <cmr@informatik.wtf>
---
 arch/powerpc/Kconfig.debug |  7 +++++++
 arch/powerpc/xmon/xmon.c   | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 4e00cb0a5464..33cc01adf4cb 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -117,6 +117,13 @@ config XMON_DISASSEMBLY
 	  to say Y here, unless you're building for a memory-constrained
 	  system.
 
+config XMON_RO
+	bool "Set xmon read-only mode"
+	depends on XMON
+	default y
+	help
+	  Disable state- and memory-altering write operations in xmon.
+
 config DEBUGGER
 	bool
 	depends on KGDB || XMON
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a0f44f992360..c13ee73cdfd4 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -80,6 +80,7 @@ static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
 #endif
 static unsigned long in_xmon __read_mostly = 0;
 static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
+static int xmon_ro = IS_ENABLED(CONFIG_XMON_RO);
 
 static unsigned long adrs;
 static int size = 1;
@@ -1042,6 +1043,8 @@ cmds(struct pt_regs *excp)
 			set_lpp_cmd();
 			break;
 		case 'b':
+			if (xmon_ro == 1)
+				break;
 			bpt_cmds();
 			break;
 		case 'C':
@@ -1055,6 +1058,8 @@ cmds(struct pt_regs *excp)
 			bootcmds();
 			break;
 		case 'p':
+			if (xmon_ro == 1)
+				break;
 			proccall();
 			break;
 		case 'P':
@@ -1777,6 +1782,9 @@ read_spr(int n, unsigned long *vp)
 static void
 write_spr(int n, unsigned long val)
 {
+	if (xmon_ro == 1)
+		return;
+
 	if (setjmp(bus_error_jmp) == 0) {
 		catch_spr_faults = 1;
 		sync();
@@ -2016,6 +2024,10 @@ mwrite(unsigned long adrs, void *buf, int size)
 	char *p, *q;
 
 	n = 0;
+
+	if (xmon_ro == 1)
+		return n;
+
 	if (setjmp(bus_error_jmp) == 0) {
 		catch_memory_errors = 1;
 		sync();
@@ -2884,9 +2896,13 @@ memops(int cmd)
 	scanhex((void *)&mcount);
 	switch( cmd ){
 	case 'm':
+		if (xmon_ro == 1)
+			break;
 		memmove((void *)mdest, (void *)msrc, mcount);
 		break;
 	case 's':
+		if (xmon_ro == 1)
+			break;
 		memset((void *)mdest, mval, mcount);
 		break;
 	case 'd':
@@ -3796,6 +3812,14 @@ static int __init early_parse_xmon(char *p)
 	} else if (strncmp(p, "on", 2) == 0) {
 		xmon_init(1);
 		xmon_on = 1;
+	} else if (strncmp(p, "rw", 2) == 0) {
+		xmon_init(1);
+		xmon_on = 1;
+		xmon_ro = 0;
+	} else if (strncmp(p, "ro", 2) == 0) {
+		xmon_init(1);
+		xmon_on = 1;
+		xmon_ro = 1;
 	} else if (strncmp(p, "off", 3) == 0)
 		xmon_on = 0;
 	else
-- 
2.21.0

