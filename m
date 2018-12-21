Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E20CC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 14:18:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BB620815
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 14:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BB620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LrMl3QxbzDrMr
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 01:18:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sebott@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LrGw3qTTzDr8H
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 01:14:31 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBLEDvXB053541
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 09:14:29 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ph1q6r5xn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 09:14:29 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sebott@linux.ibm.com>;
 Fri, 21 Dec 2018 14:14:28 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 21 Dec 2018 14:14:23 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBLEENZH34209890
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Dec 2018 14:14:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC26BAE04D;
 Fri, 21 Dec 2018 14:14:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 954E1AE051;
 Fri, 21 Dec 2018 14:14:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 21 Dec 2018 14:14:22 +0000 (GMT)
From: Sebastian Ott <sebott@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 2/3] PCI/IOV: provide flag to skip VF scanning
Date: Fri, 21 Dec 2018 15:14:19 +0100
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181220200750.GF183878@google.com>
References: <20181220200750.GF183878@google.com>
X-TM-AS-GCONF: 00
x-cbid: 18122114-0008-0000-0000-000002A49B79
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122114-0009-0000-0000-0000220F3D5B
Message-Id: <20181221141420.22555-2-sebott@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-21_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=919 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812210112
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Provide a flag to skip scanning for new VFs after SRIOV enablement.
This can be set by implementations for which the VFs are already
reported by other means.

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/iov.c   | 6 ++++++
 include/linux/pci.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 408db232a328..3aa115ed3a65 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -257,6 +257,9 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	unsigned int i;
 	int rc;
 
+	if (dev->no_vf_scan)
+		return 0;
+
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
@@ -385,6 +388,9 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	if (dev->no_vf_scan)
+		return;
+
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 11c71c4ecf75..f9bc7651c406 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -405,6 +405,7 @@ struct pci_dev {
 	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
 	unsigned int	is_probed:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
+	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
2.13.4

