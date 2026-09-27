Return-Path: <linuxppc-dev+bounces-28325-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EC2C98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 17:51:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htBpQ3LNBz2yPR;
	Mon, 28 Sep 2026 03:51:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790528126;
	cv=none; b=Xa1cj12dXgcd5EZCe2FExchWWI3Eogj82emPF7MeoYprRbDfGkSrR/TyWv3bTrxmP/4ciVTKxYo6eXVuuTgi9HDhQuogQPiimAO8mvGx/3x9tiVANV3WmmYnm+CF0NKWBhPKlzS6fuwENnu9Cen2SJc2P7qPLuXdXdXZaTvcm/QUeyX3TtR/5PuAcE1MwQH0VuA+uKXF01RDNax+L1OSsAtHrLFUEDfXf2dwH3jzHxLwIpZk0p0LQjrH/H2X8UOzJm2qbfOhZDbMxR4BnvZ3LNKwH2Ovzz1q6qz+x5zdUlxQjoHRtzzfpvGl5R18gj0RAEoBgskXPlvszKc6WKLZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790528126; c=relaxed/relaxed;
	bh=NTuSGrduqyu3DK4wAPJF2MCmGI7vblXuBOgLU0bscZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0GFmgSKXNwOvTtl5YWZ5JFCWLaLkxqPYmjBpzMh5XaPxa3b7PcnzXGIEe9U12r3jNFyd+ttUXpRdGW8kBHzTdZ4yBrsq/Aim7iRdScV2IYff6pzsbbgftW382VSnXoaftT+i1bbQvKGvXFmq6xWnkM8lv833PjpLqbvxvEgtLK5LvbZlwjwEz8zGkFFNZfkGYHP4ENUGyjagXkZepi5Eq8299UfAgp34yKqZV4C5/YJ+2dP7sEN5FVQeD7Gwyq/2c7Pl5Ph3rG5+f3RIwE/dTt/4wMink191YLVtF59yhkr7lXaXOR/ZmyZN2cNB03qOz1C3merVM/r3MNmwTqoeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TdYXvhy3; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TdYXvhy3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht9Y93nrTz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 02:55:25 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so12542735e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790528122; x=1791132922; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NTuSGrduqyu3DK4wAPJF2MCmGI7vblXuBOgLU0bscZM=;
        b=TdYXvhy3+DwT3/wLmqXXDd0xJeB/+03qh1YFHCDr5AmDYJcHnvgs06ccHvvM8QsY2y
         KEhWBF5qCCyCrfaUZhY9+tCeS/vLSs1RPrVIZv733bKl7XEnETUjjucCdnvitB7kl2i5
         lfwr2juVG3Cw/5DQGGDcAZJDyYWT2RmIZ2OGkt+uRk0U7WAvSXMGaA4MALqyBLAPYd2H
         o3zrfb9I1Q7Lzv+UYdF97TAR1DDAZGsU6c8kp3enb59FpCe5k+rpz52Ymhmq94epjw0i
         1wqh7iuIQI4+iEH1e4zesRkVEIyMTr/HJbsBMLy+1t7Rse4+9a/TKJ3jpf9gllCwl3/c
         DeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790528122; x=1791132922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NTuSGrduqyu3DK4wAPJF2MCmGI7vblXuBOgLU0bscZM=;
        b=wYyXWSyNECKHg9sR4m43YFOxfWJC8QfdImEsFSixqmDyklX+GMb5l0p4cprVYg9lnk
         JHEBz48o6YNwCt185b3PyKTfm0V1RDQv/DPKeckxLXOU9xV+0BD6lEI/X99KQ0mVMUXe
         KHWN0I0ugv+gC97r2ND7E9bxa+u0UtGVjLvy+vXkO7AfP5H0YKWAzKL/TtMSMTsJCGtV
         BzuAqivS4U+MphbGwyDWTdzsRYpY1BbOp5ZAJYh6J+qw+l4LPHoUouoDmfM8IT+QJOOs
         Z2EIEdCuCJ8/1d9JmrjjcVnwWCMrkePfP+wuAXYAKreVEysQCw4ioqs2ZLlhIdBOPQgT
         uLZw==
X-Forwarded-Encrypted: i=1; AKwUvBwhFpuSKrXtQnQ74SL3Q3k86k7aDzI4Dt8onUXHagjx4SjTRe/JeLoODZt+DkItGCpTheLTSiIcV4cddN0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mtHaNidGZM/IqyYgCAEx+cIIQuSaPXLl9kAYzTiNyGVkYUMMrJ
	2lPQgTpnnpSq7sNo5Rqr7OD5aAJg8AtEmTm9H88f1cSUvYf+R30WqSv1
X-Gm-Gg: AYBFou2Tdu8t5igu8ZQ5FzJush51NGlXUrmyjEUZk/opk1PdmtbWAnshVZZwpiY5hy1
	tITn1IH8RpDlWtsqXUVnbiZ1ABg/1yjGZyhVggKDce+pTAkRoku1c87Q0plglPUhZnRTARwFXJ4
	7yO+AH8FrePTMKB9sg1BTXW+iL3OKRXBRyWZP24y0PxWAjCQHdoAr3q30qP0IXPcGZ2nENCUsc+
	N9+HyMNP16FcjPSM+XOs07o7H1YWJTZlTDcBqR3sjj4v89S+C7MgrFEK/eouT/KFiVLcR1ovp8o
	Enf1qh0S1PRrI1naFwKHr5L1mPwqqhgYeVViXF0MUFOanesKLa80jE9sIvP4Kw3DL1dGPEghqxf
	OU0u5yehm2TAuYs7D1yoqW5GCUxeyWbO1c/mKDo4tsxvbMUfaYkULl5UKHnwEcoUkI0WZ5PyVhl
	1JurLecqo9Ec4+iHtTHn0KYUL8CGM7NvGzr+NYmMooU7N5B0aGtGTLhnxxl5HwIm3EdKDNVsnX6
	Fr/DpBtJsEe91gIeevJ8pTIizMaAYHNymAwboIH6bDlEunQo00yIWY4NNKLmCTDGgNbAZ4lpRl4
	aQ==
X-Received: by 2002:a05:600c:34d4:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49fe66d07c9mr170308515e9.12.1790528121995;
        Sun, 27 Sep 2026 09:55:21 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178bebasm76167695e9.11.2026.09.27.09.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:55:21 -0700 (PDT)
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
Subject: [PATCH RFC v2 3/5] PCI/DPC: Add pci_dpc_wait_recovery()
Date: Sun, 27 Sep 2026 16:54:56 +0000
Message-ID: <20260927165459.829900-4-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927165459.829900-1-abhinjoses@gmail.com>
References: <20260927165459.829900-1-abhinjoses@gmail.com>
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
index 2e113806f9f95..ad98e2d9289ea 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -940,12 +940,14 @@ void pci_restore_dpc_state(struct pci_dev *dev);
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


