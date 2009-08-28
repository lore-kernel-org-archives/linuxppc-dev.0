Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BE707B7BFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 02:37:40 +1000 (EST)
Received: from mail-gx0-f215.google.com (mail-gx0-f215.google.com
	[209.85.217.215]) by ozlabs.org (Postfix) with ESMTP id 13888DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 02:37:39 +1000 (EST)
Received: by gxk11 with SMTP id 11so2610451gxk.16
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 09:37:37 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1250569288.19007.15.camel@pasglop>
References: <1250569288.19007.15.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 28 Aug 2009 10:37:17 -0600
Message-ID: <fa686aa40908280937nda32be7m97314e4aaef9ff81@mail.gmail.com>
Subject: Re: [RFC] Clock binding
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 17, 2009 at 10:21 PM, Benjamin
Herrenschmidt<benh@kernel.crashing.org> wrote:
> However, it's a bit nasty to mix strings and numbers (phandles) in a
> single property. It's possible, but would likely lead to the phandle not
> being aligned and tools such as lsprop to fail miserably to display
> those properties in any kind of readable form.
[...]
> However, I really dislike that numerical clock ID. Magic numbers suck.
> It should be a string.

Agreed.

> Hence my idea below. It's not perfect but it's the less sucky i've come
> up with so far. And then we can do some small refinements.
>
> =A0 =A0 =A0 =A0* Device has:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- "clock-input-names" as above
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- "clock-map" contains list of phandle,ind=
ex
>
> =A0 =A0 =A0 =A0* Clock source has:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- "clock-output-names" list of strings

The big problem as you say is the referencing of both phandles and
strings in the same property, but it's not particularly pretty to
disperse the data across multiple properties.  Changes to the two
properties must be kept in sync, and if order changes in one and not
the other then badness occurs...  Actually, I don't *dislike* you're
proposed binding, but in the interest of generating and endless
goodness argument, what about the following?

As above, clock source has:
        - "clock-output-names" list of strings.  All possible inputs
must be in this list in the interest of clarity and sanity checking,
but drivers must not depend on the order of the list.  Drivers must
always resolve clocks by name.

Clock consumer has:
        - "clock-inputs" property.  Array of string 'tuples' in the
form: "input-name","clock-source-path","output-name".

This sidesteps the phandle issue by using the path string instead.
It's not as efficient space wise, but (at least when using dtc) the
syntax stays pretty sane, and the output remains mere-mortal parsable:
  ie: clock-inputs =3D "sysclk", &clocksource, "clkout_orange";

> The "index" in the clock map thus would reference the
> "clock-output-names" array in the clock provider. That means that the
> "magic number" here is entirely local to a given device-tree, doesn't
> leak into driver code, which continues using names.
>
> In addition, we can even have some smooth "upgrade" path from existing
> "clock-frequency" properties by assuming that if "clock-output-names" is
> absent, but "clock-frequency" exist, then index 0 references a fixed
> frequency clock source without a driver. This could be generally handy
> anyway to represent crystals of fixed bus clocks without having to write
> a clock source driver for them.

The analog of this could be:

clock-inputs =3D "sysclk", &clocksource, "0";

Otherwise, I think the approach is sound and I agree fully that
referencing names makes sense.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
