Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD0A4DDEBA
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 23:48:24 +1000 (EST)
In-Reply-To: <1184707558.25235.159.camel@localhost.localdomain>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
	<C2D29334-489F-49B0-8220-0D94E89FEAC3@kernel.crashing.org>
	<1184707558.25235.159.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <60DF811F-EA7E-4A84-A2F9-60FFFF010ECF@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
Date: Wed, 18 Jul 2007 15:48:05 +0200
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

>> Yes, I shouldn't say "defaulted" -- a unit interrupt specifier
>> simply has no unit address part, in an interrupt domain that
>> doesn't correspond to a "normal" bus.  But saying it like this
>> is a little bit inexact, and it uses more words.
>>
>>> which is why I tend to prefer having it
>>> explicitely in the interrupt controller node :-)
>>
>> Which is simply incorrect.
>
> It's absolutely not.

Of course it is.  #address-cells is a property for
bus nodes, you don't go around putting it in unrelated
places, just like you don't put "slot-names" properties
where it has no business.

Oh, wait, you're going to say that is a stupid comparison.
Yeah it is, "slot-names" would be way more harmless, #a is
such a fundamental low-level building block of the OF device
tree that the imap people didn't dare change it semantics
(or, were simply smart enough to not try).

> Please, stop that moronic pin-head behaviour and
> find me a single case where that would actually be a problem of any =20=

> sort
> or form.

You want all DTS authors to put properties where they do
not belong, confusing them even further about what all this
stuff is.  You want to make this a "requirement", although
it of course won't help anything anywhere, since *even you
_do_ have to follow the rules*, because the Linux code has
to support proper standards-compliant OF device trees, too.

>> You mean, the magic default values you used for #address-cells
>> and #size-cells?  That was simply a bug, someone forgot to read
>> the documentation...
>
> No, defaults are crap, period. This is a general thing.

I'm sorry if you feel that way, but there simply is no
way you can do anything about it; defaults exist, you
have to support them.

> Besides, the
> spec itself has issues about the default values (remember those blurbs
> about PCI and ISA supposedly having different defaults ?)

I remember those very very vaguely.  The conclusion was that
people have trouble understanding what they read, if I
remember it right.

Anyway, quit saying vague things about supposed bugs in the
OF documents without pointing them out; it is less than
helpful.

> In any way,
> defaults are a bad idea and I'm happy to say don't use them.

Sure, feel free to recommend people to explicitly write out
default values.  Nothing wrong there, it's just one particular
coding style.

As I've explained enough times though, the issue at hand isn't
about writing out a default value though; you want to require
(not recommend) a completely bogus property where it doesn't
belong.  And none of the code will benefit, either.  I don't
see the point.

>> For this?  No way:
>>
>> [=46rom the base spec]:
>>
>> =93#address-cells=94 S
>> 	Standard property name to define the package=92s address format.
>> 	prop-encoded-array: Integer, encoded with encode-int.
>>
>> 	This property applies to packages that define a physical
>> 	address space, i.e., those packages with =93decode-unit=94
>> 	methods. The property value specifies the number of cells
>> 	that are used to encode a physical address within that
>> 	address space. The value of this property affects the other
>> 	functions, commands, and methods that deal with physical
>> 	addresses. In a package with a =93decode-unit=94 method, a =
missing
>> 	=93#address-cells=94 property signifies that the number of
>> 	address cells is two.
>
> And you omit the various bus bindings that have come up with different
> defaults...

a) Do you expect me to quote every OF document in every post?
    That would easily exceed the message limits on this list,
    sorry.
b) There are no such bindings.  Stop confusing people.  There
    might be a bug in one such binding or so, but that would be
    just that, a bug; or maybe it uses confusing language; or
    maybe some people just don't know how to read [that would
    include me, I'm not trying to escalate this, ahem, polite
    conversation].  In any case, please point out the exact
    spot where you say this happens.

>> See?  The flat device tree unfortunately has no decode-unit, but
>> it is still pretty clear which nodes "define a physical address
>> space" and which do not.
>>
>> There is nothing badly defined here.
>
> See above. Besides, as I said, default values are crap.

Hey, maybe if you repeat it often enough, I might start to
believe it.  Not that that will help your point, since it
is absolutely irrelevant.

> And no, it's not
> obvious which nodes define a physical address space or not, at =20
> least not
> for a generic parser.

"Everything which can have kids with an @ in your DTB full
name thingie".  That includes everything with a #address-cells.

> Defaults are a bad idea, just get it

I'm getting tired of repeating myself, I hope you do, too.

> and move on and stop arguing just for the sake of arguing.

Would you please stop using that childish argument when
you've run out of real ones?

> Pointing out the letter
> of the spec is not a constructive attitude here.

Not just the letter, also the spirit, and the history.

And of course it _is_ constructive; you want to make a
useless, non-compatible change, are we peasants allowed
to quote the law that even you the mighty king must follow?
It's the only weapon we have you know.  Oh, if you discount
the pitchforks ;-)

