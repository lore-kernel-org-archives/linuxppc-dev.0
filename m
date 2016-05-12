Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r59rt3yTwzDqrX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 21:35:10 +1000 (AEST)
Message-ID: <1463052903.20034.0.camel@ellerman.id.au>
Subject: Re: [PATCH v9 26/26] powerpc/powernv: Exclude root bus in
 pnv_pci_reset_secondary_bus()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 alistair@popple.id.au
Date: Thu, 12 May 2016 21:35:03 +1000
In-Reply-To: <20160512034854.GA10460@gwshan>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-27-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160512034854.GA10460@gwshan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-05-12 at 13:48 +1000, Gavin Shan wrote:

> On Tue, May 03, 2016 at 03:41:45PM +1000, Gavin Shan wrote:

> > The function pnv_pci_reset_secondary_bus() is called like below.
> > It's impossible for call the function on root bus. So it's safe
> > to remove the root bus case in the function. No functional changes
> > introduced.
> > 
> >   pci_parent_bus_reset() / pci_bus_reset() / pci_try_reset_bus()
> >   pci_reset_bridge_secondary_bus()
> >   pcibios_reset_secondary_bus()
> >   pnv_pci_reset_secondary_bus()
> > 
> > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > Reviewed-by: Daniel Axtens <dja@axtens.net>
> > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > arch/powerpc/platforms/powernv/eeh-powernv.c | 12 ++----------
> > 1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> > index 9226df1..593b8dc 100644
> > --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> > +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> > @@ -868,16 +868,8 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
> > 
> > void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
> > {
> > -	struct pci_controller *hose;
> > -
> > -	if (pci_is_root_bus(dev->bus)) {
> > -		hose = pci_bus_to_host(dev->bus);
> > -		pnv_eeh_root_reset(hose, EEH_RESET_HOT);
> > -		pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
> > -	} else {
> > -		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> > -		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
> > -	}
> > +	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> > +	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
> > }
> 
> Michael, please revert this one as it is already in linux-ppc-next
> branch. Sorry for the overhead.

Done.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=848912e547c4569445a61203a7df402646a88c25

cheers
