Return-Path: <linuxppc-dev+bounces-18656-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F467F532C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 01:01:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffsDQ6jjzz2yVB;
	Tue, 24 Mar 2026 12:01:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774314070;
	cv=none; b=Cq6bp8uOvq96U4fPDCESyHa5W3sP89uyiaN/RzZ4ScHwEO/4Dw8dnXinQ9fqfOVjexFbD/o1Fs1mclxQNNCnxO+0FszBVBYsHs9C2QiJ0gECQdc4PP1dn1m+DUNgD/3e7Xe6vNzZ1HGVleiCFajFzlBPjjNhvxGpOQU3WvwXtP9NT8AesA0YUIINg1xMm2ExdX5Em7mHvwLHJDtELdBPVaxIo/RHBfuoPT5snOEUhNEp/IN73O8cApWhrP2Lj92NAvGStKo+sKqgfGJrmvW2czrIDaFN495unhPhdkdcEWa01l9QgcURnSCjTGZK+OW9Y7vd/L4skut7VJlf+Za4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774314070; c=relaxed/relaxed;
	bh=R9hS0Coi1z6CfHjgu38NsWnlAIE2XRyrESfEMKeS3Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvXfju064UAR+aUWeut9u6UEkLir3heX+Ri/S1YqhYeq62hDQy/HmdGri/V+s9JiI42OwYP7ggqPsbao97RItV+vx3ecz5eXiE1GdXm5Y9nIxAMv8UW1GPjyUU90V1HqtgiF+tFnfXbkE7cJr7X9m3HQy3TQ1stL0wUuIny1CtPdSoz43I+mk1qp25C8M5e/nkVt6xWlJn4eG8MkFPrIcjvgKnYm5g5QqYXd6ynnulvZdSr/gAThm5aQxUjfp/yxgcaG+zEQ+QiVE+guLGBB2qK6vHoZ2ZcE4xbkidddXp+8XqpjODRKBddHmeKj4wWParHsfDgUzMZANX4JmiWXBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=erU7fvhz; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=erU7fvhz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffsDQ1ln2z2yps
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 12:01:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B1AFA404E5;
	Tue, 24 Mar 2026 01:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931DBC2BCB0;
	Tue, 24 Mar 2026 01:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774314068;
	bh=A7+ilLlUptt8NahoteAzf0RgIRgwKuFBHYBpfbQD/9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=erU7fvhzJv2tp5KrkKrqx+Erdif01ZeeUOpNA4f3SMGY5Zd3volrXG0e/GJE1PA+4
	 eGQrxZX3PAs12r5SMw5wVj3Dru900+u5sZlt2HAhjsWXohecP7okhBQJqUVMGYmK9x
	 t4JpMcZVTz48+PY+wk5zYrMxets8K+lB6YlpzvSaaUxQizoh9N8ogOZ6kZFkBtVUt/
	 +2U/I6kRnURbopqcXHThSae0+v5nsjA+MtxnO1+6Qp2DXSnViA+Sg/1CnS+DYaIbv9
	 MmwreYV6dk6ePxO92r/nW6iGASWXgbC1mouwugaLRXGpdUBgdYK22pwqvUSENOqNbX
	 RFBSTYbpYZsGA==
From: Danilo Krummrich <dakr@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-spi@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-arm-kernel@lists.infradead.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 10/12] s390/ap: use generic driver_override infrastructure
Date: Tue, 24 Mar 2026 01:59:14 +0100
Message-ID: <20260324005919.2408620-11-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324005919.2408620-1-dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
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

When the AP masks are updated via apmask_store() or aqmask_store(),
ap_bus_revise_bindings() is called after ap_attr_mutex has been
released.

This calls __ap_revise_reserved(), which accesses the driver_override
field without holding any lock, racing against a concurrent
driver_override_store() that may free the old string, resulting in a
potential UAF.

Fix this by using the driver-core driver_override infrastructure, which
protects all accesses with an internal spinlock.

Note that unlike most other buses, the AP bus does not check
driver_override in its match() callback; the override is checked in
ap_device_probe() and __ap_revise_reserved() instead.

Also note that we do not enable the driver_override feature of struct
bus_type, as AP - in contrast to most other buses - passes "" to
sysfs_emit() when the driver_override pointer is NULL. Thus, printing
"\n" instead of "(null)\n".

Additionally, AP has a custom counter that is modified in the
corresponding custom driver_override_store().

