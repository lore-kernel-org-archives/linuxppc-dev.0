Message-Id: <200106290009.f5T09C823337@stimpy.networkrobots.com>
Date: Thu, 28 Jun 2001 17:13:20 -0700
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
From: Paul White <pwhite@networkrobots.com>
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
Cc: jtm@smoothsmoothie.com, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.95.1010628062229.5112E-100000@november.bhjjh.er
 ols.com>
References: <200106281622.f5SGMW810376@stimpy.networkrobots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Justin,

I was able to get Data cache disabled today, after playing around with it
for a while.

There were several things I had to do.  Now, I don't recall what CPU you
are using, so I'll just tell you what I found with mine.

First off, I'm using the 7410, which has 32 byte cache lines.  Note that the
8xx and such have 16 byte cache lines.  In my manual, under "Enabling
and Disabling Data Cache", it states that the dcbz instruction will cause an
alignment exception, and that all others are nop'd.  So the first thing I did,
was search for dcbz throughout my code, and I found two files that had
several matches:

arch/ppc/kernel/misc.S

Line 380:
Inside clear_page.  Here, I commented out the dcbz line, and added more
of the stw lines to clear 32 bytes (it was set to only do 16, as on the 8xx
its
only 16 bytes):
//#ifdef CONFIG_8xx
        li      r4, 0
1:      stw     r4, 0(r3)
        stw     r4, 4(r3)
        stw     r4, 8(r3)
        stw     r4, 12(r3)
        stw     r4, 16(r3)
        stw     r4, 20(r3)
        stw     r4, 24(r3)
        stw     r4, 28(r3)
//#else
//1:    dcbz    0,r3
//#endif

Line 426:
Inside copy_page.  I left this one alone, as this one is called after Linux is
running normally and the exception handler catches it.  Note that the
exception handler detects it was just a dcbz w/ data cache disabled, and
returns normally.  Doesn't kernel panic.

arch/ppc/lib/string.S

Line 170:
Inside cacheable_memzero, this one is called from MMU_init() where
exceptions aren't enabled yet, so this one must be commented out,
and changed to store 0's in its place, as such:
        li      r7,4
//#if !defined(CONFIG_8xx)
//10:   dcbz    r7,r6
//#else
10:     stw     r4, 0(r6)
        stw     r4, 4(r6)
        stw     r4, 8(r6)
        stw     r4, 12(r6)
        stw     r4, 16(r6)
        stw     r4, 20(r6)
        stw     r4, 24(r6)
        stw     r4, 28(r6)
//#endif

Line 279:
Inside cacheable_memcpy.  This one is also called after Linux is running
normally, so I left this one alone as the exception handler catches it.

Line 483:
Inside copy_tofrom_user.  This one, I just needed to comment out:
//#if !defined(CONFIG_8xx)
//      dcbt    r3,r4
//      dcbz    r11,r6
//#endif


After doing this, I then edited arch/ppc/mm/init.c
Changed the RAM_PAGE define to:

#define RAM_PAGE (_PAGE_RW | _PAGE_NO_CACHE )

Then, in setbat() where it says "make IBAT same as DBAT":
               } else {
                        /* make IBAT same as DBAT */
                        bat[0] = bat[1];
                }

I changed this to:
               } else {
                        /* make IBAT same as DBAT */
                        bat[0] = bat[1];
                        bat[0].word[1] &= ~(_PAGE_NO_CACHE);
                }

This allowed Instruction cache to work still.

After this, I then wanted to be really sure data cache was disabled, so I
edited
arch/ppc/kernel/head.S:

Inside enable_caches, I changed the line:
	ori	r11,r11,HID0_DCE|HID0_ICE

to:
	ori	r11,r11,HID0_ICE

This just never enabled data cache, and everything worked fine (but slowly!).

Hope this information helps...  Eventually I'll work up a patch with
something like
CONFIG_NO_DCACHE, and maybe even CONFIG_WRITE_THRU on the cache
and e-mail them out.

Paul W.



At 06:43 AM 6/28/2001 -0400, Justin (Gus) Hurwitz wrote:
>
>Hrm... well, that's not the answer that I wanted, but it does explain a
>lot :-/
>
>It sounds like you know a lot more about what's going on here, Paul, but
>since it sounds like we're in the same boat, I'm more than willing to help
>in whatever way I can (especially since I have nothing better to do until
>I get the ethernet controller working, and that just isn't happening
>without this fixed :)
>
>And thanks for the heads up that setting PAGE_NO_CACHE doesn't work- I'd
>just tried disabling caches entirely and was about to go in and start
>mucking with lower level things- starting with a BAT entry :)
>
>Back to the debugger...
>--Gus
>
>On Thu, 28 Jun 2001, Paul White wrote:
>
>>
>> Justin,
>>
>> >From my recent experience, this does not work.  We have a device on our
>> PCI bus which is DMAing to SDRAM, and so far I can't get anything to
>> work without cache coherency support in the system controller.
>>
>> If you find anything out, please let me know.  I may end up adding a new
>> memory queue for non-cacheable memory, and just use another BAT entry
>> for some pre-defined amount of memory for a non-cacheable pool.  A new
>> flag to kmalloc() could then be used to get non-cacheable memory.  Does
>> anyone know if anything like this already exists, or if theres a much
>> easier way around this??  I should hopefully get cache coherency
>> working, but we have been unable to so far.  If I end up doing the work,
>> I"ll post the patches here.
>>
>> Btw..  I attempted to disable cache, as well as simply set the RAM bat's
>> to PAGE_NO_CACHE, however this does not work because the PowerPC will
>> throw alignment exceptions whenever a cache instruction is called on
>> either a non-cached memory region, or if caching is disabled.  Just
>> wanted to give you a heads up on this.
>>
>> Paul W.
>>
>>
>> At 04:52 AM 6/28/2001 -0400, Justin (Gus) Hurwitz wrote:
>> >
>> >Did yo ever get a reply to this? That sounds like just what I want to do
>> >(well, it sounds just like what our vxworks code does to do what I want to
>> >do, which I guess is good enough).
>> >
>> >TIA,
>> >--Gus
>
>
>
-------------------------------------------------------------
Network Robots, Inc.         /--\               Paul H. White
                           / ____ \
4695 Chabot Dr. #200      / ( oo ) \       Software Developer
Pleasanton, CA 94588     /   ----   \             Engineering
(925) 924-8600           \   ----   /          (925) 580-4883
                          \  V--V  /
                           \      /
                             \--/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
