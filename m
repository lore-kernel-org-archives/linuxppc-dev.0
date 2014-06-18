Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 268D31A032E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 21:36:40 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 18 Jun 2014 21:36:38 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D95EE3578048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 21:36:34 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5IBaITi10027468
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 21:36:19 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5IBaXcH028839
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 21:36:34 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] vfio: Fix endianness handling for emulated BARs
Date: Wed, 18 Jun 2014 21:36:31 +1000
Message-Id: <1403091391-31780-1-git-send-email-aik@ozlabs.ru>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Alex Williamson <alex.williamson@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VFIO exposes BARs to user space as a byte stream so userspace can
read it using pread()/pwrite(). Since this is a byte stream, VFIO should
not do byte swapping and simply return values as it gets them from
PCI device.

Instead, the existing code assumes that byte stream in read/write is
little-endian and it fixes endianness for values which it passes to
ioreadXX/iowriteXX helpers. This works for little-endian as PCI is
little endian and le32_to_cpu/... are stubs.

This also works for big endian but rather by an accident: it reads 4 bytes
from the stream (@val is big endian), converts to CPU format (which should
be big endian) as it was little endian (@val becomes actually little
endian) and calls iowrite32() which does not do swapping on big endian
system.

This removes byte swapping and makes use ioread32be/iowrite32be
(and 16bit versions) on big-endian systems. The "be" helpers take
native endian values and do swapping at the moment of writing to a PCI
register using one of "store byte-reversed" instructions.

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 210db24..f363b5a 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -21,6 +21,18 @@
 
 #include "vfio_pci_private.h"
 
+#ifdef __BIG_ENDIAN__
+#define ioread16_native		ioread16be
+#define ioread32_native		ioread32be
+#define iowrite16_native	iowrite16be
+#define iowrite32_native	iowrite32be
+#else
+#define ioread16_native		ioread16
+#define ioread32_native		ioread32
+#define iowrite16_native	iowrite16
+#define iowrite32_native	iowrite32
+#endif
+
 /*
  * Read or write from an __iomem region (MMIO or I/O port) with an excluded
  * range which is inaccessible.  The excluded range drops writes and fills
@@ -50,9 +62,9 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
 				if (copy_from_user(&val, buf, 4))
 					return -EFAULT;
 
-				iowrite32(le32_to_cpu(val), io + off);
+				iowrite32_native(val, io + off);
 			} else {
-				val = cpu_to_le32(ioread32(io + off));
+				val = ioread32_native(io + off);
 
 				if (copy_to_user(buf, &val, 4))
 					return -EFAULT;
@@ -66,9 +78,9 @@ static ssize_t do_io_rw(void __iomem *io, char __user *buf,
 				if (copy_from_user(&val, buf, 2))
 					return -EFAULT;
 
-				iowrite16(le16_to_cpu(val), io + off);
+				iowrite16_native(val, io + off);
 			} else {
-				val = cpu_to_le16(ioread16(io + off));
+				val = ioread16_native(io + off);
 
 				if (copy_to_user(buf, &val, 2))
 					return -EFAULT;
-- 
2.0.0
