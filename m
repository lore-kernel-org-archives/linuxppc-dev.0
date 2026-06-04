Return-Path: <linuxppc-dev+bounces-22092-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF1ECD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:18:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlTc3tbpz2yRM;
	Fri, 05 Jun 2026 12:18:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585347;
	cv=none; b=MA88xM+OGmSH6+FFGo9ThiT4crOpfYteVK1A/hBXO4V809/QuEqwOHEjCgzAoyJHvFgx32PlcMP0dKUhf+AOVgKURTrKz5jDRDXJZ2QJTd5OOBBWxmzjzdJ92eBd2gtsmXtfap5pCvr7/cHjwTuvM3k/IS13ojzKcSXAQCE3BzFE4jGRqk+2K08HErevhuuJRV/AC03pj16F1mxsmViVCo0sm7ZCd16WILKMjsIh5i8RK/WTYrZxBdegKc4raN6+IrOVjAMhmxQupxX/Rg0LV3riEGQdG8SADBThO2oHTuCS3PiQ0ihrXMkr7IhnjugefxipJYGN9Wz4F59o4hwH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585347; c=relaxed/relaxed;
	bh=xRdDzAJ66h/qKzlMtNZ7QYJac4Hlkm37yqxsR8KWCKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHfj4kiR3ZsvoWgvzhR+H8odt4gR+bCXIxGJ8Gi9KSoqpk2W348rnUWqwG7uAUKFLL0pD4874ipnQjORIxZ2zlG4DarFhuPawTxDLJaweABOozvrEEetjWB7ejRyw/lE4AhD6xdrTOUBO/ahF3sjKV1cjBt36bgxdyPCMu+bQyFNM5GFLvrD86AtCuh6G0MzNbJwSav9G610YtoAlpPJ07MDLy1yo2Iz4b037Z6LGF5UrmOmFmmHCIO64UTCtC1/izlFSB3L66xsMUDSgKY3nI25OnL7nzEBL7aIJN3fvplr4VwJh542FV42LNPmFjYDLuQUXXyXjkJrYYWD6kdaoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BG2jJ3PZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BG2jJ3PZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTt48wpz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:02:26 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-84230ab8857so377146b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585344; x=1781190144; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRdDzAJ66h/qKzlMtNZ7QYJac4Hlkm37yqxsR8KWCKU=;
        b=BG2jJ3PZheB0bMsfl4sBepl39PYNYZCWtk5dBDCT+XEwRBzndapD2ce6xSSLF8eD4O
         KUfNhm5f5uzhjKIEDsh6j9h95mNyqh5XN/E48tgMdDmPj7Jy54fe6jeo7gLsbDdb9oxh
         CeKn7AhPpByyBtGMOez7nCeAUVb6zb6xMk972lunnxHPSepnaeLe6/G7PI/o66cvjD8S
         r9zgZH6zP0aTcrNcj8xPEfB6IJbJ4mYxIWfEsz7lzWN7LZFR9c2vZebZ2fzauN/o7S/N
         GPIOCK65Eu2ey8GXlcTasJXKtKPLDnsfH2+WFXxde5czIzAxADPpAuhKRq1m+drNubk5
         HdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585344; x=1781190144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRdDzAJ66h/qKzlMtNZ7QYJac4Hlkm37yqxsR8KWCKU=;
        b=rFPujXpog/JAtV4K+Y4445bW7SDpNiPaCb+jpHlV1sDbmoILZqnqMhfI1CtqIUhcoQ
         yxjF06xOhWG9f9vhCb/I1r0yBOgwWah37hierrhD3RYtlbkgCDn03UVZZ+Wt2N4498cl
         YpclBCUnbOA+OdUEzW0kmlTQNa6/alvi1lRTbF5GyNvwzpOSRqwU3HKuCdfaRy0YEute
         bnIuTrWa2eIfwu0dnaLIG7a3jJJ3koGT1/LOUh6GZEfp4OGSwpLLnmmFt8PuX7NwTWah
         rpK5Aj1W7zeeF+W9c5XAGZxmmJzhY4QXds6PNujFhBEa+qHR54F3Yh59vsUEqGt6iPh2
         iLHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9frFu9oOqrbOAdUehtRBFvCXMn9cdFfKvyzVUfe0X4rT0DkM2aqSK941PjD6YPih9dHvaK2KiNt6sMHDo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymPVCgdRCF0pB0AbD2ihdM0kSg1F8FTm422zK8sWhQ31FIzUj+
	eELW4QXdGKoYtW7rMStqGSNoWY55PzlFdwot8aIbKI4KUbI7e74bwJH0
