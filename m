Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id C9359DE15C
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 00:38:02 +1100 (EST)
Date: Mon, 12 Jan 2009 14:37:55 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: mal_probe crash
In-Reply-To: <aday6xknnp2.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0901121421140.13607@vixen.sonytel.be>
References: <20090107154434.0c9437ef@lappy.seanm.ca>
	<1231368610.2142.27.camel@pasglop>
	<200901091549.56943.matthias.fuchs@esd-electronics.com>
	<200901091602.05730.matthias.fuchs@esd-electronics.com>
	<Pine.LNX.4.64.0901091620240.13230@vixen.sonytel.be>
	<1231536613.2142.74.camel@pasglop> <aday6xknnp2.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 9 Jan 2009, Roland Dreier wrote:
>  > Can you double check that the e1000 isn't copying the PCI resources into
>  > a unsigned long before ioremap'ing the result, thus cropping the top
>  > bits ?
> 
> as far as I can see, e1000 is using pci_ioremap_bar(), which should do
> the right thing as long as resource_size_t is the right type (which it
> looks like it is on PowerPC 44x).

Indeed, the full 36-bit address is passed to __ioremap() via pci_ioremap_bar(),
as evidenced from the additional debug output below (see [1]).

As I don't have any other 3.3V PCI Ethernet cards, I plugged in a 3.3V PCI USB
2.0 card in the second PCI slot, and got a similar crash (see [2]).

Are the PCI slots on the Sequoia known broken under recent Linux kernels? I've
never used them before...

