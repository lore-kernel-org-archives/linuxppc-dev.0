Date: Sat, 26 Apr 2003 22:51:43 +0200
Subject: Re: ibook2r2 & strange freeze.
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: "Linuxppc-Dev@Lists.          " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Brice Figureau <brice@tincell.com>
In-Reply-To: <1051389314.1829.37.camel@gaston>
Message-Id: <E31EF083-7828-11D7-9243-0003939D5F18@tincell.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday, April 26, 2003, at 10:35 PM, Benjamin Herrenschmidt wrote:
> On Sat, 2003-04-26 at 22:22, Brice Figureau wrote:
>> On Saturday, April 26, 2003, at 12:33 PM, Benjamin Herrenschmidt
>> wrote:
>>>
>>>> After several hours of kernel compiling (my ibook is not that fast
>>>> ;-)), I found that the latest working patch is -ben8.
>>>> The first non working is then -ben9.
>>>
>>> Great, many thanks. That will help.
>>>
>>> Can you try now to put drivers/video/radeonfb.c from -ben8 into
>>> -ben9 (and then -ben10 if it works) and tell me if that helps ?
>> Here is the results:
>>   -ben9 with -ben8 radeon crashes exactly at the same place
>>   -ben10 with -ben8 radeon crashes exacctly like -ben9
>
> That's weird since you say using no video driver (that is offb) seems
> to cure the problem and the backtrace tend to show an fbcon problem,
> but there is nothing different in the fbcon layer afaik.
The pc was in fbcon_radeon_bmove, so even if it's a fbcon problem, the
crash is happening into the radeonfb module...
video=ofonly works fine because it does not use fbcon_radeon_bmove I
guess...

> So there is probably some memory corruption going on... I'm comparing
> other bits of ben8 and ben9 now and see nothing relevants. The changes
> where in the cache flush affecting cpufreq and sleep, and radeonfb...
Since the crash occurs in the scoll, if there is a problem with the
font (corrupted font or something) the scroll computation might be
wrong, and thus fbcon_radeon_bmove might copy some memory from/to a bad
area.

>> Just to remind you:
>>   -ben9 crashes always at the same place (and triggers xmon, have a
>> look
>> at the backtrace)
>>   -ben10 freezes randomly, usually in the boot process. It freezes
>> often
>> right after the font uploading to the console layer, but sometimes
>> farther (I once could go until the network started). When it freezes
>> the last line at the bottom of the screen is printed *twice* (which
>> might confirm the -ben9 backtrace).
>>
>> All the tested kernels were configured with CONFIG_PPC_RTC enabled
>> (and
>> CONFIG_RTC disabled), and CONFIG_CPU_FREQ disabled too.
>>
>> noaccel parameters didn't seem to change anything. I might have to
>> check again.
>
> Just in case, the proper syntax in yaboot.conf is:
>
> append="video=radeon:noaccel"
Yes I know, it was just shorter to write noaccel in my mail ;-)

> The backtrace seem to indicate something wrong with fbcon_scroll,
> though
> I fail to see what/why, I suspect something else is causing it to die.

> With xmon, can you do:
>
> di %pc
>
> and then
>
> r
>
> So I can have a better idea of what it's doing. It's probably using
> a pointer that got overwritten, but the actual cause of the corruption
> can be completely elsewhere in the kernel. It may also be present in
> earlier kernels and happen to corrupt some other harmless bit of memory
> in them... Unfortunately, this one may be difficult to track down.
Unfortunately those bugs are the most difficult to find and fix.
What I could do is disable some part of the -ben9 patch in favor of the
-ben8 version, until I find in which part it happens.

I'll let you know what I found.
Thanks,

Brice


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
