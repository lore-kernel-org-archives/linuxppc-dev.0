Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 8D05A67A5F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 12:44:58 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k5R2tsov029422 for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Jun 2006 19:55:54 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k5R2is76000938
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Jun 2006 21:44:55 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306D9253D@zch01exm40.ap.freescale.net>
From: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
To: Florian Boelstler <euphoria@arcor.de>, linuxppc-embedded@ozlabs.org
Subject: RE: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
Date: Tue, 27 Jun 2006 10:44:45 +0800
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, 

Please see inline comments.

Best Regards,
Zhang Wei

> -----Original Message-----
> From: 
> linuxppc-embedded-bounces+wei.zhang=freescale.com@ozlabs.org 
> [mailto:linuxppc-embedded-bounces+wei.zhang=freescale.com@ozla
> bs.org] On Behalf Of Florian Boelstler
> Sent: Monday, June 26, 2006 6:48 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
> 
> Hi,
> 
> I am currently working on a MPC8548-based development system.
> Linux kernel version is 2.6.11 with patches delivered from 
> Freescale (BSP MPC8548CDS 02/24/2006).
> 
> Kernel configuration contains a warning message for CONFIG_PEX:
> "This requires hardware modification to work correctly if 
> your CPU version < 2.0 and will break the PCI bus. [...]"
> 
> I was wondering whether enabling PCIe makes PCI bus 
> functionality unusable at all (including kernel functionality 
> for detecting devices behind a transparent PCI-to-PCI bridge).

The interrupts polarity of MPC8548 PCIe controller is reversed to PCI. That's an errata of MPC8548.
So you must rework to fix them. You can find the detail from user manual of bsp.

> 
> Our setup connects a transparent PLX8516 PCI-to-PCI bridge to 
> the PCIe port of the MPC8548 daughter board. Behind that 
> bridge is another PCIe capable device.
> MPC8548 is configured to run as PCIe host mode.
> 
> When trying to lookup the PCIe devices using lspci I can only 
> see the PPC itself and the bridge.
> However I cannot see the device(s) behind the bridge.

Yes, that's also an errata to MPC8548 PCIe controller.
Trying to apply below patch code:

diff -u -r1.1.1.2.2.3 ppc85xx_setup.c
--- arch/ppc/syslib/ppc85xx_setup.c	7 Apr 2006 08:57:50 -0000	1.1.1.2.2.3
+++ arch/ppc/syslib/ppc85xx_setup.c	27 Jun 2006 02:45:54 -0000
@@ -256,6 +256,7 @@
 {
 	volatile struct ccsr_pex *pex;
 	unsigned short temps;
+	unsigned int pribus;
 	bd_t *binfo = (bd_t *) __res;
 
 	pex = ioremap(binfo->bi_immr_base + MPC85xx_PEX_OFFSET,
@@ -265,6 +266,11 @@
 	temps |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
 	early_write_config_word(hose, 0, 0, PCI_COMMAND, temps);
 	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
+
+	/* PCIE Bus, Fix the MPC8548 host bridge's location to bus 0xFF. */
+	early_read_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, &pribus);
+	pribus = (pribus & 0xff000000) | (0xff) | (0x0 << 8) | (0xfe << 16);
+	early_write_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, pribus);
 
 	/* Disable all windows (except powar0 since its ignored) */
 	pex->pexowar1 = 0; 
> 
> Is there another method for detecting PCI(e) devices?
> Is "BSP MPC8548CDS 02/24/2006" the latest version 
> corresponding to that hardware?

Yes, it's the last version.

> 
> Thanks in advance,
> 
>    Florian
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
