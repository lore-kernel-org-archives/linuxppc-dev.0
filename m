Return-Path: <srivatsan@deccanetworld.com>
Received: from gatekeeper.deccanetworld.com (mail.deccanetworld.com
	[203.196.146.50])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEFB32BF09
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Nov 2004 20:37:38 +1100 (EST)
Received: from gatekeeper.deccanetworld.com (localhost [127.0.0.1])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id iAK9KDcA031653
	for <linuxppc-embedded@ozlabs.org>; Sat, 20 Nov 2004 14:50:13 +0530
Received: from mail.deccanetworld.com (server.deccanetworld.com [192.168.1.32])
	by gatekeeper.deccanetworld.com (8.12.2/8.12.2/SuSE Linux 0.6) with
	ESMTP id iAK9K8dW031648
	for <linuxppc-embedded@ozlabs.org>; Sat, 20 Nov 2004 14:50:08 +0530
Received: (from root@localhost)
	by mail.deccanetworld.com (8.11.0/8.11.0) id iAK9kqx26438
	for linuxppc-embedded@ozlabs.org; Sat, 20 Nov 2004 15:16:52 +0530
Received: from bgcw301 ([192.168.1.69])
	by mail.deccanetworld.com (8.11.0/8.11.0) with ESMTP id iAK9kq726395
	for <linuxppc-embedded@ozlabs.org>; Sat, 20 Nov 2004 15:16:52 +0530
From: "Srivatsan" <srivatsan@deccanetworld.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Sat, 20 Nov 2004 14:59:14 +0530
Message-ID: <000001c4cee3$66af9ea0$4501a8c0@bgcw301>
MIME-Version: 1.0
In-Reply-To: <20041120010005.624B42BF11@ozlabs.org>
Content-type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Subject: Linux Kernel Memory map for MPC8280
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=_IS_MIME_Boundary
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Is there any documentation which provided details about Linux Kernel
Memory map (before and after decompression - assumption is a compressed
Linux Kernel Image) with Ram Disk image, Root File system or can anybody
provide me some insight onto the Kernel Memory map (Not talking about
the process memory layout).

I am using PowerQuicc II processor. 

With Best Regards,
C.R.Srivatsan


-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of
linuxppc-embedded-request@ozlabs.org
Sent: Saturday, November 20, 2004 6:30 AM
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 3, Issue 30

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. [PATCH 2.6.10-rc2] ppc32: Have the 8260 board-hook happen a
      bit	later (Tom Rini)
   2. [PATCH 2.6.10-rc2] ppc32: Fix __iomem warnings in TODC code
      (Tom Rini)
   3. [PATCH][PPC32] Marvell host bridge support (mv64x60)
      (Mark A. Greer)
   4. [PATCH][PPC32] Support for Marvell EV-64260[ab]-BP eval
      platform (Mark A. Greer)
   5. [PATCH][PPC32] Support for Artesyn Katana cPCI boards
      (Mark A. Greer)
   6. Re: [PATCH][PPC32] Marvell host bridge support (mv64x60)
      (Andrew Morton)


----------------------------------------------------------------------

Message: 1
Date: Fri, 19 Nov 2004 11:06:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
Subject: [PATCH 2.6.10-rc2] ppc32: Have the 8260 board-hook happen a
	bit	later
To: Andrew Morton <akpm@osdl.org>, linuxppc-embedded@ozlabs.org
Cc: Borut Lukic <borutlukic@email.si>
Message-ID: <20041119180653.GF16043@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii

Borut Lukic <borutlukic@email.si> brought to my attention that in
platform_init() on 8260 the board hook was being called too early to
allow for overrides (e.g. different memory sizings functions or rtc, or
anything else).  This moves the call to the end of platform_init() and I
suspect fixes some unnoticed yet bugs in a number of 8260 platforms.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.26/arch/ppc/syslib/m8260_setup.c	2004-08-24 08:31:20 -07:00
+++ edited/arch/ppc/syslib/m8260_setup.c	2004-11-19 11:03:35
-07:00
@@ -241,9 +241,6 @@
 		strcpy(cmd_line, (char *)(r6+KERNELBASE));
 	}
 
