Message-Id: <v04003a17b876b6e2a882@[24.70.162.28]>
In-Reply-To: <E16TySf-000098-00@piglet.grunz.lu>
References: <Pine.LNX.4.43.0201241431430.29327-100000@andromeda.dsdk12.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 25 Jan 2002 01:26:08 -0600
To: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Re: Radeon DRI support patch
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:59 PM -0600 1/24/02, Michel Lanners wrote:
[...]
>By chance, this would not be something comparable to what has been
>discovered for the athlon processor under linux recently? Namely cache
>coherency problems between processor and AGP.
>
>>From what I understood (which may be wrong ;-) AGP gart is non-coherent
>(by design?) . So, if the processor has a _cacheable_ mapping for the
>same memory as the AGP card also has, there can be coherency problems if
>the (valid) data in the processor's cache is modified by the AGP card
>before the processor writes the cache line back to memory.
>
>It was also mentioned that the erronous behaviour was related to
>speculative writes, which are also use on the PPC processors.
>
>Just a shot in the dark...

It's not the speculative write that kills the athlon, it's the fact that
the incomplete speculative write dirties the otherwise clean cache line,
which then gets written back unmodified somewhere down the road.

Caching non-coherent segments should be safe-ish so long as you:

1: Write a full cache line, and always a full cache line.
2: Always flush sequentially after writing.
3: Always invalidate sequentially before reading.

The athlon's speculative writes would violate rules #1 and #2. If the PPC
dirties the cache line on it's incomplete speculative writes, then it also
violates the same rules. (Does it? Anyone?)

Of course, if the code itself violates these rules, then all hell breaks
loose. :)

Indeed the simple solution is to turn off caching on AGP-mapped pages.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
