Return-Path: <linuxppc-dev+bounces-28351-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E907AC98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 22:19:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htJkw3xPJz2yQl;
	Mon, 28 Sep 2026 08:19:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790533231;
	cv=none; b=HW04U7xdBxsqLHO1CIA+agJ5FktsCzGIDNQ0Gak5Idg187BFlzfWeW6tp+jjM9tj834bcPUu+e2ot8Ha8JzIxc3mIJn2a+PvZ+dt4i6a3W+whBP5mGaViOajvc8wOfIAsDsPRJ7Qlyc0CrMNnQzsORrowWs4/g9HnQScu1m+Ho1t/6Yy0B8wYVc+3lPwsLcouhsayGMcG9mm2CHqYBEr+rDGU6qrK6CA765S9H+siGRfOZMYsOHNy3ZU8AIWa/2geIlMUkRwNhoMLo6SVBelSJAHsiYuAicben9u47FtqB0UDQJHw8mVQUg1DgAIjGhsROfTaFIOQ7TP8qUpzdno5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790533231; c=relaxed/relaxed;
	bh=/YmLfvNYngEdzxR1cneHvQxjYljmSjSjM29lfe3X1Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntYvz1bTCwezjNjxwczEBGjRSoOsXVXAcf8eYLeaal8aFauj30CHh7atupHssGiHYDmHs1aXZwRfI0aDieA95paGXkchBQSSogjCKDkM0lTtPLTwpcQWZqbcLYEUBeS0ajHSs9NdarLoKjIhjZ/HDb+WY2h6yRSGz2Z8MnIeHGSx8qcGJzkNbW8/JBQ1NXiV6W9lgMwa3RRrA27GfmxlO3VDwhfWmfMQe5jzq3gKPB8viPgQKvmZXGQSU58CHtsBaVKtvzNLtX1V11Im6lNMIIgIdXW8LlAiLETvRR9fh5BJd3kZ1OVsup8j0ngh2oL7U51wmPmqxfmwQIuoG90bjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qh0lFXos; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qh0lFXos;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htCRL5qlqz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 04:20:30 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49ffed768deso4232785e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790533228; x=1791138028; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/YmLfvNYngEdzxR1cneHvQxjYljmSjSjM29lfe3X1Ew=;
        b=qh0lFXoseMoEc+33NV3AWHJgx5Z2P6vwSxf8lhRB/QVKs6TWeRhFhDaiGKEt/PZq1N
         hVbRm3aZmjBjX/JC7A2zm4JT5D7rKCyf/vFMvyltYSOa8mtkiV1or20DUQEwMN+mnwM7
         QxnpvypfUfO2frWbin8Yl5lITtmk13W8NdmqxRMR17HXCpOFNynaKLn8GrszWa8a/KIP
         CY0k2ifCc9LW2IqwAmF/oWwnIiL0DZGq5YZBDiD0tFgS5IC4QsqVEBK8QcAnOK+79g4x
         VhUT1g6+szVljFkv0AdC/WnFcyJjzUQi6DKvZfODrFsF30XP6wus6r6y8l0/Oc8D4Xct
         gWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790533228; x=1791138028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/YmLfvNYngEdzxR1cneHvQxjYljmSjSjM29lfe3X1Ew=;
        b=AP4j39zY3uqKRZD776e/yaLZfsq6scNg3eAr+yfqNeZSTRnSTLVMIyVOLJSuIMniRA
         AT+9Q2h1t4JakkI7B9uPwlF01vAqCS4atX9a+z4GYAuzd0kF3l1wQhS52jF/yZpKr79H
         DEkCqzXyO8cbEhZjALVXJt+OfmbbC7rftgirUphmUqZaOM8u+3cHd+1+KBXXPbKuaAq7
         G5QbmmNp/7g82joFgnU9SgFFAT70Ni+65y2aL/MJDYcI3xYwVOB/8hu+SBL0qUSt3KtX
         LLyoueMyJapoic0/01U/3M/3CWetOC4G1Is4lZIrd4iKK0eextJ/jPZ4lgEvyjG9SQln
         cyng==
X-Forwarded-Encrypted: i=1; AKwUvBwW2UdpdZESQbqU+8IfoA2JT4XTS/vO8KyTjEp6vZoy24MlkerAmdqg8POEAohvoZVBnAnwJnDQoAcCtSQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mAYSTSX1fksNP4vbdUrRwK9jYKbrR9Q1QWKjcLq+3ZHQFYRsuK
	sDrkPYcl9FsUKKhhXUgoLRKE7oic5hJ0buAArszoB7t9QGpnzuXHsx+i
X-Gm-Gg: AYBFou0F6QQO2BpYAduQOOIHg5uNs8UNVcQT9xO+lWblgPxASyHGddieSw+mCLoulKc
	FYKzt8DDvn4vZDu1HdBkEgrB+zBT/cRrMKznUqdOfG7pGW5XpzfNaJfE1+eoWKn+AggMHCRRZmG
	WCLjsgiNzBhfYBeM8SC3T73vgbWZJUJwppISjji398+j5uiUjtQG3Jh80KIS6bc57Z6yuFZH0pw
	WDrV1w8q+EDTTUV2sdlrNPG9ntEUZTcy3Fr9irNjLjFVSp5KdgOjqOiNp0rA7CzjYaZH90U6yV2
	WvZZXe3yAlTOY57bjI5I1UMjC/r5nldgOlUI4q+FDMaW/rRjah1mYQ7MOiAeD2jtcu4eyfYicEB
	Y3Qer1w2oOf3JxvKWbXDRbIm34kGAPf1JJxgOVMbcf10N+DBWmsGy/5NrEZO4jngW9RB8Zco/Tf
	HywqHRYRZkpjBXBEJxJk8+odYSnZo/Cokzce2h0duAVisCXfT0GlXIsceY6GPwRwi2GKlBGIRWX
	eIGoOWAFwEWN0aaMeeodjcuSwCKRt7RRjaTVwOT3ObqJwmI8He3Fyw+DQN8ld+sjL4=
X-Received: by 2002:a05:600c:1908:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-49fffa2221emr59153925e9.11.1790533227271;
        Sun, 27 Sep 2026 11:20:27 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a002d1d8d5sm38371585e9.0.2026.09.27.11.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:20:26 -0700 (PDT)
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
Subject: [PATCH RFC v4 3/5] PCI/DPC: Add pci_dpc_wait_recovery()
Date: Sun, 27 Sep 2026 18:20:14 +0000
Message-ID: <20260927182017.938565-4-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927182017.938565-1-abhinjoses@gmail.com>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
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