-	/* Call back for board-specific settings. */
-	m82xx_board_init();
-
 	ppc_md.setup_arch		= m8260_setup_arch;
 	ppc_md.show_cpuinfo		= m8260_show_cpuinfo;
 	ppc_md.init_IRQ			= m8260_init_IRQ;
@@ -259,4 +256,7 @@
 
 	ppc_md.find_end_of_memory	= m8260_find_end_of_memory;
 	ppc_md.setup_io_mappings	= m8260_map_io;
+	
+	/* Call back for board-specific settings and overrides. */
+	m82xx_board_init();
 }

-- 
Tom Rini
http://gate.crashing.org/~trini/


------------------------------

Message: 2
Date: Fri, 19 Nov 2004 11:15:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
Subject: [PATCH 2.6.10-rc2] ppc32: Fix __iomem warnings in TODC code
To: Andrew Morton <akpm@osdl.org>, linuxppc-embedded@ozlabs.org
Message-ID: <20041119181525.GG16043@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii

A trivial fix for the __iomem warnings in arch/ppc/syslib/todc_time.c

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- a/arch/ppc/syslib/todc_time.c	2004-10-29 18:29:54.000000000
-0700
+++ b/arch/ppc/syslib/todc_time.c	2004-10-29 18:40:10.000000000
-0700
@@ -82,13 +82,13 @@ extern spinlock_t	rtc_lock;
 u_char
 todc_direct_read_val(int addr)
 {
-	return readb(todc_info->nvram_data + addr);
+	return readb((void __iomem *)(todc_info->nvram_data + addr));
 }
 
 void
 todc_direct_write_val(int addr, unsigned char val)
 {
-	writeb(val, todc_info->nvram_data + addr);
+	writeb(val, (void __iomem *)(todc_info->nvram_data + addr));
 	return;
 }


-- 
Tom Rini
http://gate.crashing.org/~trini/


------------------------------

Message: 3
Date: Fri, 19 Nov 2004 14:43:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Subject: [PATCH][PPC32] Marvell host bridge support (mv64x60)
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
Message-ID: <419E6900.5070001@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

This patch adds core support for a line of host bridges from Marvell 
(formerly Galileo).  This code has been tested with a GT64260a, 
GT64260b, MV64360, and MV64460.  Patches for platforms that use these 
bridges will be sent separately.

The patch is rather large so a link is provided.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

ftp://source.mvista.com/pub/mgreer/mv64x60.patch



------------------------------

Message: 4
Date: Fri, 19 Nov 2004 14:49:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Subject: [PATCH][PPC32] Support for Marvell EV-64260[ab]-BP eval
	platform
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
Message-ID: <419E6A50.5060107@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed

This patch adds support for a line of evaluation platforms from Marvell 
that use the Marvell GT64260[ab] host bridges.

This patch depends on the Marvell host bridge support patch (mv64x60).

This patch is larger than 40KB so a link is provided (as per 
instructions in SubmittingPatches).

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

ftp://source.mvista.com/pub/mgreer/ev64260.patch



------------------------------

Message: 5
Date: Fri, 19 Nov 2004 15:29:59 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Subject: [PATCH][PPC32] Support for Artesyn Katana cPCI boards
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linuxppc-embedded@ozlabs.org
Message-ID: <419E73E7.8080703@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

This patch adds support for the Artesyn Katana 750i, 752i, and 3750.

This patch depends on the Marvell host bridge support patch (mv64x60) 
[and the ev64260 platform support patch because the 2 patches touch the 
same Makefiles and Kconfig file but there are no code dependencies].

Note that the patch itself does not depend on the previously submitted 
MPSC driver but the platform does.  That is, to use the serial ports on 
those boards, the MPSC driver patch is required.

