Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F1C606A330
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:44:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTyrn0f8Hz2y32;
	Wed, 18 Nov 2026 21:44:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794998649;
	cv=none; b=RgBr0i12DCSBHdnubGlYczfgspWB3Y4ffI7XIYNVK2T6GoMsQ+poNKPJi/4nUbi42JxPti2lr46l5OW23jHQ+mtJN6L7XNTwW4YIThItT1mCbLI7GkKyPmX3rnhju9zyOKjlKGqD/Cuv+16pMv7nTlnAgx9Q5/ITbB1Nm8BUORVSWnS+OJL4lqt6vEvOK1VteL1sld9sCAVXA/NuFeDrgedHjlMnCluk6rA1TZmiluUHzlVefQujh9nP1JVplsVFWmcpfjQk78GR2Ivdxc6uQrSHU+5XQOy7RAlYYaO9Aa01WRF9WPx2QGKnmbN2eUpGyHvqNK67m0J4TNhlHaAVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794998649; c=relaxed/relaxed;
	bh=zXpUKWW6Hx2bk+Iwk827DIeBENgbMoEUuiov/SIQQsQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=ge5kpnN1js4+ledoz9ZCZbyTyCmKakU3ZzHiAFjajSJNZ9UyYsuEjkaQdFGWC99Rtdiah1FPeUFedSM2C20opc5p+AZTloooTufqrQIVAZ98mbr4NtMKqODGpNo+UEMX2CLAibbkEdQ3e/J0mD6WT5d4ug8OE2GBY8eCwGLj2htk8/a9mSGHtPDr3lafX5MhYzEv+W5KyzAJrkTVCtd1mpMou2w2dJ4PCfUW3qwhxYw+5PPIWVx9pzAqA4cpH6tQ9zsaUX1ZenBEIOmehMkdoKraO0Pn+3PTzcje5yBZkQmixXSCWWpYHLj+bm2FET7heiu/dNfOplGzAbzS4C42Og==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTyrm37hxz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:44:08 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id B42D6414F;
	Wed, 18 Nov 2026 11:44:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 8E2036000333; Wed, 18 Nov 2026 11:44:05 +0100 (CET)
Message-ID: <8ab33b2307e9136719f72ccc2d9f946417651eab.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:03 +0100
Subject: [PATCH v2 3/7] PCI/ERR: Clear error status bits more selectively
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Darshit Shah <darnshah@amazon.de>, Jason Perlow <jperlow@gmail.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

After recovery from a PCIe error, all of the error status bits in the
Device Status register are cleared indiscriminately, regardless of the
error's severity.

So when a Correctable Error occurs simultaneously to an Uncorrectable
Error, after the former is handled, it is cleared alongside the latter.
As a result, the Uncorrectable Error isn't handled at all.

Conversely, an Uncorrectable Error occurring shortly before a Correctable
Error may cause the latter to be cleared and thus ignored.

Avoid by clearing only the error bits corresponding to the error severity
being handled.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v1 -> v2:
  * New patch to clear error status bits more selectively (sashiko).
 
 drivers/pci/pcie/aer.c | 20 +++++++++++++++++++-
 drivers/pci/pcie/err.c |  7 ++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6f2460231422..51cf2ff8c85a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -141,6 +141,12 @@ struct aer_info {
 					PCI_ERR_ROOT_MULTI_COR_RCV |	\
 					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 
+static const u8 severity2devsta[] = {
+	[AER_NONFATAL]    = PCI_EXP_DEVSTA_NFED,
+	[AER_FATAL]       = PCI_EXP_DEVSTA_FED,
+	[AER_CORRECTABLE] = PCI_EXP_DEVSTA_CED,
+};
+
 static bool pcie_aer_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
@@ -1314,6 +1320,17 @@ bool is_aer_internal_error(struct aer_err_info *info)
 }
 #endif
 
+static void pcie_clear_device_status_sev(struct pci_dev *dev, u8 severity,
+					 u32 uncor_status)
+{
+	u16 devsta = severity2devsta[severity];
+
+	if (uncor_status & PCI_ERR_UNC_UNSUP)
+		devsta |= PCI_EXP_DEVSTA_URD;
+
+	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, devsta);
+}
+
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
@@ -1344,7 +1361,8 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 			if (pdrv && pdrv->err_handler &&
 			    pdrv->err_handler->cor_error_detected)
 				pdrv->err_handler->cor_error_detected(dev);
-			pcie_clear_device_status(dev);
+			pcie_clear_device_status_sev(dev, AER_CORRECTABLE,
+						     info->anfe_status);
 		}
 	} else if (info->severity == AER_NONFATAL)
 		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 1a7fc71c79d8..24a8a8263c2e 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -21,6 +21,10 @@
 #include "portdrv.h"
 #include "../pci.h"
 
+#define PCI_EXP_DEVSTA_UNC_MASK	(PCI_EXP_DEVSTA_NFED | \
+				 PCI_EXP_DEVSTA_FED | \
+				 PCI_EXP_DEVSTA_URD)
+
 static pci_ers_result_t merge_result(enum pci_ers_result orig,
 				  enum pci_ers_result new)
 {
@@ -274,7 +278,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 * signaling device may not even be visible to the OS.
 	 */
 	if (host->native_aer) {
-		pcie_clear_device_status(dev);
+		pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
+					   PCI_EXP_DEVSTA_UNC_MASK);
 		pci_aer_clear_nonfatal_status(dev);
 	}
 
-- 
2.53.0


