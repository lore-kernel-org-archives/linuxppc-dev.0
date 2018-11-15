Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343E9C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 06:51:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1F0223CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 06:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1F0223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wX8j0RrWzF3cX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 17:51:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sathnaga@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wX6c5v3RzF3bf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 17:50:00 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAF6mwqf117327
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 01:49:58 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ns309a5s5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 01:49:58 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sathnaga@linux.vnet.ibm.com>;
 Thu, 15 Nov 2018 06:49:56 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 15 Nov 2018 06:49:54 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAF6nrXn58720278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Nov 2018 06:49:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 910D8A4060;
 Thu, 15 Nov 2018 06:49:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD654A405F;
 Thu, 15 Nov 2018 06:49:52 +0000 (GMT)
Received: from dhcp-9-193-110-205.in.ibm.com (unknown [9.122.211.233])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 15 Nov 2018 06:49:52 +0000 (GMT)
From: sathnaga@linux.vnet.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V3] powerpc: Add KVM guest defconfig
Date: Thu, 15 Nov 2018 12:19:50 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 18111506-4275-0000-0000-000002E13F8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111506-4276-0000-0000-000037EE5696
Message-Id: <20181115064950.15628-1-sathnaga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-15_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=563 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150062
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
Cc: leitao@debian.org, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

This patch adds new defconfig options for powerpc KVM guest
and guest.config with additional config symbols enabled,
which is to build kernel to boot without initramfs and can be used
as place holder for guest specific additional config symbols in future.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
---
Changes Since:
    V1:
        * replaced kvm to KVM in commit msg.
    V2:
        * moved XFS config symbol enable into 
          ppc64_defconfig, based on suggestion from Michael.  

 arch/powerpc/Makefile             |  8 ++++++++
 arch/powerpc/configs/guest.config | 13 +++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/powerpc/configs/guest.config

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8a2ce14d68d0..0bff8bd82ed5 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -317,6 +317,14 @@ PHONY += ppc64le_defconfig
 ppc64le_defconfig:
 	$(call merge_into_defconfig,ppc64_defconfig,le)
 
+PHONY += ppc64le_guest_defconfig
+ppc64le_guest_defconfig:
+	$(call merge_into_defconfig,ppc64_defconfig,le guest)
+
+PHONY += ppc64_guest_defconfig
+ppc64_guest_defconfig:
+	$(call merge_into_defconfig,ppc64_defconfig,be guest)
+
 PHONY += powernv_be_defconfig
 powernv_be_defconfig:
 	$(call merge_into_defconfig,powernv_defconfig,be)
diff --git a/arch/powerpc/configs/guest.config b/arch/powerpc/configs/guest.config
new file mode 100644
index 000000000000..8b8cd18ecd7c
--- /dev/null
+++ b/arch/powerpc/configs/guest.config
@@ -0,0 +1,13 @@
+CONFIG_VIRTIO_BLK=y
+CONFIG_VIRTIO_BLK_SCSI=y
+CONFIG_SCSI_VIRTIO=y
+CONFIG_VIRTIO_NET=y
+CONFIG_NET_FAILOVER=y
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_KVM_GUEST=y
+CONFIG_EPAPR_PARAVIRT=y
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_VHOST_NET=y
+CONFIG_VHOST=y
-- 
2.17.2

