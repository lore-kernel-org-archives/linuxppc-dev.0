Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 619B22C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 18:26:43 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 15 Mar 2013 01:26:40 -0600
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3D39D6E802A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 03:26:34 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2F7QZsm59441214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 03:26:36 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2F7QZXq019653
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 03:26:35 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] VFIO: VFIO_DEVICE_SET_ADDR_MAPPING command
Date: Fri, 15 Mar 2013 15:26:29 +0800
Message-Id: <1363332390-12754-3-git-send-email-shangw@linux.vnet.ibm.com>
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

The address (domain/bus/slot/function) of the passed PCI device
looks quite different from perspective of host and guest. Some
architectures like PPC need to setup the mapping in host. The patch
introduces additional VFIO device IOCTL command to address that.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 include/uapi/linux/vfio.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 6e58d9b..ecc4f38 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -289,6 +289,22 @@ struct vfio_irq_set {
  */
 #define VFIO_DEVICE_RESET		_IO(VFIO_TYPE, VFIO_BASE + 11)
 
+/**
+ * VFIO_DEVICE_SET_ADDR_MAPPING - _IO(VFIO_TYPE, VFIO_BASE + 12)
+ *
+ * The address, which comprised of domain/bus/slot/function looks
+ * different between host and guest. We need to setup the mapping
+ * in host for some architectures like PPC so that the passed PCI
+ * devices could support RTAS smoothly.
+ */
+struct vfio_addr_mapping {
+	__u64 buid;
+	__u8  bus;
+	__u8  slot;
+	__u8  func;
+};
+#define VFIO_DEVICE_SET_ADDR_MAPPING	_IO(VFIO_TYPE, VFIO_BASE + 12)
+
 /*
  * The VFIO-PCI bus driver makes use of the following fixed region and
  * IRQ index mapping.  Unimplemented regions return a size of zero.
-- 
1.7.5.4
