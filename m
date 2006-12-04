Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 2D1E467BF8
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 23:56:50 +1100 (EST)
Date: Mon, 4 Dec 2006 13:56:46 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Message-ID: <20061204125646.GA28600@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 04, Segher Boessenkool wrote:

> >--- a/arch/powerpc/kernel/pci_64.c
> >+++ b/arch/powerpc/kernel/pci_64.c
> >@@ -1234,6 +1234,14 @@ static void __devinit fixup_resource(str
> > 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> > 	unsigned long start, end, mask, offset;
> >
> >+	/*
> >+	 * tell the core code that this ressource is unassigned
> >+	 * fixes p630 winbond IDE with libata
> >+	 */
> >+	if (res->start == 0) {
> >+		res->flags = 0;
> >+		return;
> >+	}
> > 	if (res->flags & IORESOURCE_IO) {
> > 		offset = (unsigned long)hose->io_base_virt - pci_io_base;
> 
> Please make this run on pSeries only; on a PowerMac for

I could just match for winbond an start == 0.
