Date: Sun, 6 Apr 2003 01:03:42 -0800
From: Fred Gray <fegray@socrates.berkeley.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PREP RTC interrupts?
Message-ID: <20030406090342.GB18134@socrates.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear linuxppc-embedded,

I have recently taken over the development of a data acquisition system that
includes several MVME2600 and MVME2300 series processor boards, which are
members of the PREP family.  Until last week, the system ran on vxWorks, but
it was recently invaded by penguins.  The latest 2.4 devel kernel seems to
run very nicely, and I got J. Hannappel's driver for the Universe VME interface
to work with it with some effort.  (I am aware of G. Paubert's driver as well,
but the Hannappel driver is a better fit for porting our vxWorks program.)

So, here is my question: the vxWorks program includes quite a number of
busy-wait delays.  These delays are typically of order 0.1 to 1 ms,
so they are much shorter than 1/HZ but still long enough to be worth
sleeping so that relevant background tasks can run.  On the x86, the
real-time clock can be programmed to generate periodic interrupts with
frequencies up to 8192 Hz, and the /dev/rtc interface allows a user program
to wait on such an interrupt.  I have used this feature successfully.
On the PREP, the RTC does not seem to have an interrupt allocated.  I don't
know whether that is because of a fundamental hardware limitation or simply
because no one has done it yet, though.  Does anyone have suggestions on the
best way to implement a short delay on these boards?

Thanks in advance for your help,

-- Fred

-- Fred Gray / Visiting Postdoctoral Researcher                       --
-- Department of Physics / University of California, Berkeley         --
-- fegray@uclink.berkeley.edu / phone 510-642-4057 / fax 510-642-9811 --

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
