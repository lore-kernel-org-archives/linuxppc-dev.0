Message-Id: <5.1.0.14.2.20030715133146.030d2e60@mail.ebshome.net>
Date: Tue, 15 Jul 2003 13:39:19 -0700
To: Darin.Johnson@nokia.com
From: Eugene Surovegin <ebs@ebshome.net>
Subject: RE: [RFC] consistent_sync and non L1 cache line aligned buffers
Cc: <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <F0B628F30F48064289D8CCC1EE21B7A80C48A5@mvebe001.americas.n
 okia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 01:18 PM 7/15/2003, Darin.Johnson@nokia.com wrote:

>I solved the problem (in a non-Linux system) by just flushing the first
>and last lines in the requested range, and invalidating the rest.  The
>very slight performance hit is probably less than testing to see if the
>buffer is unaligned.

I don't think so.

If you take a look at the assembler output of my patch you'll see that test
for unaligned just accesses register, when dcbf may require memory access
which is *significantly* slower.

In majority of cases consistent_sync is called with properly aligned buffer
and I don't want to penalize this path by *unconditionally* (as you are
suggesting) flushing start and end of the buffer.

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
