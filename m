Date: Thu, 11 Apr 02 09:16:08 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204111616.AA28753@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Fine, StarMON + ppc-boot-linux.  But this really is splitting hairs.
> The problem is firmware (or firmware writers) who know about Linux and
> want to boot linux from their firmware (in your case, you wrote another
> program, ppc-boot-linux, to know about the linux bits) and those who
> don't.

First it's ppc-linux-boot, not ppc-boot-linux. Second as you can see from it's
code it is not specific to StarMON except on boards where there is no other
firmware. So your whole argument of StarMON + ppc-linux-boot as somehow special
is misbased. You could have PPCBug + ppc-linux-boot or DINK + ppc-linux-boot
just as well.

Also I'm not even using ppc-linux-boot any more, in 2_4_alt I've made a
zImage.ppcstar that runs directly from the (completely Linux-unaware) StarMON
console. As you can see it isn't that hard. (And as I already wrote I made that
wrapper instead of ppc-linux-boot not because I like this, but because you guys
just can't agree on the vmlinux entry point ABI precluding external booters.)

> What's the incentive to do something like that when it all just works
> tho?

The incentive, for me at least, is to sell boards and to have standard Linux
and BSD distributions shipping with them to make them sell better. I don't
think any company would be particularly happy about cutting, testing,
archiving, distributing, etc. 20 different CD variants for each release of an
OS because you have to have a different one for each slightly different CPU
board model, even if the difference is one byte.

I don't think we'll ever come to an agreement because we have different goals.
You are taking directions from people like Art Webb, and I'm trying to deliver
a better product to the market that all those Art Webbs. I want my boards
supported in the CONFIG_ALL_PPC kernel or its successor and I'm prepared to do
whatever boot mechanism changes it takes to do that. If you don't have that
goal and your goal is instead to keep things "simple", fine, no one can tell
you what to do with your boards. Let's just accept that my board ports will
always be very different from yours.

> Hell, it could probably run on StarMON (I suspect it'd just need to have
> the ELF header stripped off and loaded into a 'good' location). :)

Yes, it would run, except on boards where somewhere along the way you make an
assumption about some hardware (like the interrupt controller or IDE) being in
a certain state on entry, which is the state established by some other firmware
but not StarMON. I remember problems of that sort on K2. Also in your current
EV-64260 port the wrapper assumes that the GT registers are at 0x14000000,
while StarMON puts them at the much more reasonable 0xF1000000. But I did
indeed boot your EV-64260 zImage from StarMON, I just wrote a tiny program that
remaps the GT registers back to 0x14000000 and jumps to 0x800000 where zImage
lives. (I also had to comment out a few things in the Linux code proper in your
wonderful EV-64260 port that prevented it from running on my board, but that's
beside the point here.)

It'll also run inefficiently on most boards as far as caches go. StarMON stores
its state variables and in some implementations its code in locked caches. When
you get a full OS up and running you want to flush all that out to use all
caches normally as caches in their full capacity.

> 'simple' doesn't want to know about the firmware, 'simple' wants to get
> Linux up and running. :)

Let's just accept that I'll do my board ports differently because I have a
different view and a different goal.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
