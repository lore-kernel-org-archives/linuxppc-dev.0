Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54A7C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 15:50:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6FF2082E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 15:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Tx35XaCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6FF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tXH32gchzDqKt
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 02:50:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yadro.com
 (client-ip=89.207.88.251; helo=mta-01.yadro.com;
 envelope-from=s.miroshnichenko@yadro.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yadro.com header.i=@yadro.com header.b="Tx35XaCP"; 
 dkim-atps=neutral
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tX7J2TtvzDqJB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 02:43:56 +1100 (AEDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id AE3A941965;
 Mon,  4 Feb 2019 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1549294573; x=1551108974; bh=OR7+kHmdLXiuucrl8doe382h27BVql/saF5
 X7nTlQ/w=; b=Tx35XaCPqZrYvfTN/N64bIHJTg5LSEexAhnqb/GT/vXCv0HJT0k
 aX0TPiy7N99DJmvccb9k3/LUFmLdppgbC2wcPHgfALrQrWBDOlla3lqtu85YHCaw
 /2syD3LdzdqlgsqDTyqvjgLVg/RSx8VmK9ccycVsCWPMcjcYwQvQSKxM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x8JMTZgsNevE; Mon,  4 Feb 2019 18:36:13 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 7AA8A41908;
 Mon,  4 Feb 2019 18:36:10 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 4 Feb
 2019 18:36:09 +0300
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>
Subject: [PATCH RFC v3 02/21] PCI: Fix race condition in
 pci_enable/disable_device()
Date: Mon, 4 Feb 2019 18:35:42 +0300
Message-ID: <20190204153601.7576-3-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204153601.7576-1-s.miroshnichenko@yadro.com>
References: <20190204153601.7576-1-s.miroshnichenko@yadro.com>
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
 Sergey Miroshnichenko <s.miroshnichenko@yadro.com>, linux@yadro.com,
 Bjorn Helgaas <helgaas@kernel.org>, Oliver <oohall@gmail.com>,
 Rajat Jain <rajatja@google.com>, linuxppc-dev@lists.ozlabs.org
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
index e1fc93c9eea1..3a83e05f8363 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1571,6 +1571,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	struct pci_dev *bridge;
 	int retval;
 
+	mutex_lock(&dev->enable_mutex);
+
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
 		pci_enable_bridge(bridge);
@@ -1578,6 +1580,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	if (pci_is_enabled(dev)) {
 		if (!dev->is_busmaster)
 			pci_set_master(dev);
+		mutex_unlock(&dev->enable_mutex);
 		return;
 	}
 
@@ -1586,11 +1589,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
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
 
@@ -1606,8 +1612,13 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
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
@@ -1622,8 +1633,10 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
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
 
@@ -1866,15 +1879,20 @@ void pci_disable_device(struct pci_dev *dev)
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
index 257b9f6f2ebb..bbc12934f041 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2191,6 +2191,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
+	mutex_init(&dev->enable_mutex);
 
 	return dev;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c2f082..28fecfdd598d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -416,6 +416,7 @@ struct pci_dev {
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
+	struct mutex	enable_mutex;
 
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
-- 
2.20.1

