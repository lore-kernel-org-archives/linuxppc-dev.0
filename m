Return-Path: <Sellsa@ZIN-TECH.COM>
Received: from zinexc.ZIN.NET (ramp034-158.rampant.com [64.28.34.158])
	by ozlabs.org (Postfix) with ESMTP id D3EF9DE493
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Apr 2008 02:05:18 +1000 (EST)
Message-ID: <4810AF87.80602@zin-tech.com>
Date: Thu, 24 Apr 2008 12:04:23 -0400
From: Aaron Sells <aaron.sells@zin-tech.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>, sam.d.karp@gmail.com
Subject: Re: SecretLab 2.6.24 with USB
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>	<fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>	<16825460.post@talk.nabble.com>	<fa686aa40804221309g7d0749e8qc329ad72389f0138@mail.gmail.com>	<480E4EBD.3010202@zin-tech.com>	<fa686aa40804221355s11f8fd6em3f2075bbb2073c8@mail.gmail.com>	<480F4E8E.4010506@zin-tech.com>
	<87iqy8haf8.fsf@macbook.be.48ers.dk>
In-Reply-To: <87iqy8haf8.fsf@macbook.be.48ers.dk>
Content-Type: multipart/mixed; boundary="------------010109060901000707030201"
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
--------------010109060901000707030201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Korsgaard wrote:
> I don't see anything with platform devices for the c67x00 driver.

I added the relevant struct information.  The patch is attached.

