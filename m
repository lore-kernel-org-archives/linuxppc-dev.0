Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmw7l3VrnzF0p8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 11:23:47 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1M0MKl6112603
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 19:23:44 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g9hs22jef-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 19:23:44 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 22 Feb 2018 00:23:42 -0000
Date: Thu, 22 Feb 2018 11:23:35 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Cc: mpe@ellerman.id.au, bhelgaas@google.com, bryantly@linux.vnet.ibm.com
Subject: [PATCH RFC 1/1] powerpc/pseries: fix EEH recovery of IOV devices
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <4bd50291799b920b42f8a12f5635c40ccae1302e.1519258921.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently EEH recovery will fail on pSeries platforms for
passed-through physical devices that support IOV, when CONFIG_PCI_IOV
is set and the hypervisor doesn't provide a device tree node
"ibm,open-sriov-vf-bar-info" for the device. (Found on an IOV capable
device using the ipr driver.)

EEH recovery fails in pci_enable_resources() at the check on
r->parent, because r->flags is set and r->parent is not.  This state
is due to sriov_init() setting the start, end and flags members of the
IOV BARs but the parent not being set later in
pseries_pci_fixup_iov_resources(), because the
"ibm,open-sriov-vf-bar-info" property is missing, causing it to bail
out early.

Correct this by zeroing the IOV resources in the bailout path, so that
they are not seen by pci_enable_resources().

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
Hi,

This is a fix to allow EEH recovery to succeed in a specific situation,
which I've tried to explain in the commit message. But while I'm fairly sure of
the situation leading up to the problem, I'm not sure how it should be fixed,
which is why I've posted this as an RFC.

Just zeroing out the flags is sufficient in my tests but it seemed cleaner to
also clear start and end, but other changes would work as well: just clearing
the flags, or just removing IORESOURCE_IO and IORESOURCE_MEM or even adding
some new flag and also adjusting the test. Perhaps there's something else.
I'm not sure what implications these choices have for the generic PCI code so I
would appreciate feedback on it.

Note that this problem doesn't seem to have been introduced by
pseries_pci_fixup_iov_resources() (which was added recently): recovery
already failed (in this way) before it's introduction.

 arch/powerpc/platforms/pseries/setup.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 372d7ada1a0c..019836ffe53d 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -618,13 +618,24 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
 {
 	const int *indexes;
 	struct device_node *dn = pci_device_to_OF_node(pdev);
+	int i;
+	struct resource *r;
 
 	if (!pdev->is_physfn || pdev->is_added)
 		return;
 	/*Firmware must support open sriov otherwise dont configure*/
 	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
-	if (!indexes)
+	if (!indexes) {
+		/* Hide the BARs we can't configure, otherwise other
+		 * code may see r->flags != 0 and r->parent == 0
+		 * and raise an error. */
+		pci_warn(pdev, "No hypervisor support for SRIOV on this device, IOV BARs disabled.\n");
+		for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+			r = &pdev->resource[PCI_IOV_RESOURCES + i];
+			r->start = r->end = r->flags = 0;
+		}
 		return;
+	}
 	/* Assign the addresses from device tree*/
 	of_pci_parse_iov_addrs(pdev, indexes);
 }
-- 
2.16.1.74.g9b0b1f47b