>> Nothing in the "interrupt mapping" spec redefines #address-cells
>> (OF isn't all that stupid you know); it simply says that a /unit
>> interrupt specifier/ has no /unit address/ part if there is no
>> #address-cells.  The algorithm in paragraph 7 makes it super
>> clear how exactly this should work.
>
> No, the algorithm provided isn't clear and is buggy.

Yes it is clear.  No it isn't buggy (it _does_ state right
before the algo that some details are left out, maybe that
hurt you?)

>  I have implemented it so I know what I'm talking about.

Me too.

> The fact that basically you end up
> with "different" defaults for what is essentially the value
> #address-cells depending on whether you are walking the device-tree =20=

> for
> address resolution or for interrupt resolution is stupid.

Until you realise #address-cells is missing in those two
cases for completely different reasons.  In the first case,
#address-cells is missing for historic reasons; there didn't
use to be a #address-cells, everyone implicitly assumed it
was 2, it wasn't a default as such.  After #a was introduced,
not specifying it if it was 2 had to be allowed, for compatibility
reasons.  To this day, people routinely write trees with implicit
#address-cells =3D <2>, simply since they find it handy [<-- this
is the only thing you can fight with that "defaults are bad"
argument, btw, and you won't get far; most people feel passionately
about their own coding style].

In the interrupt "tree" case though, #address-cells is missing
in certain nodes ***because it simply doesn't belong there!***
The imap spec doesn't put any new rules on #address-cells [how
could it, without risking serious damage], it simply specifies
how to deal with the existing bus tree structure.  And not every
node in the interrupt graph is a bus node, so it says how to
form a unit interrupt specifier when there is no #address-cells:
you simply leave out the unit part.  Wow.  Now that was hard.
And there is no "default" (in your sense) in sight.

> Thus, the
> solution is simple: don't do defaults. Explicit values are good.

Except where the decisive thing is whether there _is_ a value
at all.

>>> and the spec contains gray areas
>>> and contradictions as to what the default values should be in some
>>> circumstances.
>>
>> In some areas, perhaps.  And it would be nice to bring those
>> areas to the attention of the working group, instead of just
>> to complain.
>
> The working group is dead

"It's just resting".

> and some of the ex members of it expressed
> their lack of interest in pursuing these matters.

Some, yes.  Even if the WG wouldn't help, there are some other
forums where you can discuss OF bugs; if all else fails, you
could try this mailing list even.

Point remains: it is a terribly bad argument to say "defaults
are bad, ooh I'm creating a rumour there are some vague defaults
in the OF standard right here, without pointing out anything,
ever".


[Here you cut out the part of our little chat where you
suggest the interrupt mapping spec should have said that
if there is no #address-cells in a node, just put something
there]

>> If it would, the interrupt mapping spec would have had to say
>> how the semantics of #address-cells were changed (and they
>> weren't, and they shouldn't, and this is such a laughable idea
>> I wonder why anyone would suggest it did).
>
> That's bullshit. The semantics are exactly the same. You obviously
> decided to be immune to any kind of common sense today.

Huh?  Let me write more abstractly what I said:

	"If you change A, A gets changed".

Hard to argue with that I would think, but hey.

>> What the interrupt mapping spec defines is how to _use_ the
>> value of #address-cells, and how to interpret its absence;
>> what should be put in #address-cells for separate nodes is
>> defined elsewhere (namely, in the base spec, and in relevant
>> device bindings).
>
> There is no such crackpot interpretation.

Well please read it again, if that's what you think.  Obviously
you didn't understand it on the first try.  This is really basic
stuff; it's how standards work.

> A unit interrupt specifier
> contains ... an address. An address format/size is defined by a
> #address-cells.

No.  A unit address format is defined by its device binding.
Luckily, for (PCI) interrupt mapping, nothing more than the
unit address _size_ is needed since the imap spec doesn't
concern itself with the semantics of the unit addresses in
question; it just needs some way to get unique identifiers.

> Period. That's not an "interpretation", that's the
> basic, primary semantic of #address-cells.

Pretty much, yes...

> The fact that the absence of
> #address-cells will give a different "default" for the address size
> depending on "how" you walk the tree is just a plain wrong bad idea.

...so I don't see how you made _this_ mental jump.

There _is_ no default, there is just a different way to
form unit interrupt specifiers for nodes with or without
#address-cells.  They are treated differently, because
they _are_ different.  Yes you can try to shoehorn them
into one mould by pretending #address-cells exists and
has the value 0; this might be okay for an interrupt tree
walker implementation [or it might not -- the writers of
the example algorithm that you so despise probably had
a reason for writing it out all three times, even though
they aren't all that careful in other places], maybe it
isn't too confusing there, but it certainly is if you put
it in a device tree.

> I
> see no reason why it would be or cause or be in any way shape or form
> wrong or against the "spirit" of the spec (if not the letter) to
> explicitely specify in the case of leaf interrupt controllers, that
> their #address-cells is 0 and be done with it.

Maybe you don't see it.  But the specs make abundantly
clear that _not_ putting an #address-cells here is perfectly
fine, which I thought would have prevented this particular
flame war from happening at all.  Oh well.


Segher
