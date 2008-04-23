Return-Path: <Sellsa@ZIN-TECH.COM>
Received: from zinexc.ZIN.NET (ramp034-158.rampant.com [64.28.34.158])
	by ozlabs.org (Postfix) with ESMTP id CF0AEDDFCC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 00:59:17 +1000 (EST)
Message-ID: <480F4E8E.4010506@zin-tech.com>
Date: Wed, 23 Apr 2008 10:58:22 -0400
From: Aaron Sells <aaron.sells@zin-tech.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>,
	Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: SecretLab 2.6.24 with USB
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>	
	<fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>	
	<16825460.post@talk.nabble.com>	
	<fa686aa40804221309g7d0749e8qc329ad72389f0138@mail.gmail.com>	
	<480E4EBD.3010202@zin-tech.com>
	<fa686aa40804221355s11f8fd6em3f2075bbb2073c8@mail.gmail.com>
In-Reply-To: <fa686aa40804221355s11f8fd6em3f2075bbb2073c8@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------040505050205000209020300"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040505050205000209020300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Grant Likely wrote:
> Compare arch/ppc/syslib/virtex_devices.c with the one in my git tree.
> Add the relevant missing bits.

Peter Korsgaard wrote:
> Did you register a struct platform_device for the c67x00?

I copied over the relevant USB code from secretlab's virtex_devices.c to 
my Xilinx tree.  In case I missed something, the diff between the two 
files is attached. And yes, I copied over include/linux/usb/c67x00.h as 
well.  After doing this, I had to modify a couple of the c67x00 driver 
files to get the kernel to compile.  The patch is attached.

root@xilinx-ml403:/# dmesg | grep -i usb
[    0.175963] usbcore: registered new interface driver usbfs
[    0.178207] usbcore: registered new interface driver hub
[    0.179810] usbcore: registered new device driver usb
[    3.426016] usbcore: registered new interface driver ub
[    4.156086] usbmon: debugfs is not available
[    4.209160] Initializing USB Mass Storage driver...
[    4.268302] usbcore: registered new interface driver usb-storage
[    4.336109] USB Mass Storage support registered.
[    4.958294] usbcore: registered new interface driver usbhid
[    5.020120] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver

It still doesn't look like the ML403 Cypress host device is being 
recognized.  No messages appear upon insertion and removal of USB devices.

Regards,
Aaron Sells

--------------040505050205000209020300
Content-Type: text/plain;
 name="virtex_devices.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="virtex_devices.c.diff"