[1] E1000 probe with more debug info:
| Intel(R) PRO/1000 Network Driver - version 7.3.20-k3-NAPI
| Copyright (c) 1999-2006 Intel Corporation.
| e1000 0000:00:0a.0: enabling device (0000 -> 0003)
| resource 0: [0x180000000-0x18001ffff]
| resource 1: [0x180020000-0x18003ffff]
| resource 2: [0x1000-0x103f]
| resource 3: [0x0-0x0]
| resource 4: [0x0-0x0]
| resource 5: [0x0-0x0]
| __ioremap: addr 0x180000000, size 131072, flags 0x500
|   v = 0xd10c0000
|   ((unsigned long)addr & ~PAGE_MASK) = 0x0
|   return d10c0000
| hw->hw_addr = d10c0000
| e1000_set_media_type:502: hw = cf8114fc
| e1000_set_media_type:503: hw->hw_addr = d10c0000
| e1000_set_media_type:509: 
| e1000_set_media_type:534: er32(STATUS) will do a readl() on d10c0008
| Machine check in kernel mode.
| Data Read PLB Error
| Oops: Machine check, sig: 7 [#1]
| PowerPC 44x Platform
| Modules linked in:
| NIP: c0188b48 LR: c0188b38 CTR: c01732f8
| REGS: cfff7f10 TRAP: 0214   Not tainted  (2.6.28-07939-g2150edc-dirty)
| MSR: 00029000 <EE,ME,CE>  CR: 28f60b22  XER: 20000000
| TASK = cf818400[1] 'swapper' THREAD: cf828000
| GPR00: c0188b38 cf829d90 cf818400 00000048 00001a88 ffffffff c0173d7c 00003fff 
| GPR08: 00000000 d10c0008 00003fff 00001a88 28f60b22 01000030 0ffb2400 00000001 
| GPR16: 007fff13 00400458 00800000 c032f69c c024cfc4 c0330000 cf8114fc 00000001 
| GPR24: cf811000 cf811320 00000001 00000047 c02a27dc 00000000 c024d524 cf8114fc 
| NIP [c0188b48] e1000_set_media_type+0xf4/0x1ec
| LR [c0188b38] e1000_set_media_type+0xe4/0x1ec
| Call Trace:
| [cf829d90] [c0188b38] e1000_set_media_type+0xe4/0x1ec (unreliable)
| [cf829db0] [c0236c84] e1000_probe+0x3c0/0xdf4
| [cf829e10] [c015c0bc] local_pci_probe+0x24/0x34
| [cf829e20] [c015c2e4] pci_device_probe+0x84/0xa8
| [cf829e50] [c017b9ec] driver_probe_device+0xb4/0x1e8
| [cf829e70] [c017bbc4] __driver_attach+0xa4/0xa8
| [cf829e90] [c017b1a0] bus_for_each_dev+0x70/0xac
| [cf829ec0] [c017b804] driver_attach+0x24/0x34
| [cf829ed0] [c017aaa8] bus_add_driver+0x1d0/0x244
| [cf829ef0] [c017bde4] driver_register+0x70/0x160
| [cf829f10] [c015c58c] __pci_register_driver+0x4c/0xac
| [cf829f30] [c02e1b30] e1000_init_module+0x58/0xa8
| [cf829f50] [c00013d8] do_one_initcall+0x34/0x1b0
| [cf829fc0] [c02c8178] kernel_init+0x94/0x100
| [cf829ff0] [c000da64] kernel_thread+0x50/0x6c
| Instruction dump:
| 409d00e8 80df0000 3c60c02a 7fc4f378 38a00216 386327e8 38c60008 480aaa19 
| 813f0000 39290008 7c0004ac 7fa04c2c <0c1d0000> 4c00012c 3c60c02a 7fa6eb78 
| ---[ end trace 6c682238ca36f67d ]---

[2] EHCI probe:
| ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
| ehci_hcd 0000:00:0c.2: enabling device (0000 -> 0002)
| ehci_hcd 0000:00:0c.2: EHCI Host Controller
| ehci_hcd 0000:00:0c.2: new USB bus registered, assigned bus number 1
| Machine check in kernel mode.
| Data Read PLB Error
| Oops: Machine check, sig: 7 [#1]
| PowerPC 44x Platform
| Modules linked in:
| NIP: c01baebc LR: c01a8264 CTR: c01badcc
| REGS: cfff7f10 TRAP: 0214   Not tainted  (2.6.28-07939-g2150edc-dirty)
| MSR: 00029000 <EE,ME,CE>  CR: 28d60324  XER: 20000000
| TASK = cf818400[1] 'swapper' THREAD: cf828000
| GPR00: 00000000 cf829d80 cf818400 cfa0f800 00000001 00000000 c026dd0c fffffffd 
| GPR08: 00000000 d1098000 00000000 d1098000 48d60342 01208030 0ffb2400 00000001 
| GPR16: 007fff13 00400458 00800000 ffffffff 007fff00 0ffadd68 00000000 00000001 
| GPR24: 00000000 c032de18 00000010 000000a0 cf8c6400 cf84c000 cfa0f8b8 cfa0f800 
| NIP [c01baebc] ehci_pci_setup+0xf0/0x600
| LR [c01a8264] usb_add_hcd+0x1a8/0x5e8
| Call Trace:
| [cf829d80] [00000001] 0x1 (unreliable)
| [cf829db0] [c01a8264] usb_add_hcd+0x1a8/0x5e8
| [cf829de0] [c01b395c] usb_hcd_pci_probe+0x158/0x2e4
| [cf829e10] [c015c0bc] local_pci_probe+0x24/0x34
| [cf829e20] [c015c2e4] pci_device_probe+0x84/0xa8
| [cf829e50] [c017b9ec] driver_probe_device+0xb4/0x1e8
| [cf829e70] [c017bbc4] __driver_attach+0xa4/0xa8
| [cf829e90] [c017b1a0] bus_for_each_dev+0x70/0xac
| [cf829ec0] [c017b804] driver_attach+0x24/0x34
| [cf829ed0] [c017aaa8] bus_add_driver+0x1d0/0x244
| [cf829ef0] [c017bde4] driver_register+0x70/0x160
| [cf829f10] [c015c58c] __pci_register_driver+0x4c/0xac
| [cf829f30] [c03061a0] ehci_hcd_init+0xb0/0xf0
| [cf829f50] [c00013d8] do_one_initcall+0x34/0x1b0
| [cf829fc0] [c02ec178] kernel_init+0x94/0x100
| [cf829ff0] [c000da64] kernel_thread+0x50/0x6c
| Instruction dump:
| 2f8001b5 409eff68 801e00e0 64002000 901e00e0 74082000 813f008c 7d2b4b78 
| 913f00b8 40a2ff60 7c0004ac 7c004c2c <0c000000> 4c00012c 5400063e 7c0b0214 
| ---[ end trace 8e7aeede5368187f ]---

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
