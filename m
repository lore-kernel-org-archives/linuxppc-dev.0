Return-Path: <linuxppc-dev+bounces-27135-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CA0C88E56
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 13:37:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhFw71RCkz2yxB;
	Fri, 11 Sep 2026 23:37:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789129972;
	cv=none; b=iruRaF5DDrIC2V6ybfTicFGTky2x8y2sQ1X/wr7BdZcUnB5JHOM51Cbg7UfiispqLEI8ybYpc5frl9gijeLpEBQ1YRxkNI2/vtBrfcVSgB04pIh+9bJ5oViZMHP/Ecf7iEb7JUraJ3Fj7QNuaqaQtYiBmpeWZTexMduQgR/ppVAHp1oFbT8QpD+uJQd6FBDOcM8Gy+kcOoqBG6h3govgAlDj5IvT28nz95alMuT6xHjV3UbJqlb/Dype3c75RAw5oNcgDk9t7eoZzrRif+r75v4eNHZyQUlCZOaiVd4iIJlj0fOcBUXKrGZF62P0KRho4vfyMPuQJ/yj8GuXrMqoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789129972; c=relaxed/relaxed;
	bh=Ltbq+GWhG/1KvJm+1fqt+ZO5n9zoPu7qeY/Gw0JRs8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkProUWf6FQW+Ra7itNwIlpChEIQxrP99a5s6RTZDnZrhhnQKItVv82bgVFP0c2C8x23yJu00dbvGJOxD5Bx90ccvXBdo6vpbWVZEZ4GJySM+Hw2eFtT1RPrqGKQxCK8O7IrE34xAc7vyITXWlJnNizZQ1RpZVnYSkfObOGKtRfiEwDz5L1EmcloJ9hr0r0o/ZhVOEchBzMZEtdY5wND0YEgHIneSJuceUHhcs7RUEdIb7irJGLqHB/qtV8to8xTDjisdqWt4Kl8OR8M5pfB/IZRNNNoI5oyOke+IIPudTHWhFuFwY/gAt6VqhNTxNqGAwZCwa84ZzITf4cpzkY5fQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=fsXNNtmp; dkim-atps=neutral; spf=pass (client-ip=35.162.73.231; helo=pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org) smtp.mailfrom=amazon.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=fsXNNtmp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amazon.de (client-ip=35.162.73.231; helo=pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org)
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhDTb1ryJz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 22:32:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789129971; x=1820665971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ltbq+GWhG/1KvJm+1fqt+ZO5n9zoPu7qeY/Gw0JRs8Q=;
  b=fsXNNtmpAvUyiYcK59E33VNLrLwcqk6DUQ/xMzjDNSECXwiua7gHleex
   wvTJWsf/8TUHGEBs5nFMuG1coXqdFClUhmSoF/1MYDC4QvbWTNet8RSPC
   SdFL9PJBcKLBCHXSTCjwkmxoTnvPs+9YPa2TBlhEvUjdFRQHRlbuCLdv1
   l5GsmvSZHscHnBjMLae/Vfu8p6zC7UyL5kxThRGPYAjDXOPn+y5MldfZ1
   Qp2GszG/ZNk5kpQVSfhxsN1lgls2s6UUrzgDxQArSbzHSwJDKS4WhbXOi
   cOHPWoj/l4m2rQ49Ce8xlQSrreC8q6GwtVv7ZtVr2ITBR+blQ6EepaKvF
   g==;
X-CSE-ConnectionGUID: 2DIrQMtuQdu/rLuQKS2jXQ==
X-CSE-MsgGUID: MvMsu7H/QwOI0AyHD2ETgg==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28221489"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:32:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:23580]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.113:2525] with esmtp (Farcaster)
 id beb290be-5da5-4822-b0d6-73219791d65a; Fri, 11 Sep 2026 12:32:45 +0000 (UTC)
X-Farcaster-Flow-ID: beb290be-5da5-4822-b0d6-73219791d65a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:32:45 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:32:42 +0000
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
Subject: [RFC PATCH 6/8] PCI/IOV: Let sriov_add_vfs() own the failure unwind
Date: Fri, 11 Sep 2026 14:32:41 +0200
Message-ID: <20260911123241.3312-1-sakacpav@amazon.de>
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
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

__pci_iov_add_virtfn() unwinds its own sysfs-link failure with
pci_stop_and_remove_bus_device(), which lockdep-asserts
pci_rescan_remove_lock. The next commit runs __pci_iov_add_virtfn() from
async workers that must never take or require that lock, so the unwind
has to move to the enabling task.

Leave __pci_iov_add_virtfn() reporting only and let each caller unwind
through pci_iov_remove_virtfn(), whose lookup-based design is correct at
every failure stage. sriov_add_vfs() unwinds ids 0..i inclusive on
failure of VF i, since VF i may be registered but not yet linked. The
wrapper unwinds fully before returning, because its EEH caller discards
the return code: the VF is removed through pci_iov_remove_virtfn(),
which also frees the bus it empties, and a bus this call created with
no VF registered on it is removed explicitly.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/iov.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index dda9303516f5..a32b2c295922 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -383,35 +383,42 @@ static int __pci_iov_add_virtfn(struct pci_dev *dev, struct pci_bus *bus,
 	pci_device_add(virtfn, virtfn->bus);
 	rc = pci_iov_sysfs_link(dev, virtfn, id);
 	if (rc)
-		goto failed1;
+		return rc;
 
 	pci_bus_add_device(virtfn);
 
 	return 0;
-
-failed1:
-	pci_stop_and_remove_bus_device(virtfn);
-	pci_dev_put(dev);
-
-	return rc;
 }
 
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
 	struct pci_bus *bus;
+	bool created;
 	int rc;
 
-	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id), NULL);
+	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id), &created);
 	if (!bus)
 		return -ENOMEM;
 
 	rc = __pci_iov_add_virtfn(dev, bus, id);
-	if (rc)
-		virtfn_remove_bus(dev->bus, bus);
+	if (rc) {
+		pci_iov_remove_virtfn(dev, id);
+		/*
+		 * Same ownership and stale-pointer rules as the
+		 * sriov_add_vfs() bus unwind.
+		 */
+		if (created) {
+			bus = pci_find_bus(pci_domain_nr(dev->bus),
+					   pci_iov_virtfn_bus(dev, id));
+			if (bus)
+				virtfn_remove_bus(dev->bus, bus);
+		}
+	}
 
 	return rc;
 }
 
+/* Unwind primitive for partial adds: a missing VF must stay a silent no-op. */
 void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
 {
 	char buf[VIRTFN_ID_LEN];
@@ -681,8 +688,10 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	kvfree(buses);
 	return 0;
 failed:
-	while (i--)
+	/* VF i may be partially added: unwind ids 0..i inclusive. */
+	do {
 		pci_iov_remove_virtfn(dev, i);
+	} while (i--);
 
 remove_buses:
 	/*
-- 
2.47.3