diff linux-2.6-xlnx_arch-ppc-syslib-virtex_devices.c secretlab_arch-ppc-syslib-virtex_devices.c
77,92d76
<  * ML300/ML403 Video Device: shortcut macro for single instance
<  */
< #define XPAR_TFT(num) { \
< 	.name = "xilinxfb", \
< 	.id = num, \
< 	.num_resources = 1, \
< 	.resource = (struct resource[]) { \
< 		{ \
< 			.start = XPAR_TFT_##num##_BASEADDR, \
< 			.end = XPAR_TFT_##num##_BASEADDR+7, \
< 			.flags = IORESOURCE_IO, \
< 		}, \
< 	}, \
< }
< 
< /*
126,152d109
<  * EMAC: shortcut macro for single instance
<  */
< #define XPAR_EMACLITE(num) { \
< 	.name		= "xilinx_emaclite", \
< 	.id		= num, \
< 	.num_resources	= 2, \
< 	.resource = (struct resource[]) { \
< 		{ \
< 			.start	= XPAR_EMACLITE_##num##_BASEADDR, \
< 			.end	= XPAR_EMACLITE_##num##_HIGHADDR, \
< 			.flags	= IORESOURCE_MEM, \
< 		}, \
< 		{ \
< 			.start	= XPAR_INTC_0_EMACLITE_##num##_VEC_ID, \
< 			.flags	= IORESOURCE_IRQ, \
< 		}, \
< 	}, \
< 	.dev.platform_data = &(struct xemaclite_platform_data) { \
< 		.tx_ping_pong = XPAR_EMACLITE_##num##_TX_PING_PONG, \
< 		.rx_ping_pong = XPAR_EMACLITE_##num##_RX_PING_PONG, \
< 		/* locally administered default address */ \
< 		.mac_addr = {2, 0, 0, 0, 0, num}, \
< 	}, \
< }
< 
< 
< /*
199,288c156,160
< #define XPAR_LLTEMAC_RESOURCES(num) \
< 	.name = "xilinx_lltemac", \
< 	.id = XPAR_LLTEMAC_##num##_DEVICE_ID, \
< 	.num_resources = 2, \
< 	.resource = (struct resource[]) { \
< 		{ \
< 			.start = XPAR_LLTEMAC_##num##_BASEADDR, \
< 			.end = XPAR_LLTEMAC_##num##_BASEADDR + 0x1000, \
< 			.flags = IORESOURCE_MEM \
< 		}, \
< 		{ \
< 			.start = XPAR_INTC_0_LLTEMAC_##num##_VEC_ID, \
< 			.end = XPAR_INTC_0_LLTEMAC_##num##_VEC_ID, \
< 			.flags = IORESOURCE_IRQ \
< 		} \
< 	}
< 
< #ifdef XPAR_XLLDMA_USE_DCR
< #define DCRHOST 0xFF
< #else 
< #define DCRHOST 0x00
< #endif
< 
< #define XPAR_LLTEMAC(num) { \
< 	XPAR_LLTEMAC_RESOURCES(num), \
< 	.dev.platform_data = &(struct xlltemac_platform_data) { \
< 		.tx_csum = XPAR_LLTEMAC_##num##_TXCSUM, \
< 		.rx_csum = XPAR_LLTEMAC_##num##_RXCSUM, \
< 		.phy_type = XPAR_LLTEMAC_##num##_PHY_TYPE, \
< 		.dcr_host = DCRHOST, \
< 		.ll_dev_type = XPAR_LLTEMAC_##num##_LLINK_CONNECTED_TYPE, \
< 		.ll_dev_baseaddress = XPAR_LLTEMAC_##num##_LLINK_CONNECTED_BASEADDR, \
< 		.ll_dev_dma_rx_irq = XPAR_LLTEMAC_##num##_LLINK_CONNECTED_DMARX_INTR, \
< 		.ll_dev_dma_tx_irq = XPAR_LLTEMAC_##num##_LLINK_CONNECTED_DMATX_INTR, \
< 		.ll_dev_fifo_irq = XPAR_LLTEMAC_##num##_LLINK_CONNECTED_FIFO_INTR, \
< 		/* locally administered default address */ \
< 		.mac_addr = {2, 0, 0, 0, 0, num}, \
< 	}, \
< }
< 
< 
< #define XPAR_PS2(num) { \
< 	.name = "xilinx_ps2", \
< 	.id = num, \
< 	.num_resources = 2, \
< 	.resource = (struct resource[]) { \
< 		{ \
< 			.start = XPAR_PS2_##num##_BASEADDR, \
< 			.end = XPAR_PS2_##num##_HIGHADDR, \
< 			.flags = IORESOURCE_MEM, \
< 		}, \
< 		{ \
< 			.start = XPAR_INTC_0_PS2_##num##_VEC_ID, \
< 			.flags = IORESOURCE_IRQ, \
< 		}, \
< 	}, \
< }
< 
< #define XPAR_IIC(num) { \
<     .name = "xilinx_iic", \
<     .id = num, \
<     .num_resources = 2, \
<     .resource = (struct resource[]) { \
<         { \
<             .start = XPAR_IIC_##num##_BASEADDR, \
<             .end = XPAR_IIC_##num##_HIGHADDR, \
<             .flags = IORESOURCE_MEM, \
<         }, \
<         { \
<             .start = XPAR_INTC_0_IIC_##num##_VEC_ID, \
<             .flags = IORESOURCE_IRQ, \
<         }, \
<     }, \
< }
< 
< #ifdef CONFIG_XILINX_VIRTEX_II_PRO
< #define XPAR_HWICAP_FAMILY "virtex2p"
< #endif
< #ifdef CONFIG_XILINX_VIRTEX_4_FX
< #define XPAR_HWICAP_FAMILY "virtex4"
< #endif
< #ifdef CONFIG_XILINX_VIRTEX_5
< #define XPAR_HWICAP_FAMILY "virtex5"
< #endif
< #ifndef XPAR_HWICAP_FAMILY
< #define XPAR_HWICAP_FAMILY NULL
< #endif
< 
< #define XPAR_HWICAP(num) { \
< 	.name = "xilinx_icap", \
---
> /*
>  * ML300/ML403 Video Device: shortcut macro for single instance
>  */
> #define XPAR_TFT(num) { \
> 	.name = "xilinxfb", \
293,295c165,167
<                         .start = XPAR_HWICAP_##num##_BASEADDR,  \
< 			.end   = XPAR_HWICAP_##num##_HIGHADDR,    \
< 			.flags = IORESOURCE_MEM, \
---
> 			.start = XPAR_TFT_##num##_BASEADDR, \
> 			.end = XPAR_TFT_##num##_BASEADDR+7, \
> 			.flags = IORESOURCE_IO, \
298d169
< 	.dev.platform_data = XPAR_HWICAP_FAMILY,	\
409,410c280,281
< 		.name = "serial8250",
< 		.id = 0,
---
> 		.name		= "serial8250",
> 		.id		= 0,
437,450d307
< 	/* EMACLITE instances */
< #if defined(XPAR_EMACLITE_0_BASEADDR)
< 	XPAR_EMACLITE(0),
< #endif
< #if defined(XPAR_EMACLITE_1_BASEADDR)
< 	XPAR_EMACLITE(1),
< #endif
< #if defined(XPAR_EMACLITE_2_BASEADDR)
< 	XPAR_EMACLITE(2),
< #endif
< #if defined(XPAR_EMACLITE_3_BASEADDR)
< 	XPAR_EMACLITE(3),
< #endif
< 
484,518d340
< 	/* LLTEMAC instances */
< #if defined(XPAR_LLTEMAC_0_BASEADDR)
< 	XPAR_LLTEMAC(0),
< #endif
< #if defined(XPAR_LLTEMAC_1_BASEADDR)
< 	XPAR_LLTEMAC(1),
< #endif
< #if defined(XPAR_LLTEMAC_2_BASEADDR)
< 	XPAR_LLTEMAC(2),
< #endif
< #if defined(XPAR_LLTEMAC_3_BASEADDR)
< 	XPAR_LLTEMAC(3),
< #endif
< 
< #if defined(XPAR_PS2_0_BASEADDR)
< 	XPAR_PS2(0),
< #endif
< #if defined(XPAR_PS2_1_BASEADDR)
< 	XPAR_PS2(1),
< #endif
< #if defined(XPAR_PS2_2_BASEADDR)
< 	XPAR_PS2(2),
< #endif
< #if defined(XPAR_PS2_3_BASEADDR)
< 	XPAR_PS2(3),
< #endif
< 
< #if defined(XPAR_IIC_0_BASEADDR)
<     XPAR_IIC(0),
< #endif
< 
< #if defined(XPAR_HWICAP_0_BASEADDR)
< 	XPAR_HWICAP(0),
< #endif
< 
554d375
< 	extern void gen550_init(int i, struct uart_port *serial_req);
558,564c379,385
< 	serial_req.mapbase = pdata->mapbase;
< 	serial_req.membase = pdata->membase;
< 	serial_req.irq = pdata->irq;
< 	serial_req.uartclk = pdata->uartclk;
< 	serial_req.regshift = pdata->regshift;
< 	serial_req.iotype = pdata->iotype;
< 	serial_req.flags = pdata->flags;
---
> 	serial_req.mapbase	= pdata->mapbase;
> 	serial_req.membase	= pdata->membase;
> 	serial_req.irq		= pdata->irq;
> 	serial_req.uartclk	= pdata->uartclk;
> 	serial_req.regshift	= pdata->regshift;
> 	serial_req.iotype	= pdata->iotype;
> 	serial_req.flags	= pdata->flags;
608,609d428
< 		printk(KERN_INFO "Registering device %s:%d\n",
< 		       index->name, index->id);

