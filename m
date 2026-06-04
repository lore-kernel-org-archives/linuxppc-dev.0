Return-Path: <linuxppc-dev+bounces-22082-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B60CD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:16:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlS25C8vz2xll;
	Fri, 05 Jun 2026 12:16:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585321;
	cv=none; b=DsAqn0CyMCOBUHi/HbveEaM93ksyxx5yi6z+lOX6AJ76L0Ld26G/yIZNvHR3bYZmOFqkKFs/2o2zHx0sZhrO6O6nQzRbnv95k1HBpEj/VV7BJGI56SpCMqVcBfqzPJqUHtyrCLfg+yQUtiP3L711so9/p5gw/FFGcMFSOyGcfsyVZbpfzmUgUR003fyL+FbueYsffccSppPvXfV6lzI01MPJoHKxNvz0d9CUej3h/GpXRmKQMS2JWZuv+etMiVcIEpGhjZm+Yw+I9id4h/xHXn/mJUIKQoi+WVfo0q5ZJLoAALkMYfm2m7AIcac6926RblJUSJgPrZZz3gEg2ZpKew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585321; c=relaxed/relaxed;
	bh=7P+ek6ocV5HFyMB6++Nc5HRt5X7Za6z5O1aRcqqwv/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaesxmeRk/5KGxxK+Z+z8VI8uiI1mzzkBxVssu8uRLVanUepME6WXszh6tmPDmpBpQCTJtAMk8BhoSpSVUaQUdQyBPQ4hMzxt8m2EzETFwcETpQDWmJY50FhXz9LzfDy6pePqLwXdQctiPaaDqyra+WT04n5lDdosEvBpmocKGlIPVnmNrl3RRHZ2JGP9MARU6uRmE25iz9NOJsSIgkO/o9bHGKkdJyAR4AjbKhQ0IafFBSMnmah6y0WcbG2DyKkui8Dstr2HcKobD8B1O/RY+0vQywEOLoIH886DWo6Cf6mtFWuOIYRbl+YqFrX1o3pZmWfp7wlcRA2L/eV7Y4mPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nop/zOdL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nop/zOdL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTN1hr6z2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:02:00 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2bea7176c72so5682645ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585318; x=1781190118; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7P+ek6ocV5HFyMB6++Nc5HRt5X7Za6z5O1aRcqqwv/w=;
        b=nop/zOdLqedGD/+7uIAyl5BXTyco9NI3Qzn7nhOeFiGDezJGl20NzpOOVbE4XfoCB+
         WMmpC6c7pnOHa9SVT2pkEq5xQOIaOKJMk5lgsGcOcgQG4S4+dZCeZoUzhZFjkt9roJL+
         x1UNzJWo9mEAIaZZvmou1L1POQAMmsDlYd3aoeZKCbnHmLjjJx/eBSRnjvMWjaZWLhWI
         RD42vPBSzQhM+0tkwo7WKSR4eLJQCFB+6oucgmBiYFn30djhKm04C3hqk9RRAFWyUfmw
         RoCUjbQrJ97Fq0ASSMWOQqeBM1Po6wzm+uFCVosJJFKsex5TTyEk+jqA5adNHxoqu0ZX
         74+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585318; x=1781190118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7P+ek6ocV5HFyMB6++Nc5HRt5X7Za6z5O1aRcqqwv/w=;
        b=pSGRyujqNUI9poVRuLZZE6Xt1lBqcPx4Lw0K4I0RY46HD7FbC9QilzFrgiOFlsqFur
         l+ksse43gIq33XYQ441rTNSnaSQ9CbLVNHHcc6CZl25LV3RofszXHpVlrgyGy0jSZVvO
         AI2XlHiWJK6A/lEIjkJ+Ec2plOTiJOHWMh3FdczSZ2ym0ox7DWLW8xMTSBZ/AGetcvRi
         vvpMgU59M2WojwSuwtC+Bz0DPdpobffD5lLKlhkBJpyrWsPY0wAN1oPAAlpOgiySaFvd
         0Jogl+sjyMTw4yh6zEgyrp27FJM+G9gpf0IJCWtJf7qBCKTxRR0898vmCAk9m6pp/Jb+
         W7Lw==
