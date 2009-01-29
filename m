Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id A45D7DE010
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 04:37:53 +1100 (EST)
Date: Thu, 29 Jan 2009 18:37:48 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Broken PCI on Sequoia
Message-ID: <alpine.LRH.2.00.0901291819440.22142@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi Ben, Josh,

I did some background bisecting to find out when PCI stopped working on the
AMCC EV-440EPX `Sequoia' Reference Board.

With ppc44x_defconfig + CONFIG_USB=y + CONFIG_USB_EHCI_HCD=y and a USB 2.0 PCI
card in one of the PCI slots, I get:

| ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
| ehci_hcd 0000:00:0a.2: enabling device (0000 -> 0002)
| ehci_hcd 0000:00:0a.2: EHCI Host Controller
| ehci_hcd 0000:00:0a.2: new USB bus registered, assigned bus number 1
| Machine check in kernel mode.
| Data Read PLB Error
| Oops: Machine check, sig: 7 [#1]
| PowerPC 44x Platform
| Modules linked in:
| NIP: c01acf24 LR: c019a2e0 CTR: c01ace34
| REGS: cfff7f10 TRAP: 0214   Not tainted  (2.6.29-rc3)
| MSR: 00029000 <EE,ME,CE>  CR: 28002224  XER: 20000000
| TASK = cf818400[1] 'swapper' THREAD: cf828000
| GPR00: 00000000 cf829d80 cf818400 cf9a8a00 0000002f 00000000 c024dd9c fffffffd 
| GPR08: 00000000 d10a8000 00000000 d10a8000 48002242 1001b1cc 0ffb2400 00000001 
| GPR16: 007fff13 00400458 00800000 ffffffff 007fff00 0ffadd68 00000000 00000001 
| GPR24: 00000000 c0322a88 00000010 000000a0 cf9fd000 cf83a800 cf9a8ab8 cf9a8a00 
| NIP [c01acf24] ehci_pci_setup+0xf0/0x5f0
| LR [c019a2e0] usb_add_hcd+0x1a8/0x5e8
| Call Trace:
| [cf829d80] [cf9a8a00] 0xcf9a8a00 (unreliable)
| [cf829db0] [c019a2e0] usb_add_hcd+0x1a8/0x5e8
| [cf829de0] [c01a59c4] usb_hcd_pci_probe+0x158/0x2e4
| [cf829e10] [c015c0cc] local_pci_probe+0x24/0x34
| [cf829e20] [c015c2f4] pci_device_probe+0x84/0xa8
| [cf829e50] [c017b388] driver_probe_device+0xb4/0x1e8
| [cf829e70] [c017b560] __driver_attach+0xa4/0xa8
| [cf829e90] [c017ab2c] bus_for_each_dev+0x5c/0xb0
| [cf829ec0] [c017b1a4] driver_attach+0x24/0x34
| [cf829ed0] [c017a44c] bus_add_driver+0x1d0/0x244
| [cf829ef0] [c017b780] driver_register+0x70/0x160
| [cf829f10] [c015c59c] __pci_register_driver+0x4c/0xac
| [cf829f30] [c02fb514] ehci_hcd_init+0xb0/0xf0
| [cf829f50] [c00013d8] do_one_initcall+0x34/0x1b0
| [cf829fc0] [c02e1178] kernel_init+0x94/0x100
| [cf829ff0] [c000da64] kernel_thread+0x50/0x6c
| Instruction dump:
| 2f8001b5 409eff68 801e00e0 64002000 901e00e0 74082000 813f008c 7d2b4b78 
| 913f00b8 40a2ff60 7c0004ac 7c004c2c <0c000000> 4c00012c 5400063e 7c0b0214 
| ---[ end trace 1bac7a35c80d2df5 ]---

I get a similar crash with a Sym53c876 SCSI card.

PCI seems to have stopped working between 2.6.28 and 2.6.29-rc1, due to the
following commit:

| commit 84d727a109081684c2e01b811cb0d6dc3b9380ca
| Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
| Date:   Thu Oct 9 16:58:19 2008 +0000
| 
|     powerpc/4xx: Add support for ISA holes on 4xx PCI/X/E
|     
|     This adds support for ISA memory holes on the PCI, PCI-X and
|     PCI-E busses of the 4xx platforms. The patch includes changes
|     to the Bamboo and Canyonlands device-trees to add such a hole,
|     others can be updated separately.
|     
|     The ISA memory hole is an additional outbound window configured
|     in the bridge to generate PCI cycles in the low memory addresses,
|     thus allowing to access things such as the hard-decoded VGA
|     aperture at 0xa0000..0xbffff or other similar things. It's made
|     accessible to userspace via the new legacy_mem file in sysfs for
|     which support was added by a previous patch.
|     
|     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
|     Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
| 
|  boot/dts/bamboo.dts      |    3 
|  boot/dts/canyonlands.dts |    3 
|  sysdev/ppc4xx_pci.c      |  306 ++++++++++++++++++++++++++++++---------------
|  3 files changed, 213 insertions(+), 99 deletions(-)

Git-reverting this commit on top of 2.6.29-rc3 makes the crash go away.

Perhaps sequoia.dts (and other 44x DTS files) had to be changed, too?

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
