Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 9B7AADDF39
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 06:11:06 +1000 (EST)
Date: Mon, 2 Jul 2007 22:11:04 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
In-Reply-To: <00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
Message-ID: <Pine.LNX.4.60.0707022114020.3339@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Segher,

On Mon, 2 Jul 2007, Segher Boessenkool wrote:

> > +	while ((node = of_get_next_child(adap_node, node))) {
> 
> of_for_each_child_node() or whatever it is called?

Sure, would be nice, only I cannot find anything like that. I seem to 
remember seeing a patch like that, but maybe I'me mistaken... Do you 
remember details / can you find it?

> > +		addr = of_get_property(node, "reg", &len);
> > +		if (!addr || len < sizeof(int) || *addr > 0xffff)
> > +			continue;
> 
> Addresses aren't 16 bit AFAIK?

Maximum 10 bits. So, yes, it can become 0x3ff.

> > +		name = of_get_property(node, "compatible", NULL);
> > +		if (!name)
> > +			name = node->name;
> > +		if (!name)
> > +			continue;
> 
> Look at "name" first, then look at "compatible", not
> the other way around.

ok

> > +		model = of_get_property(node, "model", NULL);
> > +		if (!model)
> > +			model = name;
> 
> No way.  "model" and "name" have nothing in common
> semantically.

ok

> > +		/* FIXME: the i2c code should allow drivers to specify
> > +		 * multiple match names; board code shouldn't need to
> > +		 * know what driver will handle a given type.
> > +		 */
> 
> This should be handled by the OF matching stuff, there
> is no direct connection between device tree naming and
> Linux driver naming.  I don't want to see this patch
> going in without this problem being fixed first.

Right, this one is interesting. But this time I cannot even vaguely 
remember seeing any "OF matching" code. I can only remember each driver 
(or OF glue to a generic driver) parsing compatible of entries, like 
legacy_serial.c. Or you mean we need to write such a matching layer?

AFAIK, i2c is not specified by OF standard. So, we are free to chose any 
"compatible" fields for our dts. Which we then would need to match against 
drivers. So, why not make this a 1-to-1 match? I.e.,
[OF]			[I2C]
compatible	<->	driver_name
model		<->	type

Thanks
Guennadi
---
Guennadi Liakhovetski
