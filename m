Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 63C01DDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 13:59:13 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0A2x5Ge000029
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 19:59:05 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0A2x38M022548
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Jan 2007 20:59:04 -0600 (CST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1165806548.7260.0.camel@localhost.localdomain>
References: <1165806548.7260.0.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1168398002.571.3.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 10 Jan 2007 11:00:03 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,
	After apply your patch, my 8548CDS board blocked when booting up.
	Should I adjust my flat device tree or bug introduced by this patch?
	Thanks.
Roy


On Mon, 2006-12-11 at 11:09, Benjamin Herrenschmidt wrote:
> The changes to use pci_read_irq_line() broke interrupt parsing
> on some 32 bits powermacs (oops). The reason is a bit obscure.
> The code to parse interrupts happens earlier now, during
> pcibios_fixup() as the PCI bus is being probed. However, the
> current implementation pci_device_to_OF_node() for 32 bits
> powerpc relies, on machines like PowerMac who renumber PCI busses,
> on a table called pci_OF_bus_map containing a map of bus numbers
> between the kernel and the firmware which is setup only later.
> Thus, it fails to match the device node. In addition, some of
> Apple internal PCI devices lack a proper PCI_INTERRUPT_PIN, thus
> preventing the fallback mapping code to work.
> 
> This patch fixes it by making pci_device_to_OF_node() 32 bits
> implementation use a different algorithm that works without
> using the pci_OF_bus_map thing (which I intend to deprecate
> anyway). It's a bit slower but that function isn't called in
> any hot path hopefully.
> 
