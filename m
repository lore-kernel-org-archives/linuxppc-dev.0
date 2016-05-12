Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r58r92ZxBzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 20:49:28 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Christian Lamparter <chunkeey@googlemail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: linux-mips@linux-mips.org, johnyoun@synopsys.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, a.seppala@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Felipe Balbi <balbi@ti.com>, Douglas Anderson <dianders@chromium.org>,
 Gregory Herrero <gregory.herrero@intel.com>,
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] usb: dwc2: fix regression on big-endian PowerPC/ARM systems
Date: Thu, 12 May 2016 12:48:09 +0200
Message-Id: <1463050104-2788693-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A patch that went into Linux-4.4 to fix big-endian mode on a Lantiq
MIPS system unfortunately broke big-endian operation on PowerPC
APM82181 as reported by Christian Lamparter, and likely other
systems.

It actually introduced multiple issues:

- it broke big-endian ARM kernels: any machine that was working
  correctly with a little-endian kernel is no longer using byteswaps
  on big-endian kernels, which clearly breaks them.
- On PowerPC the same thing must be true: if it was working before,
  using big-endian kernels is now broken. Unlike ARM, 32-bit PowerPC
  usually uses big-endian kernels, so they are likely all broken.
- The barrier for dwc2_writel is on the wrong side of the __raw_writel(),
  so the MMIO no longer synchronizes with DMA operations.
- On architectures that require specific CPU instructions for MMIO
  access, using the __raw_ variant may turn this into a pointer
  dereference that does not have the same effect as the readl/writel.

This patch is a simple revert for all architectures other than MIPS,
in the hope that we can more easily backport it to fix the regression
on PowerPC and ARM systems without breaking the Lantiq system again.

We should follow this up with a more elaborate change to add runtime
detection of endianess, to make sure it also works on all other
combinations of architectures and implementations of the usb-dwc2
device. That patch however will be fairly large and not appropriate
for backports to stable kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 95c8bc360944 ("usb: dwc2: Use platform endianness when accessing registers")
---
 drivers/usb/dwc2/core.h | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 3c58d633ce80..1f8ed149a40f 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -64,12 +64,24 @@
 	DWC2_TRACE_SCHEDULER_VB(pr_fmt("%s: SCH: " fmt),		\
 				dev_name(hsotg->dev), ##__VA_ARGS__)
 
+
+#ifdef CONFIG_MIPS
+/*
+ * There are some MIPS machines that can run in either big-endian
+ * or little-endian mode and that use the dwc2 register without
+ * a byteswap in both ways.
+ * Unlike other architectures, MIPS does not require a barrier
+ * before the __raw_writel() to synchronize with DMA but does
+ * require the barrier after the writel() to serialize a series
+ * of writes. This set of operations was added specifically for
+ * MIPS and should only be used there.
+ */
 static inline u32 dwc2_readl(const void __iomem *addr)
 {
 	u32 value = __raw_readl(addr);
 
-	/* In order to preserve endianness __raw_* operation is used. Therefore
-	 * a barrier is needed to ensure IO access is not re-ordered across
+	/* in order to preserve endianness __raw_* operation is used. therefore
+	 * a barrier is needed to ensure io access is not re-ordered across
 	 * reads or writes
 	 */
 	mb();
@@ -81,15 +93,32 @@ static inline void dwc2_writel(u32 value, void __iomem *addr)
 	__raw_writel(value, addr);
 
 	/*
-	 * In order to preserve endianness __raw_* operation is used. Therefore
-	 * a barrier is needed to ensure IO access is not re-ordered across
+	 * in order to preserve endianness __raw_* operation is used. therefore
+	 * a barrier is needed to ensure io access is not re-ordered across
 	 * reads or writes
 	 */
 	mb();
-#ifdef DWC2_LOG_WRITES
-	pr_info("INFO:: wrote %08x to %p\n", value, addr);
+#ifdef dwc2_log_writes
+	pr_info("info:: wrote %08x to %p\n", value, addr);
 #endif
 }
+#else
+/* Normal architectures just use readl/write */
+static inline u32 dwc2_readl(const void __iomem *addr)
+{
+	u32 value = readl(addr);
+	return value;
+}
+
+static inline void dwc2_writel(u32 value, void __iomem *addr)
+{
+	writel(value, addr);
+
+#ifdef dwc2_log_writes
+	pr_info("info:: wrote %08x to %p\n", value, addr);
+#endif
+}
+#endif
 
 /* Maximum number of Endpoints/HostChannels */
 #define MAX_EPS_CHANNELS	16
-- 
2.7.0