Fixes: d38a87d7c064 ("s390/ap: Support driver_override for AP queue devices")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/s390/crypto/ap_bus.c   | 34 +++++++++++++++++-----------------
 drivers/s390/crypto/ap_bus.h   |  1 -
 drivers/s390/crypto/ap_queue.c | 24 ++++++------------------
 3 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index d652df96a507..f24e27add721 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -859,25 +859,24 @@ static int __ap_queue_devices_with_id_unregister(struct device *dev, void *data)
 
 static int __ap_revise_reserved(struct device *dev, void *dummy)
 {
-	int rc, card, queue, devres, drvres;
+	int rc, card, queue, devres, drvres, ovrd;
 
 	if (is_queue_dev(dev)) {
 		struct ap_driver *ap_drv = to_ap_drv(dev->driver);
 		struct ap_queue *aq = to_ap_queue(dev);
-		struct ap_device *ap_dev = &aq->ap_dev;
 
 		card = AP_QID_CARD(aq->qid);
 		queue = AP_QID_QUEUE(aq->qid);
 
-		if (ap_dev->driver_override) {
-			if (strcmp(ap_dev->driver_override,
-				   ap_drv->driver.name)) {
-				pr_debug("reprobing queue=%02x.%04x\n", card, queue);
-				rc = device_reprobe(dev);
-				if (rc) {
-					AP_DBF_WARN("%s reprobing queue=%02x.%04x failed\n",
-						    __func__, card, queue);
-				}
+		ovrd = device_match_driver_override(dev, &ap_drv->driver);
+		if (ovrd > 0) {
+			/* override set and matches, nothing to do */
+		} else if (ovrd == 0) {
+			pr_debug("reprobing queue=%02x.%04x\n", card, queue);
+			rc = device_reprobe(dev);
+			if (rc) {
+				AP_DBF_WARN("%s reprobing queue=%02x.%04x failed\n",
+					    __func__, card, queue);
 			}
 		} else {
 			mutex_lock(&ap_attr_mutex);
@@ -928,7 +927,7 @@ int ap_owned_by_def_drv(int card, int queue)
 	if (aq) {
 		const struct device_driver *drv = aq->ap_dev.device.driver;
 		const struct ap_driver *ap_drv = to_ap_drv(drv);
-		bool override = !!aq->ap_dev.driver_override;
+		bool override = device_has_driver_override(&aq->ap_dev.device);
 
 		if (override && drv && ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
 			rc = 1;
@@ -977,7 +976,7 @@ static int ap_device_probe(struct device *dev)
 {
 	struct ap_device *ap_dev = to_ap_dev(dev);
 	struct ap_driver *ap_drv = to_ap_drv(dev->driver);
-	int card, queue, devres, drvres, rc = -ENODEV;
+	int card, queue, devres, drvres, rc = -ENODEV, ovrd;
 
 	if (!get_device(dev))
 		return rc;
@@ -991,10 +990,11 @@ static int ap_device_probe(struct device *dev)
 		 */
 		card = AP_QID_CARD(to_ap_queue(dev)->qid);
 		queue = AP_QID_QUEUE(to_ap_queue(dev)->qid);
-		if (ap_dev->driver_override) {
-			if (strcmp(ap_dev->driver_override,
-				   ap_drv->driver.name))
-				goto out;
+		ovrd = device_match_driver_override(dev, &ap_drv->driver);
+		if (ovrd > 0) {
+			/* override set and matches, nothing to do */
+		} else if (ovrd == 0) {
+			goto out;
 		} else {
 			mutex_lock(&ap_attr_mutex);
 			devres = test_bit_inv(card, ap_perms.apm) &&
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 51e08f27bd75..04ea256ecf91 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -166,7 +166,6 @@ void ap_driver_unregister(struct ap_driver *);
 struct ap_device {
 	struct device device;
 	int device_type;		/* AP device type. */
-	const char *driver_override;
 };
 
 #define to_ap_dev(x) container_of((x), struct ap_device, device)
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 3fe2e41c5c6b..ca9819e6f7e7 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -734,26 +734,14 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct ap_queue *aq = to_ap_queue(dev);
-	struct ap_device *ap_dev = &aq->ap_dev;
-	int rc;
-
-	device_lock(dev);
-	if (ap_dev->driver_override)
-		rc = sysfs_emit(buf, "%s\n", ap_dev->driver_override);
-	else
-		rc = sysfs_emit(buf, "\n");
-	device_unlock(dev);
-
-	return rc;
+	guard(spinlock)(&dev->driver_override.lock);
+	return sysfs_emit(buf, "%s\n", dev->driver_override.name ?: "");
 }
 
 static ssize_t driver_override_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	struct ap_queue *aq = to_ap_queue(dev);
-	struct ap_device *ap_dev = &aq->ap_dev;
 	int rc = -EINVAL;
 	bool old_value;
 
@@ -764,13 +752,13 @@ static ssize_t driver_override_store(struct device *dev,
 	if (ap_apmask_aqmask_in_use)
 		goto out;
 
-	old_value = ap_dev->driver_override ? true : false;
-	rc = driver_set_override(dev, &ap_dev->driver_override, buf, count);
+	old_value = device_has_driver_override(dev);
+	rc = __device_set_driver_override(dev, buf, count);
 	if (rc)
 		goto out;
-	if (old_value && !ap_dev->driver_override)
+	if (old_value && !device_has_driver_override(dev))
 		--ap_driver_override_ctr;
-	else if (!old_value && ap_dev->driver_override)
+	else if (!old_value && device_has_driver_override(dev))
 		++ap_driver_override_ctr;
 
 	rc = count;
-- 
2.53.0


