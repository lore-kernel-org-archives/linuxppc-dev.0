Return-Path: <SRS0=KGvS=E4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA7AC5519F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2020 07:42:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9162078E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2020 07:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9162078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cf2L71T3szDqcx
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2020 18:42:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=107.174.27.60; helo=ozlabs.ru;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Cf2JJ54c5zDqXd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2020 18:40:32 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id A6F9AAE80249;
 Sun, 22 Nov 2020 02:39:57 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v2] vfio/pci/nvlink2: Do not attempt NPU2 setup on
 POWER8NVL NPU
Date: Sun, 22 Nov 2020 18:39:50 +1100
Message-Id: <20201122073950.15684-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
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
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 stable@vger.kernel.org,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We execute certain NPU2 setup code (such as mapping an LPID to a device
in NPU2) unconditionally if an Nvlink bridge is detected. However this
cannot succeed on POWER8NVL machines as the init helpers return an error
other than ENODEV which means the device is there is and setup failed so
vfio_pci_enable() fails and pass through is not possible.

This changes the two NPU2 related init helpers to return -ENODEV if
there is no "memory-region" device tree property as this is
the distinction between NPU and NPU2.

Tested on
- POWER9 pvr=004e1201, Ubuntu 19.04 host, Ubuntu 18.04 vm,
  NVIDIA GV100 10de:1db1 driver 418.39
- POWER8 pvr=004c0100, RHEL 7.6 host, Ubuntu 16.10 vm,
  NVIDIA P100 10de:15f9 driver 396.47

Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
Cc: stable@vger.kernel.org # 5.0
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* updated commit log with tested configs and replaced P8+ with POWER8NVL for clarity
---
 drivers/vfio/pci/vfio_pci_nvlink2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
index 65c61710c0e9..9adcf6a8f888 100644
--- a/drivers/vfio/pci/vfio_pci_nvlink2.c
+++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
@@ -231,7 +231,7 @@ int vfio_pci_nvdia_v100_nvlink2_init(struct vfio_pci_device *vdev)
 		return -EINVAL;
 
 	if (of_property_read_u32(npu_node, "memory-region", &mem_phandle))
-		return -EINVAL;
+		return -ENODEV;
 
 	mem_node = of_find_node_by_phandle(mem_phandle);
 	if (!mem_node)
@@ -393,7 +393,7 @@ int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
 	int ret;
 	struct vfio_pci_npu2_data *data;
 	struct device_node *nvlink_dn;
-	u32 nvlink_index = 0;
+	u32 nvlink_index = 0, mem_phandle = 0;
 	struct pci_dev *npdev = vdev->pdev;
 	struct device_node *npu_node = pci_device_to_OF_node(npdev);
 	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
@@ -408,6 +408,9 @@ int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
 	if (!pnv_pci_get_gpu_dev(vdev->pdev))
 		return -ENODEV;
 
+	if (of_property_read_u32(npu_node, "memory-region", &mem_phandle))
+		return -ENODEV;
+
 	/*
 	 * NPU2 normally has 8 ATSD registers (for concurrency) and 6 links
 	 * so we can allocate one register per link, using nvlink index as
-- 
2.17.1

