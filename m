Message-Id: <v04003a03b4eba8589635@[24.66.67.189]>
In-Reply-To: <200003080639.HAA00275@piglet.grunz.lu>
References: <20000307160835.H399@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 8 Mar 2000 01:08:36 -0600
To: mlan@cpu.lu, trini@kernel.crashing.org
From: Tony Mantler <eek@escape.ca>
Subject: Re: nvram access in 2.3.48?
Cc: chas@cmf.nrl.navy.mil, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:39 AM -0600 3/8/2000, Michel Lanners wrote:
>On   7 Mar, this message from Tom Rini echoed through cyberspace:
>[about NVRAM]
>>> > there were some posts about this about a month or so ago.
>>>
>>> Here is the essence:
>>>
>>> http://lists.linuxppc.org/listarcs/linuxppc-dev/200002/msg00079.html
>>>
>>> And to say I do read every message on this list...
>>
>> Yeah, that did it (it forgot to change the CONFIG_MAC version).  I'll pass
>> it along to BK.
>>
>> I still think it would be a good idea to try and merge the two macintosh
>>nvram
>> drivers into one tho.
>
>Be careful; isn't the one in drivers/macintosh needed by the M68K port?

Don't think so. Unless nvram is just a curiously renamed and retasked pram,
which I seem to recall it isn't, then 68k macs don't even have it.

The pram/rtc, by the way, is accessed on 68k macs by either some VIA
register twiddling, or by IIsi, PMU or CUDA style adb, so if you see any
refrences to that code anywhere, don't break it. :)


By the way, if you get rid of the nvram.c in drivers/macintosh, then it
would probably be fruitful to entirely disband the directory. I don't have
a 2.3 source tree handy, but I seem to recall that the 68k serial driver
was merged with the PPC serial driver a little bit back, and belongs most
sensibly in drivers/char anyways, adb probably belongs in a drivers/adb
directory so the NeXT port people need not associate with those icky macs
;), and after all that's gone there's not much of anything left in
drivers/macintosh that can't be moved elsewhere.


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
