Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id E18E02BF07
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 11:53:55 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A64745A@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>
Date: Wed, 5 Jan 2005 19:53:52 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: simple bootloader 2.6.10-rc3 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

start_:

Interestingly, - as soon as I additionally defined CONFIG_FORCE in head.S
(after disabling MMU for my case 
CONFIG_60POTS) to disable I-cache, my board would not
even get to the booting level (of inflating kernel in zlib, where it
currently fails ).

Then I tried to reverse the order: first disable I-cache, then disable MMU
(I just copied assembler code that was under 
#ifdef CONFIG_FORCE to be under #if defined (CONFIG_V52) || defined
(CONFIG_60POTS) || defined (CONFIG_COMBO) but 
above # disable MMU...)  - but result again was the same... - so it looks
like that irregardless of the order this 
combination does not work ... ?

....
start_:

#ifndef CONFIG_60POTS
#define CONFIG_60POTS 1
#endif


#if defined (CONFIG_V52) || defined (CONFIG_60POTS) || defined
(CONFIG_COMBO)

# disable MMU
        sync
        mfmsr   r11
        lis     r10,0xffff
        ori     r10,r10,0xffcf
        and     r11,r11,r10
        mtmsr   r11
        isync

        lis     r11,0xfa20
        mtspr   638,r11

        lwz     r12,0x11c(r11)
        lis     r10,0xfeff
        ori     r10,r10,0xffff
        and     r12,r12,r10
        stw     r12,0x11c(r11)
#endif

#ifdef CONFIG_FORCE
        /* We have some really bad firmware.  We must disable the L1
         * icache/dcache now or the board won't boot.
         */
        li      r4,0x0000
        isync
        mtspr   HID0,r4
        sync
        isync
#endif

-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Wednesday, January 05, 2005 12:37 PM
To: Steven Rostedt
Cc: Povolotsky, Alexander; linuxppc-embedded@ozlabs.org
Subject: Re: simple bootloader 2.6.10-rc3 8xx


On Tue, Dec 28, 2004 at 12:47:57PM -0500, Steven Rostedt wrote:
> On Tue, 2004-12-28 at 12:28 -0500, Povolotsky, Alexander wrote:
> > Hi! (Thanks !) 
> > 
> > I guess I need some more education - since I am getting my problem right
at
> > the boot - is I-Cache enabled (by default ?) for 8xx on 2.6 at the
booting ? - I do not
> > see anything in .config 
> > which controls it (or I am missing it there ?) 
> > How (where and at what point during the boot)-) I could disable I-Cache
?
> 
> Since you where able to get to the prekernel portion (that was
> relocated) I don't think you have a problem with caches, unless for some
> reason the pre-kernel can relocate itself, but it doesn't know to
> refresh the cache after relocating the actual kernel.

The in-kernel bootwrapper codes does indeed relocate itself (overlap
isn't a problem either, except for a small window.  All of this can be
avoided if you link the kernel where it will be loaded into memory by
the firmware as well), but it should also do all needed cache flushing.

But as has been said before, since the CPU15 errata doesn't exist with
i-cache disabled, the simple workaround would be to disable the i-cache
as quickly as possible from the head.S portions of the in-kernel
bootwrapper and make sure we don't re-enable it later on (I _think_ we
do for speed reasons).

-- 
Tom Rini
http://gate.crashing.org/~trini/