This patch is larger that 40KB so a link is provided (as per 
instructions in SubmittingPatches).

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

ftp://source.mvista.com/pub/mgreer/katana.patch



------------------------------

Message: 6
Date: Fri, 19 Nov 2004 15:58:54 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][PPC32] Marvell host bridge support (mv64x60)
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Message-ID: <20041119155854.02af2174.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII

"Mark A. Greer" <mgreer@mvista.com> wrote:
>
> This patch adds core support for a line of host bridges from Marvell 
> (formerly Galileo).  This code has been tested with a GT64260a, 
> GT64260b, MV64360, and MV64460.  Patches for platforms that use these 
> bridges will be sent separately.
> 

Shouldn't these guys:


+       u32     cpu2mem_tab[MV64x60_CPU2MEM_WINDOWS][2] = {
+                       { MV64x60_CPU2MEM_0_BASE, MV64x60_CPU2MEM_0_SIZE
},
+                       { MV64x60_CPU2MEM_1_BASE, MV64x60_CPU2MEM_1_SIZE
},
+                       { MV64x60_CPU2MEM_2_BASE, MV64x60_CPU2MEM_2_SIZE
},
+                       { MV64x60_CPU2MEM_3_BASE, MV64x60_CPU2MEM_3_SIZE
}
+       };
+       u32     com2mem_tab[MV64x60_CPU2MEM_WINDOWS][2] = {
+                       { MV64360_MPSC2MEM_0_BASE,
MV64360_MPSC2MEM_0_SIZE },
+                       { MV64360_MPSC2MEM_1_BASE,
MV64360_MPSC2MEM_1_SIZE },
+                       { MV64360_MPSC2MEM_2_BASE,
MV64360_MPSC2MEM_2_SIZE },
+                       { MV64360_MPSC2MEM_3_BASE,
MV64360_MPSC2MEM_3_SIZE }
+       };
+       u32     dram_selects[MV64x60_CPU2MEM_WINDOWS] = { 0xe, 0xd, 0xb,
0x7 };

be static, and maybe __devinitdata?  Right now, the CPU has to populate
them by hand at runtime.

