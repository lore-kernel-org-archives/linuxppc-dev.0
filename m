Message-ID: <39805F0A.5CE376C6@execpc.com>
Date: Thu, 27 Jul 2000 11:10:50 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: powerbook hang from post-sleep cdrom access - fix
References: <Pine.LNX.4.10.10007271407230.23151-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
> Aye. Can you be more specific about 'do whatever needs to be done'? Can I
> just send the disk a read command to wake it up? Send a reset
> command?? Will a reset command hurt if I always send a drive reset
> there?

My expirience is that just reading the drive causes a problem, much like
userspace trying to read it.  there is also the door locking feature that I
suppose could be done explicitly on wakeup if mounted.  I dont know what else a
"media change" ctl entails, but it seems to do enough to get the cdrom back to
where it left off.

> I'll try that on my Lombard to see if I can save the nasty timeout when
> the drive was powered off with hdparm -Y ?? That would help fake sleep
> mode on the Pismo, or did you implement pmu sleep/wakeup there yet?

My wallstreet has the same problem.  it has to reset the whole ide bus to get it
going again.  rather, i use hdparm -y, which just puts it in standby rather than
sleep.  When the drive does a normal hardware-timeout sleep, it seems to do
this, since it doesn't require a reset to wake up.

Last I remember, the result to when it resets the bus so it can wake up from a
-Y, the flaky 8G (DYLA) drive is set in such a way that it can then wake up
correctly from -Y. I recall that unmaskirq should be one way for the 8G, but
upon the reset, its the other way.  my current 6G (from brother's upgraded
lombard) seems to always time out in my PDQ (at wakeup, using_dma varies,
unmaskirq is always off).  judging by message log, its another lost interrupt
problem.  It would make sense.  8G - reset, regains irq, wake normally.  6G -
reset, still no irq when drive eventually wakes.

heres two sequential wakes from -Y sleep with the 6G in my PDQ

Jul 27 10:48:07 momiji kernel: hda: lost interrupt
Jul 27 10:48:07 momiji kernel: hda: dma_intr: status=0xd0 { Busy }
Jul 27 10:48:07 momiji kernel: ide0: reset: success
Jul 27 10:48:33 momiji kernel: hda: irq timeout: status=0xd0 { Busy }
Jul 27 10:48:33 momiji kernel: ide0: reset: success

sidenote, a powerbook hard drive compatibility grid can be found at
http://www01.u-page.so-net.ne.jp/ba2/nsxt/faq1E.html

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
