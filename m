Return-Path: <linuxppc-dev+bounces-22088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB3FCD6E6E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:17:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlSs4V5Rz3bqV;
	Fri, 05 Jun 2026 12:17:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585331;
	cv=none; b=dwIJmKDCqdwqbh3fYdXNh4UCBatt7/0/ChN9hqy0xdF0yIq4rkAoFvXJZWOI/ZcSjEEC2F+di8K3gTDWpVf3AfqR04TAjX693qMvuVt+Q/JPxOp4mDAjq6GUMAHSxem8wtiKUWIzbIRj0Rjz2Wt/uOxiqS2ArLYYcbK47x5B56MxfBwqUpyfLq+rcl74TtUJvHQzSB9QQ/bsc18NF9fpUJUYdcMYsy49B/HxSHBGcYOsX6Xh3eloqrAqxH4CuJi4Gira1XcTHSyvceRiUiriZTMqO22Aga1toGvUCSowkl49r59BLssKxJfm3kaOh6gStt/3OV01LFtqSclfZdmrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585331; c=relaxed/relaxed;
	bh=WoqDAswymnFuDctzAHclbYUv6AH/JbUjYrzVeObwiVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+45yDFqiZ5WriwKL4g2aAeVLTKKKxf///pfSVgaEZSqOeOfio0ez4dBtojFHcDqwmPyCumQgky4AF+hScDyXgslzztJzONcYbTK8Nh17bwmGJkkESrb2r93LLLXqW/1SK03UREL63KmuIAOmwBzweH9irxqRatNaLcNnyZQeFc9Y1l2ElwVzgRSOQwqbFxHRZnQ918NHBEbtfxlrQ01vU3VFSZIbP+439k9bon0uclV5Xu7KvMM0pjXIj2ziThkFFjPw2GjvksI+eewdajTDP27krz5FnOsPfnHHAcgyuHlZ6gjUxNx+BbQi1Lfyvhg/9/u1/a+y4hLJo4686Zk9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wup4t0JP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wup4t0JP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTZ1CPCz2ybR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:02:10 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2bf77d4a4e2so11469015ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585328; x=1781190128; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoqDAswymnFuDctzAHclbYUv6AH/JbUjYrzVeObwiVA=;
        b=Wup4t0JP7NowDs56RzaUGmPe6+kcx3+afCCgTL1C5yfo3q0Qio5jO5vUH7GQ+BSXg7
         tKaXXr+6ALmiiJH7Kdu/EjNdVHs1QLuXOnJ0IYR+whD5RyD/WycVEwM51js7yuFrnitN
         BasbuNsJXOexjFdEufFIMHhi2uagp9AsP6hBh0pkrFuFQU/SM6Pio0+eIomcU7LvXX4i
         aO12SCy7jEOUX4aHpL9bnHIo3LiYfWBFKWhq7lI7OQLwkYgAKkakHDdv4JD8aq95gRH8
         8UaRPoUyQXbb0fAZs3JQ3Ro027KccDIwWCNytNPnO4v9tlyp9qLSIio+js2cP+Z0I3yx
         Ajpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585328; x=1781190128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WoqDAswymnFuDctzAHclbYUv6AH/JbUjYrzVeObwiVA=;
        b=ixQalHNwia/Yk7PlC05M9nuNonIOZHYPBkpxqAtSRRN8aNvqr2UEB4B2U603RfZuNw
         6108rqyEXh4jDEVz9HCUUwwtsQHzhi+rGvH+hjoUhzkB8kNd9x8CuevIDcaIlKrBMlrH
         nV+C49SJ5ow6ZWy3nBK3IgGq8c4apMq+jAcaiSfYnGx3YzQnDTmkNJgOoZvRigXapjnG
         9OT6b9DsVWEy58KuJY+reXmIoOPHEX2vjJxU946iEF4p2nfG7D0qffSkcvyQ6mnqHmn7
         5UUY/xE++wjGg2xVebhWXaj1zdUWyRohoGrRHPAXYi97v/GT3VLhsVKzxLnXxEEpEgMe
         hbgA==
X-Forwarded-Encrypted: i=1; AFNElJ/ssBqm1PnntFCpScgD7TI+QUaKoePk1It+oDVpieL8YgOgnWftKs3lAotCebqc4LYg7aKv7QWaQzDQIm0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywcu8X9QJ5s8u61vD2iZAL0Ulr6KH1SYGABVerDmmg5ook2jOJw
	VUkwChIzQtc+ej0/CA24PaDJkKPHqeCFRBKU4NQ7LcReWmz3Bsg9g7xJ
