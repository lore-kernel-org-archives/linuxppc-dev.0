Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id EAFDDDDF15
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jul 2007 03:50:24 +1000 (EST)
Date: Wed, 4 Jul 2007 19:50:09 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
In-Reply-To: <030A74A7-7D15-46C3-9ACE-21A42D395E65@kernel.crashing.org>
Message-ID: <Pine.LNX.4.60.0707041938170.5952@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707040707010.4300@poirot.grange>
	<030A74A7-7D15-46C3-9ACE-21A42D395E65@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Jul 2007, Segher Boessenkool wrote:

> > be filled by respective drivers themselves.
> 
> That would be nicer yes, but a bigger change.

Aha, but nicer!:-)

> > For this to work i2c would need something similar to what pci, usb do -
> > register supported device ids. The only difference is that instead of
> > numerical IDs we have to use plain text names for i2c devices...
> 
> Yeah, that would be nice.  Are you suggesting the Linux I2C
> layer should use "OF-style" names as its "native" naming
> scheme?  I'd rather keep the namespaces separate, coupling
> them always seems like a great idea and always turns out a
> disaster.

Sorry, I'm probably missing something here. What's the principal 
difference between the "OF-style" and "native" names? Wouldn't "rs5c372b" 
be a natural name for both the DT "compatible" property and the list of 
driver supported devices in i2c?

The only thing that I can see here is devices with not so obvious names. 
OTOH, we do want all .dts to use the same name for the same chip, soooo...

> > Yes, this is why I put "would". Looks like this is the common powerpc
> > practice ATM - to make such a glue to map arbitrary "OF names" to what
> > respective drivers react to. Like in the case of the serial driver.
> 
> Yes.  This is the most flexible scheme possible and allows
> for all kinds of fixups/workarounds in case of broken device
> trees (or broken kernel code, for that matter).

Well, I think, I might bite. But - mostly for the above argument, i.e., 
just because it offers slightly more flexibility, doesn't require changes 
to existing drivers / subsystems...

> > But -
> > i2c is much more diverse and dynamic than serial, so, maybe it is worth
> > thinking about "fixing" i2c?
> 
> Be my guest :-)  I care more about the OF side of things, but
> let me ask anyway -- what do you see as "broken" in the Linux
> IIC "core" that needs fixing here?

No, I put "fixing" in quotes, i.e., I didn't really mean it was some 
brokenness. Just nobody needed this until now. Just that device - driver 
matching in i2c happens based on driver id, not device id, like in pci, 
usb, maybe others.

Thanks
Guennadi
---
Guennadi Liakhovetski
