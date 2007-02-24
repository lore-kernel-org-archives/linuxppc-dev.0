Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A6B2DE068
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 22:12:04 +1100 (EST)
In-Reply-To: <1172298948.1902.20.camel@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<9841c5ba165e4bec773366568b3d4195@kernel.crashing.org>
	<1172298948.1902.20.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c3142d07a3c85adb9e67659ee5953c45@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Sat, 24 Feb 2007 12:11:56 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <b08248@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> It would be nicer to keep the "interrupts" property and
>> add a property "interrupt-parents" with the same number
>> of entries, that encodes the same as "interrupt-parent"
>> but per interrupt.  You keep more in line with the
>> "normal" stuff and I suspect it's less code to parse as
>> well.
>
> There are pro and cons to this approach. I did think about it 
> initially.
> The main cons is that "interrupts" becomes harder to parse as you ahve
> to walk interrupt-parents at the same time to get the #interrupt-cells
> of each entry.

Yeah, you have to do some things inside of the interrupt
parsing loop, that you normally can move outside of the
loop.  That's true in the "interrupt-array" case too, you
just get the interrupt parent from somewhere else.  It's
in the nature of this extension.

> Also, it adds more potential for stupid breakage (how
> shluld the parser react if interrupt-parents has less entries than
> interrupts ?)

Just fail loudly.  Just like it should do if it notes
something else nonsensical (a non-phandle in the
"interrupt-array" case, for example, or running out
of encoded integers while parsing).

> The pro, which is quite important too, is that it's a common assuption
> that you have interrupts when you have an "interrupts" property, 
> period.

Yes, it would be a lot closer to the generic case, only add
to the interrupt mapping binding, not change anything in the
base OF spec.

> In fact, it would indeed fit a bit better in the current parser.

Yeah I think so too.

>> Wrong place to document this?  It's true for all interrupt
>> specifiers.
>
> Might be worth giving a crazy example where the 2 interrupt specifiers
> have different size.

I'd rather not.  Anyway, this was in reply to:

>> +Note: the number of cells needed to represent the
>> +interrupt-specifier is determined by the #interrupt-cells
>> +property of the interrupt parent.

Which is a general statement about interrupt specifiers.
Nowhere does the "booting without OF" doc define interrupt
specifiers before it uses them; do that, move this comment
there, and put a comment saying "each entry in "interrupts"
can potentially have a different # of interrupt cells, you
have to look at the corresponding interrupt parent to find
out" in its place?


Segher
