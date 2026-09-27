Return-Path: <linuxppc-dev+bounces-28335-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32E1C9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 18:08:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htC9Z46qZz2yMn;
	Mon, 28 Sep 2026 04:08:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790532514;
	cv=none; b=XTu+o398rOtHgyeUW3iUzIzADD1aIW0rxg1bW7kg8eywzgX1nllh8TUwvcN8mrzJTFbXNOQMEAIoThOhkba+04f0nDopYH6WMYsZ4pKQrb+FHzxkVrvwspGmcqFFcpuGXNHagvGfYkaRGChoKBodF647hmqXGETh5w33lYgrdVNbV6pjby8hXrwr12pZtHXmiVSSX3yYSG06l2jATY7GzAhAE2cnbm5IHG6JVSUkt713cDtZCOATn8fri3B7ERoDmjsmbsNC7UWtWeDXyvoJddDPyOYYpVYqDh+TPnD/oe4vinkoc7aGRsHWRwrEq4mqx+5AQYVIjaCntTyoZKntHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790532514; c=relaxed/relaxed;
	bh=bPJQcycX4CHAC/rJxE3ZKIzOgPXW5wJt79y/S05Yaxk=;
	h=Message-ID:From:Date:Subject:To:Cc; b=j5PhKq/x7AJAf0rSG8+0z11HOUVmw9+b8INAIf+PGQ2KMzz/l860YjaC9ycmbOpe31MKiG1XVt2XOJgDOPvzotBOYhanN7tZOzUu34ymHbL8rkjIJvUwQcJYIHDaGVDJqgrIj1BW+U5m9BoEhFmMABvykHTsVB7ryGz3jbLnKIq8b2OsNDC2oLMrRcbXHZQhYw0cyz0UJsa0VL4bUXYyv9ZxQfsQWy5K8H4t3S59vJDUL107SVO/Nl2HMUTX+KVenWkjNp9cyq1W0fOEzeJw9G8RpWgXEV5UfldeQkmQUoBrS7bSW1Na7qLQqoeDFvZSzylAgdSPfo/3iep5R4HAwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 374 seconds by postgrey-1.37 at boromir; Mon, 28 Sep 2026 04:08:33 AEST
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htC9Y3qLBz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 04:08:33 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id E64391D03;
	Sun, 27 Sep 2026 20:02:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A341D6078B58; Sun, 27 Sep 2026 20:02:02 +0200 (CEST)
Message-ID: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:00 +0200
Subject: [PATCH 0/7] Error reporting for AER-incapable devices
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
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

Bjorn suggests "the PCI core should do pci_enable_pcie_error_reporting()
independent of whether the device has an AER Capability":

https://lore.kernel.org/r/20260826212619.GA1566339@bhelgaas/

This is done in patch [7/7].  The preceding patches contain prep work.

For context, PCIe r7.1 sec 6.2.1 defines two error reporting paradigms:
AER and baseline capability.  The latter relies (solely) on the error
enable/status bits in the Device Control and Device Status registers,
which exist on every PCIe device.  The kernel has supported the AER
paradigm for 20 years.  With the present series, it gains support for
the baseline capability paradigm.

Patches [1/7] and [2/7] reinstate DPC on AER-incapable Downstream Ports.
The kernel used to support this until 2020.  It is hereby fixed because
it eases introduction of baseline capability error reporting in the
subsequent patches.

Lukas Wunner (6):
  PCI/DPC: Avoid access to non-existent AER capability
  PCI/DPC: Reinstate support for AER-incapable ports
  PCI/AER: Drop AER native check from handles_cxl_errors()
  PCI/AER: Move AER capability check out of pcie_aer_is_native()
  PCI/AER: Renumber severity constants
  PCI/AER: Enable baseline capability error reporting

Yury Murashka (1):
  PCI/ERR: Avoid stale error status bits on recovery failure

 .../ABI/testing/sysfs-bus-pci-devices-aer     | 26 +++++++---
 Documentation/PCI/pcieaer-howto.rst           |  9 ++--
 drivers/pci/pcie/aer.c                        | 51 +++++++++++--------
 drivers/pci/pcie/aer_cxl_rch.c                |  3 +-
 drivers/pci/pcie/dpc.c                        | 24 ++++-----
 drivers/pci/pcie/err.c                        |  5 ++
 include/linux/aer.h                           |  8 +--
 include/ras/ras_event.h                       |  2 +-
 8 files changed, 72 insertions(+), 56 deletions(-)

-- 
2.53.0


