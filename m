Return-Path: <SRS0=+4wI=W6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E65C3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 10:46:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F8422CF7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 10:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0Y1WYFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F8422CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46N3XX488xzDqGL
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 20:46:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="M0Y1WYFA"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46N2tn65NRzDqYk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2019 20:17:05 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id t11so1601667plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Sep 2019 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QkBEvx4jjUC5SgtRKMxgodSfEvD5fInmplDhp4aotmo=;
 b=M0Y1WYFAmPtpvzVJZ9McH1q1WWRiOkAhN6nSjPn8+ImwKue3jyRN+OFLkOBnuBTItq
 S+vH66vt5xoDb4I4DrozI9eja5zz3ads8Rdy2Fu7Q2YZx3Gbv8ALPa9DtlbgDiUTw+dd
 T+R39ZFsxkfaGi0jo1zed6WMskox5T3AxnsyxDCMS15iIgM5Twls0YtFKQ2zlGzzxGzo
 1x4yrk/DPN6/LTKJUFxtzPxDYsIZSXwA475MMWqFcfi/FbM9MHFnVizUdC+zYn2mEFvb
 p8nuj54pP3w+cW6ZfWrKKxjTnRLABnK+f2pso1vwTJJD+chGb81Hb2iZiQqi4tVid4td
 1VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QkBEvx4jjUC5SgtRKMxgodSfEvD5fInmplDhp4aotmo=;
 b=Al0zV864Xfe7w7/WIgz8dPcdDqySv26WcwnEwx9SC5bX/79+amKEnYsE7IavrCEWt5
 5Pf2LwyG2ya9u4j2DTEQMTVLSwbxdFmoRhda6wzT9CSQndhf4jhu6xNRRPlI+78GpbeI
 6wgEg2GmGioJr2zpMz/K8g3FqlpxLqsB/TGXTkIsmJnb9nWnS3MdkEnr2/CvvC2jdgYH
 GPLls2FQqbHlzgfQQ+8WHOO1ZEzmBZIPx4fejMUW468lUdta9r8WpdZG/6KPtF7lDepO
 Wa91f6/2iF3CrxP6aWEbCMp6UMRwkNyA03LTBRs1Ybej1y9Ayxp4uBs2DbF2LjKbj0TJ
 EKgg==
X-Gm-Message-State: APjAAAXS1/19yLRWKdqyMx4rAqy8twMTBLQJEo/ObEr4y/52XV2Ip1zy
 2xz/888qoJXvKiJMXghANi8RMnjk
X-Google-Smtp-Source: APXvYqxuvqlq5+Y7NHHdS4ITXjLliLBqV2SwUkKlTfO+QlCpwNN+Z9hw12ZN2GF/VN+0IMN2KXWgog==
X-Received: by 2002:a17:902:4581:: with SMTP id
 n1mr35234858pld.310.1567505822864; 
 Tue, 03 Sep 2019 03:17:02 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id e24sm19676701pgk.21.2019.09.03.03.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 03:17:02 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/14] powerpc/eeh: Add debugfs interface to run an EEH check
Date: Tue,  3 Sep 2019 20:16:03 +1000
Message-Id: <20190903101605.2890-13-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903101605.2890-1-oohall@gmail.com>
References: <20190903101605.2890-1-oohall@gmail.com>
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

Detecting an frozen EEH PE usually occurs when an MMIO load returns a 0xFFs
response. When performing EEH testing using the EEH error injection feature
available on some platforms there is no simple way to kick-off the kernel's
recovery process since any accesses from userspace (usually /dev/mem) will
bypass the MMIO helpers in the kernel which check if a 0xFF response is due
to an EEH freeze or not.

If a device contains a 0xFF byte in it's config space it's possible to
trigger the recovery process via config space read from userspace, but this
is not a reliable method. If a driver is bound to the device an in use it
will frequently trigger the MMIO check, but this is also inconsistent.

To solve these problems this patch adds a debugfs file called
"eeh_dev_check" which accepts a <domain>:<bus>:<dev>.<fn> string and runs
eeh_dev_check_failure() on it. This is the same check that's done when the
kernel gets a 0xFF result from an config or MMIO read with the added
benifit that it can be reliably triggered from userspace.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/eeh.c | 61 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 46d17817b438..ace1c5a6b8ed 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1873,6 +1873,64 @@ static const struct file_operations eeh_force_recover_fops = {
 	.llseek	= no_llseek,
 	.write	= eeh_force_recover_write,
 };
+
+static ssize_t eeh_debugfs_dev_usage(struct file *filp,
+				char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	static const char usage[] = "input format: <domain>:<bus>:<dev>.<fn>\n";
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       usage, sizeof(usage) - 1);
+}
+
+static ssize_t eeh_dev_check_write(struct file *filp,
+				const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	uint32_t domain, bus, dev, fn;
+	struct pci_dev *pdev;
+	struct eeh_dev *edev;
+	char buf[20];
+	int ret;
+
+	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	if (!ret)
+		return -EFAULT;
+
+	ret = sscanf(buf, "%x:%x:%x.%x", &domain, &bus, &dev, &fn);
+	if (ret != 4) {
+		pr_err("%s: expected 4 args, got %d\n", __func__, ret);
+		return -EINVAL;
+	}
+
+	pdev = pci_get_domain_bus_and_slot(domain, bus, (dev << 3) | fn);
+	if (!pdev)
+		return -ENODEV;
+
+	edev = pci_dev_to_eeh_dev(pdev);
+	if (!edev) {
+		pci_err(pdev, "No eeh_dev for this device!\n");
+		pci_dev_put(pdev);
+		return -ENODEV;
+	}
+
+	ret = eeh_dev_check_failure(edev);
+	pci_info(pdev, "eeh_dev_check_failure(%04x:%02x:%02x.%01x) = %d\n",
+			domain, bus, dev, fn, ret);
+
+	pci_dev_put(pdev);
+
+	return count;
+}
+
+static const struct file_operations eeh_dev_check_fops = {
+	.open	= simple_open,
+	.llseek	= no_llseek,
+	.write	= eeh_dev_check_write,
+	.read   = eeh_debugfs_dev_usage,
+};
+
 #endif
 
 static int __init eeh_init_proc(void)
@@ -1888,6 +1946,9 @@ static int __init eeh_init_proc(void)
 		debugfs_create_bool("eeh_disable_recovery", 0600,
 				powerpc_debugfs_root,
 				&eeh_debugfs_no_recover);
+		debugfs_create_file_unsafe("eeh_dev_check", 0600,
+				powerpc_debugfs_root, NULL,
+				&eeh_dev_check_fops);
 		debugfs_create_file_unsafe("eeh_force_recover", 0600,
 				powerpc_debugfs_root, NULL,
 				&eeh_force_recover_fops);
-- 
2.21.0

