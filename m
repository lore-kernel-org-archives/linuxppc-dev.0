Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF0C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 13:36:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA072087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 13:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="HY76VbSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA072087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44HzfF6FK8zDqGB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 00:36:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="HY76VbSe"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44HzXY3zghzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 00:31:41 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id D9CDC419E1;
 Mon, 11 Mar 2019 13:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1552311091; x=1554125492; bh=66s2kCOqq88zcimSppWGg7PR6QLy3zAR7m1
 vSMIMRF0=; b=HY76VbSeRpu59ojIX6F1rUTcaYZLq8lluzVmKUqdiLeZKrmvW4c
 igxcC1BMPFxdIYHHXxv0mPDtyppM8yiebzIJdiFODlyzCrIF6v3L/5ZhTA+hA3lI
 BzhEqKDDRjluDIV7LAgetuU4bgECK+a6GNi43Q2h+6waUk/m/xPw5D24=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z-zh5dnGxCVe; Mon, 11 Mar 2019 16:31:31 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id B3FD341954;
 Mon, 11 Mar 2019 16:31:30 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 16:31:30 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC v4 02/21] PCI: Fix race condition in
 pci_enable/disable_device()
Date: Mon, 11 Mar 2019 16:31:03 +0300
Message-ID: <20190311133122.11417-3-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
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
Cc: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

 CPU0                                      CPU1

 pci_enable_device_mem()                   pci_enable_device_mem()
   pci_enable_bridge()                       pci_enable_bridge()
     pci_is_enabled()
       return false;
     atomic_inc_return(enable_cnt)
     Start actual enabling the bridge
     ...                                       pci_is_enabled()
     ...                                         return true;
     ...                                   Start memory requests <-- FAIL
     ...
     Set the PCI_COMMAND_MEMORY bit <-- Must wait for this

This patch protects the pci_enable/disable_device() and pci_enable_bridge()
with mutexes.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.c   | 26 ++++++++++++++++++++++----
 drivers/pci/probe.c |  1 +
 include/linux/pci.h |  1 +
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f006068be209..895201d4c9e6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1615,6 +1615,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	struct pci_dev *bridge;
 	int retval;
 
+	mutex_lock(&dev->enable_mutex);
+
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
 		pci_enable_bridge(bridge);
@@ -1622,6 +1624,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	if (pci_is_enabled(dev)) {
 		if (!dev->is_busmaster)
 			pci_set_master(dev);
+		mutex_unlock(&dev->enable_mutex);
 		return;
 	}
 
@@ -1630,11 +1633,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
 		pci_err(dev, "Error enabling bridge (%d), continuing\n",
 			retval);
 	pci_set_master(dev);
+	mutex_unlock(&dev->enable_mutex);
 }
 
 static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 {
 	struct pci_dev *bridge;
+	/* Enable-locking of bridges is performed within the pci_enable_bridge() */
+	bool need_lock = !dev->subordinate;
 	int err;
 	int i, bars = 0;
 
@@ -1650,8 +1656,13 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
 	}
 
-	if (atomic_inc_return(&dev->enable_cnt) > 1)
+	if (need_lock)
+		mutex_lock(&dev->enable_mutex);
+	if (pci_is_enabled(dev)) {
+		if (need_lock)
+			mutex_unlock(&dev->enable_mutex);
 		return 0;		/* already enabled */
+	}
 
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
@@ -1666,8 +1677,10 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 			bars |= (1 << i);
 
 	err = do_pci_enable_device(dev, bars);
-	if (err < 0)
-		atomic_dec(&dev->enable_cnt);
+	if (err >= 0)
+		atomic_inc(&dev->enable_cnt);
+	if (need_lock)
+		mutex_unlock(&dev->enable_mutex);
 	return err;
 }
 
@@ -1910,15 +1923,20 @@ void pci_disable_device(struct pci_dev *dev)
 	if (dr)
 		dr->enabled = 0;
 
+	mutex_lock(&dev->enable_mutex);
 	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
 		      "disabling already-disabled device");
 
-	if (atomic_dec_return(&dev->enable_cnt) != 0)
+	if (atomic_dec_return(&dev->enable_cnt) != 0) {
+		mutex_unlock(&dev->enable_mutex);
 		return;
+	}
 
 	do_pci_disable_device(dev);
 
 	dev->is_busmaster = 0;
+
+	mutex_unlock(&dev->enable_mutex);
 }
 EXPORT_SYMBOL(pci_disable_device);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2ec0df04e0dc..977a127ce791 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2267,6 +2267,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
+	mutex_init(&dev->enable_mutex);
 
 	return dev;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 77448215ef5b..cb2760a31fe2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -419,6 +419,7 @@ struct pci_dev {
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
+	struct mutex	enable_mutex;
 
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
-- 
2.20.1

