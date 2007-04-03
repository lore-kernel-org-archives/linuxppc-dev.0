Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id E6AFBDDFA3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Apr 2007 03:23:29 +1000 (EST)
Message-ID: <46128E70.50503@ru.mvista.com>
Date: Tue, 03 Apr 2007 21:27:12 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Peter Mendham <petermendham@computing.dundee.ac.uk>
Subject: Re: Using Linux 2.6.19 with Xilinx ML405
References: <46125216.2080903@computing.dundee.ac.uk>
In-Reply-To: <46125216.2080903@computing.dundee.ac.uk>
Content-Type: multipart/mixed; boundary="------------010507010407030104060202"
Cc: linuxppc-embedded@ozlabs.org
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
--------------010507010407030104060202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter,

CONFIG_PPC_OCP and ppc_sys_platform_devices related problems are
due to the kernel.org tree stopped using the OCP infrastructure in favor
of ppc_sys stuff (originally created for Freescale 8xx/8xxx SOCs).

What BSP vesion have you selected in the xps?
As far as I can tell, linux_2_6_v1_00_a uses
the approach similar to 2.6 kernel based MontaVista LSP:
"manual" registration of all the devices in arch/ppc/platforms/4xx/virtex.c,
static int __init xilinx_platform_init(void). The only exception
are 16x50 compatible UARTs, that rely on struct ocp_def core_ocp[] etc.

At the moment I am doing some rework of our code (includes rebasing the patches
against a more-or-less recent kernel.org tree). My plan is to drop
both PPC_OCP and ppc_sys, and register all the devices inside xilinx_platform_init().
For Xilinx'es using ppc_sys adds no value but some unneeded complexity.
And it seems ppc_sys is no longer used/supported after Freescale 8xx/8xxx SOCs
moved to arc/powerpc?
Having all the device registration (and references to xparameters.h as well!) in one
place IMHO would make it easier to move Xilinx based boards to arc/powerpc
(someday).

Attached is the patch to get rid of both XILINX_OCP and ppc_sys for
the Xilinx boards. With this patch applied it should be not so difficult
to add the relevant entries to arch/ppc/platforms/4xx/virtex.c by
copying them from the EDK generated linux_2_6_v1_00_a BSP.
The patch is against 2.6.21-rc4 if it matters.


Thanks,
Andrei


Peter Mendham wrote:
> Dear all,
> 
> I am attempting to get a 2.6.19 kernel running on an ML405.  In the 
> spirit of walking before I start to run, I have setup a very simple 
> system with a 10/100 MAC, a UARTlite and the SystemACE controller (other 
> than that, my EDK project has the DDR RAM,  some BRAM, an interrupt 
> controller and the usual gubbins to get a system to work).  I am having 
> some serious issues just getting the thing to compile so I was hoping to 
> pick the brains of this list.  I would appreciate any tips on where I am 
> going wrong.
> 
> First thing I did was to patch the kernel with the BSP from my EDK 
> project (maybe this is my first mistake).  Several files #include 
> config.h - I changed this to autoconf.h.  The ocp_def structure 
> definition was being ignored because CONFIG_PPC_OCP was not defined - I 
> altered some Kconfig files to ensure that when and an ML403 is selected 
> XILINX_OCP is defined, and when that is defined PPC_OCP is also 
> defined.  That solved that problem but left me with a missing definition 
> for ppc_sys_platform_devices which was not present in virtex.c.  I added 
> one but am a bit stuck as to what this should contain.  Another one I 
> have seen lists a UART (which xilinx_ml403.c seems to depend upon).  But 
> this is for a 8250-type UART.  How can I configure this for a UARTlite?  
> Do I need to add an entry for the SystemACE?  I have already added an 
> entry for the EMAC.
> 
> Any hints/experience would be gratefully received.
> 
> TIA,
> -- Peter
> 
> 


--------------010507010407030104060202
Content-Type: text/x-patch;
 name="get-rid-of-ppc_sys.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="get-rid-of-ppc_sys.patch"

Index: linux-2.6.20/arch/ppc/platforms/4xx/virtex.c
===================================================================
--- linux-2.6.20.orig/arch/ppc/platforms/4xx/virtex.c
+++ linux-2.6.20/arch/ppc/platforms/4xx/virtex.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/serial_8250.h>
-#include <asm/ppc_sys.h>
 #include <platforms/4xx/virtex.h>
 #include <platforms/4xx/xparameters/xparameters.h>
 
@@ -30,7 +29,14 @@
 		.regshift = 2, \
 	}
 
