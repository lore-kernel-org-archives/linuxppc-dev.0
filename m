Return-Path: <linuxppc-dev+bounces-28331-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3796FC98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 17:54:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htBs66Xpxz30TL;
	Mon, 28 Sep 2026 03:54:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790531537;
	cv=none; b=OK3IRllnDkyzWf8ypkPQITS50lzJCosT2Um7HsOpfYfpdgFir58p6Hw3nGc7+Njj84iy7+lSIYzUz32veVy5Smx7zDo71oi3NpOzm8OGvvssT50YIYk1oAuyhyvx/mWkt26vXRV+M80+Lkyf5duF81XW7+dBJ7pelTQOZlSFibf4PwlTSoko/0qmKTxrPpbc162azli73Ns6jRL30QGym3knQiUUjH9sDAk5sB6kgzDdKRZvQkopYWPhh20NxnAofJ5E85aZ8SrdGWvIC+bD/+othA6oYuxzPXuvwdL3Xo5eXqgd8LG7xSJiX2Nv7RPwb6UueWEJAcT/Ny13KMWL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790531537; c=relaxed/relaxed;
	bh=/YmLfvNYngEdzxR1cneHvQxjYljmSjSjM29lfe3X1Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hv18FsFY+2azzuP2lZC92KEVYfexpydKGS4V/1YkCdOlvIzDDDBeREkarTFJ3t9Li742RgnVV9VyJVUA/NQWQwAuiA8WNcUmoE1JkMJeL5XPZdWkjqIwOaN/z8IM4mnLfU9nMrHlSidTHu8NGSPZ4sn7Ufnj/mwOXaX1mJRQJ8xfk+a/a1zO2cLd0seZK3/jGnv6n8iI9lxYV/cCgKOquWe66bsf37s1cJCWhJeh8WYSLuUfrzD6ObB6/8MCEoDv2QMWjr3Z6GL0yZzgrA3EY+b03+OjhryyRzyMKWVs21YF6H201kxWofmuLVaGBuzLVJdYdgG2+dt5bhq8rt18Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qUcRqQEb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qUcRqQEb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com [IPv6:2a00:1450:4864:30::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htBpm2jCqz30WT
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 03:52:16 +1000 (AEST)
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-482f6350f91so1314563f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531533; x=1791136333; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/YmLfvNYngEdzxR1cneHvQxjYljmSjSjM29lfe3X1Ew=;
        b=qUcRqQEb94cZeLYE+a3k9MDQ3s9jQPLyuJHIHbirgXFYU2Sw5ySH5pjDLRMbaKEocR
         ro6a7N4onFn3zxmvY942NxzA+RkYyihfEh4Xo6GpNniRsYhzi5Far3jIFHMrkdPdcd9Q
         lTL9dw4JE080uWSWZ87kImFP+AmdBGoC6bQ6pYTZ7zj2vsfTlGShCMdqdgDcZQ7vFxkf
         xWnxQ2Ig9mrBil7sTfjVLp2uyuJZVpu8Ty6G/DJHymou3Iode3DW7AMo2P/v+JTJBze0
         KRUjId5lDf91cBX4/Z1gwBzmGDgedPDIxyH9ZC6nMh3l6BcDdUHx9H1NBCtjaUT5zVoq
         jfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531533; x=1791136333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/YmLfvNYngEdzxR1cneHvQxjYljmSjSjM29lfe3X1Ew=;
        b=HMAhf/7gq097KFpM6zhjfuFCz6cp1pLUMoiH1Xm58r+J6W1uIv0ejdoOoomnq5zR3L
         vVPRaLb4HL1HjyohdIPWQMPeb5PTiz83TqaO9dpslcWdo6VPkDys5FpsDhWow9OKQJ8u
         VXu46sit7bxj77HZm6exBApjn7wcuNmyXyvMPY6sjq0Ud8lpOErXcC0ZHjGbk0f8ojNt
         isPZHXhp0HRkkiLz0TfsEMMHw2UK5nq8RjbM99o1Gp4GdBy1IIU7/ihR5NFIDCkcWH4x
         ymPOVTL0HMS879fb+JvI677wrclKrXpzRMdixS8Ov7MXzLwLzE1riji0MNsqahWHGUgS
         nkMQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9uBjvQYgxlCN56vNeqSRY8Fk1B8Xk7ItB/dl97vLe8174YAIvXkQLX01NG8qOZ6V3M+5L/S1BXGMlroU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIRTJIKVc3ipAIXzFj2Dfi8TYVwmIKQt12No1dan4F+eKKjQg9X
	8Y/kpw1FvG/8wADTJAwaDaRRvoYHFauHCsoOlzP+/bjJAU7X/MJ4Q2f72dr2oZUL
X-Gm-Gg: AYBFou2uPPJSW1fDngIL1coAYun5mnk4x7VG7gJC51SMXlA+mLC8/UYGXG9UEPewE0W
	GQ3Mxk3DH7o57dXy2+/f9+tJHwSha4Y+ISDfp56BzI4c4+JcW0fMXcXFhNS+6ukPK29SK77vzt4
	cpcxkiAkvSNeBttV4eivKwxpJCgbp5yA3mUTzY0p4Gk1FSyLsM+YEOB7SezhvYmR5bfLm7x6AWE
	wibAr/i4g3k/c2HLbRYNrJZM0fGAQ0PF5wZ9Rw+Q9uyyjK/u/fUBIdMzpBpBB8YSL6BNksx85PL
	HdgULfCRM/FrkqXcfcf/Ubi+sGtfFCKfLtW6BS9dyjsYh1uErNC2mUakxIot8X6i7URgeANrU+v
	y6iJVS+q3GFFgKesIffdHyu4HtnBR0SASqtQomeQT8TceJ6qY1uduoI5UJs8umdsB/v9iylWZYk
	sRiWvIbEeL/8Duw2K0UAbIC451AaOkoNBly+dfvH00ILQfslndwXiXq2MzHOIO+K5dwJxdOGVbr
	OGAHrSvey7OGMYvR2cUgt+xqHhRnyIOuyhFZQzHNMm4IM8PQp76YuWSujXnCZcCqHU=
X-Received: by 2002:a05:6000:2010:b0:488:7803:c1ef with SMTP id ffacd0b85a97d-4887db496acmr14370762f8f.48.1790531532912;
        Sun, 27 Sep 2026 10:52:12 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcc4sm22563923f8f.1.2026.09.27.10.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:52:12 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Kees Cook <kees@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC v3 3/5] PCI/DPC: Add pci_dpc_wait_recovery()
