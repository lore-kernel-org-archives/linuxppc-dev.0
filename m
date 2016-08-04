Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4y5q0My8zDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 03:45:50 +1000 (AEST)
Date: Thu, 4 Aug 2016 12:45:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: York Sun <york.sun@nxp.com>, linux-edac@vger.kernel.org,
 morbidrsa@gmail.com, oss@buserror.net, stuart.yoder@nxp.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 01/10] driver/edac/mpc85xx_edac: Fix compiling error
Message-ID: <20160804174542.GA13504@localhost>
References: <1469745064-26597-1-git-send-email-york.sun@nxp.com>
 <1469745064-26597-2-git-send-email-york.sun@nxp.com>
 <20160804100117.GC8093@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160804100117.GC8093@nazgul.tnic>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2016 at 12:01:17PM +0200, Borislav Petkov wrote:
> On Thu, Jul 28, 2016 at 03:30:55PM -0700, York Sun wrote:
> > Two symbols are missing if mpc85xx_edac driver is compiled as module.
> > 
> > Signed-off-by: York Sun <york.sun@nxp.com>
> > ---
> > Change log
> >   v2: no change
> > 
> >  arch/powerpc/kernel/pci-common.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > index 0f7a60f..86bc484 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -226,6 +226,7 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
> >  	}
> >  	return NULL;
> >  }
> > +EXPORT_SYMBOL(pci_find_hose_for_OF_device);
> >  
> >  /*
> >   * Reads the interrupt pin to determine if interrupt is use by card.
> > @@ -1585,6 +1586,7 @@ int early_find_capability(struct pci_controller *hose, int bus, int devfn,
> >  {
> >  	return pci_bus_find_capability(fake_pci_bus(hose, bus), devfn, cap);
> >  }
> > +EXPORT_SYMBOL(early_find_capability);

arch/microblaze also contains a declaration and implementation of
early_find_capability(), but as far as I can see, this was just copied
from powerpc, and it is never used on microblaze.  So just as a matter
of good code hygiene, please add a patch to remove it from microblaze.

mpc85xx looks like a weird mix of platform driver and PCI device
driver.  If loaded as a module, it shouldn't need
early_find_capability(); regular pci_find_capability() (or just
pci_is_pcie()) should work fine by the time we can load modules.
Maybe it would even work by the time mpc85xx_pci_err_probe() runs when
built-in.

The whole early_find_capability() thing seems a little questionable,
too, but it's really only used in the FSL enumeration path, so maybe
there's something really special about that system.

Bjorn