> Either you do this by hand or you
> create XPAR_* macros which take the needed info out of xparameter.h
> (sorry, I don't have an xparameters.h with those defines at hand).

I generate the xparameters_ml403.h file using Xilinx's EDK base system 
builder wizard.  However, the wizard does not automatically enable the 
Cypress device to be interrupt driven.  I have manually done this as 
described in the attached patch.

The resulting xparameters_ml403.h has the following defines:

sellsa@SS-SBIR-Ubuntu:~/spacesuit/linux-2.6-xlnx$ cat 
arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h | grep USB
/* Definitions for peripheral CYPRESS_USB */
#define XPAR_CYPRESS_USB_PRH0_BASEADDR 0x80800000
#define XPAR_CYPRESS_USB_PRH0_HIGHADDR 0x8080FFFF
#define XPAR_SYSTEM_USB_INT_PIN_MASK 0X000001
#define XPAR_XPS_INTC_0_SYSTEM_USB_INT_PIN_INTR 0

When I boot the Xilinx ML403 board up, I get the following:

[    9.256329] ------------[ cut here ]------------
[    9.260000] Badness at drivers/usb/c67x00/c67x00-ll-hpi.c:244
[    9.260000] NIP: c01b5d6c LR: c01b5d60 CTR: c00170f4
[    9.260000] REGS: c3c19d70 TRAP: 0700   Not tainted 
(2.6.24-rc8-xlnx-dirty)
[    9.260000] MSR: 00029030 <EE,ME,IR,DR>  CR: 24000082  XER: 20000073
[    9.260000] TASK = c3c178a0[1] 'swapper' THREAD: c3c18000
[    9.260000] GPR00: 00000001 c3c19e20 c3c178a0 00000000 c032f518 
c0372730 27b38fa6 00000001
[    9.260000] GPR08: 00000000 00200200 c3d2b164 c3d2b164 24000082 
ffffcd64 c02d4c5c c02d4c6c
[    9.260000] GPR16: c02d4c90 c02d4c98 c02d4ca8 c02d4cd4 c02d4ce8 
00000000 c02d7114 c0370e78
[    9.260000] GPR24: c0360000 c02d4c54 c0330724 00000000 c3d2b148 
00000000 c3d2b140 c0330708
[    9.260000] NIP [c01b5d6c] c67x00_ll_reset+0x48/0x88
[    9.260000] LR [c01b5d60] c67x00_ll_reset+0x3c/0x88
[    9.260000] Call Trace:
[    9.260000] [c3c19e20] [c01b5d60] c67x00_ll_reset+0x3c/0x88 (unreliable)
[    9.260000] [c3c19e40] [c02885e0] c67x00_drv_probe+0x16c/0x2d8
[    9.260000] [c3c19e70] [c01694b0] platform_drv_probe+0x20/0x30
[    9.260000] [c3c19e80] [c01674f8] driver_probe_device+0xec/0x194
[    9.260000] [c3c19ea0] [c0167750] __driver_attach+0x88/0xf4
[    9.260000] [c3c19ec0] [c0166648] bus_for_each_dev+0x58/0x98
[    9.260000] [c3c19ef0] [c01672f4] driver_attach+0x24/0x34
[    9.260000] [c3c19f00] [c016706c] bus_add_driver+0xb4/0x218
[    9.260000] [c3c19f20] [c0167a64] driver_register+0x78/0x10c
[    9.260000] [c3c19f40] [c016982c] platform_driver_register+0x9c/0xac
[    9.260000] [c3c19f50] [c035fa44] c67x00_init+0x18/0x28
[    9.260000] [c3c19f60] [c034e200] kernel_init+0xfc/0x294
[    9.260000] [c3c19ff0] [c00047d8] kernel_thread+0x44/0x60
[    9.260000] Instruction dump:
[    9.260000] 90010024 480d56c5 38800000 7fa3eb78 6084fa50 4bfff2f5 
387d0020 388004e2
[    9.260000] 480d48d9 707dffff 7c000026 54001ffe <0f000000> 3c00ffff 
7fbd00d0 60000005
[   11.316192] c67x00 c67x00.0: Device reset failed
[   11.364172] c67x00: probe of c67x00.0 failed with error 65531

Sam, since you have this working, any help would be greatly appreciated. 
  What else do I need to do in order to get USB host working on this board?

--------------010109060901000707030201
Content-Type: text/plain;
 name="virtex_devices.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="virtex_devices.c.patch"

--- arch/ppc/syslib/virtex_devices.c.old	2008-04-24 11:37:03.000000000 -0400
+++ arch/ppc/syslib/virtex_devices.c	2008-04-24 11:10:09.000000000 -0400
@@ -18,6 +18,7 @@
 #include <syslib/virtex_devices.h>
 #include <platforms/4xx/xparameters/xparameters.h>
 #include <linux/xilinx_devices.h>
+#include <linux/usb/c67x00.h>
 #include <asm/io.h>
 
 /*
@@ -320,6 +321,31 @@
 	}, \
 }
 
+/*
+ * Cypress USB C67x00 shortcut macro for single instance
+ */
+#define XPAR_C67x00_USB(num) { \
+	.name = "c67x00", \
+	.id = num, \
+	.num_resources = 2, \
+	.resource = (struct resource[]) { \
+		{ \
+			.start	= XPAR_CYPRESS_USB_PRH0_BASEADDR, \
+			.end	= XPAR_CYPRESS_USB_PRH0_BASEADDR + 0xf, \
+			.flags	= IORESOURCE_MEM, \
+		}, \
+		{ \
+			.start  = XPAR_XPS_INTC_0_SYSTEM_USB_INT_PIN_INTR, \
+			.end    = XPAR_XPS_INTC_0_SYSTEM_USB_INT_PIN_INTR, \
+			.flags  = IORESOURCE_IRQ, \
+		}, \
+	}, \
+	.dev.platform_data	= &(struct c67x00_platform_data) { \
+		.sie_config	= C67X00_SIE1_HOST | C67X00_SIE2_PERIPHERAL, \
+		.hpi_regstep	= 0x02, /* A0 not connected on 16bit bus */ \
+	}, \
+}
+
 /* UART 8250 driver platform data table */
 struct plat_serial8250_port virtex_serial_platform_data[] = {
 #if defined(XPAR_UARTNS550_0_BASEADDR)
@@ -511,6 +537,13 @@
 #if defined(XPAR_OPB_AC97_CONTROLLER_REF_1_BASEADDR)
 	XPAR_AC97_CONTROLLER_REFERENCE(1),
 #endif
+
+#if defined(XPAR_CYPRESS_USB_PRH0_BASEADDR)
+	XPAR_C67x00_USB(0),
+#endif
+#if defined(XPAR_CYPRESS_USB_PRH1_BASEADDR)
+	XPAR_C67x00_USB(1),
+#endif
 };
 
 /* Early serial support functions */

--------------010109060901000707030201
Content-Type: text/plain;
 name="XilinxEDKUSBInterrupts.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="XilinxEDKUSBInterrupts.patch"