Date: Sun, 27 Sep 2026 17:52:00 +0000
Message-ID: <20260927175203.928270-4-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927175203.928270-1-abhinjoses@gmail.com>
References: <20260927175203.928270-1-abhinjoses@gmail.com>
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
Content-Transfer-Encoding: 8bit

pci_dpc_recovered() awaits completion of DPC recovery and then tells
whether DPC recovered successfully, using test_and_clear_bit() on
PCI_DPC_RECOVERED. The answer is one-shot: only the first caller sees
true.

Split pci_dpc_recovered() into:

 - pci_dpc_hp_sync_supported(), the check whether hotplug can
   synchronize with DPC at all.
 - dpc_wait_completed(), the wait for recovery with its 4 second
   timeout;
 - the final test_and_clear_bit().

Add pci_dpc_wait_recovery(), which does the check and the wait but
leaves PCI_DPC_RECOVERED alone. No functional change intended.

Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
Assisted-by: LLM
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/dpc.c | 54 ++++++++++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cfa0202bf610b..b1d9df904c625 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -941,12 +941,14 @@ void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
 void dpc_process_error(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
+void pci_dpc_wait_recovery(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 unsigned int dpc_tlp_log_len(struct pci_dev *dev);
 #else
 static inline void pci_save_dpc_state(struct pci_dev *dev) { }
 static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
 static inline void pci_dpc_init(struct pci_dev *pdev) { }
+static inline void pci_dpc_wait_recovery(struct pci_dev *pdev) { }
 static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 #endif
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861b..a6438a7e3d9c7 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -92,15 +92,7 @@ static bool dpc_completed(struct pci_dev *pdev)
 	return true;
 }
 
-/**
- * pci_dpc_recovered - whether DPC triggered and has recovered successfully
- * @pdev: PCI device
- *
- * Return true if DPC was triggered for @pdev and has recovered successfully.
- * Wait for recovery if it hasn't completed yet.  Called from the PCIe hotplug
- * driver to recognize and ignore Link Down/Up events caused by DPC.
- */
-bool pci_dpc_recovered(struct pci_dev *pdev)
+static bool pci_dpc_hp_sync_supported(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *host;
 
@@ -108,13 +100,18 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 		return false;
 
 	/*
-	 * Synchronization between hotplug and DPC is not supported
-	 * if DPC is owned by firmware and EDR is not enabled.
-	 */
+	* Synchronization between hotplug and DPC is only supported if DPC is owned
+	* by the OS, or by firmware with EDR enabled.
+	*/
 	host = pci_find_host_bridge(pdev->bus);
 	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
 		return false;
 
+	return true;
+}
+
+static void dpc_wait_completed(struct pci_dev *pdev)
+{
 	/*
 	 * Need a timeout in case DPC never completes due to failure of
 	 * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
@@ -122,6 +119,39 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 	 */
 	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
 			   msecs_to_jiffies(4000));
+}
+
+/**
+ * pci_dpc_wait_recovery - await completion of DPC recovery
+ * @pdev: PCI device
+ *
+ * Wait for recovery if DPC was triggered for @pdev and recovery hasn't
+ * completed yet.  Unlike pci_dpc_recovered(), leave the record of a
+ * successful recovery in place.  Called from the PCIe hotplug driver where
+ * it needs the link to have settled, but not the cause of a link change.
+ * Nothing is awaited if synchronization between hotplug and DPC is not
+ * supported for @pdev.
+ */
+void pci_dpc_wait_recovery(struct pci_dev *pdev)
+{
+	if (pci_dpc_hp_sync_supported(pdev))
+		dpc_wait_completed(pdev);
+}
+
+/**
+ * pci_dpc_recovered - whether DPC triggered and has recovered successfully
+ * @pdev: PCI device
+ *
+ * Return true if DPC was triggered for @pdev and has recovered successfully.
+ * Wait for recovery if it hasn't completed yet.  Called from the PCIe hotplug
+ * driver to recognize and ignore Link Down/Up events caused by DPC.
+ */
+bool pci_dpc_recovered(struct pci_dev *pdev)
+{
+	if (!pci_dpc_hp_sync_supported(pdev))
+		return false;
+
+	dpc_wait_completed(pdev);
 
 	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
 }
-- 
2.51.1


