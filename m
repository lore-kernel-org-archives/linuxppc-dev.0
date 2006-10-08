Return-Path: <olaf@ibook.aepfle.de>
Received: from natblert.rzone.de (natblert.rzone.de [81.169.145.181])
	by ozlabs.org (Postfix) with ESMTP id E141667CE5
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 19:42:58 +1000 (EST)
Date: Sun, 8 Oct 2006 11:42:51 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Don't get PCI IRQ from OF for devices with no IRQ
Message-ID: <20061008094251.GA19752@aepfle.de>
References: <1160030441.22232.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1160030441.22232.33.camel@localhost.localdomain>
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

On Thu, Oct 05, Benjamin Herrenschmidt wrote:

> This patch adds checking of the PCI_INTERRUPT_PIN register before
> using standard OF parsing to retreive PCI interrupts. The reason is
> that some PCI devices may have no PCI interrupt, though they may have
> interrupts attached via other means. In this case, we shall not use
> irq->pdev, but device-specific code can later retreive those interrupts
> instead.
> 
> Without that patch, Maple and derivatives don't get the right interrupt
> for the second IDE channel as the linux IDE code fallsback to the PCI
> irq instead of trying to use the legacy ones for the on-board controller
> (which has no PCI_INTERRUPT_PIN). Having no PCI IRQ assign to it (as it
> doesn't request any) fixes it.

This breaks at least G5, IDE is probed twice, the first try uses IRQ 0.
SATA doesnt get an interrupt either.
