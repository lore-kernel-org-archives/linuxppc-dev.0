Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id CC536DDE9F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 04:27:50 +1000 (EST)
Message-ID: <4627B5AE.5060109@ru.mvista.com>
Date: Thu, 19 Apr 2007 22:32:14 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC] add 8-bit bus support to the Xilinx SystemACE device driver
	+ minor clean-ups
References: <1176600194262-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1176600194262-git-send-email-grant.likely@secretlab.ca>
Content-Type: multipart/mixed; boundary="------------070603060008010001030707"
Cc: Peter Korsgaard <jacmet@sunsite.dk>,
	Andrei Konovalov <akonovalov@ru.mvista.com>, Stefan Roese <sr@denx.de>,
	Rick Moleres <Rick.Moleres@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070603060008010001030707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The attached patch should be applied on top of the SystemACE device
driver patch by Grant.

Here is the list of changes:

1) 8-bit bus support added to the driver.
    SystemACE chip could be connected to the FPGA by 8-bit or
    16-bit data bus.
    ML403 uses the 16-bit connection, while ML300 - the 8-bit one.

2) In the original driver the data bus width and endiannes has
    been hard-coded with "#if 1" etc statements.
    I've tried to bind this selection to the board the kernel is built
    for: the bus width is defined by the board design, am I right?
    Please let me know if this concept is correct.

3) Added "do {" "} while(0)" brackets to the macros that need them.

Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>

I've done some testing for the Grant's driver with this patch applied.
Both ML403 and ML300 booted OK with rootfs on CF card and the microdrive
respectively. ML403 survived "bonnie++ -f -u root -x 5 -r 8 -s 16" test
(it took 15 minutes to complete), and I wouldn't like to repeat this
test because of the risk to kill the CF card. ML300 oopsed during
the 3d pass of "bonnie++ -f -u root -x 5 -r 10 -s 20"
(kernel access of bad area, sig: 11). Haven't dig into this yet.

Thanks,
Andrei

Grant Likely wrote:
> Add support for block device access to the Xilinx SystemACE Compact
> flash interface
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> I think this driver is in pretty good shape.  I've got a few things to
> clean up a bit.  Specifically, I'm still working on error handling and
> making sure that the state machine is sane at all times.
> 
> I would appreciate any review/comments.  One area where I am undecided is
> the format of the state machine.  The current code uses one big function
> with a large switch() statment for each state.  I'm considering breaking
> this up into a seperate function for each state, and adding a static
> state table with pointers to each state function.
> 
> I feel this driver is pretty close to done, and I'd like to get it into
> mainline for the 2.6.22 timeframe.
> 
> Cheers,
> g.
> 
>  drivers/block/Kconfig   |    6 +
>  drivers/block/Makefile  |    1 +
>  drivers/block/xsysace.c | 1070 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1077 insertions(+), 0 deletions(-)

--------------070603060008010001030707
Content-Type: text/x-patch;
 name="add-8bit-support-for-systemace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-8bit-support-for-systemace.patch"

Index: linux-2.6.20/arch/ppc/platforms/4xx/Kconfig
===================================================================
--- linux-2.6.20.orig/arch/ppc/platforms/4xx/Kconfig
+++ linux-2.6.20/arch/ppc/platforms/4xx/Kconfig
@@ -55,12 +55,14 @@ config WALNUT
 config XILINX_ML300
 	bool "Xilinx-ML300"
 	select XILINX_VIRTEX_II_PRO
+	select XSYSACE_8BIT
 	help
 	  This option enables support for the Xilinx ML300 evaluation board.
 
 config XILINX_ML403
 	bool "Xilinx-ML403"
 	select XILINX_VIRTEX_4_FX
+	select XSYSACE_16BIT_LE
 	help
 	  This option enables support for the Xilinx ML403 evaluation board.
 endchoice
Index: linux-2.6.20/drivers/block/Kconfig
===================================================================
--- linux-2.6.20.orig/drivers/block/Kconfig
+++ linux-2.6.20/drivers/block/Kconfig
@@ -459,6 +459,16 @@ config XILINX_SYSACE
 	help
 	  Include support for the Xilinx SystemACE CompactFlash interface
 
