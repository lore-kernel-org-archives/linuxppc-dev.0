Date: Sun, 27 Apr 2003 00:51:17 +0200
Subject: Re: ibook2r2 & strange freeze.
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: "Linuxppc-Dev@Lists.                " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Brice Figureau <brice@tincell.com>
In-Reply-To: <1051396850.8476.1.camel@gaston>
Message-Id: <97719C92-7839-11D7-A81D-0003939D5F18@tincell.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sunday, April 27, 2003, at 12:40 AM, Benjamin Herrenschmidt wrote:
> On Sun, 2003-04-27 at 00:32, Brice Figureau wrote:
>> On Sunday, April 27, 2003, at 12:13 AM, Benjamin Herrenschmidt wrote:
>>>> disassembly:
>>>> c0184554 380b0e40 addi	r0,r11,3640
>>>> c0184558 7c00042c lwbrx	r0,r0,r0
>>>> c018455c 0c000000 twi	0,r0,0   <---- pc
>>>> c0184560 4c00012c isync
>>> [snip]
>>
>>> Hrm... Interesting. It dies reading from the chip (MMIO). Can you
>>> check with xmon "h" command if there's a translation for 0xd9000000 ?
>> I'll do that at my next reboot.
There was a translation for d9000000 (sorry, I don't remember wich
address it was).

>>> (Or hack radeonfb init to printk the result of ioremap of the
>>> registers
>>> to see if it's really 0xd9000000 or if the structure was corrupted
>>> some
>>> way)
>> I'll try to find where is the init.
The MMIO ioremap gave 0xd9000000.
There is also another ioremap (I can't remember for which member of the
struct), it gave 0xd9005000.

>>>
>>> What is the exact error in xmon ? (vector number)
>> Vector 200
>
> Ah, that's a machine check... interesting. So either the address above
> is bogus, or the card is crashed. In this later case, noaccel should
> have helped, except if, for some reason, the argument was ignored
> when setting the initial mode...
Since the address does not seem to be bogus, could it be possible that
my computer is broken in a certain way ? (bad memory...).
I'll do another noaccel check.

Brice


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