--------------040505050205000209020300
Content-Type: text/plain;
 name="c67x00.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="c67x00.patch"

diff -Naur c67x00.old/c67x00-drv.c c67x00/c67x00-drv.c
--- c67x00.old/c67x00-drv.c	2008-04-23 10:36:16.000000000 -0400
+++ c67x00/c67x00-drv.c	2008-04-23 10:39:20.000000000 -0400
@@ -57,8 +57,7 @@
 		c67x00_hcd_probe(sie);
 		break;
 
-	case C67X00_SIE_PERIPHERAL_A:
-	case C67X00_SIE_PERIPHERAL_B:
+	case C67X00_SIE_PERIPHERAL:
 		c67x00_udc_probe(sie);
 		break;
 
@@ -82,8 +81,7 @@
 		c67x00_hcd_remove(sie);
 		break;
 
-	case C67X00_SIE_PERIPHERAL_A:
-	case C67X00_SIE_PERIPHERAL_B:
+	case C67X00_SIE_PERIPHERAL:
 		c67x00_udc_remove(sie);
 		break;
 
diff -Naur c67x00.old/c67x00-ll-hpi.c c67x00/c67x00-ll-hpi.c
--- c67x00.old/c67x00-ll-hpi.c	2008-04-23 10:36:16.000000000 -0400
+++ c67x00/c67x00-ll-hpi.c	2008-04-23 10:39:35.000000000 -0400
@@ -431,7 +431,7 @@
 		       USB_CTL_REG(sie->sie_num),
 		       SOF_EOP_EN(0) | SOF_EOP_EN(1));
 
-	if (sie->mode == C67X00_SIE_PERIPHERAL_A)
+	if (sie->mode == C67X00_SIE_PERIPHERAL)
 		hpi_write_word(dev, DEVICE_N_PORT_SEL(sie->sie_num),  0x0000);
 	else
 		hpi_write_word(dev, DEVICE_N_PORT_SEL(sie->sie_num),  0x4000);

--------------040505050205000209020300--