X-Forwarded-Encrypted: i=1; AFNElJ+6acFED/FmJlNeK9TxISeoYRhomlTk5qEYK6laeriSG8ub6ZjvkWXaRdrpJB6ivTQ7a7UufsMnsIez6CE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyoxhW4PPdW2DSjCr5SkRxSk7EV6Xxj+0XDz4MBrVpEmmLze0bb
	MnXbpTfKB7lHo7rkFbOhNsdvclzBRHeIlujjkUa9kP4aC4bTbpHwmjcw
X-Gm-Gg: Acq92OG1+GATujczV4FeZB5kVU+KO0k+ZIkGd9AoMxQRiPF5pjlMkqdZX8jAi5+iMYI
	QxzIP4QddnnXsHoQH921DoIptHoExsLOXaBvu3dh0AMPCDMLzTr8Xg3Rv5eoIFWeys7iV7Qsd2y
	YZq13nBP9JW/MLm17y1q/aMWWq6yNHMoPqgW8p/0sIhYNzQFIpitd0NiOFp9GUUk5Dq4TvLpthQ
	UY4qdkFQz0S2UFIFh9wEBNc38vze53y1UjS9OzghQWyPJLfIkXIwfFRv9Zob8RYqY8sfc2RbDo2
	SiZl2g5pDkPffmWpRRqQnEjgKvrzwH5ZUyiVH7puRQHysNOKBKJf+zx71l/jaUu21TBGY4s8bV7
	K2gSI3GuQ/38MclMfjGIdID4nESdO6SGBiUm0HfXCd571C6uT+MMmUKFJXpA8F6XHaHQ4
X-Received: by 2002:a17:903:948:b0:2bf:305a:310b with SMTP id d9443c01a7336-2c1639edf93mr84099595ad.1.1780585318015;
        Thu, 04 Jun 2026 08:01:58 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d40asm57714915ad.64.2026.06.04.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:57 -0700 (PDT)
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
Subject: [RFC 02/12] PCI: Convert iov.c to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:43 -0700
Message-ID: <20260604150153.3619662-3-dimitri.daskalakis1@gmail.com>
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

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/iov.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..5de26057b99a 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -23,7 +23,7 @@
 
 int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
 	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
 				    dev->sriov->stride * vf_id) >> 8);
@@ -31,7 +31,7 @@ int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 
 int pci_iov_virtfn_devfn(struct pci_dev *dev, int vf_id)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
 	return (dev->devfn + dev->sriov->offset +
 		dev->sriov->stride * vf_id) & 0xff;
@@ -42,7 +42,7 @@ int pci_iov_vf_id(struct pci_dev *dev)
 {
 	struct pci_dev *pf;
 
-	if (!dev->is_virtfn)
+	if (!pci_is_sriov_virtfn(dev))
 		return -EINVAL;
 
 	pf = pci_physfn(dev);
@@ -71,7 +71,7 @@ void *pci_iov_get_pf_drvdata(struct pci_dev *dev, struct pci_driver *pf_driver)
 {
 	struct pci_dev *pf_dev;
 
-	if (!dev->is_virtfn)
+	if (!pci_is_sriov_virtfn(dev))
 		return ERR_PTR(-EINVAL);
 	pf_dev = dev->physfn;
 	if (pf_dev->driver != pf_driver)
@@ -152,7 +152,7 @@ static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
 
 resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	return dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)];
@@ -300,7 +300,7 @@ static umode_t sriov_vf_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (!pdev->is_virtfn)
+	if (!pci_is_sriov_virtfn(pdev))
 		return 0;
 
 	return a->mode;
