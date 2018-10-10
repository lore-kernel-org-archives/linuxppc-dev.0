Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC8C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 06:13:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D20F2087D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 06:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmZ7Yotm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D20F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VP1F6XdBzF1hT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 17:13:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YmZ7Yotm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YmZ7Yotm"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VNvT5VBFzF27h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 17:08:37 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id n31-v6so1982292pgm.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 23:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ynEGxB3zoiNQfK6YCA8PG94aCjKSgY7OMx+UsGhvtSY=;
 b=YmZ7YotmkfNgrt/NOuMsxjXg537xq9VzmeY9fuwBq2k7uRX5H6eZBeLDA5eoqaaPUS
 jsTgJwiWbQ4+1R2pmrod1WrfwcP3G5dU5erE9LJdp9ecyfSPfwEu/+4VIZsVLTl2dZM3
 veR1R62wAs8wBJJfKZoRrtLR8WxJt2c6qRCwNlc40pLnIxFGItIb7ViZnM8HhTh54O81
 AawvbCR/KR0OsASfJzI2k/1NWWDJ9f5CUbxf4NXmmrtdKbAfM2O7RnasvwuAueXXfh3k
 ZqPXUGOkh2mxEfRfol0EWuhbk4cKsfPDALWkaucIHHL7w7XA3Rdq7oD3k4vRPmwrFQvu
 LqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ynEGxB3zoiNQfK6YCA8PG94aCjKSgY7OMx+UsGhvtSY=;
 b=ccg/Gybv/E1NS8CxITi4OfPBRNNu0Q+9lHB4Tr5hMFQf/ERMcXR8g7jlTuBZRxre9M
 0Q/pNisyFxNF+qWDVxQw4pgdbx9iGAThYW4FhpsQjrapmTVsm/O/3Lx8dFT2MxrvAXSj
 55cRCOrJnNqUGT9hu/DSWOHoyeH8dwUb2auNA6lXDSq7i5YcpdLbd6DQH/SXwlot5jiV
 ykdk+qlpSW9I02eA1JZcGGi1W0H/nYkTdGh1VyF++CTy5ZKd98+n4ZSqQC71BoOFKs22
 an3zMZQATAPJ0U5X1ZSITbZ6KKPzpD6g5I7GqHYz7dcFbDlscwW40yd2Gf3Ci9CPAlp6
 PZ9w==
X-Gm-Message-State: ABuFfojSlQwnXgJGD7yqwPJtHXwGatt3woo42q1/jU3WwcC+K0CNiNA7
 sQXHMX8SMHFYq3qZ8pEoIEVdY4eH
X-Google-Smtp-Source: ACcGV61qlO27KBAeWcT9fmZHzEBZFDY9cFTn8sBglUdILCFj+xjgOvN6HuTDz3nxkQuIF01HIg6gqQ==
X-Received: by 2002:a63:9855:: with SMTP id
 l21-v6mr28617417pgo.162.1539151715782; 
 Tue, 09 Oct 2018 23:08:35 -0700 (PDT)
Received: from flat-canetoad.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id h6-v6sm31742957pgn.84.2018.10.09.23.08.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Oct 2018 23:08:35 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/pseries: PAPR persistent memory support
Date: Wed, 10 Oct 2018 17:08:11 +1100
Message-Id: <20181010060812.20068-2-oohall@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20181010060812.20068-1-oohall@gmail.com>
References: <20181010060812.20068-1-oohall@gmail.com>
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
Cc: nfont@linux.vnet.ibm.com, Oliver O'Halloran <oohall@gmail.com>,
 linux-nvdimm@lists.01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch implements support for discovering storage class memory
devices at boot and for handling hotplug of new regions via RTAS
hotplug events.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/firmware.h       |  3 ++-
 arch/powerpc/include/asm/hvcall.h         | 10 +++++++++-
 arch/powerpc/include/asm/rtas.h           |  2 ++
 arch/powerpc/kernel/rtasd.c               |  2 ++
 arch/powerpc/platforms/pseries/Makefile   |  2 +-
 arch/powerpc/platforms/pseries/dlpar.c    |  4 ++++
 arch/powerpc/platforms/pseries/firmware.c |  1 +
 arch/powerpc/platforms/pseries/pseries.h  |  5 +++++
 arch/powerpc/platforms/pseries/ras.c      |  3 ++-
 9 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 7a051bd21f87..113c64d5d394 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -52,6 +52,7 @@
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
 #define FW_FEATURE_DRMEM_V2	ASM_CONST(0x0000000400000000)
 #define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000800000000)
+#define FW_FEATURE_PAPR_SCM 	ASM_CONST(0x0000001000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -69,7 +70,7 @@ enum {
 		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
 		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
 		FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRMEM_V2 |
-		FW_FEATURE_DRC_INFO,
+		FW_FEATURE_DRC_INFO | FW_FEATURE_PAPR_SCM,
 	FW_FEATURE_PSERIES_ALWAYS = 0,
 	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
 	FW_FEATURE_POWERNV_ALWAYS = 0,
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index a0b17f9f1ea4..0e81ef83b35a 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -295,7 +295,15 @@
 #define H_INT_ESB               0x3C8
 #define H_INT_SYNC              0x3CC
 #define H_INT_RESET             0x3D0
