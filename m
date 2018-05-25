Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sRyT6ZdZzF1P6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 10:31:45 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P0U8eT082184
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 20:31:43 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j62bb5393-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 20:31:43 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 25 May 2018 01:31:41 +0100
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Cc: mpe@ellerman.id.au, bhelgaas@google.com, bryantly@linux.vnet.ibm.com
Subject: [PATCH v2 1/1] powerpc/pseries: fix EEH recovery of some IOV devices
Date: Fri, 25 May 2018 10:31:36 +1000
Message-Id: <7598ffeb48c16c88a34937ad93b18f806222b8df.1527208281.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EEH recovery currently fails on pSeries for some IOV capable PCI
devices, if CONFIG_PCI_IOV is on and the hypervisor doesn't provide
certain device tree properties for the device. (Found on an IOV
capable device using the ipr driver.)

Recovery fails in pci_enable_resources() at the check on r->parent,
because r->flags is set and r->parent is not.  This state is due to
sriov_init() setting the start, end and flags members of the IOV BARs
but the parent not being set later in
pseries_pci_fixup_iov_resources(), because the
"ibm,open-sriov-vf-bar-info" property is missing.

Correct this by zeroing the resource flags for IOV BARs when they
can't be configured.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
Hi,

This is a fix to allow EEH recovery to succeed in a specific situation,
which I've tried to explain in the commit message.

As with the RFC version, the IOV BARs are disabled by setting the resource
flags to 0 but the other fields are now left as-is because that is what is done
elsewhere (see sriov_init() and __pci_read_base()).

I've also examined the concern raised by Bjorn Helgaas, that VFs could be
enabled later after the BARs are disabled, and it already seems safe: enabling
VFs (on pseries) depends on another device tree property,
"ibm,number-of-configurable-vfs" as well as support for the RTAS function
"ibm_map_pes". Since these are all part of the hypervisor's support for IOV it
seems unlikely that we would ever see some of them but not all. (None are
currently provided by QEMU/KVM.) (Additionally, the ipr driver on which the EEH
recovery failure was discovered doesn't even seem to have SR-IOV support so it
certainly can't enable VFs.)

Cheers,
Sam.
====== v1 -> v2: ======

Patch 1/1: powerpc/pseries: fix EEH recovery of some IOV devices
* Moved the BAR disabling code to a function.
* Also check in pseries_pci_fixup_resources().

====== v1: ======

Patch 1/1: powerpc/pseries: fix EEH recovery of IOV devices

 arch/powerpc/platforms/pseries/setup.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b55ad4286dc7..0a9e4243ae1d 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -645,6 +645,15 @@ void of_pci_parse_iov_addrs(struct pci_dev *dev, const int *indexes)
 	}
 }
 
+static void pseries_disable_sriov_resources(struct pci_dev *pdev)
+{
+	int i;
+
+	pci_warn(pdev, "No hypervisor support for SR-IOV on this device, IOV BARs disabled.\n");
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
+		pdev->resource[i + PCI_IOV_RESOURCES].flags = 0;
+}
+
 static void pseries_pci_fixup_resources(struct pci_dev *pdev)
 {
 	const int *indexes;
@@ -652,10 +661,10 @@ static void pseries_pci_fixup_resources(struct pci_dev *pdev)
 
 	/*Firmware must support open sriov otherwise dont configure*/
 	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
-	if (!indexes)
-		return;
-	/* Assign the addresses from device tree*/
-	of_pci_set_vf_bar_size(pdev, indexes);
+	if (indexes)
+		of_pci_set_vf_bar_size(pdev, indexes);
+	else
+		pseries_disable_sriov_resources(pdev);
 }
 
 static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
@@ -667,10 +676,10 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
 		return;
 	/*Firmware must support open sriov otherwise dont configure*/
 	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
-	if (!indexes)
-		return;
-	/* Assign the addresses from device tree*/
-	of_pci_parse_iov_addrs(pdev, indexes);
+	if (indexes)
+		of_pci_parse_iov_addrs(pdev, indexes);
+	else
+		pseries_disable_sriov_resources(pdev);
 }
 
 static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *pdev,
-- 
2.16.1.74.g9b0b1f47b