X-Gm-Gg: Acq92OE29S+nfnXZDuVygsuhbq/EoAMl+TWhsuC2fx/i90JVS40sBUrEthD1++zpJbC
	QpZMCZEQUalr/gAlEa626H2kz2U9JqkrLHGHXCfd9S8TokNdFJSYXOZzqpNs4ZGYdzfIMoVSAnZ
	4Lj9TAipedr6uMRavd2WsX1msSCk8si+j5gexl7bIv2kdJNWm7K6MwkR8vrwWWsfoNrk27WS/V4
	xckS96MDemVqdTPdgSyrqQqUpPXg7zGQ5RvA5A12Hp86npJgO+irw23K71M2xUL0PUZRXCc1Z49
	NtPhIVhkx8zPj4TfHGtvZI/KJJOtDSlLKN+BwObOWr090vixR6NOWoqJp55P/fPQIXIGUBpeM/v
	2gO+LyIyid2VBdv8WMsEe5iI1H+CQoOdpbL0wEpeNog9Wq8lgaok9kNfEZiIXihyvQ8QV0Jt+B9
	DCnLoUv89pibSrXM0GTlRXpuQmK7vdogRBWIZ5NG4=
X-Received: by 2002:a17:902:820e:b0:2c0:a858:8128 with SMTP id d9443c01a7336-2c197b1805fmr25629535ad.1.1780585327615;
        Thu, 04 Jun 2026 08:02:07 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm63879855ad.60.2026.06.04.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:06 -0700 (PDT)
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
Subject: [RFC 08/12] PCI: Add is_sriov bit to struct pci_dev
Date: Thu,  4 Jun 2026 08:01:49 -0700
Message-ID: <20260604150153.3619662-9-dimitri.daskalakis1@gmail.com>
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

We need a way to disambiguate the virtualization type of a PF/VF.
PFs may support multiple types of virtualization, while a VF should
only support one.

Tighten pci_is_sriov_physfn() / pci_is_sriov_virtfn() to ensure the
is_sriov bit is set. This allows the existing is_physfn/is_virtfn
bits to be agnostic of virtualization type.

No functional changes for SR-IOV.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 arch/s390/pci/pci_iov.c | 1 +
 drivers/pci/iov.c       | 4 ++++
 include/linux/pci.h     | 5 +++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_iov.c b/arch/s390/pci/pci_iov.c
index 13050ce5c3e9..82e9ef1f132f 100644
--- a/arch/s390/pci/pci_iov.c
+++ b/arch/s390/pci/pci_iov.c
@@ -53,6 +53,7 @@ static int zpci_iov_link_virtfn(struct pci_dev *pdev, struct pci_dev *virtfn, in
 		return rc;
 
 	virtfn->is_virtfn = 1;
+	virtfn->is_sriov = 1;
 	virtfn->multifunction = 0;
 	virtfn->physfn = pci_dev_get(pdev);
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 5de26057b99a..4aed4f6a42c3 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -326,6 +326,7 @@ static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
 	virtfn->vendor = dev->vendor;
 	virtfn->device = iov->vf_device;
 	virtfn->is_virtfn = 1;
+	virtfn->is_sriov = 1;
 	virtfn->physfn = pci_dev_get(dev);
 	virtfn->no_command_memory = 1;
 
@@ -897,6 +898,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 		iov->dev = dev;
 
 	dev->sriov = iov;
+	dev->is_sriov = 1;
 	dev->is_physfn = 1;
 	rc = compute_max_vf_buses(dev);
 	if (rc)
@@ -906,6 +908,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 
 fail_max_buses:
 	dev->sriov = NULL;
+	dev->is_sriov = 0;
 	dev->is_physfn = 0;
 failed:
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
@@ -926,6 +929,7 @@ static void sriov_release(struct pci_dev *dev)
 
 	kfree(dev->sriov);
 	dev->sriov = NULL;
+	dev->is_sriov = 0;
 }
 
 static void sriov_restore_vf_rebar_state(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 28892243f49f..ca84f66425b2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -479,6 +479,7 @@ struct pci_dev {
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
+	unsigned int	is_sriov:1;		/* SR-IOV is enabled on this device (PF or VF) */
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
@@ -606,12 +607,12 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 
 static inline bool pci_is_sriov_physfn(const struct pci_dev *dev)
 {
-	return dev->is_physfn;
+	return dev->is_physfn && dev->is_sriov;
 }
 
 static inline bool pci_is_sriov_virtfn(const struct pci_dev *dev)
 {
-	return dev->is_virtfn;
+	return dev->is_virtfn && dev->is_sriov;
 }
 
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
-- 
2.52.0


