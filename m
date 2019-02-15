Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93875C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:09:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB6A20840
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmpkMcw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB6A20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440wBr0wyKzDqBl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 12:09:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QmpkMcw5"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440vlH5YhwzDqYP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:48:43 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id g9so4065577plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PQYTLwTUTUNQitC9VV0okYczJ8dcLrtFO9YklGXLjzc=;
 b=QmpkMcw52HKDDASp583Zifgp97igSBaN0A+TygBBkD2315ZyOOeznh0hM7/U0wUlbE
 xsXxzEeeH1iBed3iYpthUcwrUfZ8QHbJVRBjzh+Ir9XzFJ9cf16XsUya+LWaCKPDpQ85
 aI0ZjlVHqy0J4jicJcmytOtokVCT0VOp28y7hZnYPXWU8vNu0v63LqexZGBm8zTYFpzo
 skys+hLBzrgJcS/d4IDEM8pbJdoJ0wNAdGUuEPgs5UVNfc3wAnnvbZ6u8dcz0bEkoPkl
 FGh/E7sJlO5yYooH0IiFKruvvd8X4uijHcWYD9El69fsF5pSuQLhS0Cxw4nooSooL4YD
 nDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PQYTLwTUTUNQitC9VV0okYczJ8dcLrtFO9YklGXLjzc=;
 b=Hey06hvJD1qShUZrpruydXuFiWHe6kWRl8raWf8nSIXjXd/dJH8dcYsXCSQXbAp4yd
 gkhaaJx7+wqIdsaMXxqkbH9iKGcZg1lQjIhfTARszEEz5y7BdeIbVg3C0u70tKBbwiGr
 IWxZrCKw1yVhkYsoabWrU6kKVbOko4ng9tNhNft9h7lG0xJe7VTGqzJjfB4rbNeUwBBj
 bPMrN8WP0TY9qejGXUjYDS7tl8CvAN0LIDZHmhESpe43s9nkEoQy725h70Vyx0aSqQtI
 WqLSakaVpwf0FLg8nxjUcAhgddsAvncCa4T+NFt+3sRR3mgTWKauvv7CE/QwiMDdaCh3
 lRxA==
X-Gm-Message-State: AHQUAuZOm7HwiILXLuwCrLljDbEFWDt3Nw9dgeaGpdExSm7NnyG4TEwO
 n8vANr8HemWRRCd3jc2koLtvZGV+
X-Google-Smtp-Source: AHgI3IZPXaC+HKAygspqig6rjRtjL3dvCWEk0JDUKUP3kb0t4CcdkYmPOqa/ZYuBknc8vuGjDUQdig==
X-Received: by 2002:a17:902:7590:: with SMTP id
 j16mr4881936pll.304.1550191721951; 
 Thu, 14 Feb 2019 16:48:41 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id v26sm4993751pfg.62.2019.02.14.16.48.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:48:41 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 7/7] powerpc/eeh: Add eeh_force_recover to debugfs
Date: Fri, 15 Feb 2019 11:48:17 +1100
Message-Id: <20190215004817.19961-7-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215004817.19961-1-oohall@gmail.com>
References: <20190215004817.19961-1-oohall@gmail.com>
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
Cc: sbobroff@linux.ibm.com, Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch adds a debugfs interface to force scheduling a recovery event.
This can be used to recover a specific PE or schedule a "special" recovery
even that checks for errors at the PHB level.
To force a recovery of a normal PE, use:

 echo '<#pe>:<#phb>' > /sys/kernel/debug/powerpc/eeh_force_recover

To force a scan for broken PHBs:

 echo 'hwcheck' > /sys/kernel/debug/powerpc/eeh_force_recover

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v2: Rename from pci_find_hose_for_domain() to
    pci_find_controller_for_domain()

    Use the more descriptive "hwcheck" to send a special event
    rather than "null"
---
 arch/powerpc/include/asm/eeh_event.h |  1 +
 arch/powerpc/kernel/eeh.c            | 59 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/eeh_event.c      | 25 +++++++-----
 3 files changed, 75 insertions(+), 10 deletions(-)

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
index 9f20099ce2d9..37677468be6d 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1805,6 +1805,62 @@ static int eeh_enable_dbgfs_get(void *data, u64 *val)
 
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
+	if (!strncmp(buf, "hwcheck", 7)) {
+		__eeh_send_failure_event(NULL);
+		return count;
+	}
+
+	ret = sscanf(buf, "%x:%x", &phbid, &pe_no);
+	if (ret != 2)
+		return -EINVAL;
+
+	hose = pci_find_controller_for_domain(phbid);
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
@@ -1820,6 +1876,9 @@ static int __init eeh_init_proc(void)
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

