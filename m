Subject: Re: ibook2r2 & strange freeze.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brice Figureau <brice@tincell.com>
Cc: "Linuxppc-Dev@Lists.                  " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <97719C92-7839-11D7-A81D-0003939D5F18@tincell.com>
References: <97719C92-7839-11D7-A81D-0003939D5F18@tincell.com>
Content-Type: text/plain
Message-Id: <1051398872.8435.15.camel@gaston>
Mime-Version: 1.0
Date: 27 Apr 2003 01:14:32 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Ah, that's a machine check... interesting. So either the address above
> > is bogus, or the card is crashed. In this later case, noaccel should
> > have helped, except if, for some reason, the argument was ignored
> > when setting the initial mode...
> Since the address does not seem to be bogus, could it be possible that
> my computer is broken in a certain way ? (bad memory...).
> I'll do another noaccel check.

Well, it's weird... It seems the ATI chip isn't anwsering on the bus on
a specific access.

Are you sure of that specific bit of disassembly ?

c0184554 380b0e40 addi  r0,r11,3640

Is't it 3648 instead ? (the opcode seem to indicate that). In this case,
the problem is that we are getting a machine check in radeon_fifo_wait()
while reading RBBM_STATUS register.

I have absolutely no idea what can cause this (but bad HW ?) in xmon,
if you first check out r0 (it may not be d9000000 again ...) and then
do "m d9000000.l" (or replace d9000000 by whatever it has become) and
finally tell me if you atually read a value or not.

I completely fail to understand why a problem like this would happen
with -ben9 and not -ben8. Are you absolutely sure you properly tried
-ben9 with the radeonfb from -ben8 ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