@@ -604,7 +604,7 @@ static umode_t sriov_pf_attrs_are_visible(struct kobject *kobj,
 {
 	struct device *dev = kobj_to_dev(kobj);
 
-	if (!dev_is_pf(dev))
+	if (!dev_is_sriov_pf(dev))
 		return 0;
 
 	return a->mode;
@@ -707,7 +707,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		if (!pdev)
 			return -ENODEV;
 
-		if (!pdev->is_physfn) {
+		if (!pci_is_sriov_physfn(pdev)) {
 			pci_dev_put(pdev);
 			return -ENOSYS;
 		}
@@ -814,7 +814,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 
 	ctrl = 0;
 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
-		if (pdev->is_physfn)
+		if (pci_is_sriov_physfn(pdev))
 			goto found;
 
 	pdev = NULL;
@@ -1006,7 +1006,7 @@ int pci_iov_init(struct pci_dev *dev)
  */
 void pci_iov_release(struct pci_dev *dev)
 {
-	if (dev->is_physfn)
+	if (pci_is_sriov_physfn(dev))
 		sriov_release(dev);
 }
 
@@ -1018,7 +1018,7 @@ void pci_iov_remove(struct pci_dev *dev)
 {
 	struct pci_sriov *iov = dev->sriov;
 
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return;
 
 	iov->driver_max_VFs = iov->total_VFs;
@@ -1035,7 +1035,7 @@ void pci_iov_remove(struct pci_dev *dev)
  */
 void pci_iov_update_resource(struct pci_dev *dev, int resno)
 {
-	struct pci_sriov *iov = dev->is_physfn ? dev->sriov : NULL;
+	struct pci_sriov *iov = pci_is_sriov_physfn(dev) ? dev->sriov : NULL;
 	struct resource *res = pci_resource_n(dev, resno);
 	int vf_bar = pci_resource_num_to_vf_bar(resno);
 	struct pci_bus_region region;
@@ -1111,7 +1111,7 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
  */
 void pci_restore_iov_state(struct pci_dev *dev)
 {
-	if (dev->is_physfn) {
+	if (pci_is_sriov_physfn(dev)) {
 		sriov_restore_vf_rebar_state(dev);
 		sriov_restore_state(dev);
 	}
@@ -1124,7 +1124,7 @@ void pci_restore_iov_state(struct pci_dev *dev)
  */
 void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool auto_probe)
 {
-	if (dev->is_physfn)
+	if (pci_is_sriov_physfn(dev))
 		dev->sriov->drivers_autoprobe = auto_probe;
 }
 
@@ -1141,7 +1141,7 @@ int pci_iov_bus_range(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (!dev->is_physfn)
+		if (!pci_is_sriov_physfn(dev))
 			continue;
 		if (dev->sriov->max_VF_buses > max)
 			max = dev->sriov->max_VF_buses;
@@ -1161,7 +1161,7 @@ int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 {
 	might_sleep();
 
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -ENOSYS;
 
 	return sriov_enable(dev, nr_virtfn);
@@ -1176,7 +1176,7 @@ void pci_disable_sriov(struct pci_dev *dev)
 {
 	might_sleep();
 
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return;
 
 	sriov_disable(dev);
@@ -1191,7 +1191,7 @@ EXPORT_SYMBOL_GPL(pci_disable_sriov);
  */
 int pci_num_vf(struct pci_dev *dev)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	return dev->sriov->num_VFs;
@@ -1212,7 +1212,7 @@ int pci_vfs_assigned(struct pci_dev *dev)
 	unsigned short dev_id;
 
 	/* only search if we are a PF */
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	/*
@@ -1228,7 +1228,7 @@ int pci_vfs_assigned(struct pci_dev *dev)
 		 * It is considered assigned if it is a virtual function with
 		 * our dev as the physical function and the assigned bit is set
 		 */
-		if (vfdev->is_virtfn && (vfdev->physfn == dev) &&
+		if (pci_is_sriov_virtfn(vfdev) && (vfdev->physfn == dev) &&
 			pci_is_dev_assigned(vfdev))
 			vfs_assigned++;
 
@@ -1254,7 +1254,7 @@ EXPORT_SYMBOL_GPL(pci_vfs_assigned);
  */
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -ENOSYS;
 
 	if (numvfs > dev->sriov->total_VFs)
@@ -1279,7 +1279,7 @@ EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
  */
 int pci_sriov_get_totalvfs(struct pci_dev *dev)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	return dev->sriov->driver_max_VFs;
@@ -1301,7 +1301,7 @@ int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn)
 
 	might_sleep();
 
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -ENODEV;
 
 	if (pci_vfs_assigned(dev)) {
-- 
2.52.0


