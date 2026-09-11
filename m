Return-Path: <linuxppc-dev+bounces-27131-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4E1C88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 13:36:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhFvW5pJbz2yrL;
	Fri, 11 Sep 2026 23:36:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789129754;
	cv=none; b=i/JAjpjPYI2E4NqQbsMJwjRiwbgf+C25Sf17ZN27GL2ib6yiEOJTjEM6MHBngtcx3/55cjCp6lnyaL1NNu5kYiA0GdnVu91NsyWvt2Be0IOK28HiazmnJ6rEQ1jvkhjwSy7JZgDX5wtixFSeXVRiHZ0lbmw8w5g3Mrg5RY9E7+cJ6EBNFszdhyJYgNemnd/6fs413jrZtdajeQPfW05aakcxyotyXvUb3+GLP6cqx2U7Re2UPo9OetMP4/FHJteQui/1sum/woiUHp2cs0xTMZbYU4DOOwAn02y3eFsr88ITl/u265NREc2h6f7AMyjJ8VTzsKNQ4OQSMXyKcRcj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789129754; c=relaxed/relaxed;
	bh=f0dNMrQX9nlSUWSHEteekI596QsuKLoL7NzPMKWWv2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNPD9464vQQucjZZO6VeA3VIRliDWNviem9H3/tqYv3O2sMOJgzh5AU9A7KqwJqEE4UAgIy9OjaSdwQCnTf5eGXhTCOfFUXpPtxai5FzV1j4tYvU1FA8HjpwC8nxmU8bk8KspbnfwHSprY4x8OeBDXIqZuWTlPaT0Ln3LcR2cfmnMPtwA/5b/3ynJBoCmWOEtgS9C8XyDO5P2sOXUi9NMPsSiKg8l73dt2SE96Bhrq9S2HDWsV0enE7K7XdVVVHsQrM7Sape/qpQyuXgYpy0yO6JhIlFfL0s4mTeiw3BL+BgcivnvMBQ0vN5b7r847pqMllHyViuViPeomYN+FC2Ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=BGhvyKf9; dkim-atps=neutral; spf=pass (client-ip=35.83.148.184; helo=pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org) smtp.mailfrom=amazon.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=BGhvyKf9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amazon.de (client-ip=35.83.148.184; helo=pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org)
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhDPQ0DgFz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 22:29:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789129754; x=1820665754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f0dNMrQX9nlSUWSHEteekI596QsuKLoL7NzPMKWWv2s=;
  b=BGhvyKf9t/L7j85Wxt4o7I1yBM6K/cGDj92QWkoT5o5ksKSa4yf8wx1w
   5mdh/8WASCap6hLOdhdp3zDTGGxC+LRMY8CQLJwCdQfsa12UphlG6spwm
   CoTHd45ZSHrHuGHrf/OsXi9zJnnjARiWDZFXTK0Jyb5JTMFNuQmW5OwLG
   83ydM+FUJPOzDOrUTW99gaGBxkyYO8pR+lNGEeqA+fMd2cRkWnvsnSqrA
   EwHnqmqonr7zBm0KTRQFC7p/YquUmVBscalu00zAb8lue+rm1IxfBGGTl
   PvIcYAWGIJXji0W2TbhTvFnQeDqtaVD1tcBBwDfN62d9+x36SJnAe/Axh
   A==;
X-CSE-ConnectionGUID: wIn58uYPQ96TRm2APJ38+g==
X-CSE-MsgGUID: rUD9oqXSTHOsAxr+5f17IQ==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28215968"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:29:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:12471]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.160:2525] with esmtp (Farcaster)
 id 2742a140-836f-44a1-bad7-d2f5f8a45c98; Fri, 11 Sep 2026 12:29:08 +0000 (UTC)
X-Farcaster-Flow-ID: 2742a140-836f-44a1-bad7-d2f5f8a45c98
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:29:08 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:29:05 +0000
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
Subject: [RFC PATCH 2/8] PCI/IOV: Create virtfn buses up front in sriov_add_vfs()
Date: Fri, 11 Sep 2026 14:29:04 +0200
Message-ID: <20260911122904.85386-1-sakacpav@amazon.de>
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
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

virtfn_add_bus() is find-then-create and therefore assumes external
serialization. Create every virtfn bus before adding any VF, taking the
bus-create path out of the per-VF loop so a later commit can run the
per-VF adds concurrently against a stable bus set. Bus numbers are
already fixed before the loop, since pci_iov_set_numvfs() has latched
offset and stride.

The cleanup pass must remove only buses this enable created, because
virtfn_remove_bus() checks that a bus is empty rather than who created
it, so virtfn_add_bus() now reports whether it created the bus and
sriov_add_vfs() records that per VF id in a bitmap. Return early for
num_vfs == 0: kvcalloc(0, ...) returns ZERO_SIZE_PTR and a later commit
dereferences buses[0] unconditionally.

Several ids can share one bus number; only the creating id's bit is set.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/iov.c | 60 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 1826d32a2364..dda9303516f5 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/log2.h>
 #include <linux/pci.h>
@@ -124,10 +125,14 @@ static int compute_max_vf_buses(struct pci_dev *dev)
 	return rc;
 }
 
-static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
+static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr,
+				      bool *created)
 {
 	struct pci_bus *child;
 
+	if (created)
+		*created = false;
+
 	if (bus->number == busnr)
 		return bus;
 
@@ -140,6 +145,8 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 		return NULL;
 
 	pci_bus_insert_busn_res(child, busnr, busnr);
+	if (created)
+		*created = true;
 
 	return child;
 }
@@ -394,7 +401,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	struct pci_bus *bus;
 	int rc;
 
-	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
+	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id), NULL);
 	if (!bus)
 		return -ENOMEM;
 
@@ -632,22 +639,67 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
 
 static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 {
+	unsigned long *created_buses;
+	struct pci_bus **buses;
+	struct pci_bus *bus;
 	unsigned int i;
 	int rc;
 
-	if (dev->no_vf_scan)
+	if (!num_vfs || dev->no_vf_scan)
 		return 0;
 
+	buses = kvcalloc(num_vfs, sizeof(*buses), GFP_KERNEL);
+	if (!buses)
+		return -ENOMEM;
+
+	created_buses = bitmap_zalloc(num_vfs, GFP_KERNEL);
+	if (!created_buses) {
+		kvfree(buses);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < num_vfs; i++) {
-		rc = pci_iov_add_virtfn(dev, i);
+		bool created;
+
+		buses[i] = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, i),
+					  &created);
+		if (!buses[i]) {
+			rc = -ENOMEM;
+			goto remove_buses;
+		}
+		if (created)
+			__set_bit(i, created_buses);
+	}
+
+	for (i = 0; i < num_vfs; i++) {
+		rc = __pci_iov_add_virtfn(dev, buses[i], i);
 		if (rc)
 			goto failed;
 	}
+
+	bitmap_free(created_buses);
+	kvfree(buses);
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
 
+remove_buses:
+	/*
+	 * Remove only buses this enable created: several ids can share one
+	 * bus and only the creating id is recorded; virtfn_remove_bus()
+	 * checks emptiness, not ownership.  Re-look each up by number --
+	 * the VF unwind above may already have freed it.
+	 */
+	for_each_set_bit(i, created_buses, num_vfs) {
+		bus = pci_find_bus(pci_domain_nr(dev->bus),
+				   pci_iov_virtfn_bus(dev, i));
+		if (bus)
+			virtfn_remove_bus(dev->bus, bus);
+	}
+
+	bitmap_free(created_buses);
+	kvfree(buses);
 	return rc;
 }
 
-- 
2.47.3


