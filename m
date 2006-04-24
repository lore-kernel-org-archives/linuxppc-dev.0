Return-Path: <pnasrat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 4D25067A3B
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 05:10:06 +1000 (EST)
Subject: Re: [PATCH] DTC - validation by device_type
From: Paul Nasrat <pnasrat@redhat.com>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1145547307.5314.118.camel@cashmere.sps.mot.com>
References: <1143586160.2660.19.camel@enki.eridu>
	<66cc5bfb5a367a814fbace8105572658@penguinppc.org>
	<1143599612.2704.14.camel@enki.eridu>
	<1145547307.5314.118.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 15:09:52 -0400
Message-Id: <1145905793.4082.27.camel@enki.eridu>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-04-20 at 10:35 -0500, Jon Loeliger wrote:
> On Tue, 2006-03-28 at 20:33, Paul Nasrat wrote:
> 
> > Signed-off-by: Paul Nasrat <pnasrat@redhat.com>
> 
> Paul,
> 
> Sorry about the hang-time here.  Couple questions.
> 
> 
> > +static int check_network(struct node *net)
> > +{
> > +
> > +	int ok = 1;
> > +	struct property *prop;
> > +
> > +	CHECK_HAVE(net, "reg");
> > +	CHECK_HAVE(net, "local-mac-address");
> > +	CHECK_HAVE(net, "mac-address");
> > +	CHECK_HAVE(net, "address-bits");
> > +
> > +	return ok;
> > +}
> 
> This says that all network nodes have to have all four
> of those properties.  It's not clear to me that they all
> need to have both local-mac-address and mac-address.


> Specifically, 1275 seems to indicate to me that the
> mac-address property, being introduced by the open
> operation, might be dynamically set at run time, rather
> than passed as a config parameter from, say, U-Boot to
> the kernel.  Thus, it might not be necessary here.


1275 defines shall to indicate a mandatory requirement.

p.165 (Annexe A) defines "network" device_type:

A standard package with this "device_type" property shall implement the
following methods:

open, ...

Requirements for open method:

Execute mac-address and create a "mac-address" property with that value.
...
A standard package with this "device_type" property shall implement the
following property if the associated device has a preassigned IEEE 802.3
MAC (network) address:

So for flattened device tree my reading would be something like:

local-mac-address - for the most part this would be compulsory - does
anyone have any cases where a device would not have a preassigned MAC
address?  Use of address in the booting-without-of and example should be
replaced by local-mac-address.

For a standard 1275 tree mac-address would be created on open, obviously
this isn't a hard requirement for compatibility so I think we could make
this optional.

Paul
