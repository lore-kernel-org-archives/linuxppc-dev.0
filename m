Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B892606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:40:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTymw1t8nz2y2T;
	Wed, 18 Nov 2026 21:40:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794998448;
	cv=none; b=Z0daTRdSQAUwzFTV/6ZgVFceivukLzfG48C13Uts6dpZZyzZBqERsMzLXQEd1P/bLMnQSzFR5NzuEND559y7Ni4vJ5JaGeXxFLqAVEmodUv+04vV1/1s5sU6b1og02ooxiKDAzaVujdQXZFLPpLZQyLWfec3120Y1oQpQnCzJbFiLrDJVFHnEe6TdidfFi2PRXHbHmfWToEVh4jKN5i84MR1Zu4wx7paY0gFgnRGlnjYG503T0nER6m+LP1H58+7bp1XiVbMQRP/RMf46U6CzwFNZ+gNx9pHMZToeNlIw4S3GFsdm4anlFTQP58CiwUtSzkL35/5+SqQ8MdU/h8N5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794998448; c=relaxed/relaxed;
	bh=lJRXZTaLABiQOC03YvgzkJOyiEumqmL4Ha8lE9HKd2U=;
	h=Message-ID:From:Date:Subject:To:Cc; b=eWDcyNYv4TEk/BSur3CL8vzMGEZN41QQoKhjzsQHyPx4dos4Q0vsJK714RFFA/KKGkNn/GCA4gRucepctrB+DpGHWsUUkO2pMRbs3PZQT4L2CiQeZ1uPtF653wstBsP6t7KnKPnEg231Qk9AUkGNdrFoeULpNYw0hngxADbNwNjwW4SD+5qcgoJEUWR/b31F2jwvX+wnC+8F0uJ1izRUh9TITsQ4O6zCfeSNo9T1BhK7FY/elkxR5tSU5N0hnsGM18q2LTle6CzeXNakRy3DJm9Wqp/WX4ipEs+3pWgtb5rDKXRwnXjwiRKRCVJLKIFis8VnyDjo1Iw32px4QFhCuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTymt3QF9z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:40:43 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 3C4CD3438;
	Wed, 18 Nov 2026 11:40:39 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 361D4600034D; Wed, 18 Nov 2026 11:40:39 +0100 (CET)
Message-ID: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:00 +0100
Subject: [PATCH v2 0/7] Error reporting for AER-incapable devices
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Darshit Shah <darnshah@amazon.de>, Jason Perlow <jperlow@gmail.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
The kernel used to support this until 2018.  It is hereby fixed because
it eases introduction of baseline capability error reporting in the
subsequent patches.


Changes v1 -> v2:

* Patch [1/7]:
  * On AER-capable devices, infer severity from AER Extended Capability
    instead of Device Status register because the latter also logs masked
    errors (Sathya).
  * Fix storytelling in commit message because 4e5fad429bd1 changed
    behavior, not 708b20003624 (Sathya).

* Patch [3/7]:
  * New patch to clear error status bits more selectively (sashiko).

* Patch [4/7]:
  * Clear Fatal Errors as well on recovery failure (Sathya, sashiko).

* Patch [6/7]:
  * Amend kernel-doc of pci_aer_unmask_internal_errors() (Sathya).

* Patch [7/7]:
  * Convert AER severity to Device Status bit with new severity2devsta[]
    array, instead of renumbering AER severity (sashiko).
  * On entry of aer_get_device_error_info(), clear info->mask and
    info->first_error (Sathya, sashiko).
  * Emit "(no details available)" message for AER-incapable devices
    as well as for devices whose AER registers are deliberately not
    read on Fatal Errors (Sathya).
  * Amend commit message to inform that System Errors may be raised
    by AER-incapable devices if they have no AER- or DPC-capable
    port in their ancestry (Sathya).

Link to v1:

https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de/


Lukas Wunner (6):
  PCI/DPC: Avoid access to non-existent AER capability
  PCI/DPC: Reinstate support for AER-incapable ports
  PCI/ERR: Clear error status bits more selectively
  PCI/AER: Drop AER native check from handles_cxl_errors()
  PCI/AER: Move AER capability check out of pcie_aer_is_native()
  PCI/AER: Enable baseline capability error reporting

Yury Murashka (1):
  PCI/ERR: Avoid stale error status bits on recovery failure

 .../ABI/testing/sysfs-bus-pci-devices-aer     | 26 +++++--
 Documentation/PCI/pcieaer-howto.rst           |  9 +--
 drivers/pci/pcie/aer.c                        | 76 +++++++++++++------
 drivers/pci/pcie/aer_cxl_rch.c                |  3 +-
 drivers/pci/pcie/dpc.c                        | 46 +++++++----
 drivers/pci/pcie/err.c                        | 14 +++-
 6 files changed, 120 insertions(+), 54 deletions(-)


base-commit: 6d69eeae8966bc3bea0facbd550f45ef9de41cc4
-- 
2.53.0