ZGlmZiAtTmF1ciBtbDQwM3Byb2plY3Qub2xkL2RhdGEvc3lzdGVtLnVjZiBtbDQwM3Byb2pl
Y3QvZGF0YS9zeXN0ZW0udWNmCi0tLSBtbDQwM3Byb2plY3Qub2xkL2RhdGEvc3lzdGVtLnVj
ZgkyMDA4LTA0LTI0IDExOjI5OjMwLjAwMDAwMDAwMCAtMDQwMAorKysgbWw0MDNwcm9qZWN0
L2RhdGEvc3lzdGVtLnVjZgkyMDA4LTA0LTI0IDExOjI4OjA0LjAwMDAwMDAwMCAtMDQwMApA
QCAtNTk5LDYgKzU5OSwxMCBAQAogTmV0IGZwZ2FfMF9GTEFTSF9NZW1fQ0VfcGluPDA+IFNM
RVcgPSBGQVNUOwogTmV0IGZwZ2FfMF9GTEFTSF9NZW1fQ0VfcGluPDA+IERSSVZFID0gODsK
IAorIyMjTkVUIFVTQiBpbnRlcnJ1cHQKK05ldCBVU0JfSU5UX3BpbiBMT0M9VjU7DQorTmV0
IFVTQl9JTlRfcGluIElPU1RBTkRBUkQgPSBMVkNNT1MzMzsKKwogIyMjIyBOZXcgR01BQyBD
b3JlZ2VuIERlcml2ZWQgQ29uc3RyYWludHMKIAkJCiBORVQgIip0eF9nbWlpX21paV9jbGsq
IiAgICAJCQlUTk1fTkVUID0gImNsa19waHlfdHhfY2xrMCI7CmRpZmYgLU5hdXIgbWw0MDNw
cm9qZWN0Lm9sZC9zeXN0ZW0ubWhzIG1sNDAzcHJvamVjdC9zeXN0ZW0ubWhzCi0tLSBtbDQw
M3Byb2plY3Qub2xkL3N5c3RlbS5taHMJMjAwOC0wNC0yNCAxMToyOTowOC4wMDAwMDAwMDAg
LTA0MDAKKysrIG1sNDAzcHJvamVjdC9zeXN0ZW0ubWhzCTIwMDgtMDQtMjQgMTE6Mjg6Mjku
MDAwMDAwMDAwIC0wNDAwCkBAIC0xOCw2ICsxOCw3IEBACiAgUEFSQU1FVEVSIFZFUlNJT04g
PSAyLjEuMAogCiAKKyBQT1JUIFVTQl9JTlRfcGluID0gVVNCX0lOVCwgRElSID0gSQogIFBP
UlQgZnBnYV8wX1JTMjMyX1VhcnRfUlhfcGluID0gZnBnYV8wX1JTMjMyX1VhcnRfUlgsIERJ
UiA9IEkKICBQT1JUIGZwZ2FfMF9SUzIzMl9VYXJ0X1RYX3BpbiA9IGZwZ2FfMF9SUzIzMl9V
YXJ0X1RYLCBESVIgPSBPCiAgUE9SVCBmcGdhXzBfTEVEc180Qml0X0dQSU9fSU9fcGluID0g
ZnBnYV8wX0xFRHNfNEJpdF9HUElPX0lPLCBESVIgPSBJTywgVkVDID0gWzA6M10KQEAgLTQy
MSw2ICs0MjIsNiBAQAogIFBBUkFNRVRFUiBDX0hJR0hBRERSID0gMHg4MTgwZmZmZgogIEJV
U19JTlRFUkZBQ0UgU1BMQiA9IHBsYgogIFBPUlQgSXJxID0gRUlDQzQwNUVYVElOUFVUSVJR
Ci0gUE9SVCBJbnRyID0gUlMyMzJfVWFydF9JbnRlcnJ1cHQgJiBMRURzXzRCaXRfSVAySU5U
Q19JcnB0ICYgTEVEc19Qb3NpdGlvbnNfSVAySU5UQ19JcnB0ICYgUHVzaF9CdXR0b25zX1Bv
c2l0aW9uX0lQMklOVENfSXJwdCAmIElJQ19FRVBST01fSUlDMklOVENfSXJwdCAmIFRyaU1v
ZGVfTUFDX0dNSUlfVGVtYWNJbnRjMF9JcnB0ICYgeHBzX3RpbWVyXzFfSW50ZXJydXB0ICYg
VHJpTW9kZV9NQUNfR01JSV9maWZvX0lQMklOVENfSXJwdAorIFBPUlQgSW50ciA9IFJTMjMy
X1VhcnRfSW50ZXJydXB0ICYgTEVEc180Qml0X0lQMklOVENfSXJwdCAmIExFRHNfUG9zaXRp
b25zX0lQMklOVENfSXJwdCAmIFB1c2hfQnV0dG9uc19Qb3NpdGlvbl9JUDJJTlRDX0lycHQg
JiBJSUNfRUVQUk9NX0lJQzJJTlRDX0lycHQgJiBUcmlNb2RlX01BQ19HTUlJX1RlbWFjSW50
YzBfSXJwdCAmIHhwc190aW1lcl8xX0ludGVycnVwdCAmIFRyaU1vZGVfTUFDX0dNSUlfZmlm
b19JUDJJTlRDX0lycHQgJiBVU0JfSU5UCiBFTkQKIAo=
--------------010109060901000707030201--