-#define MAX_HCALL_OPCODE	H_INT_RESET
+#define H_SCM_READ_METADATA     0x3E4
+#define H_SCM_WRITE_METADATA    0x3E8
+#define H_SCM_BIND_MEM          0x3EC
+#define H_SCM_UNBIND_MEM        0x3F0
+#define H_SCM_QUERY_BLOCK_MEM_BINDING 0x3F4
+#define H_SCM_QUERY_LOGICAL_MEM_BINDING 0x3F8
+#define H_SCM_MEM_QUERY	        0x3FC
+#define H_SCM_BLOCK_CLEAR       0x400
+#define MAX_HCALL_OPCODE	H_SCM_BLOCK_CLEAR
 
 /* H_VIOCTL functions */
 #define H_GET_VIOA_DUMP_SIZE	0x01
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 71e393c46a49..1e81f3d55457 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -125,6 +125,7 @@ struct rtas_suspend_me_data {
 #define RTAS_TYPE_INFO			0xE2
 #define RTAS_TYPE_DEALLOC		0xE3
 #define RTAS_TYPE_DUMP			0xE4
+#define RTAS_TYPE_HOTPLUG		0xE5
 /* I don't add PowerMGM events right now, this is a different topic */ 
 #define RTAS_TYPE_PMGM_POWER_SW_ON	0x60
 #define RTAS_TYPE_PMGM_POWER_SW_OFF	0x61
@@ -316,6 +317,7 @@ struct pseries_hp_errorlog {
 #define PSERIES_HP_ELOG_RESOURCE_MEM	2
 #define PSERIES_HP_ELOG_RESOURCE_SLOT	3
 #define PSERIES_HP_ELOG_RESOURCE_PHB	4
+#define PSERIES_HP_ELOG_RESOURCE_PMEM   6
 
 #define PSERIES_HP_ELOG_ACTION_ADD	1
 #define PSERIES_HP_ELOG_ACTION_REMOVE	2
diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 6fafc82c04b0..fad0baddfcba 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -91,6 +91,8 @@ static char *rtas_event_type(int type)
 			return "Dump Notification Event";
 		case RTAS_TYPE_PRRN:
 			return "Platform Resource Reassignment Event";
+		case RTAS_TYPE_HOTPLUG:
+			return "Hotplug Event";
 	}
 
 	return rtas_type[0];
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 7e89d5c47068..892b27ced973 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= kexec.o
 obj-$(CONFIG_PSERIES_ENERGY)	+= pseries_energy.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug-cpu.o
-obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o
+obj-$(CONFIG_MEMORY_HOTPLUG)	+= hotplug-memory.o pmem.o
 
 obj-$(CONFIG_HVC_CONSOLE)	+= hvconsole.o
 obj-$(CONFIG_HVCS)		+= hvcserver.o
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c03f078..795996fefdb9 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -357,6 +357,10 @@ static int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 	case PSERIES_HP_ELOG_RESOURCE_CPU:
 		rc = dlpar_cpu(hp_elog);
 		break;
+	case PSERIES_HP_ELOG_RESOURCE_PMEM:
+		rc = dlpar_hp_pmem(hp_elog);
+		break;
+
 	default:
 		pr_warn_ratelimited("Invalid resource (%d) specified\n",
 				    hp_elog->resource);
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index a3bbeb43689e..4927de57d8ee 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -65,6 +65,7 @@ hypertas_fw_features_table[] = {
 	{FW_FEATURE_SET_MODE,		"hcall-set-mode"},
 	{FW_FEATURE_BEST_ENERGY,	"hcall-best-energy-1*"},
 	{FW_FEATURE_HPT_RESIZE,		"hcall-hpt-resize"},
+	{FW_FEATURE_PAPR_SCM,		"hcall-scm"},
 };
 
 /* Build up the firmware features bitmask using the contents of
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 60db2ee511fb..d0829677c896 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -63,11 +63,16 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 			 struct completion *hotplug_done, int *rc);
 #ifdef CONFIG_MEMORY_HOTPLUG
 int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
+int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog);
 #else
 static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 {
 	return -EOPNOTSUPP;
 }
+int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
+{
+	return -EOPNOTSUPP;
+};
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 851ce326874a..ae22fc007276 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -237,7 +237,8 @@ static irqreturn_t ras_hotplug_interrupt(int irq, void *dev_id)
 	 * hotplug events on the ras_log_buf to be handled by rtas_errd.
 	 */
 	if (hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_MEM ||
-	    hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_CPU)
+	    hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_CPU ||
+	    hp_elog->resource == PSERIES_HP_ELOG_RESOURCE_PMEM)
 		queue_hotplug_event(hp_elog, NULL, NULL);
 	else
 		log_error(ras_log_buf, ERR_TYPE_RTAS_LOG, 0);
-- 
2.9.5

