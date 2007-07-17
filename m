Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16758DDEC2
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 07:26:11 +1000 (EST)
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <C2D29334-489F-49B0-8220-0D94E89FEAC3@kernel.crashing.org>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
	<C2D29334-489F-49B0-8220-0D94E89FEAC3@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Date: Wed, 18 Jul 2007 07:25:57 +1000
Message-Id: <1184707558.25235.159.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yes, I shouldn't say "defaulted" -- a unit interrupt specifier
> simply has no unit address part, in an interrupt domain that
> doesn't correspond to a "normal" bus.  But saying it like this
> is a little bit inexact, and it uses more words.
> 
> > which is why I tend to prefer having it
> > explicitely in the interrupt controller node :-)
> 
> Which is simply incorrect.

It's absolutely not. Please, stop that moronic pin-head behaviour and
find me a single case where that would actually be a problem of any sort
or form.

> You mean, the magic default values you used for #address-cells
> and #size-cells?  That was simply a bug, someone forgot to read
> the documentation...

No, defaults are crap, period. This is a general thing. Besides, the
spec itself has issues about the default values (remember those blurbs
about PCI and ISA supposedly having different defaults ?) In any way,
defaults are a bad idea and I'm happy to say don't use them.

> For this?  No way:
> 
> [From the base spec]:
> 
> “#address-cells” S
> 	Standard property name to define the package’s address format.
> 	prop-encoded-array: Integer, encoded with encode-int.
> 
> 	This property applies to packages that define a physical
> 	address space, i.e., those packages with “decode-unit”
> 	methods. The property value specifies the number of cells
> 	that are used to encode a physical address within that
> 	address space. The value of this property affects the other
> 	functions, commands, and methods that deal with physical
> 	addresses. In a package with a “decode-unit” method, a missing
> 	“#address-cells” property signifies that the number of
> 	address cells is two.

And you omit the various bus bindings that have come up with different
defaults...

> See?  The flat device tree unfortunately has no decode-unit, but
> it is still pretty clear which nodes "define a physical address
> space" and which do not.
> 
> There is nothing badly defined here.

See above. Besides, as I said, default values are crap. And no, it's not
obvious which nodes define a physical address space or not, at least not
for a generic parser. Defaults are a bad idea, just get it and move on
and stop arguing just for the sake of arguing. Pointing out the letter
of the spec is not a constructive attitude here.

> Nothing in the "interrupt mapping" spec redefines #address-cells
> (OF isn't all that stupid you know); it simply says that a /unit
> interrupt specifier/ has no /unit address/ part if there is no
> #address-cells.  The algorithm in paragraph 7 makes it super
> clear how exactly this should work.

No, the algorithm provided isn't clear and is buggy. I have implemented
it so I know what I'm talking about. The fact that basically you end up
with "different" defaults for what is essentially the value
#address-cells depending on whether you are walking the device-tree for
address resolution or for interrupt resolution is stupid. Thus, the
solution is simple: don't do defaults. Explicit values are good.

> > and the spec contains gray areas
> > and contradictions as to what the default values should be in some
> > circumstances.
> 
> In some areas, perhaps.  And it would be nice to bring those
> areas to the attention of the working group, instead of just
> to complain.

The working group is dead and some of the ex members of it expressed
their lack of interest in pursuing these matters.

> Linux will have to keep supporting them for "real OF", so
> requiring an explicit #address-cells where its value is 2
> doesn't really help much.  I'm not opposed to this though,
> for flat device trees at least (I think it's a good thing
> for OF trees as well, but for different reasons; and that's
> beside the point here).
> 
> On the other hand, requiring an #address-cells where it is
> supposed to be absent, and you only want it so you can wrap
> your head around the interrupt mapping recommended practice
> in a more confusing and confused way, is simply WRONG.

No, it's not, It's purely having an explicit representation of what was
a stupid default behaviour.

> If it would, the interrupt mapping spec would have had to say
> how the semantics of #address-cells were changed (and they
> weren't, and they shouldn't, and this is such a laughable idea
> I wonder why anyone would suggest it did).

That's bullshit. The semantics are exactly the same. You obviously
decided to be immune to any kind of common sense today.

> What the interrupt mapping spec defines is how to _use_ the
> value of #address-cells, and how to interpret its absence;
> what should be put in #address-cells for separate nodes is
> defined elsewhere (namely, in the base spec, and in relevant
> device bindings).

There is no such crackpot interpretation. A unit interrupt specifier
contains ... an address. An address format/size is defined by a
#address-cells. Period. That's not an "interpretation", that's the
basic, primary semantic of #address-cells. The fact that the absence of
#address-cells will give a different "default" for the address size
depending on "how" you walk the tree is just a plain wrong bad idea. I
see no reason why it would be or cause or be in any way shape or form
wrong or against the "spirit" of the spec (if not the letter) to
explicitely specify in the case of leaf interrupt controllers, that
their #address-cells is 0 and be done with it.

Ben.
