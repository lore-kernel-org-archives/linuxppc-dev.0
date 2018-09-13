Return-Path: <sebott@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429yvN6YNPzF3SH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 22:41:36 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8DCd1dv097230
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 08:41:34 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mfpn0bvrw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 08:41:33 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sebott@linux.ibm.com>;
 Thu, 13 Sep 2018 13:41:31 +0100
From: Sebastian Ott <sebott@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org,
 Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: [PATCH 2/2] s390/pci: handle function enumeration after sriov
 enablement
Date: Thu, 13 Sep 2018 14:41:24 +0200
In-Reply-To: <20180913124124.14632-1-sebott@linux.ibm.com>
References: <20180912130205.GG118330@bhelgaas-glaptop.roam.corp.google.com>
 <20180913124124.14632-1-sebott@linux.ibm.com>
Message-Id: <20180913124124.14632-3-sebott@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement add_vfs|del_vfs callbacks as empty functions. VF
creation will be triggered by the hotplug code.

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
---
 arch/s390/pci/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 9381d5d98156..2ba2cbfaa091 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -785,6 +785,15 @@ static void zpci_remove_bus(struct pci_bus *bus)
 	kfree(zdev);
 }
 
+static int zpci_add_vfs(struct pci_dev *pdev, u16 num_vfs)
+{
+	return 0;
+}
+
+static void zpci_del_vfs(struct pci_dev *pdev)
+{
+}
+
 static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
@@ -801,6 +810,8 @@ static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 	bridge->busnr = bus;
 	bridge->ops = ops;
 	bridge->remove_bus = zpci_remove_bus;
+	bridge->add_vfs = zpci_add_vfs;
+	bridge->del_vfs = zpci_del_vfs;
 
 	error = pci_scan_root_bus_bridge(bridge);
 	if (error < 0)
-- 
2.13.4
