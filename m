Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EC83EB7BF4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 10:51:40 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35A5FDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 10:51:39 +1000 (EST)
Subject: Re: [RFC] Clock binding
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mitch Bradley <wmb@firmworks.com>
In-Reply-To: <4A970C85.8090703@firmworks.com>
References: <1250569288.19007.15.camel@pasglop>
	<1251346157.20467.22.camel@pasglop> <4A96F69A.5050003@firmworks.com>
	<1251411532.20467.74.camel@pasglop>  <4A970C85.8090703@firmworks.com>
Content-Type: text/plain
Date: Fri, 28 Aug 2009 10:51:26 +1000
Message-Id: <1251420686.20467.96.camel@pasglop>
Mime-Version: 1.0
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


> I agree in general.  It has long been a convention of mine to follow the 
> vendor's names as exactly as possible.  But that often presents 
> difficulties. Many of them have been touched on in our previous 
> discussion but I'll list some here just to emphasize the problem we face:
> 
> a) Inconsistent naming within a vendor's documentation set - datasheet 
> spells it one way, programmer's manual another, appnotes/porting guide 
> still another, reference schematic spells it two different ways (pin 
> name on part versus net name of signal wire).

Right. I should emphasis that what the device-tree should contain is the
pin name on part and -not- the net name of the wire. Of course, bogus
datasheet and inconsistent spelling will still hurt, nothing much we can
do about it, other than having the first to write a driver become a
de-facto "guide" to other implementors :-)

Maybe we could have a Wiki where the first time a given chip is used for
a binding, we put down the names used to encourage people to use the
same. To some extent it's going to be the responsibility of the person
writing the .dts to pick up names that will work with existing drivers. 

In fact that problem is no different than picking up "compatible" names,
and that Wiki thing might help in both cases.

> b) Sometimes the name is abbreviated and sometimes spelled out.  SMBALRT 
> vs. SMbus Alert.

Right. Still better than a magic number where you simply have no
reference whatsoever to what it is.

> c) Different tools (CAD programs, word processors) have different 
> conventions leading to existence of ambiguously-representable name 
> components - particular cases in point are overbars for active low 
> signals and embedded spaces/underscores/hyphens in names.

Yes, that can be an issue, though overbar is less common for clocks.

> d) Compatible part from different vendors leads to confusion about which 
> vendor's names are canonical.  Or leading vendor goes out of business or 
> gets bought.

Sure, same problem with "compatible" properties. There's no silver
bullet here. But we could try the Wiki approach to provide an unofficial
"reference" of canonical names for common devices. For -very- common
ones such as 8250-compatible UARTs, a full blown binding is probably the
way to go.

> These problems are getting worse rapidly as more devices are being 
> sourced from Asia, where the linguistic connection to the Roman alphabet 
> is tenuous.

True.

> You need a Pope to decide what is canonical.

Perhaps. But we can try our best with something like a wiki in the
meantime and see how it works out.

Cheers,
Ben.

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
