Return-Path: <mgreer@mvista.com>
Date: Tue, 15 Jan 2008 10:20:27 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/4] powerpc: mv64x60 - Use early_* PCI accessors for
	hotswap reg
Message-ID: <20080115172027.GA26853@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
	<20080115101936.d186329d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080115101936.d186329d.sfr@canb.auug.org.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2008 at 10:19:36AM +1100, Stephen Rothwell wrote:

> Hi Mark,

Hi Stephen.  Thanks for taking the time to review these patches.

> On Mon, 14 Jan 2008 15:51:50 -0700 "Mark A. Greer" <mgreer@mvista.com> wrote:
> >
> > +static inline struct pci_controller *mv64x60_find_hose(u32 idx)
> > +{
> > +	struct device_node *phb;
> > +	struct pci_controller *hose;
> > +	const u32 *prop;
> > +	int len;
> > +
> > +	for_each_compatible_node(phb, "pci", "marvell,mv64360-pci") {
> > +		prop = of_get_property(phb, "cell-index", &len);
> > +		if (prop && (len == sizeof(prop)) && (*prop == idx)) {
> > +			hose = pci_find_hose_for_OF_device(phb);
> > +			of_node_put(phb);
> > +			return hose;
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> I would think that this is way to big to inline ...

Yeah, I suppose.  I'm not sure why I made it an inline, TBH.  I'll make
it a "real" routine.

Mark