X-Gm-Gg: Acq92OFC+n3vciIHPxFMc5b3lH7IW7N8kAmVAhJLHmdFhGDzqRvZ1qpJryuEjTHjkPY
	TZNoUc+KIcndqNeFzJhwfRZDMJdZEU9tIgou8xANtG3Ei0qj6D62OPzvjZkzkXRDX76UG2Tbh6c
	oCvZj9Sqxy+MSZIy/MBzBAZkOSmlRyR9VovQnZ1PWSP1MAv2JGbczUdSLrB0c4XWw6sLcnvWnpI
	bP7k4s7MXSwHSRPun3+YhwTOy+LgdNdRIvmah5K42Zf6pAploa2E3QQPo1icLwVCq5JqBOctXd0
	CSB4ihEA7+2bZFDocdIDHMzO6F5/ueFAUsehDUuMedvL0uKOpd0rabbe0DwhiNclo9TgsIbK2/X
	J85/j0lIVMUsuNwM4qGd1WhSjtxwmtK1WnttqS5nO96AFxStplG1Cx3xOCE1HWJ85laLkWeir0L
	SpZtb8rWR4L4BVStWmyWTIW4LOqAf7nxwMETWLUtruxdVigE6H7A==
X-Received: by 2002:a05:6a00:218e:b0:842:5ad6:2d3 with SMTP id d2e1a72fcca58-84284ef2c41mr8159937b3a.38.1780585335784;
        Thu, 04 Jun 2026 08:02:15 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291a837sm6331464b3a.60.2026.06.04.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:15 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 12/12] PCI: Reserve bus range for SIOV devices
Date: Thu,  4 Jun 2026 08:01:53 -0700
Message-ID: <20260604150153.3619662-13-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
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

From: Dimitri Daskalakis <daskald@meta.com>

SDI routing IDs are computed from the PF's devfn plus an offset and
stride, exactly like SR-IOV VFs. When the stride pushes routing IDs
past the current bus number, additional bus numbers must be reserved
during PCI bus scanning to ensure the SDIs can be enumerated.

Add pci_siov_bus_range(), which walks all SIOV-capable PFs on a bus
and returns the maximum number of additional buses required. This
parallels pci_iov_bus_range() for SR-IOV.

The bus range is pre-computed during siov_init() by computing the bus
number of the last valid SDI.

Note: The PCIe 7.0 spec outlines an alternative RID assignment
algorithm for SDIs. The spec states a Virtualization Intermediary
(likely a hypervisor) after boot can compute the set of RIDs that are
valid for SDIs. There is a six step algorithm to compute this
RID allowlist. To keep things simple, we are only adding support for
strided RID assignments.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/probe.c |  4 ++--
 drivers/pci/siov.c  | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bebc32c8d374..9ef6827ab345 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3100,8 +3100,8 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	for (devnr = 0; devnr < PCI_MAX_NR_DEVS; devnr++)
 		pci_scan_slot(bus, PCI_DEVFN(devnr, 0));
 
-	/* Reserve buses for SR-IOV capability */
-	used_buses = pci_iov_bus_range(bus);
+	/* Reserve buses for SR-IOV and SIOV capability */
+	used_buses = max(pci_iov_bus_range(bus), pci_siov_bus_range(bus));
 	max += used_buses;
 
 	/*
diff --git a/drivers/pci/siov.c b/drivers/pci/siov.c
index 7372ce95714b..6405a8830052 100644
--- a/drivers/pci/siov.c
+++ b/drivers/pci/siov.c
@@ -111,3 +111,24 @@ void pci_siov_release(struct pci_dev *dev)
 	if (dev->siov)
 		siov_release(dev);
 }
+
+/**
+ * pci_siov_bus_range - find the max bus number consumed by SDIs
+ * @bus: the PCI bus
+ *
+ * Returns max additional buses consumed across all SIOV PFs on this bus.
+ */
+int pci_siov_bus_range(struct pci_bus *bus)
+{
+	int max = 0;
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (!dev->siov)
+			continue;
+		if (dev->siov->max_SDI_buses > max)
+			max = dev->siov->max_SDI_buses;
+	}
+
+	return max ? max - bus->number : 0;
+}
-- 
2.52.0


