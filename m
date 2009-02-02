Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 4E305DDF16
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Feb 2009 23:13:43 +1100 (EST)
Date: Mon, 2 Feb 2009 13:13:41 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/44x: Fix address decoding setup of PCI 2.x cells
In-Reply-To: <20090202002429.ADA74DDF43@ozlabs.org>
Message-ID: <alpine.LRH.2.00.0902021128200.16460@vixen.sonytel.be>
References: <20090202002429.ADA74DDF43@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2 Feb 2009, Benjamin Herrenschmidt wrote:
> The PCI 2.x cells used on some 44x SoCs only let us configure the decode
> for the low 32-bit of the incoming PLB addresses. The top 4 bits (this
> is a 36-bit bus) are hard wired to different values depending on the
> specific SoC in use. Our code used to work "by accident" until I added
> support for the ISA memory holes and while at it added more validity
> checking of the addresses.
> 
> This patch should bring it back to working condition. It still relies
> on the device-tree being correct but that's somewhat a pre-requisite
> for anything to work anyway.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This is untested. Geert, can you give it a go on Sequoia and let me
> know if it fixes your problem ?

Thanks, it seems to fix the problems.

Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

| sequoia:~# lspci -v
| 00:00.0 Bridge: IBM Device 027f
|         Subsystem: Applied Micro Circuits Corp. Device cafe
|         Flags: bus master, medium devsel, latency 0, IRQ 16
|         Memory at <unassigned> (32-bit, prefetchable)
                    ^^^^^^^^^^^^
Is this expected?

|         Capabilities: [58] Power Management version 2
| 
| 00:0a.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
|         Subsystem: DTK Computer PTI-205N USB 2.0 Host Controller
|         Flags: bus master, medium devsel, latency 8, IRQ 16
|         Memory at 180000000 (32-bit, non-prefetchable) [size=4K]
|         Capabilities: [40] Power Management version 2
|         Kernel driver in use: ohci_hcd
| 
| 00:0a.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
|         Subsystem: DTK Computer PTI-205N USB 2.0 Host Controller
|         Flags: bus master, medium devsel, latency 8, IRQ 16
|         Memory at 180001000 (32-bit, non-prefetchable) [size=4K]
|         Capabilities: [40] Power Management version 2
|         Kernel driver in use: ohci_hcd
| 
| 00:0a.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
|         Subsystem: DTK Computer PTI-205N USB 2.0 Host Controller
|         Flags: bus master, medium devsel, latency 68, IRQ 16
|         Memory at 180002000 (32-bit, non-prefetchable) [size=256]
|         Capabilities: [40] Power Management version 2
|         Kernel driver in use: ehci_hcd
| 
| sequoia:~# 

However, 'lsusb' doesn't detect any USB devices connected to the USB PCI card, except for
the root hubs:

| sequoia:~# lsusb
| Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
| Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
| Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
| sequoia:~# 

An E1000 Ethernet card does work fine now.

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
