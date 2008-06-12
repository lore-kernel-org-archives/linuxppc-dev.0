Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 7C9DEDE5F3
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 00:26:56 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/4xx: Workaround for PPC440EPx/GRx PCI_28 Errata
Date: Thu, 12 Jun 2008 16:24:13 +0200
References: <20080611104549.45836929@zod.rchland.ibm.com>
In-Reply-To: <20080611104549.45836929@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806121624.13577.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 11 June 2008, Josh Boyer wrote:
> The 440EPx/GRx chips don't support PCI MRM commands.  Drivers determine
> this by looking for a zero value in the PCI cache line size register. 
> However, some drivers write to this register upon initialization.  This can
> cause MRMs to be used on these chips, which may cause deadlocks on PLB4.
>
> The workaround implemented here introduces a new indirect_type flag, called
> PPC_INDIRECT_TYPE_BROKEN_MRM.  This is set in the pci_controller structure
> in the pci fixup function for 4xx PCI bridges by determining if the bridge
> is compatible with 440EPx/GRx.  The flag is checked in the
> indirect_write_config function, and forces any writes to the
> PCI_CACHE_LINE_SIZE register to be zero, which will disable MRMs for these
> chips.
>
> A similar workaround has been tested by AMCC on various PCI cards, such as
> the Silicon Image ATA card and Intel E1000 GIGE card.  Hangs were seen with
> the Silicon Image card, and MRMs were seen on the bus with a PCI analyzer.
> With the workaround in place, the card functioned properly and only Memory
> Reads were seen on the bus with the analyzer.
>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: Stefan Roese <sr@denx.de>

I manually applied your patch (since it doesn't apply clean as discussed on 
IRC) and tested it on my Sequoia with a modified PCI USB driver changing 
PCI_CACHE_LINE_SIZE.

Best regards,
Stefan
