Message-Id: <200008292243.AAA00726@piglet.grunz.lu>
Date: Wed, 30 Aug 2000 00:43:19 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: asm in OF?
To: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000829180430.22619@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bonsoir Ben,

On  29 Aug, this message from Benjamin Herrenschmidt echoed through cyberspace:
> It may be cache throttling, but it may also be the speculative prefetch
> or the lack of the guard bit on the IO pages (this ROM doesn't set the
> correctly).

I don't know for sure what the problem is; some tech guy from Metabox
(maker of the G3 upgrade card) talked about '... busy loop in
software...', but gave no details. Therefore I suppose that something in
the MESH SCSI driver breaks if the CPU runs too fast. Which would
explain why it works OK if I reduce CPU and/or bus speed.

And that is the reason I want to try to throttle the CPU via ICTC :-)

> So you have to play with ICTC and HID0.

I've been able to have a look at OF's implementation of the hid0! and
hid0@ commands (address is bogus... it's pasted into a kernel file ;-)):

hid0@:

c0000010:       96 9f ff fc     stwu    r20,-4(r31)
c0000014:       7e 90 fa a6     mfdbsr  r20
c0000018:       4e 80 00 20     blr

hid0!:

c0000020:       7e 90 fb a6     mtdbsr  r20
c0000024:       4c 00 01 2c     isync
c0000028:       82 9f 00 00     lwz     r20,0(r31)
c000002c:       3b ff 00 04     addi    r31,r31,4
c0000030:       4e 80 00 20     blr

Obviously, the convention in OF is that r20 contains the top stack
value, and r31 the stack pointer. So, I know what my asm needs to look
like; I only need to find out how to code that in forth...

Somewhere in my doc archive, I've found a book by FirmWorks titled
'Writing FCode Programs for PCI - An Introduction to FCode Programming
Fully Compliant with IEEE Standard 1275-1994'. It doesn't talk a lot
about asm coding... but is perfect if you want to write a new FCode
driver for some strange hardware!

It looks as if I could code my ictc@ and ictc! commands two ways:

Either create an array in memory, that gets executed later:

	// am I missing some end delimiter here?
	create ictc@ <code> l, <code> l, <code> l,
	code ictc@ // executes my code defined above

or define a new word with code:

	// code definition in compile mode
	] code ictc@ <code> l, <code> l, <code> l, c; [

	code ictc@ // execute above code

This second method doesn't seemto work; but I may be missing the right
way to provide the name string for the new word...


OK, enough hacking; time for bed ;-)

Michel (falling asleep)

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
