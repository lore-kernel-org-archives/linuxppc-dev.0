Date: Wed, 13 Mar 2002 18:59:19 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Nasty ATI/tulip interaction
To: dgatwood@gatwood.net
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.96.1020226185429.7844B-100000@gatwood.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E16lD25-00006q-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi David,

Sorry for replying late; was on holiday...

On  27 Feb, this message from David A. Gatwood echoed through cyberspace:
>
> On Tue, 26 Feb 2002, David A. Gatwood wrote:
>
>> Weird issue.  I finally got the PowerBase 180, and I've attempted to move
>> my Linux system from the G4 over to it.  I'm running a heavily patched
>> 2.2.21-pre2 kernel.  It includes the PCI fixup patches, Promise Ultra
>> ATA/66 patches, and a few (possibly ppc-specific) bug fixes
> [ in IDE ].

Any specific reason to stay with a 2.2 kernel? I can run 2.4.18 mainline
straight-Linus (sorry, straight-Marcello) on my 7600, with a Promise as
well.

2.4 kenels are a lot faster on PPC as well...

> Thanks to Ben Herrenschmidt, I've gotten it back to the point where I have
> a console, but enabling the ethernet card still hoses the ATI output.
>
> On a hunch, I downloaded, compiled, and installed pciutils, and I found
> the problem....  The tulip card and the motherboard VGA got assigned the
> same I/O ports address (0xf2000400).  No idea how that happened, but it's
> quite consistent.

Definitely a reason to move to 2.4 with the dynamic resource allocation.
That one will catch conflicts (modulo bugs like a chip not decoding as
precise as it says...).

> Looks like something broken.  I'd try without Michel Lanners' PCI fixup
> patches, but I can't boot without them.

Use 2.4 ;-) Should boot, and you can get rid of my patches :-))

> I'm trying to track down what's
> breaking, but it isn't obvious.  I've tried to duplicate the code that
> remaps planb to remap the ethernet device, but I'm getting nowhere fast.
> It's attempting to do the remap, and it is successfully changing the
> kernel's notion of the device address, but it looks like for some reason,
> the change isn't happening in the controller itself, since I'm getting a
> machine check when I actually try to access the device now.  I'm probably
> doing something wrong.

You sure you did everything required? You need to write the new address
back into the device's control registers, and you need to enable IO/Mem
space response before the device would repond. A non-responding device
can give you a machine check.

> I'm giving up for the night, but when I get back to this tomorrow night,
> does anyone have any suggestions on how to change the PCI addy of the
> ethernet card?

I'm repeting myself, but try 2.4 ?

> BTW, this doesn't work:
[snip]

Hmmm.. should have worked, though. Didn't see any obvious errors. Try a
2.4 kernel (did I say that before?), if that fails also, I'd say you
have a hardware bug somewhere that needs to be worked around....

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
