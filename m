Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0883C4332F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Sep 2021 17:32:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3E2610C9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Sep 2021 17:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E3E2610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HFj1073b7z3dh6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Sep 2021 03:32:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN>)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HFhxr6f9Rz2yPM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Sep 2021 03:30:08 +1000 (AEST)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="222014574"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="222014574"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="704832559"
Received: from unknown (HELO bad-guy.kumite) ([10.252.132.140])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 10:26:55 -0700
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH v2 6/9] PCI: Add pci_find_dvsec_capability to find designated
 VSEC
Date: Thu, 23 Sep 2021 10:26:44 -0700
Message-Id: <20210923172647.72738-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923172647.72738-1-ben.widawsky@intel.com>
References: <20210923172647.72738-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Ben Widawsky <ben.widawsky@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 linux-pci@vger.kernel.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 "David E . Box" <david.e.box@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add pci_find_dvsec_capability to locate a Designated Vendor-Specific
Extended Capability with the specified DVSEC ID.

The Designated Vendor-Specific Extended Capability (DVSEC) allows one or
more vendor specific capabilities that aren't tied to the vendor ID of
the PCI component.

DVSEC is critical for both the Compute Express Link (CXL) driver as well
as the driver for OpenCAPI coherent accelerator (OCXL).

Cc: David E. Box <david.e.box@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/pci/pci.c   | 32 ++++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..94ac86ff28b0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -732,6 +732,38 @@ u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
 }
 EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
 
+/**
+ * pci_find_dvsec_capability - Find DVSEC for vendor
+ * @dev: PCI device to query
+ * @vendor: Vendor ID to match for the DVSEC
+ * @dvsec: Designated Vendor-specific capability ID
+ *
+ * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the capability
+ * offset in config space; otherwise return 0.
+ */
+u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
+{
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
+	if (!pos)
+		return 0;
+
+	while (pos) {
+		u16 v, id;
+
+		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1, &v);
+		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2, &id);
+		if (vendor == v && dvsec == id)
+			return pos;
+
+		pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_DVSEC);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
+
 /**
  * pci_find_parent_resource - return resource region of parent bus of given
  *			      region
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..c93ccfa4571b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1130,6 +1130,7 @@ u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
 u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
+u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec);
 
 u64 pci_get_dsn(struct pci_dev *dev);
 
-- 
2.33.0

