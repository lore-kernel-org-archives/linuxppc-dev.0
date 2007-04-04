Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 70FADDDE10
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 09:52:28 +1000 (EST)
Subject: Re: adding Pegasus IDE quirk for pata_via
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070404111635.GA1855@aepfle.de>
References: <20070404111635.GA1855@aepfle.de>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 09:52:18 +1000
Message-Id: <1175730738.30879.103.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-04 at 13:16 +0200, Olaf Hering wrote:
> The pegaos board needs an irq quirk in pata_via.
> Where is the quirk list for libata? I dont see one in pata_via.c
> 
> drivers/ide/pci/via82cxxx.c:init_hwif_via82cxxx()
> 
>     440 #ifdef CONFIG_PPC_CHRP
>     441         if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
>     442                 hwif->irq = hwif->channel ? 15 : 14;
>     443         }
>     444 #endif
> 
> 
> This is in the firmware node. Will a fixup of the 'interrupts' property
> work or does everything poke directly at the PCI registers?
> Should fixup_device_tree_chrp() take care of the 'interrupts' property?

Nothing standard will work. A PCI device isn't supposed to have more
than one interrupt per function and this one needs 2. It's the VIA
chipset being out of specs as usual.

Ben.
