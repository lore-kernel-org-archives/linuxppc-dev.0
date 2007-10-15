Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.239])
	by ozlabs.org (Postfix) with ESMTP id 93360DDF23
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 06:26:38 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so2038328qbe
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 13:26:36 -0700 (PDT)
Message-ID: <fa686aa40710151326m789046aaq60ba002e180d4e14@mail.gmail.com>
Date: Mon, 15 Oct 2007 14:26:35 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
In-Reply-To: <4713C57F.7060509@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200710151529.11485.sr@denx.de>
	<20071015163216.GA8127@gate.ebshome.net>
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>
	<20071015185340.GB4474@loki.buserror.net>
	<fa686aa40710151213r670bea49i63fa5f5402aa150d@mail.gmail.com>
	<4713BE5E.3030406@freescale.com>
	<fa686aa40710151248y5e921a4fmbb0a3e0b7c9a2ca5@mail.gmail.com>
	<4713C57F.7060509@freescale.com>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, Scott Wood <scottwood@freescale.com> wrote:
> Grant Likely wrote:
> > On 10/15/07, Scott Wood <scottwood@freescale.com> wrote:
> >> For associating a device node with a human readable label, I'd
> >> prefer a "label" property in the device node, rather than doing it
> >> backwards with aliases.
> >
> > Here the corresponding problem; having to scan every device node to
> > make sure you don't assign a number already selected by another node
> > (in the case where one node is assigned a number and another is not).
> >
> Don't Do That(tm).  If you use this mechanism, and an adapter node
> doesn't have a bus number, then it doesn't get to pre-register devices,
> but instead must use i2c_new_device.

Even that doesn't work.  For example if a PCI device is probed which
registers an i2c bus; there needs to be a mechanism for the i2c layer
to know that an id is already spoken for, so once again there needs to
be a mechanism to map easily from id to device (or lack thereof).

> >>> As per your point below; if all the i2c devices are children of
> >>> the adapter, then yes you are right that the bus number doesn't
> >>> matter to the user.  But it *does* matter for things like serial
> >>> and ethernet ports.
> >> And a label property would be great for that. :-)
> >
> > Not really; if the user needs to renumber devices; you don't want him
> >  fiddling around in the hardware description.
>
> Why would the user renumber devices?

Where user == system integrator or firmware engineer.  ie. boards with
no-populate options which affect the numbering; changes to match the
silkscreening on the chassis when a common board is used by multiple
systems.  It's a conceivable scenario.  (Again; this is more relevant
to eth and serial devices than i2c).

>
> > Just like the chosen node; an aliases describes logical constructs,
> > not physical ones.  I don't think this is any different from the
> > linux,stdout-path property in chosen.
>
> Well, it's somewhat different in that stdout describes a usage of the
> device, not the identity.
>
> Still, I don't like linux,stdout-path. :-)
> At the very least it should be a phandle.

I'm cool with it being a phandle.  (insert obvious objection someone
will make about that not being OF compatible)  :-)

Perhaps aliases should look like (which can be generated from the OF
path form when the device tree if flattened):
aliases {
     linux,eth0 = <phandle1>;
     linux,eth1 = <phandle2>;
}

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
