Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 8C76EDDE49
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 07:00:27 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 01 Oct 2007 23:00:25 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20071001210025.314240@gmx.net>
MIME-Version: 1.0
Subject: Problem with OF interrupt parsing code
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I think I found an issue in the OF interrupt parsing code, although I
have to admit that my device tree source doesn't really follow the
specification.

First some information about my target setup. I didn't specify an
interrupt-map and interrupt-map-mask property in the pci node, because
AFAIK there are three different AmigaOne models with different IRQ
routing. Secondly the AmigaOne is a desktop system with 4 PCI/AGP slots,
thus I can't specify device nodes for all possible devices. By looking at
pci_read_irq_line() in pci_common.c it should be possible for the kernel
to fall back to the interrupt settings in the PCI config space of every
device.

Unfortunately I couldn't capture the kernel log, because the serial
console is not yet working, so here comes a description of what I think
is going on.
Well, pci_read_irq_line() starts with PCI device 00:00.0 (PCI host bridge)
and invokes of_irq_map_pci() in prom_parse.c. It find the predefined
device node in the device tree. Since of_irq_map_one() can't find an
interrupt property in the device node, it returns to pci_read_irq_line()
and setups the interrupt mapping based on the settings in the PCI config
space. So far so good.
The problem occurs now, if there is no device node defined for another
PCI device. In this case, of_irq_map_pci() checks for an interrupt pin,
searches again for the host bridge node and calls of_irq_map_raw() with
the device node of the host bridge. The function finds the
#interrupt-cells, #address-cells, interrupt-controller properties, but
fails to find the interrupt-map property (because it's missing in the
device tree). Therefore the function then tries to find a new parent,
which leads to an endless loop (it always selects the PCI2ISA southbridge
in the device tree).

Can somebody confirm my explanation? It would help, if the kernel could
fall back to the PCI settings in this case, too.

Thanks!

regards,

Gerhard
-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail
