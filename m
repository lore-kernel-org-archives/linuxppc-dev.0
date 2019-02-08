Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD733C282C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:19:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0402146E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcJEE/bZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0402146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wgQr6TrxzDqW1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:19:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TcJEE/bZ"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wg9q1RmwzDqVS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 14:08:30 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id w7so913769pgp.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 19:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hNuyfTT0Zi24llTmiC4EQhnJf2Ub/VxbVQ5GL3DnxaE=;
 b=TcJEE/bZMSXnwLC1jPlgESkSsKFU9zvWAYdQffIZZg6Nl9GMftCSsucDn9OWwJLRoa
 D3Zeni6nCCkSLt2oZlcaP3Du3TD4EjKunCYg7Tj95sqTvz96AZwpzqP7Szl6PKeEcS3R
 4snRPhHuYEddcmUsuaxLL8jRiakunHbCJmMshWS+6mskiW8DKSy4Vyc7dSXSXS/dICfd
 vNdcyrWxvEDoeJWY32lUPcQ5IjddTNvW4yXYhiuEAkp0pyotLfP1IDAJB6Vz6+6osCXq
 jp5Ehg7pf4TfOrqDe6T+bLXv2pRxNDNV5XQ9273QfpITQwHJNkOA2kEnOghtfFNAnEt0
 6jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hNuyfTT0Zi24llTmiC4EQhnJf2Ub/VxbVQ5GL3DnxaE=;
 b=ii5t+mzaM/8HbH1D0DrWqugJju1109SkrSYAX9TJz0F2vckw4oVm7EelV29s5dcJrJ
 ywmDxbWM2F9dCJyFSEpRop0beDm1hxstoYaRFiQYZwF34aPDhEXxFmaE3YT7HUa6M7Ok
 38yRu2GaHaczM/iktofrmibempI3WXpvakt6nBBXvAN0JnmLymuY0EEBgN2jPFJKz2c7
 UY5aWPC/tmhtbSOg6UPeJo5ctw7+Zz27iPmX9j6/gkFdHXQDCwbnNTJZIgnajBo5xE38
 liEOqys2ayVC3T+NTuF7sh/7gpWAAiSpdRvST7lc3Zmmle1sD80qXnox/2wVuyKKs2nh
 H2IA==
X-Gm-Message-State: AHQUAuZi/TW4qcAcnGPqTBBv61g0WUVkFu8JJ67fNeia3A/ngcvmsQzT
 9syBM/kL0GPE6xBmmTwx5vnNrOXo
X-Google-Smtp-Source: AHgI3IZwugXrCQv6K4SDetrFzVc8xw/fRBcYVBxvQLlzD7sDJSdIJFNdNuyMeY/tyo+UYowF2nzRfQ==
X-Received: by 2002:aa7:8758:: with SMTP id g24mr19527725pfo.250.1549595309034; 
 Thu, 07 Feb 2019 19:08:29 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id o66sm658884pgo.75.2019.02.07.19.08.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 19:08:28 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/7] powerpc/eeh: Add eeh_force_recover to debugfs
Date: Fri,  8 Feb 2019 14:08:02 +1100
Message-Id: <20190208030802.10805-7-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208030802.10805-1-oohall@gmail.com>
References: <20190208030802.10805-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch adds a debugfs interface to force scheduling a recovery event.
This can be used to recover a specific PE or schedule a "special" recovery
even that checks for errors at the PHB level.
To force a recovery of a normal PE, use:

 echo '<#pe>:<#phb>' > /sys/kernel/debug/powerpc/eeh_force_recover

To force a scan broken PHBs:

 echo 'null' > /sys/kernel/debug/powerpc/eeh_force_recover

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/eeh_event.h |  1 +
 arch/powerpc/kernel/eeh.c            | 60 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/eeh_event.c      | 25 +++++++-----
 3 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
