Message-ID: <3D19DD30.87A5DB6D@synergymicro.com>
Date: Wed, 26 Jun 2002 08:26:40 -0700
From: Dave Wilhardt <wilhardt@synergymicro.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: contiguous kernel pages
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

We are observing some undesirable behavior in the way the PowerPC kernel

handles page allocation. We wrote a simple program that mallocs a 2MB
buffer
and does various read and write operations. After booting Linux we see
numbers like:

Write sequential: 673.550324 MB/S
Read sequential: 470.949462 MB/S
Write sequential: 499.278523 MB/S
Read sequential: 310.924958 MB/S
Write cache lines: 84.746262 MB/S
Read cache lines: 147.659226 MB/S
Write 2 cache lines: 87.324496 MB/S
Read 2 cache lines: 153.067388 MB/S
Write 37 words: 84.047736 MB/S
Read 37 words: 123.959971 MB/S
Random writes: 44.707562 MB/S
Random reads: 31.423328 MB/S

After running for a while (doing compiles and miscellaneous stuff), the
performance deteriorates and stays that way. When we run our program
after a
lot of system activity we see numbers like:

Write sequential: 305.289433 MB/S
Read sequential: 214.440869 MB/S
Write sequential: 369.741795 MB/S
Read sequential: 162.424933 MB/S
Write cache lines: 28.616503 MB/S
Read cache lines: 46.471531 MB/S
Write 2 cache lines: 23.170304 MB/S
Read 2 cache lines: 47.261479 MB/S
Write 37 words: 32.125045 MB/S
Read 37 words: 51.199579 MB/S
Random writes: 45.648529 MB/S
Random reads: 18.494342 MB/S

As you can see, some operations are less than 1/2 speed. We suspected
that
this was due to page fragmentation. We wrote a special driver to
"malloc"
contiguous kernel pages. When we use it the numbers do not deteriorate.

We suspect that the kernel has been optimized for a much smaller cache.
Where
should we be looking to make the kernel allocate larger contiguous
chunks of
memory? Because the PowerPc L2 is 2 way and 2MB in size, we suspect that
we
need to tell the kernel to attempt to allocate 1MB chunks of memory
whenever
possible. Any thoughts?

This behavior is the same on all PowerPC machines we have (Synergy,
Mac's, others).

Thanks,

- Dave

--
Dave Wilhardt
Synergy Microsystems


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
