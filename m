Date: Mon, 20 Oct 2003 12:11:13 -0500
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Odd problem with 2.4 backport of radeon driver
From: Ken Offer <koffer@arlut.utexas.edu>
To: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
Message-Id: <684DF574-0320-11D8-8EDF-000393467F1A@arlut.utexas.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I've been trying to backport parts of the 2.6 radeon driver into the
2.4 radeon driver in an effort to support the 15" Powerbooks.  The chip
in question is the Radeon Mobility 9600 (i.e. chip set 0x4e50, RV350 NP
in the driver).

I'm *almost* there, but I got stuck.  A large portion of the lines on
the screen are garbled... but strangely, not ALL of them.

Under X11, it looks like the top 20 lines are OK, and the bottom 40% of
the screen is OK, but the rest looks like the "row bytes" are incorrect
for those lines.  In text-console mode, all the screen is garbled
except for the top few lines.

When I move the pointer over the garbled area, I can see several copies
of the cursor spread out across the screen, interlaced with other
garbage.  I'm not sure why the chipset would know the line lengths
correctly for part of the screen and not all of the screen.

Any ideas as to why only part of the screen would be off like that?
I've put in bunches of print statements in both the 2.4 and 2.6
kernels, but I have yet to find the culprit.  Something must be
different, but I'm not familiar enough with the chipset to know what it
is just yet.

P.S. -

The 2.6 radeon driver is radically different.  It took me a while to
figure out the current 2.6 driver had moved (i.e. was in
"drivers/video", now in "drivers/video/aty" with an older copy still at
the old location).  I've even played around with trying to copy the new
driver directly into the 2.4 kernel, but I ran into grief because of
undefined 2.6 calls.

+--------------------------------------------------------------+
| Ken Offer                               Office: 512-835-3859 |
| Email: koffer@arlut.utexas.edu             Fax: 512-835-3259 |
| Applied Research Laboratories, University of Texas at Austin |
+--------------------------------------------------------------+


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
