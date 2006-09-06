Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9DF7967B8C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 01:11:25 +1000 (EST)
Date: Wed, 6 Sep 2006 10:10:34 -0500
From: Olof Johansson <olof@lixom.net>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [4/5] powerpc: PA Semi PWRficient platform support
Message-ID: <20060906101034.404014f7@localhost.localdomain>
In-Reply-To: <0C880511-D99D-4160-9EB1-A66B22B2D82F@kernel.crashing.org>
References: <20060904175742.5472a6fa@localhost.localdomain>
	<20060905122956.2cebd36d@localhost.localdomain>
	<0C880511-D99D-4160-9EB1-A66B22B2D82F@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 6 Sep 2006 15:38:54 +0200 Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > +#define PA_PXP_CFA(bus, devfn, off) (((bus) << 20) | ((devfn) <<  
> > 12) | (off))
> 
> > +	hose->cfg_data = ioremap(0xe0000000, 0x1000000);
> 
> Shouldn't that length be 0x10000000 then?  Or can't you have
> more than 0x10 busses?

Yes, typo that hasn't hit us yet. Thanks.

> > +	bus_range = (int *) get_property(dev, "bus-range", &len);
> > +	if (bus_range == NULL || len < 2 * sizeof(int)) {
> > +		printk(KERN_WARNING "Can't get bus-range for %s, assume bus 0\n",
> > +		dev->full_name);
> > +	}
> 
> Just kill all this "bus-range" stuff?  Or do you really need it?

Not at this time. Removed.

> > +	np = of_find_node_by_type(np, "open-pic");
> > +	if (!np) {
> > +		printk(KERN_ERR "No interrupt controller in device tree.\n");
> > +		return;
> > +	}
> 
> "device_type" for the MPIC should be "interrupt-controller", "open-pic"
> should be in the "compatible" property instead.

Thanks, I now use the same logic as Maple.

> > +	/* Find address list in /platform-open-pic */
> 
> Erm, can't you get this info from the open-pic node itself?
> I know maple does it like this but that should be fixed ;-)

How about I keep it this way until Maple is fixed then? It's better to keep it
fairly common anyway. Functionally there's no difference.

> > +	mpic = mpic_alloc(mpic_node, openpic_addr, MPIC_PRIMARY, 0, 0,
> > +			  " PAS-OPIC  ");
> > +	BUG_ON(mpic == NULL);
> > +
> > +	mpic_assign_isu(mpic, 0, openpic_addr + 0x10000);
> > +	mpic_init(mpic);
> 
> Very nice, I'll convert maple to do the same (unless someone beats
> me to it, heh).

Maple isn't that different there. It just has to deal with multiple ISUs, 
while we currently only have one.


-Olof
