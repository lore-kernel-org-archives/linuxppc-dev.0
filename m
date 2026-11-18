Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73447606A320
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PU171Cx/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVKZT0YZyz2xlY;
	Thu, 19 Nov 2026 11:48:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795049280;
	cv=none; b=B86pM64A6GvBn+uFnl4iX8ugbDrNwIlo5eVggLy64jsWnTkN0YN2uoP/dXFja/8pCFOENOch5fI535lZLVNpFS11ZA1Xc/UtBPkNn8L24hrzj5HUpCeUzbIOnPJJ1TCWsvCRxLeNow8DBJGwuB1tViCrKLg8W/gXax6xnv0b7qiC+qw+yYurJ2KSe+EQuA2puN9fV/l1zk4W59EIgd8zFCpiR6g1Ey3IXU+ZKKx8hmSPLFwuZP+NzVANijbsurnyIT1SR+pVBUkBJzNjGjB0ZKTrbXeLSgoI7LDW5ixnat76SUTE+8GljdqQVqLXfchg1BHwwukK9eJZMF3OewcVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795049280; c=relaxed/relaxed;
	bh=h7hUkUcxsVRNGzDAFlLrY1jlloNSmH8iv2Q/mCtRGsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCR2Ns4sy0FdhfwsGLf7+8tQ1dGXfz1LK1uKAowPf4NQr6JC5lrFemQ5iCq+VRW4gDC7omkJV1zbzUSkr0hxX7LMkpLikMlZ6VF75cp2T7202/krGF717DqvjCnoxdYVQHhB0tQz/xfmYLPK2+oB+o0WjkEu6iDxEvSihhn5ksgK0M3mUmaK+5T1mNYzyKDWP4KQAk0fieulDj+785cLsjFBBtA2cn4JCIziDX9ia+qFxAX2eIdYEtGGvul6JjWUXJsYzWGRPOCtGUdnq29ymY5mDNsj6odG4W8e/oDiqXYnDroFAT5pfGGhNB9dyxQn8Ip4Ir56T0KHazT4T87FKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PU171Cx/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PU171Cx/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVKZR5yz6z2xkr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 11:47:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1D597644FD;
	Thu, 19 Nov 2026 00:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A421F000C4;
	Thu, 19 Nov 2026 00:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795049276;
	bh=h7hUkUcxsVRNGzDAFlLrY1jlloNSmH8iv2Q/mCtRGsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PU171Cx/SN+7pCmK2+Qg/ntk/C+lQvgtZdJJ7+lUBn24uFdsWOHZ7EsEhsb/3gqbP
	 nTiDo5SauwshBJsSDb09vYO5QRoAaBS/A2N9Da9UjER0yizA1YdQpAprhWIIFe6HSd
	 kitlb0hEnDMY8Xyh3/1cwFGqykfNF1uK380mi8Yg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>,
	Oliver OHalloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 2294/2857] PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem dev handler
Date: Wed, 18 Nov 2026 15:55:28 +0100
Message-ID: <20261118150324.077759539@linuxfoundation.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118150201.293410965@linuxfoundation.org>
References: <20261118150201.293410965@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Richter <rrichter@amd.com>

[ Upstream commit 0a867568bb0d203ca3d28634a611a1367d7c892d ]

In Restricted CXL Device (RCD) mode a CXL device is exposed as an
RCiEP, but CXL downstream and upstream ports are not enumerated and
not visible in the PCIe hierarchy. [1] Protocol and link errors from
these non-enumerated ports are signaled as internal AER errors, either
Uncorrectable Internal Error (UIE) or Corrected Internal Errors (CIE)
via an RCEC.

Restricted CXL host (RCH) downstream port-detected errors have the
Requester ID of the RCEC set in the RCEC's AER Error Source ID
register. A CXL handler must then inspect the error status in various
CXL registers residing in the dport's component register space (CXL
RAS capability) or the dport's RCRB (PCIe AER extended
capability). [2]

Errors showing up in the RCEC's error handler must be handled and
connected to the CXL subsystem. Implement this by forwarding the error
to all CXL devices below the RCEC. Since the entire CXL device is
controlled only using PCIe Configuration Space of device 0, function
0, only pass it there [3]. The error handling is limited to currently
supported devices with the Memory Device class code set (CXL Type 3
Device, PCI_CLASS_MEMORY_CXL, 502h), handle downstream port errors in
the device's cxl_pci driver. Support for other CXL Device Types
(e.g. a CXL.cache Device) can be added later.

