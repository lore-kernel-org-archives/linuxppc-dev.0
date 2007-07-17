Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35AC1DDE0C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 00:15:22 +1000 (EST)
In-Reply-To: <1184622446.25235.89.camel@localhost.localdomain>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <C2D29334-489F-49B0-8220-0D94E89FEAC3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
Date: Tue, 17 Jul 2007 16:15:00 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> +		#address-cells =3D <0>;
>>>>> +		#size-cells =3D <0>;
>>>>
>>>> No need for these.
>>>
>>> Isn't a good practice to put #address-cells in interrupt controller
>>> nodes?
>>
>> It is not.
>
> Well, that's debatable... but yes, a strict reading of the spec would
> say that you should put neither #address-cells nor #size-cells in a =20=

> leaf
> interrupt controller.

Yes.

>>> If the device tree has an interrupt map defined the interrupt
>>> parent 'unit interrupt specifier' has to be interpreted according
>>> to the #address-cells of the interrupt parent.
>>
>> And "#address-cells" is defaulted to 0 if it is absent,
>> for the purpose of interrupt mapping (but not for its
>> other purposes).
>
> This is a bit confusing though,

Yes, I shouldn't say "defaulted" -- a unit interrupt specifier
simply has no unit address part, in an interrupt domain that
doesn't correspond to a "normal" bus.  But saying it like this
is a little bit inexact, and it uses more words.

> which is why I tend to prefer having it
> explicitely in the interrupt controller node :-)

Which is simply incorrect.

> I tend to dislike
> "magic" defaults, we've had problems with them in the past and will =20=

> have
> in the future, I much prefer having things explicit whenever possible.

You mean, the magic default values you used for #address-cells
and #size-cells?  That was simply a bug, someone forgot to read
the documentation...

>> That "typical practice" is inspired by the need to explicitly
>> put #address-cells and #size-cells into the device tree if you
>> want Linux to properly parse the device tree, even if the default
>> values would work perfectly (if Linux would work correctly,
>> that is).
>
> Linux does handle default values in some areas. The problem with =20
> default
> values is that they are badly defined

For this?  No way:

[=46rom the base spec]:

=93#address-cells=94 S
	Standard property name to define the package=92s address format.
	prop-encoded-array: Integer, encoded with encode-int.

	This property applies to packages that define a physical
	address space, i.e., those packages with =93decode-unit=94
	methods. The property value specifies the number of cells
	that are used to encode a physical address within that
	address space. The value of this property affects the other
	functions, commands, and methods that deal with physical
	addresses. In a package with a =93decode-unit=94 method, a =
missing
	=93#address-cells=94 property signifies that the number of
	address cells is two.

See?  The flat device tree unfortunately has no decode-unit, but
it is still pretty clear which nodes "define a physical address
space" and which do not.

There is nothing badly defined here.

Nothing in the "interrupt mapping" spec redefines #address-cells
(OF isn't all that stupid you know); it simply says that a /unit
interrupt specifier/ has no /unit address/ part if there is no
#address-cells.  The algorithm in paragraph 7 makes it super
clear how exactly this should work.

> and the spec contains gray areas
> and contradictions as to what the default values should be in some
> circumstances.

In some areas, perhaps.  And it would be nice to bring those
areas to the attention of the working group, instead of just
to complain.

There is no such issue in this area, anyway.

> As a general matter, I dislike default values because
> they somewhat require background knowledge of what default values =20
> should
> be in different contexts to "read" a device-tree.

Of course, you need way more than that knowledge to properly
parse or read a device tree *at all*.

> To be simple, I
> believe default values are a bad idea.

Linux will have to keep supporting them for "real OF", so
requiring an explicit #address-cells where its value is 2
doesn't really help much.  I'm not opposed to this though,
for flat device trees at least (I think it's a good thing
for OF trees as well, but for different reasons; and that's
beside the point here).

On the other hand, requiring an #address-cells where it is
supposed to be absent, and you only want it so you can wrap
your head around the interrupt mapping recommended practice
in a more confusing and confused way, is simply WRONG.

>> There are no child nodes, and no binding that says there can
>> be any; neither #address-cells not #size-cells should be there.
>
> You are being way too pedantic here.

No I'm not.

> The interrupt-tree uses those two properties, thus "there is
> no child node" is open to interpretation.

It isn't.  Not a bus -> no child node in the device tree.
The interrupt tree is a completely separate thing.

> There is no child device node, but there are child interrupt nodes, =20=

> and
> since the interrupt-tree uses #address/size-cells,

It doesn't.

> it does make some sense to specify them.

If it would, the interrupt mapping spec would have had to say
how the semantics of #address-cells were changed (and they
weren't, and they shouldn't, and this is such a laughable idea
I wonder why anyone would suggest it did).

What the interrupt mapping spec defines is how to _use_ the
value of #address-cells, and how to interpret its absence;
what should be put in #address-cells for separate nodes is
defined elsewhere (namely, in the base spec, and in relevant
device bindings).

> Yes, there is a default value when absent, but the simple fact that =20=

> the
> default is different depending if you are doing a device walk or an
> interrupt tree walk is very confusing.

Yes, perhaps there shouldn't be a default value for #a
in the device structure; this is legacy compatibility
though, way way way too late to change this.  You can do
this for the flat device tree though, since a) there are
no legacy trees around that you care about, and b) you
need to do something to get around the fact you don't have
decode-unit and encode-unit anyway, so little changes
around that area should be expected.

> As I said above, the default
> values are a source of more problem than anything else and I tend to
> think they should be banned.

You cannot ban them in the Linux code.  With that in mind,
what good would it do?  There are thousands of cases where
absence of a property signifies something that you simply
*cannot* forbid, period.  So why do it to this one?

> I would personally be inclined to define that whatever spec we come up
> with always require #address-cells/#size-cells for any node that can
> have either device children

That is fine, for the flat device tree.  Note that this would
be implicit in all separate device bindings, anyway.

> or interrupt children,

Nope.  I hope I explained my reasoning.

> and ban default values alltogether.

That is simply impossible.


Segher