index 9884e872686f..6d0412b846ac 100644
--- a/arch/powerpc/include/asm/eeh_event.h
+++ b/arch/powerpc/include/asm/eeh_event.h
@@ -33,6 +33,7 @@ struct eeh_event {
 
 int eeh_event_init(void);
 int eeh_send_failure_event(struct eeh_pe *pe);
+int __eeh_send_failure_event(struct eeh_pe *pe);
 void eeh_remove_event(struct eeh_pe *pe, bool force);
 void eeh_handle_normal_event(struct eeh_pe *pe);
 void eeh_handle_special_event(void);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 92809b137e39..63b91a4918c9 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1805,6 +1805,63 @@ static int eeh_enable_dbgfs_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(eeh_enable_dbgfs_ops, eeh_enable_dbgfs_get,
 			 eeh_enable_dbgfs_set, "0x%llx\n");
+
+static ssize_t eeh_force_recover_write(struct file *filp,
+				const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct pci_controller *hose;
+	uint32_t phbid, pe_no;
+	struct eeh_pe *pe;
+	char buf[20];
+	int ret;
+
+	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	if (!ret)
+		return -EFAULT;
+
+	/*
+	 * When PE is NULL the event is a "special" event. Rather than
+	 * recovering a specific PE it forces the EEH core to scan for failed
+	 * PHBs and recovers each. This needs to be done before any device
+	 * recoveries can occur.
+	 */
+	if (!strncmp(buf, "null", 4)) {
+		pr_err("sending failure event\n");
+		__eeh_send_failure_event(NULL);
+		return count;
+	}
+
+	ret = sscanf(buf, "%x:%x", &phbid, &pe_no);
+	if (ret != 2)
+		return -EINVAL;
+
+	hose = pci_find_hose_for_domain(phbid);
+	if (!hose)
+		return -ENODEV;
+
+	/* Retrieve PE */
+	pe = eeh_pe_get(hose, pe_no, 0);
+	if (!pe)
+		return -ENODEV;
+
+	/*
+	 * We don't do any state checking here since the detection
+	 * process is async to the recovery process. The recovery
+	 * thread *should* not break even if we schedule a recovery
+	 * from an odd state (e.g. PE removed, or recovery of a
+	 * non-isolated PE)
+	 */
+	__eeh_send_failure_event(pe);
+
+	return ret < 0 ? ret : count;
+}
+
+static const struct file_operations eeh_force_recover_fops = {
+	.open	= simple_open,
+	.llseek	= no_llseek,
+	.write	= eeh_force_recover_write,
+};
 #endif
 
 static int __init eeh_init_proc(void)
@@ -1820,6 +1877,9 @@ static int __init eeh_init_proc(void)
 		debugfs_create_bool("eeh_disable_recovery", 0600,
 				powerpc_debugfs_root,
 				&eeh_debugfs_no_recover);
+		debugfs_create_file_unsafe("eeh_force_recover", 0600,
+				powerpc_debugfs_root, NULL,
+				&eeh_force_recover_fops);
 		eeh_cache_debugfs_init();
 #endif
 	}
diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index 19837798bb1d..539aca055d70 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -121,20 +121,11 @@ int eeh_event_init(void)
  * the actual event will be delivered in a normal context
  * (from a workqueue).
  */
-int eeh_send_failure_event(struct eeh_pe *pe)
+int __eeh_send_failure_event(struct eeh_pe *pe)
 {
 	unsigned long flags;
 	struct eeh_event *event;
 
-	/*
-	 * If we've manually supressed recovery events via debugfs
-	 * then just drop it on the floor.
-	 */
-	if (eeh_debugfs_no_recover) {
-		pr_err("EEH: Event dropped due to no_recover setting\n");
-		return 0;
-	}
-
 	event = kzalloc(sizeof(*event), GFP_ATOMIC);
 	if (!event) {
 		pr_err("EEH: out of memory, event not handled\n");
@@ -153,6 +144,20 @@ int eeh_send_failure_event(struct eeh_pe *pe)
 	return 0;
 }
 
+int eeh_send_failure_event(struct eeh_pe *pe)
+{
+	/*
+	 * If we've manually supressed recovery events via debugfs
+	 * then just drop it on the floor.
+	 */
+	if (eeh_debugfs_no_recover) {
+		pr_err("EEH: Event dropped due to no_recover setting\n");
+		return 0;
+	}
+
+	return __eeh_send_failure_event(pe);
+}
+
 /**
  * eeh_remove_event - Remove EEH event from the queue
  * @pe: Event binding to the PE
-- 
2.20.1