To handle downstream port errors in addition to errors directed to the
CXL endpoint device, a handler must also inspect the CXL RAS and PCIe
AER capabilities of the CXL downstream port the device is connected
to.

Since CXL downstream port errors are signaled using internal errors,
the handler requires those errors to be unmasked. This is subject of a
follow-on patch.

The reason for choosing this implementation is that the AER service
driver claims the RCEC device, but does not allow it to register a
custom specific handler to support CXL. Connecting the RCEC hard-wired
with a CXL handler does not work, as the CXL subsystem might not be
present all the time. The alternative to add an implementation to the
portdrv to allow the registration of a custom RCEC error handler isn't
worth doing it as CXL would be its only user. Instead, just check for
an CXL RCEC and pass it down to the connected CXL device's error
handler. With this approach the code can entirely be implemented in
the PCIe AER driver and is independent of the CXL subsystem. The CXL
driver only provides the handler.

[1] CXL 3.0 spec: 9.11.8 CXL Devices Attached to an RCH
[2] CXL 3.0 spec, 12.2.1.1 RCH Downstream Port-detected Errors
[3] CXL 3.0 spec, 8.1.3 PCIe DVSEC for CXL Devices

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/20231018171713.1883517-18-rrichter@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Stable-dep-of: e86ac10110d0 ("PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/Kconfig |  9 ++++
 drivers/pci/pcie/aer.c   | 93 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 788ac8df3f9db..366a35fec776f 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -45,6 +45,15 @@ config PCIEAER_INJECT
 	  gotten from:
 	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
 
+config PCIEAER_CXL
+	bool "PCI Express CXL RAS support"
+	default y
+	depends on PCIEAER && CXL_PCI
+	help
+	  Enables CXL error handling.
+
+	  If unsure, say Y.
+
 #
 # PCI Express ECRC
 #
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9ae9f64457d0f..49f825531b527 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -942,14 +942,97 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
+#ifdef CONFIG_PCIEAER_CXL
+
+static bool is_cxl_mem_dev(struct pci_dev *dev)
+{
+	/*
+	 * The capability, status, and control fields in Device 0,
+	 * Function 0 DVSEC control the CXL functionality of the
+	 * entire device (CXL 3.0, 8.1.3).
+	 */
+	if (dev->devfn != PCI_DEVFN(0, 0))
+		return false;
+
+	/*
+	 * CXL Memory Devices must have the 502h class code set (CXL
+	 * 3.0, 8.1.12.1).
+	 */
+	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
+		return false;
+
+	return true;
+}
+
+static bool cxl_error_is_native(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+
+	return (pcie_ports_native || host->native_aer);
+}
+
+static bool is_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
+
+	return info->status & PCI_ERR_UNC_INTN;
+}
+
+static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
+{
+	struct aer_err_info *info = (struct aer_err_info *)data;
+	const struct pci_error_handlers *err_handler;
+
+	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
+		return 0;
+
+	/* protect dev->driver */
+	device_lock(&dev->dev);
+
+	err_handler = dev->driver ? dev->driver->err_handler : NULL;
+	if (!err_handler)
+		goto out;
+
+	if (info->severity == AER_CORRECTABLE) {
+		if (err_handler->cor_error_detected)
+			err_handler->cor_error_detected(dev);
+	} else if (err_handler->error_detected) {
+		if (info->severity == AER_NONFATAL)
+			err_handler->error_detected(dev, pci_channel_io_normal);
+		else if (info->severity == AER_FATAL)
+			err_handler->error_detected(dev, pci_channel_io_frozen);
+	}
+out:
+	device_unlock(&dev->dev);
+	return 0;
+}
+
+static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+{
+	/*
+	 * Internal errors of an RCEC indicate an AER error in an
+	 * RCH's downstream port. Check and handle them in the CXL.mem
+	 * device driver.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
+	    is_internal_error(info))
+		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+}
+
+#else
+static inline void cxl_rch_handle_error(struct pci_dev *dev,
+					struct aer_err_info *info) { }
+#endif
+
 /**
- * handle_error_source - handle logging error into an event log
+ * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
  * @info: comprehensive error information
  *
  * Invoked when an error being detected by Root Port.
  */
-static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
+static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int aer = dev->aer_cap;
 
@@ -973,6 +1056,12 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
 	else if (info->severity == AER_FATAL)
 		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
+}
+
+static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
+{
+	cxl_rch_handle_error(dev, info);
+	pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
 
-- 
2.53.0




