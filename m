Message-Id: <v04003a01b561eb4b5a92@[24.66.67.194]>
In-Reply-To: <Pine.LNX.4.05.10006051614100.5397-100000@callisto.of.borg>
References: <200006051351.PAA19854@mcp.cpu.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 5 Jun 2000 18:49:33 -0500
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Michel Lanners <mlan@mcp.cpu.lu>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: [patch] VRAM detection in controlfb
Cc: mlan@cpu.lu, drow@false.org, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:15 AM -0500 6/5/2000, Geert Uytterhoeven wrote:
>On Mon, 5 Jun 2000, Michel Lanners wrote:
>> So I guess the optimum would be to mark the VRAM cacheable, but in a way
>>that
>> writes don't go into the cache. Would that be write-through?
>
>That's indeed write-through. Note that writes will still be cached in such a
>way that a consecutive read from the same location will return the cached
>value.  But writes will immediately be sent to the host bridge.

True enough. Is the vram genuinley behind the PCI bridge, or is it just
magically managed as a PCI resource from the main bus? If the reads and
writes don't really go through the bridge then, again, I don't see that
there would be much benefit in using a write-through cache, with perhaps
the exception of SMP.

It would atleast be worthwhile mapping it non-cached until the driver can
be proven 100% stable (well, 95% atleast) :), then turn caching back on
(write-through, of course) and see what breaks again, knowing this time
that it's definatley cache-related.


And I mean, if all else fails, stability should always prevail over speed,
right?... right?... *tumbleweed rolls by*

;)


Cheers - Tony :)


--
Tony Mantler       Renaissance Nerd Extraordinaire     nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada                     http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
