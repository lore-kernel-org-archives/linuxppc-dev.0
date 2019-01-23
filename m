Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7575FC282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 04:08:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D3521019
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 04:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D3521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ksGk367zzDqCM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 15:08:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43ksF06mxVzDqLb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 15:07:16 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 4B1A2AE80037;
 Tue, 22 Jan 2019 23:07:12 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] vfio-pci/nvlink2: Fix ancient gcc warnings
Date: Wed, 23 Jan 2019 15:07:11 +1100
Message-Id: <20190123040711.21759-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Using the {0} construct as a generic initializer is perfectly fine in C,
however due to a bug in old gcc there is a warning:

  + /kisskb/src/drivers/vfio/pci/vfio_pci_nvlink2.c: warning: (near
initialization for 'cap.header') [-Wmissing-braces]:  => 181:9

Since for whatever reason we still want to compile the modern kernel
with such an old gcc without warnings, this changes the capabilities
initialization.

The gcc bugzilla: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53119

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/pci/vfio_pci_nvlink2.c | 30 ++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
index 054a2cf..91d945b 100644
--- a/drivers/vfio/pci/vfio_pci_nvlink2.c
+++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
@@ -178,11 +178,11 @@ static int vfio_pci_nvgpu_add_capability(struct vfio_pci_device *vdev,
 		struct vfio_pci_region *region, struct vfio_info_cap *caps)
 {
 	struct vfio_pci_nvgpu_data *data = region->data;
-	struct vfio_region_info_cap_nvlink2_ssatgt cap = { 0 };
-
-	cap.header.id = VFIO_REGION_INFO_CAP_NVLINK2_SSATGT;
-	cap.header.version = 1;
-	cap.tgt = data->gpu_tgt;
+	struct vfio_region_info_cap_nvlink2_ssatgt cap = {
+		.header.id = VFIO_REGION_INFO_CAP_NVLINK2_SSATGT,
+		.header.version = 1,
+		.tgt = data->gpu_tgt
+	};
 
 	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
 }
@@ -365,18 +365,18 @@ static int vfio_pci_npu2_add_capability(struct vfio_pci_device *vdev,
 		struct vfio_pci_region *region, struct vfio_info_cap *caps)
 {
 	struct vfio_pci_npu2_data *data = region->data;
-	struct vfio_region_info_cap_nvlink2_ssatgt captgt = { 0 };
-	struct vfio_region_info_cap_nvlink2_lnkspd capspd = { 0 };
+	struct vfio_region_info_cap_nvlink2_ssatgt captgt = {
+		.header.id = VFIO_REGION_INFO_CAP_NVLINK2_SSATGT,
+		.header.version = 1,
+		.tgt = data->gpu_tgt
+	};
+	struct vfio_region_info_cap_nvlink2_lnkspd capspd = {
+		.header.id = VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD,
+		.header.version = 1,
+		.link_speed = data->link_speed
+	};
 	int ret;
 
-	captgt.header.id = VFIO_REGION_INFO_CAP_NVLINK2_SSATGT;
-	captgt.header.version = 1;
-	captgt.tgt = data->gpu_tgt;
-
-	capspd.header.id = VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD;
-	capspd.header.version = 1;
-	capspd.link_speed = data->link_speed;
-
 	ret = vfio_info_add_capability(caps, &captgt.header, sizeof(captgt));
 	if (ret)
 		return ret;
-- 
2.17.1

