Date: Sun, 27 Apr 2003 14:39:22 +0200
Subject: Re: ibook2r2 & strange freeze.
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: "Linuxppc-Dev@Lists.                  " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Brice Figureau <brice@tincell.com>
In-Reply-To: <1051398872.8435.15.camel@gaston>
Message-Id: <457B4BE7-78AD-11D7-B4DF-0003939D5F18@tincell.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sunday, April 27, 2003, at 01:14 AM, Benjamin Herrenschmidt wrote:
>>> Ah, that's a machine check... interesting. So either the address
>>> above
>>> is bogus, or the card is crashed. In this later case, noaccel should
>>> have helped, except if, for some reason, the argument was ignored
>>> when setting the initial mode...
>> Since the address does not seem to be bogus, could it be possible that
>> my computer is broken in a certain way ? (bad memory...).
>> I'll do another noaccel check.
>
> Well, it's weird... It seems the ATI chip isn't anwsering on the bus on
> a specific access.
>
> Are you sure of that specific bit of disassembly ?
>
> c0184554 380b0e40 addi  r0,r11,3640
>
> Is't it 3648 instead ? (the opcode seem to indicate that). In this
> case,
> the problem is that we are getting a machine check in
> radeon_fifo_wait()
> while reading RBBM_STATUS register.
You were right, that was 3648, it was late yesterday when I copied
that...

> I have absolutely no idea what can cause this (but bad HW ?) in xmon,
> if you first check out r0 (it may not be d9000000 again ...) and then
> do "m d9000000.l" (or replace d9000000 by whatever it has become) and
> finally tell me if you atually read a value or not.
The address seems to exists (and it didn't change):
m d9000000.l gave:
	00030000
	6b000a00
	88030000
...
I don't think my hardware is bad since I run macosx and ben8 without
any problem (XFree86 is working fine).

> I completely fail to understand why a problem like this would happen
> with -ben9 and not -ben8. Are you absolutely sure you properly tried
> -ben9 with the radeonfb from -ben8 ?
Yes.

I'm now sure that the problem does not come from radeonfb !
To proove it, I took -ben8 and backported -ben9 changes one after one
into it, until I got the same crash as before.
It began to crash when I backported:
	 cputable.c
	 head.S
	 cputable.h

As I'm not really good at powerpc assembly, I'll let you find exactly
where the problem is ;-)

Brice


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
