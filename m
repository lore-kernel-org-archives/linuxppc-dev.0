Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D82921A0F84
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jan 2016 06:09:48 +1100 (AEDT)
Date: Thu, 31 Dec 2015 21:09:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH v2 30/32] virtio_ring: update weak barriers to use __smp_XXX
Message-ID: <1451572003-2440-31-git-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1451572003-2440-1-git-send-email-mst@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

virtio ring uses smp_wmb on SMP and wmb on !SMP,
the reason for the later being that it might be
talking to another kernel on the same SMP machine.

This is exactly what __smp_XXX barriers do,
so switch to these instead of homegrown ifdef hacks.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 67e06fe..f3fa55b 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -12,7 +12,7 @@
  * anyone care?
  *
  * For virtio_pci on SMP, we don't need to order with respect to MMIO
- * accesses through relaxed memory I/O windows, so smp_mb() et al are
+ * accesses through relaxed memory I/O windows, so virt_mb() et al are
  * sufficient.
  *
  * For using virtio to talk to real devices (eg. other heterogeneous
@@ -21,11 +21,10 @@
  * actually quite cheap.
  */
 
-#ifdef CONFIG_SMP
 static inline void virtio_mb(bool weak_barriers)
 {
 	if (weak_barriers)
-		smp_mb();
+		virt_mb();
 	else
 		mb();
 }
@@ -33,7 +32,7 @@ static inline void virtio_mb(bool weak_barriers)
 static inline void virtio_rmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		smp_rmb();
+		virt_rmb();
 	else
 		rmb();
 }
@@ -41,26 +40,10 @@ static inline void virtio_rmb(bool weak_barriers)
 static inline void virtio_wmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		smp_wmb();
+		virt_wmb();
 	else
 		wmb();
 }
-#else
-static inline void virtio_mb(bool weak_barriers)
-{
-	mb();
-}
-
-static inline void virtio_rmb(bool weak_barriers)
-{
-	rmb();
-}
-
-static inline void virtio_wmb(bool weak_barriers)
-{
-	wmb();
-}
-#endif
 
 struct virtio_device;
 struct virtqueue;
-- 
MST
