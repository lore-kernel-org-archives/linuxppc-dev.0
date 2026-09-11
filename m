Return-Path: <linuxppc-dev+bounces-27134-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA94C88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 13:37:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhFw05vWrz2yqw;
	Fri, 11 Sep 2026 23:37:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789129915;
	cv=none; b=nDDqkyp9FahcJXIeIm2u4PnAmPHwv7a6idzo3TUpoZUMLxch0AjnWlBJxHVDoV+qiyodoDH7Y9gRbx8zArZxOdFfC11EBdah2QVxQ5JkfxDJ7HeXlIOzI4s7/UOiFqxMYCi+5hD17MqgHsIjm3AX5eGUXbyQ33kEJBi4qCNtdUKSDQX1gLZe/yAofZTxWTOymBRt+L4ePVhEeKA609tssRidT1kSyS/hW3edWC0mirF08H5PZOCliEhBJJ21DDHZ4ICAGh63PwxXn2F4n0GMNPVjFyIFThhotoTVSitcrBGu0Lg2D/5SVynstdhzNO1NxzwOATL8JfWkmW1g47K94g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789129915; c=relaxed/relaxed;
	bh=uaHpFCf9InS1VfMhfcAUazBouVXMvz/Y4XYVoqAOo5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnAekra+buEKXVTFTV9S1MwsmKmAaW0HGQgZ7i0emI4Atanclf71SyAkBCwSyBCl3wXSbzXvP8pn1h2q70W5B+LKI/HJ9+Qf7sg2N2HRqbKW6JSaVtgeImHCfIcsFIubUfkjbqQSezdzQ2Lwz/qcFUMFTOryKMT5YqEIebwnoT+j7hC8Is24A6Qa6BQ2XqJHBmhSeTlFJwQfxxp7aYTDf68G/+Zm92Cga/xtynHBwNhd8Ve9AziF/CJFtiQd2sDdvYoBWRFYoGcJ6ORSI21dXfzkdvhNCYygs5fRiBxO2dDkGMjpwNhoFWMud0/MGIhuI/+WJjMzAGrgP76R3TJy3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=RDpJOevT; dkim-atps=neutral; spf=pass (client-ip=35.83.148.184; helo=pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org) smtp.mailfrom=amazon.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=RDpJOevT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amazon.de (client-ip=35.83.148.184; helo=pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=707927bfc=sakacpav@amazon.de; receiver=lists.ozlabs.org)
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhDSV05pmz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 22:31:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789129914; x=1820665914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uaHpFCf9InS1VfMhfcAUazBouVXMvz/Y4XYVoqAOo5k=;
  b=RDpJOevT0AVWCn9nMhd1j03QndJ7GFEedYtsAUnfU2THv9GFJU48Rg0X
   O6KxWqel+FzpcZeUcQ9IXuH6G/qJ2vVfYVQnXszFvNG34pmNy9HD+76Lu
   hHcAqsv5TDn2nx7Kq0lI0+bBdQoMGtA0GwiuGY1BtWg8HOgycoNsoiaUb
   IiDFuuhp+Q5eZ8Lod3l/DleDOTob4QQwGpYqNPo/5plS5lF/7ry1J0pUH
   kg+pUFOUBiyuMreVBO7s64MUAKHT+hQcrAs6qX2WrGUFvM4Ari0aP73UE
   JFEuwPIJ1arLwbZfTrIEchQZLFxVRFLJafyZNjGGV41CJWBtdsU12Ofem
   Q==;
X-CSE-ConnectionGUID: 4qH0kDm0QqiBa/83nnHZYQ==
X-CSE-MsgGUID: ERk3P2wWQmek5gdyP0r88w==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28216167"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:31:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:21641]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.93:2525] with esmtp (Farcaster)
 id 5cb3e6e0-d9b0-4a56-aa7b-619d6898f09c; Fri, 11 Sep 2026 12:31:51 +0000 (UTC)
X-Farcaster-Flow-ID: 5cb3e6e0-d9b0-4a56-aa7b-619d6898f09c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:31:51 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:31:48 +0000
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
Subject: [RFC PATCH 5/8] powerpc/pci: Serialize pcibios_bus_add_device()
Date: Fri, 11 Sep 2026 14:31:47 +0200
Message-ID: <20260911123147.97312-1-sakacpav@amazon.de>
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

The pseries and powernv pcibios_bus_add_device() hooks insert the device
into the EEH PE tree with bare list manipulation that
arch/powerpc/kernel/eeh.c itself flags as unlocked, and for SR-IOV the
pseries hook attaches every VF's eeh_dev to the shared physfn PE. Every
caller is serialized by enumeration context today; an upcoming change
runs pci_bus_add_device() for sibling VFs concurrently and makes the race
reachable.

Serialize the platform hook dispatch with an arch-local mutex. Exclusion
against the EEH recovery thread stays carried by pci_rescan_remove_lock,
and on probe-path enables the residue folds into the pre-existing
exposure described in a later patch in this series ("PCI/IOV: Initialize
virtual functions in parallel"). A proper PE-tree lock is a larger EEH
cleanup, so eeh_pe.c is left alone.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 arch/powerpc/kernel/pci-common.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 4fc52c21fe5d..21cccd0e97f8 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1046,6 +1046,15 @@ void pcibios_setup_bus_self(struct pci_bus *bus)
 		phb->controller_ops.dma_bus_setup(bus);
 }
 
+/*
+ * The pseries/powernv hooks update the shared EEH PE tree with no
+ * internal locking; serialize concurrent sibling VF additions.
+ * Removal-side updates do not take this lock: additions are
+ * drained before any unwind, and the sysfs enable and EEH paths
+ * hold pci_rescan_remove_lock.
+ */
+static DEFINE_MUTEX(pcibios_bus_add_device_lock);
+
 void pcibios_bus_add_device(struct pci_dev *dev)
 {
 	struct pci_controller *phb;
@@ -1068,8 +1077,11 @@ void pcibios_bus_add_device(struct pci_dev *dev)
 	if (ppc_md.pci_irq_fixup)
 		ppc_md.pci_irq_fixup(dev);
 
-	if (ppc_md.pcibios_bus_add_device)
+	if (ppc_md.pcibios_bus_add_device) {
+		mutex_lock(&pcibios_bus_add_device_lock);
 		ppc_md.pcibios_bus_add_device(dev);
+		mutex_unlock(&pcibios_bus_add_device_lock);
+	}
 }
 
 int pcibios_device_add(struct pci_dev *dev)
-- 
2.47.3


