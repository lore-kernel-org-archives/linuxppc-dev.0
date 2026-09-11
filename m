Return-Path: <linuxppc-dev+bounces-27130-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8280EC88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 13:36:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhFvK6Vb2z2ypW;
	Fri, 11 Sep 2026 23:36:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789129702;
	cv=none; b=NyieD/3sHOC+ZzHLmt6+XBEKkw8QzXIJrSko9t6LmVidbkUKGoUQBsQiMdXS9oLTq95pYAvwdI0/gfXcTJmdx8r4qejxcyl6foJ+f8mUyldVj/0X9Li9k29Pb9aGXK+HYadXdCHPL+ICyCYHZQFOSd6y2rQSWtuiRrmBnnFVFbZz4w9UO6m9LU8GuuX8YBVI6TZ5BQOMOWvXk9XkpAQj1FnHmpDUxMQJn32KhaILrC1AZGY1WSgEv85fP8dH30/kTeDWLCrVAXSpo0DcbI5SVXw0a2RDJtZqhDad0XTjaOmoI63P2xJDdlElJqfrAW1EJ3PrVPqRQFi0eOAWNWqG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789129702; c=relaxed/relaxed;
	bh=Rdyf/8Ttgw33V+vNGIFbMELJ7FZ26Y0HGkd+2ks6jXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AM97Dkwa/eAaB1DvSyuJIj/MUkouM+fPtZJ7j77LHTvB8fvOgbvGlLnBQwVRsKMzGCLLRIIip3pglN2j/6R457MyvSWcrI+zkAsTHPzo7lO8eGIzUn4tqol5Vwd5cUv/0IyuW0CDr6oN4tGsC1yQZegGQQvUpEy2whwgITDPIP8/ZHWaWGMBaTxmn7IvCa7QOlRRx6xpPyj6JWkDBzY7okjqrJac08EwyCwuDyH3lh/zIWuxSnVtq2vZs2s87UNFCFJhdQlyBf3HBR20o/BmOghwI4rIqzIAZGIkCrpSuGOUdTJu30z8OoYHlQFM7iBhvm8tlzpgAco1hiumfDNWsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=betd757i; dkim-atps=neutral; spf=pass (client-ip=44.245.243.92; helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org) smtp.mailfrom=amazon.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=betd757i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amazon.de (client-ip=44.245.243.92; helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org)
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhDNP074Jz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 22:28:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789129701; x=1820665701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rdyf/8Ttgw33V+vNGIFbMELJ7FZ26Y0HGkd+2ks6jXI=;
  b=betd757iDEjXDOKgM0CjOoJ5j67+AhE7Na9bgiGuCNEtlOaNnTyrrOzW
   UN37OutideC8lr5DohumHa50sMzHdjnSUApO9B0Uy7Fz75XcVYERf+N5h
   FBOM4FXRINDdHkXQhJCfYJZNxQsE4Cd3SC8wv3vXBAHo+FTayCyvMUVIL
   4jnEj0q5b+iCbUO+nChfnkGgxgXgnUNiau9+vI4Oe8w99SCX4e7IzrL2m
   rTDx9fmZtDyyKqKGDNrHRDlPTmUAhwL3UbXcAv2YbNXdVTZ5xYfLDf99O
   hz3668a0zhSV+ehefugQz1nFfvUHXe/tpIFTDxKBlTz3XNJTuPjQOqSVs
   w==;
X-CSE-ConnectionGUID: qGcm9O6eS2WTX6u9iGMBPg==
X-CSE-MsgGUID: JxZKmnZMSe6zlBWCIJeRvw==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="27923845"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:28:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:6057]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.34:2525] with esmtp (Farcaster)
 id b9a7c6f5-244d-4b45-b807-db7ef58f2f97; Fri, 11 Sep 2026 12:28:14 +0000 (UTC)
X-Farcaster-Flow-ID: b9a7c6f5-244d-4b45-b807-db7ef58f2f97
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:28:14 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:28:11 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Matlack
	<dmatlack@google.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kees Cook <kees@kernel.org>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, "Ionut
 Nechita" <ionut.nechita@windriver.com>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 1/8] PCI/IOV: Split virtfn bus handling out of pci_iov_add_virtfn()
Date: Fri, 11 Sep 2026 14:28:04 +0200
Message-ID: <20260911122804.80063-1-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
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
Content-Type: text/plain
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

pci_iov_add_virtfn() creates the virtfn bus, scans and registers the VF,
and removes the bus again on failure. A later commit creates all virtfn
buses up front, so separate the bus-lifetime concern from the VF-add
concern: move the VF add into a new __pci_iov_add_virtfn() taking the bus
as an argument, and keep bus creation and on-failure bus removal in the
public wrapper.

No functional change intended.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/iov.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9d408fb8ac25..1826d32a2364 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -343,25 +343,17 @@ static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
 	return virtfn;
 }
 
-int pci_iov_add_virtfn(struct pci_dev *dev, int id)
+static int __pci_iov_add_virtfn(struct pci_dev *dev, struct pci_bus *bus,
+				int id)
 {
-	struct pci_bus *bus;
 	struct pci_dev *virtfn;
 	struct resource *res;
 	int rc, i;
 	u64 size;
 
-	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
-	if (!bus) {
-		rc = -ENOMEM;
-		goto failed;
-	}
-
 	virtfn = pci_iov_scan_device(dev, id, bus);
-	if (IS_ERR(virtfn)) {
-		rc = PTR_ERR(virtfn);
-		goto failed0;
-	}
+	if (IS_ERR(virtfn))
+		return PTR_ERR(virtfn);
 
 	virtfn->dev.parent = dev->dev.parent;
 	virtfn->multifunction = 0;
@@ -393,9 +385,22 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 failed1:
 	pci_stop_and_remove_bus_device(virtfn);
 	pci_dev_put(dev);
-failed0:
-	virtfn_remove_bus(dev->bus, bus);
-failed:
+
+	return rc;
+}
+
+int pci_iov_add_virtfn(struct pci_dev *dev, int id)
+{
+	struct pci_bus *bus;
+	int rc;
+
+	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
+	if (!bus)
+		return -ENOMEM;
+
+	rc = __pci_iov_add_virtfn(dev, bus, id);
+	if (rc)
+		virtfn_remove_bus(dev->bus, bus);
 
 	return rc;
 }
-- 
2.47.3


