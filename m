Message-ID: <3F14719F.7080105@broadon.com>
Date: Tue, 15 Jul 2003 14:26:55 -0700
From: David Blythe <blythe@broadon.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] consistent_sync and non L1 cache line aligned buffers
References: <5.1.0.14.2.20030715133146.030d2e60@mail.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This discussion has been going on (off and on) for 2 years now.  The
consistent_sync routine does seem to be abused and it seems that in
practice a lot of code does fail (like the skbufs were doing 2 years
ago).  The party line has been that the path works as designed and
people are writing incorrect code.  There are two things that could be
done to improve the developers lot in life:

1) maintain the semantics, but add an assert or something to catch some
of the cases where developers are using it incorrectly rather than
allowing it fail in subtle ways.

2) change the definition to allow non-aligned addresses and handle them
gracefully

2) Would be the most pragmatic.  Doing nothing will ensure that a month
or two from now the topic will come up again and more people will have
wasted countless hours tracking down the same problem in yet another
piece of code.

	david


Eugene Surovegin wrote:
>
> At 01:18 PM 7/15/2003, Darin.Johnson@nokia.com wrote:
>
>> I solved the problem (in a non-Linux system) by just flushing the first
>> and last lines in the requested range, and invalidating the rest.  The
>> very slight performance hit is probably less than testing to see if the
>> buffer is unaligned.
>
>
> I don't think so.
>
> If you take a look at the assembler output of my patch you'll see that test
> for unaligned just accesses register, when dcbf may require memory access
> which is *significantly* slower.
>
> In majority of cases consistent_sync is called with properly aligned buffer
> and I don't want to penalize this path by *unconditionally* (as you are
> suggesting) flushing start and end of the buffer.
>
> Eugene.
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
