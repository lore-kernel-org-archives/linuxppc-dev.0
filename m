Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 647C42C00DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 18:26:43 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 15 Mar 2013 01:26:42 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 18CF61FF0039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 01:21:45 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2F7QdUL086788
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 01:26:39 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2F7QbAX014464
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 01:26:39 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] VFIO: Direct access config reg without capability
Date: Fri, 15 Mar 2013 15:26:30 +0800
Message-Id: <1363332390-12754-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The config registers in [0, 0x40] is being supported by VFIO. Apart
from that, the other config registers should be coverred by PCI or
PCIe capability. However, there might have some PCI devices (be2net)
who has config registers (0x7c) out of [0, 0x40], and don't have
corresponding PCI or PCIe capability. VFIO will return 0x0 on reading
those registers and writing is dropped. It caused the be2net driver
fails to be loaded because 0x0 returned from its config register 0x7c.

The patch changes the behaviour so that those config registers out
of [0, 0x40] and don't have corresponding PCI or PCIe capability
will be accessed directly.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci_config.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 964ff22..5ea3afb 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1471,18 +1471,27 @@ static ssize_t vfio_config_do_rw(struct vfio_pci_device *vdev, char __user *buf,
 
 	cap_id = vdev->pci_config_map[*ppos / 4];
 
+	/*
+	 * Some PCI device config registers might not be coverred by
+	 * capability and useful. We will enable direct access to
+	 * those registers.
+	 */
 	if (cap_id == PCI_CAP_ID_INVALID) {
-		if (iswrite)
-			return ret; /* drop */
-
-		/*
-		 * Per PCI spec 3.0, section 6.1, reads from reserved and
-		 * unimplemented registers return 0
-		 */
-		if (copy_to_user(buf, &val, count))
-			return -EFAULT;
-
-		return ret;
+		if (iswrite) {
+			if (copy_from_user(&val, buf, count))
+				return -EFAULT;
+			ret = vfio_user_config_write(vdev->pdev, (int)(*ppos),
+						     val, count);
+			return ret ? ret : count;
+		} else {
+			ret = vfio_user_config_read(vdev->pdev, (int)(*ppos),
+						    &val, count);
+			if (ret)
+				return ret;
+			if (copy_to_user(buf, &val, count))
+				return -EFAULT;
+			return count;
+		}
 	}
 
 	/*
-- 
1.7.5.4