-struct plat_serial8250_port serial_platform_data[] = {
+/* Xilinx Virtex-II Pro device descriptions */
+
+
+/*************************/
+/* 16x50 compatible UART */
+/*************************/
+
+static struct plat_serial8250_port serial_platform_data[] = {
 #ifdef XPAR_UARTNS550_0_BASEADDR
 	XPAR_UART(0),
 #endif
@@ -46,11 +52,24 @@ struct plat_serial8250_port serial_platf
 	{ }, /* terminated by empty record */
 };
 
-struct platform_device ppc_sys_platform_devices[] = {
-	[VIRTEX_UART] = {
-		.name		= "serial8250",
-		.id		= 0,
-		.dev.platform_data = serial_platform_data,
-	},
+void *xilinx_get_serial_pdata(void)
+{
+	return (void *) serial_platform_data;
+}
+
+static struct platform_device serial8250_platform_devices = {
+	.name		= "serial8250",
+	.id		= 0,
+	.dev.platform_data = serial_platform_data,
 };
 
+static int __init xilinx_platform_init(void)
+{
+#ifdef XPAR_UARTNS550_0_BASEADDR
+	platform_device_register(&serial8250_platform_devices);
+#endif
+
+	return 0;
+}
+
+subsys_initcall(xilinx_platform_init);
Index: linux-2.6.20/arch/ppc/platforms/4xx/virtex.h
===================================================================
--- linux-2.6.20.orig/arch/ppc/platforms/4xx/virtex.h
+++ linux-2.6.20/arch/ppc/platforms/4xx/virtex.h
@@ -23,13 +23,10 @@
 #if !defined(BASE_BAUD)
  #define BASE_BAUD		(0) /* dummy value; not used */
 #endif
-  
-/* Device type enumeration for platform bus definitions */
+
 #ifndef __ASSEMBLY__
-enum ppc_sys_devices {
-	VIRTEX_UART, NUM_PPC_SYS_DEVS,
-};
+void *xilinx_get_serial_pdata(void);
 #endif
-  
+
 #endif				/* __ASM_VIRTEX_H__ */
 #endif				/* __KERNEL__ */
Index: linux-2.6.20/arch/ppc/syslib/Makefile
===================================================================
--- linux-2.6.20.orig/arch/ppc/syslib/Makefile
+++ linux-2.6.20/arch/ppc/syslib/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_440SP)		+= ibm440gx_common.
 obj-$(CONFIG_440SPE)		+= ibm440gx_common.o ibm440sp_common.o ppc440spe_pcie.o
 ifeq ($(CONFIG_4xx),y)
 ifeq ($(CONFIG_XILINX_VIRTEX),y)
-obj-$(CONFIG_40x)		+= xilinx_pic.o ppc_sys.o
+obj-$(CONFIG_40x)		+= xilinx_pic.o
 else
 ifeq ($(CONFIG_403),y)
 obj-$(CONFIG_40x)		+= ppc403_pic.o
Index: linux-2.6.20/arch/ppc/platforms/4xx/xilinx_ml403.c
===================================================================
--- linux-2.6.20.orig/arch/ppc/platforms/4xx/xilinx_ml403.c
+++ linux-2.6.20/arch/ppc/platforms/4xx/xilinx_ml403.c
@@ -22,7 +22,6 @@
 #include <linux/serialP.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/ppc_sys.h>
 
 #include <syslib/gen550.h>
 #include <platforms/4xx/xparameters/xparameters.h>
@@ -57,22 +56,6 @@
  *          ppc4xx_pic_init			arch/ppc/syslib/xilinx_pic.c
  */
 
-/* Board specifications structures */
-struct ppc_sys_spec *cur_ppc_sys_spec;
-struct ppc_sys_spec ppc_sys_specs[] = {
-	{
-		/* Only one entry, always assume the same design */
-		.ppc_sys_name	= "Xilinx ML403 Reference Design",
-		.mask 		= 0x00000000,
-		.value 		= 0x00000000,
-		.num_devices	= 1,
-		.device_list	= (enum ppc_sys_devices[])
-		{
-			VIRTEX_UART,
-		},
-	},
-};
-
 #if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
 
 static volatile unsigned *powerdown_base =
@@ -125,7 +108,7 @@ ml403_early_serial_map(void)
 	struct plat_serial8250_port *pdata;
 	int i = 0;
 
-	pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(VIRTEX_UART);
+	pdata = (struct plat_serial8250_port *) xilinx_get_serial_pdata();
 	while(pdata && pdata->flags)
 	{
 		pdata->membase = ioremap(pdata->mapbase, 0x100);
@@ -159,8 +142,6 @@ platform_init(unsigned long r3, unsigned
 {
 	ppc4xx_init(r3, r4, r5, r6, r7);
 
-	identify_ppc_sys_by_id(mfspr(SPRN_PVR));
-
 	ppc_md.setup_arch = ml403_setup_arch;
 	ppc_md.setup_io_mappings = ml403_map_io;
 	ppc_md.init_IRQ = ml403_init_irq;

--------------010507010407030104060202--
