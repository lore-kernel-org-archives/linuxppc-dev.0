Return-Path: <dgibson@ozlabs.org>
Date: Mon, 5 Nov 2007 09:42:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [U-Boot-Users] use of aliases in device trees
Message-ID: <20071104224256.GC15444@localhost.localdomain>
References: <DD2A9B2C-5D35-4F53-8542-3470C6FA5265@kernel.crashing.org>
	<fa686aa40711032029x3871b76m5b44a6e93d8d7217@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40711032029x3871b76m5b44a6e93d8d7217@mail.gmail.com>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	U-Boot Users List <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 03, 2007 at 09:29:48PM -0600, Grant Likely wrote:
> On 11/3/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> > In some discussion on the u-boot dev list it became clear that having
> > aliases in the device tree might be useful as a common way to deal
> > with finding specific nodes that need fixing up by the firmware.
> > This problem also exists in the kernel bootwrappers.
> >
> > The common example is how to associate a given MAC address with the
> > proper ethernet node.  In u-boot an explicit path is hard coded into
> > the u-boot build for each ethernet device.  In the bootwrapper we use
> > "linux,network-index = <N>" in the given ethernet node.
> >
> > One common solution would be having a top level aliases like the pmac
> > tree's have:
> >
> > aliases {
> >         enet0 = "...";
> >         enet1 = "...";
> >         pci0 = "...";
> >         pci1 = "...";
> > };
> 
> One question to ask is do we use full paths or phandles to point at nodes?
> 
> OF, of course, uses full paths, but that does require more memory and
> processing power, but it might not be significant enough to worry
> about.
> 
> If we use phandles, then we should use names that don't conflict with
> full path alias names.  It would also be desirable to be able to
> generate a phandle alias from the full path alias in order to maintain
> some level of compatibility with OF.  It also think it will make
> maintaining aliases in .dts files simpler because trivial changes to
> node paths won't break the phandle alias.
> 
> Maybe something like:
> aliases {
>       enet0,phandle = <&enet0>;
>       enet1,phandle = <&enet1>;
>       ...
> };

The fairly small advantages of using phandles here are not worth the
hassle of defining a new alias format, when the OF one with full paths
already exists.

I would, however, like to extend dtc so that we can do something like:
	aliases {
		enet0 = &enet0;
	};
and the reference in non-cell context will expand to the full path.
That could be used for things like linux,stdout-path in /chosen, too.

I'd also like to extend dtc so that the label can be tagged somehow, say:
	*enet0: { ... };
and as well as creating a normal dtc label, an alias will also be
automatically added to /aliases.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
