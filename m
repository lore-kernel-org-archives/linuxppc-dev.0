Message-Id: <200107051529.LAA29124@makai.watson.ibm.com>
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Kaoru Fukui <k_fukui@highway.ne.jp>, Jean-Jacques.Levy@inria.fr,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: __divdi3 unresolved + X pointer blocks 
In-Reply-To: Message from Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
   of "05 Jul 2001 13:48:41 +0200." <8xr8vv61gm.fsf@s62.informatik.uni-bremen.de>
Date: Thu, 05 Jul 2001 11:29:01 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Holger Bettag writes:

Holger> And: 'arithmetic shift right' is _not_ the same as signed divide, because the
Holger> rounding of negative operands or results may differ.

	Exactly!  For a 32-bit operand, a signed divide by an exact power
of two is equivalent to:

srawi
addze

	For synthesized 64-bit operand, this is more complicated, which is
why GCC calls __divdi3 instead of open-coding it.

	Will all of the people posting INCORRECT information about logical
versus arithmetic shift and converting signed divide into shift, please
stop.  You are propagating bad information.

	If one converts a divide into a shift, one is assuming more
information than one has informed the compiler.

	This whole discussion thread is confusing two issues.  If one
wants GCC to produce a shift, one needs to write the code so that GCC
safely can convert the divide into a shift.  If the shift is not safe,
then the Linux kernel needs to provide __divdi3.

	The two suggestions of writing the divide as a shift and linking
with libgcc.a BOTH ARE WRONG.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
