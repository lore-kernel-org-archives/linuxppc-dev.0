Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011700b479adc20511@[216.164.138.53]>
In-Reply-To: <Pine.SGI.4.10.9912081721580.155726-100000@brule.borg.umn.edu>
References: <384EF3D1.DFC1D281@jlc.net>
Date: Sun, 12 Dec 1999 14:56:16 -0500
To: Grant Erickson <grant@lcse.umn.edu>
From: Noah Misch <nmisch@erols.com>
Subject: Re: PPC Cache Flush and Invalidate Routines
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>On Wed, 8 Dec 1999, Dan Malek wrote:
>> Grant Erickson wrote:
>> > In trying to accomodate the 4xx-based code into the Linux kernel, I've
>> > encountered an issue which relates to the cache flushing and invalidation
>> > routines in misc.S.
>> >
>> > Thoughts, opinions?
>>
>> We could simply create a configuration #define for the cache line size
>> that is assigned in the 'make config' scripts when the processor type
>> is chosen.
>
>In general, I like that idea; however, the 4xx messes things up.
>
>I'd like to have a kernel that will boot on any 4xx-based board (maybe or
>maybe not realistic), so because the 403 uses 16 byte lines and the 405
>uses 32 byte lines, I need a dynamic solution such as the one Gary
>suggested.

Instead of stuff like this:

#ifdef CONFIG_403
...
#endif

you could write the code like this:

if(CONFIG_403) {
...
}

and then remove it with optimization when you wanted to make the slimmest
possible kernel.  Otherwise, don't optimize and it will run on both boards.


>

Noah Misch
nmisch@erols.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
