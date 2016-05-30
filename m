Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJGzs3S4KzDqPP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:04:41 +1000 (AEST)
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4UD4OxM016853
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:04:39 -0400
Message-Id: <201605301304.u4UD4OxM016853@mx0a-001b2d01.pphosted.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 238k00vsxa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:04:38 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 30 May 2016 18:34:35 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B24B5E005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:37:54 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4UD4VUJ26411144
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:34:31 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4UD4Sqo017516
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:34:30 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH v2 1/4] PCI: Ignore resource_alignment if PCI_PROBE_ONLY was
 set
Date: Mon, 30 May 2016 21:00:15 +0800
In-Reply-To: <1464613218-23973-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464613218-23973-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The resource_alignment will releases memory resources allocated
by firmware so that kernel can reassign new resources later on.
But this will cause the problem that no resources can be
allocated by kernel if PCI_PROBE_ONLY was set, e.g. on pSeries
platform because PCI_PROBE_ONLY force kernel to use firmware
setup and not to reassign any resources.

To solve this problem, this patch ignores resource_alignment
if PCI_PROBE_ONLY was set.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c8b4dbd..a259394 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4761,6 +4761,12 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
 	while (*p) {
+		if (pci_has_flag(PCI_PROBE_ONLY)) {
+			printk(KERN_ERR "PCI: Ignore resource_alignment parameter: %s with PCI_PROBE_ONLY set\n",
+					p);
+			*p = 0;
+			break;
+		}
 		count = 0;
 		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
 							p[count] == '@') {
-- 
1.7.9.5
