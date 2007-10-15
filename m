Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 35A7BDDE9B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:45:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
Subject: Re: [PATCH v2] drivers/ata: add support to Freescale 3.0Gbps SATA
	Controller
Date: Mon, 15 Oct 2007 13:45:06 +0200
References: <2A6F278C5B66C4459AF4013E77A40CD3FCBB59@zin33exm20.fsl.freescale.net>
In-Reply-To: <2A6F278C5B66C4459AF4013E77A40CD3FCBB59@zin33exm20.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710151345.07515.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 15 October 2007, Kalra Ashish-B00888 wrote:
> Thanks for your comments and feedback.
> 
> Actually, for PowerPC platforms iowrite32/ioread32 internally call
> writel/readl, which are again mapped to out_le32/in_le32,

This is correct on 6xx and e500 for now, but it's a little more
complicated than that in general:

iowriteXX/ioreadXX are either the simple readX/writeX wrappers
from arch/powerpc/kernel/iomap.c, or the more complex functions
from lib/iomap.c, depending on whether any of the active platforms
has set CONFIG_PPC_INDIRECT_IO.

writeX/readX can either map directly to out_leXX/in_leXX, or do
something more complicated, again depending on the platform.
In general, writeX/readX may need to consider PCI specific error
handling or synchronization requirements, while out_leXX/in_leXX
are low-level accessors that should only be used by device drivers
when they are used on directly connected (non-PCI) devices.

Since iowriteXX/ioreadXX is supposed to be the most generic
variant covering both PCI MMIO (writeX/readX) and PCI PIO
(outX/inX) transfers, it would make sense to extend them to
also do SOC MMIO (out_leXX/in_leXX/out_beXX/in_beXX) and
DCR (dcr_write/dcr_read) accesses in the future.

	Arnd <><