+config XSYSACE_8BIT
+	bool
+	depends on XILINX_SYSACE
+	default n
+
+config XSYSACE_16BIT_LE
+	bool
+	depends on XILINX_SYSACE
+	default n
+
 endmenu
 
 endif
Index: linux-2.6.20/drivers/block/xsysace.c
===================================================================
--- linux-2.6.20.orig/drivers/block/xsysace.c
+++ linux-2.6.20/drivers/block/xsysace.c
@@ -163,7 +163,39 @@ MODULE_LICENSE("GPL");
  */
 
 /* register access macros */
-#if 1 /* Little endian 16-bit regs */
+
+#if defined CONFIG_XSYSACE_8BIT
+/* Little endian 8-bit regs */
+#define ace_reg_read8(ace, reg)	\
+	in_8(ace->baseaddr + reg)
+#define ace_reg_read16(ace, reg) \
+	(in_8(ace->baseaddr + reg) | (in_8(ace->baseaddr + reg+1) << 8))
+#define ace_reg_readdata(ace, reg) \
+	((in_8(ace->baseaddr + reg) << 8) | (in_8(ace->baseaddr + reg+1)))
+#define ace_reg_read32(ace, reg) \
+	( in_8(ace->baseaddr + reg) | \
+	 (in_8(ace->baseaddr + reg+1) << 8) | \
+	 (in_8(ace->baseaddr + reg+2) << 16) | \
+	 (in_8(ace->baseaddr + reg+3) << 24))
+#define ace_reg_write16(ace, reg, val) \
+	do { \
+		out_8(ace->baseaddr + reg, val); \
+		out_8(ace->baseaddr + reg+1, (val) >> 8); \
+	} while (0)
+#define ace_reg_writedata(ace, reg, val) \
+	do { \
+		out_8(ace->baseaddr + reg, (val)>>8); \
+		out_8(ace->baseaddr + reg+1, val); \
+	} while (0)
+#define ace_reg_write32(ace, reg, val) \
+	do { \
+		out_8(ace->baseaddr + reg, val); \
+		out_8(ace->baseaddr + reg+1, (val) >> 8); \
+		out_8(ace->baseaddr + reg+2, (val) >> 16); \
+		out_8(ace->baseaddr + reg+3, (val) >> 24); \
+	} while (0)
+#elif defined CONFIG_XSYSACE_16BIT_LE
+/* Little endian 16-bit regs */
 #define ace_reg_read8(ace, reg) in_8(ace->baseaddr + reg)
 #define ace_reg_read16(ace, reg) in_le16(ace->baseaddr + reg)
 #define ace_reg_readdata(ace, reg) in_be16(ace->baseaddr + reg)
@@ -171,11 +203,12 @@ MODULE_LICENSE("GPL");
                                   (in_le16(ace->baseaddr + reg)))
 #define ace_reg_write16(ace, reg, val) out_le16(ace->baseaddr + reg, val)
 #define ace_reg_writedata(ace, reg, val) out_be16(ace->baseaddr + reg, val)
-#define ace_reg_write32(ace, reg, val) { \
+#define ace_reg_write32(ace, reg, val) do { \
                            out_le16(ace->baseaddr + reg+2, (val) >> 16); \
                            out_le16(ace->baseaddr + reg, val); \
-                       }
-#else /* Big endian 16-bit regs */
+                       } while (0)
+#else
+/* Big endian 16-bit regs */
 #define ace_reg_read8(ace, reg) in_8(ace->baseaddr + reg)
 #define ace_reg_read16(ace, reg) in_be16(ace->baseaddr + reg)
 #define ace_reg_readdata(ace, reg) in_le16(ace->baseaddr + reg)
@@ -183,10 +216,10 @@ MODULE_LICENSE("GPL");
                                   (in_be16(ace->baseaddr + reg)))
 #define ace_reg_write16(ace, reg, val) out_be16(ace->baseaddr + reg, val)
 #define ace_reg_writedata(ace, reg, val) out_le16(ace->baseaddr + reg, val)
-#define ace_reg_write32(ace, reg, val) { \
+#define ace_reg_write32(ace, reg, val) do { \
                            out_be16(ace->baseaddr + reg+2, (val) >> 16); \
                            out_be16(ace->baseaddr + reg, val); \
-                       }
+                       } while (0)
 #endif
 
 struct ace_device {

--------------070603060008010001030707--
