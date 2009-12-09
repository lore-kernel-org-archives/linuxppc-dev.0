Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 09412B6F1C
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 03:20:07 +1100 (EST)
Date: Wed, 9 Dec 2009 19:20:05 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/fsl_pci: Fix P2P bridge handling for MPC83xx
	PCIe controllers
Message-ID: <20091209162005.GA14253@oksana.dev.rtsoft.ru>
References: <20091207225435.GA18485@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091207225435.GA18485@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, "B.J. Buchalter" <bj@mhlabs.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 08, 2009 at 01:54:35AM +0300, Anton Vorontsov wrote:
> It appears that we wrongly calculate dev_base for type1 config cycles.
> The thing is: we shouldn't subtract hose->first_busno because PCI core
> sets PCI primary, secondary and subordinate bus numbers, and PCIe
> controller actually takes the registers into account. So we should use
> just bus->number.
> 
> Also, according to MPC8315 reference manual, primary bus number should
> always remain 0. We have PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS quirk
> in indirect_pci.c, but since 83xx is somewhat special, it doesn't use
> indirect_pci.c routines, so we have to implement the quirk specifically
> for 83xx PCIe controllers.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> This fixes the issue similar to http://www.pubbs.net/linuxppc/200908/22024/
> i.e. lspci reports:
> 
> 0000:00:00.0 Power PC: Freescale Semiconductor Inc Device 00b4 (rev 11)
> 0002:02:00.0 PCI bridge: Freescale Semiconductor Inc Device 00b4 (rev 11)
> 0002:03:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200(A) PCI Express-to-PCI Bridge (rev 03)
> 0002:04:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200(A) PCI Express-to-PCI Bridge (rev 03)
> 0002:04:01.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200(A) PCI Express-to-PCI Bridge (rev 03)
> 0002:04:02.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200(A) PCI Express-to-PCI Bridge (rev 03)
> ...
> 
> While it should be:
> 
> 0000:00:00.0 Power PC: Freescale Semiconductor Inc Device 00b4 (rev 11)
> 0002:02:00.0 PCI bridge: Freescale Semiconductor Inc Device 00b4 (rev 11)
> 0002:03:00.0 PCI bridge: Texas Instruments XIO2000(A)/XIO2200(A) PCI Express-to-PCI Bridge (rev 03)
> 0002:04:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01)

Just for the reference... I found and tested a PLX bridge, and
it works OK as well:

0002:03:00.0 PCI bridge: PLX Technology, Inc. PEX8112 x1 Lane PCI Express-to-PCI Bridge (rev aa)
0002:04:00.0 USB Controller: NEC Corporation USB (rev 43)
0002:04:00.1 USB Controller: NEC Corporation USB (rev 43)
0002:04:00.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
0002:04:01.0 FireWire (IEEE 1394): NEC Corporation uPD72874 IEEE1394 OHCI 1.1 3-port PHY-Link Ctrlr (rev 01)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
