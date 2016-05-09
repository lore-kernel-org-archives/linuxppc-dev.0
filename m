Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3JhY5tbQzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 20:36:29 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org, benh@au1.ibm.com, linux-mips@linux-mips.org
Cc: Christian Lamparter <chunkeey@googlemail.com>, linux-usb@vger.kernel.org,
 johnyoun@synopsys.com, gregkh@linuxfoundation.org, a.seppala@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Mon, 09 May 2016 12:36:04 +0200
Message-ID: <4162108.qmr2GZCaDN@wuerfel>
In-Reply-To: <1462753402.20290.95.camel@au1.ibm.com>
References: <4231696.iL6nGs74X8@debian64> <1908894.Nkk1LXQkFm@debian64>
 <1462753402.20290.95.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 09 May 2016 10:23:22 Benjamin Herrenschmidt wrote:
> On Sun, 2016-05-08 at 13:44 +0200, Christian Lamparter wrote:
> > On Sunday, May 08, 2016 08:40:55 PM Benjamin Herrenschmidt wrote:
> > > 
> > > On Sun, 2016-05-08 at 00:54 +0200, Christian Lamparter via Linuxppc-dev 
> > > wrote:
> > > > 
> > > > I've been looking in getting the MyBook Live Duo's USB OTG port
> > > > to function. The SoC is a APM82181. Which has a PowerPC 464 core
> > > > and related to the supported canyonlands architecture in
> > > > arch/powerpc/.
> > > > 
> > > > Currently in -next the dwc2 module doesn't load: 
> > > Smells like the APM implementation is little endian. You might need to
> > > use a flag to indicate what endian to use instead and set it
> > > appropriately based on some DT properties.
> > I tried. As per common-properties[0], I added little-endian; but it has no
> > effect. I looked in dwc2_driver_probe and found no way of specifying the
> > endian of the device. It all comes down to the dwc2_readl & dwc2_writel
> > accessors. These - sadly - have been hardwired to use __raw_readl and
> > __raw_writel. So, it's always "native-endian". While common-properties
> > says little-endian should be preferred.
> 
> Right, I meant, you should produce a patch adding a runtime test inside
> those functions based on a device-tree property, a bit like we do for
> some of the HCDs like OHCI, EHCI etc...
> 
> 

The patch that caused the problem had multiple issues:

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

I think we can simply make this set of accessors architecture-dependent
(MIPS vs. the rest of the world) to revert ARM and PowerPC back to
the working version.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
