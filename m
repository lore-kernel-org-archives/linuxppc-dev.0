Message-Id: <5.1.0.14.0.20020517085301.02c5d1f8@sgss.com>
Date: Fri, 17 May 2002 08:55:25 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Dean McBride <dmcbride@sgss.com>
Subject: kernel BUG at page_alloc.c:191!
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Anyone have any ideas what would cause the following kernel crash?
Note this problem doesn't occur all the time, or in a consistent fashion!
I have seen the problem 3 different times the past couple days in my
testing.  Here's what's spit out to the console window.  Unfortunately this
is an embedded system with no disk, do I don't have any system log files,
just what is printed out to the console.

kernel BUG at page_alloc.c:191!

    &

kernel BUG at page_alloc.c:191!
Kernel stack overflow in process de7c8000, r1=de7c86f0
Kernel stack overflow in process c0898000, r1=c0898760

I'm running on a VQG4 system with 4-7400 G4's, 512 Mbytes
of RAM & 2Mbytes of cache per processor.  I'm running Linux
version 2.4.10-pre10.

I've seen references to the same problem on other x86 machines
suggesting to run memtest86 to check out memory.  Is there a tool
similar to this for a PPC?  I didn't see any solutions for the problem
either ;(

I have 2 processes that are reading & writing data to an PMC ADC/DAC
card.  When the driver is loaded it initially allocates 3 MBytes of memory
at initialization.  The test do cause high interrupt rates (approximately
~12,000 interrupts per second).  In the test data I have collected,
the read/write processes do get moved around on the various CPU's but
interrupts always seem to be handled by CPU 0.  Both processes are setup
for Real-time RR scheduling (if you call it that), at a priority of 1.

I don't know if any of this information will help, but any feedback,
suggestions
will be greatly appreciated!!!

Thank you for your Help!
Dean


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