+wait_for_ownership(int chan)
+{
+	int	i;
+
+	for (i=0; i<MAX_TX_WAIT; i++) {
+		if ((MV64x60_REG_READ(sdma_regs[chan].sdcm) &
+				SDMA_SDCM_TXD) == 0)
+			break;
+
+		udelay(1000);

ow, big busywait.  Can't use a sleep in here?  I guess not :(

+ * arch/ppc/boot/simple/mv64x60_tty.c

hm.  Normally we put arch-specific drivers like this into drivers/serial
and do the appropriate Kconfig work.  Is there a reason why this serial
driver is buried under arch/ppc?

+#include "../../../../drivers/serial/mpsc_defs.h"

erk.

+struct mv64x60_rx_desc {
+	volatile u16 bufsize;
+	volatile u16 bytecnt;
+	volatile u32 cmd_stat;
+	volatile u32 next_desc_ptr;
+	volatile u32 buffer;
+};
+
+struct mv64x60_tx_desc {
+	volatile u16 bytecnt;
+	volatile u16 shadow;
+	volatile u32 cmd_stat;
+	volatile u32 next_desc_ptr;
+	volatile u32 buffer;
+};

Do these need to be volatile?  If so, it indicates that the driver is
doing
something wrong.

+gt64260_register_hdlrs(void)
+{
+	/* Register CPU interface error interrupt handler */
+	request_irq(MV64x60_IRQ_CPU_ERR, gt64260_cpu_error_int_handler,
+		    SA_INTERRUPT, CPU_INTR_STR, 0);

request_irq() can fail.

+int
+mv64360_get_irq(struct pt_regs *regs)
+{
+	int irq;
+	int irq_gpp;
+
+#ifdef CONFIG_SMP
+	/*
+	 * Second CPU gets only doorbell (message) interrupts.
+	 * The doorbell interrupt is BIT28 in the main interrupt low
cause reg.
+	 */
+	int cpu_nr = smp_processor_id();

This function has no callers, so I am unable to determine whether it is
called from non-preemptible code.  If it is called from preemptible code
then that smp_processor_id() is buggy, because you can switch CPUs at
any
time.


+static struct platform_device mpsc_shared_device = { /* Shared device
*/
+	.name		= MPSC_SHARED_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mv64x60_mpsc_shared_resources),
+	.resource	= mv64x60_mpsc_shared_resources,
+	.dev = {
+		.driver_data = (void *)&mv64x60_mpsc_shared_pd_dd,
+	},
+};

The cast to void* is unnecessary.

+	(void)mv64x60_setup_for_chip(&bh);

how come you always stick that (void) in there?

+mv64x60_config_cpu2mem_windows(struct mv64x60_handle *bh,
+	struct mv64x60_setup_info *si,
+	u32 mem_windows[MV64x60_CPU2MEM_WINDOWS][2])
+{
+	u32	i, win;
+	u32	prot_tab[] = {
+			MV64x60_CPU_PROT_0_WIN, MV64x60_CPU_PROT_1_WIN,
+			MV64x60_CPU_PROT_2_WIN, MV64x60_CPU_PROT_3_WIN
+		};
+	u32	cpu_snoop_tab[] = {
+			MV64x60_CPU_SNOOP_0_WIN,
MV64x60_CPU_SNOOP_1_WIN,
+			MV64x60_CPU_SNOOP_2_WIN, MV64x60_CPU_SNOOP_3_WIN
+		};

static initialisation?

+mv64x60_config_cpu2pci_windows(struct mv64x60_handle *bh,
+	struct mv64x60_pci_info *pi, u32 bus)
+{
+	int	i;
+	u32	win_tab[2][4] = {
+			{ MV64x60_CPU2PCI0_IO_WIN,
MV64x60_CPU2PCI0_MEM_0_WIN,
+			  MV64x60_CPU2PCI0_MEM_1_WIN,
+			  MV64x60_CPU2PCI0_MEM_2_WIN },
+			{ MV64x60_CPU2PCI1_IO_WIN,
MV64x60_CPU2PCI1_MEM_0_WIN,
+			  MV64x60_CPU2PCI1_MEM_1_WIN,
+			  MV64x60_CPU2PCI1_MEM_2_WIN },
+		};
+	u32	remap_tab[2][4] = {
+			{ MV64x60_CPU2PCI0_IO_REMAP_WIN,
+			  MV64x60_CPU2PCI0_MEM_0_REMAP_WIN,
+			  MV64x60_CPU2PCI0_MEM_1_REMAP_WIN,
+			  MV64x60_CPU2PCI0_MEM_2_REMAP_WIN },
+			{ MV64x60_CPU2PCI1_IO_REMAP_WIN,
+			  MV64x60_CPU2PCI1_MEM_0_REMAP_WIN,
+			  MV64x60_CPU2PCI1_MEM_1_REMAP_WIN,
+			  MV64x60_CPU2PCI1_MEM_2_REMAP_WIN }
+		};
+

ditto

+mv64x60_config_pci2mem_windows(struct mv64x60_handle *bh,

and here

+mv64360_set_pci2mem_window(struct pci_controller *hose, u32 bus, u32
window,

and here

+mv64360_config_io2mem_windows(struct mv64x60_handle *bh,

and here


Anyway, I'll stick this as-is in -mm.  Feel free to send an incremental
patch, or a replacement.




------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 3, Issue 30
************************************************




********************************DISCLAIMER**********************************

This e-mail and any attachment is for authorised use by the intended
recipient(s) only. It may contain proprietary material, confidential
information and/or be subject to legal privilege of Deccanet Designs Ltd.
If you have received this message in error, please notify the originator
immediately. If you are not the intended recipient, you are notified that
you are strictly prohibited from retaining, using, copying, altering or
disclosing the contents of this message.

****************************************************************************
--=_IS_MIME_Boundary--
