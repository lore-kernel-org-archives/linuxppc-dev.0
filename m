Message-Id: <3.0.5.32.19990713083902.0080d910@mailhost.bulldog.com>
Date: Tue, 13 Jul 1999 08:39:02 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Joe Julicher <joe_julicher@macktrucks.com>
Subject: Interesting Beige G3 Storage Stuff
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

Here are a few storage related problems I have encountered.  Nothing a show
stopper but certainly interesting.  If it is somthing I am doing wrong
somebody please enlighten me.

About my G3
Beige G3 Overclocked to 292/83/146 (CPU/BUS/CACHE)
Rage 2+ and 6mb SGRAM with AV daughter card
160 MB RAM
14GB IBM GXP drive (7200 rpm ATA-33)
LinuxPPC R5

First:
IDE HD.  The drive gives > 12mb/sec under MacOS.  Runs great and I have
used it to record movies at 30fps.  Not bad.  However, under linux a hdparm
-t /dev/hda gives 1.96mb/s  If I do a hdparm -T /dev/hda (to measure cache
performance) it gives 64mb/s.  The drive speed seems VERY slow using this
simple benchmark.  I would expect much better.  There are parameters to
adjust with hdparm, but I haven't messed with them.

Second:
MESH.  I have a SCSI chain that includes the following devices.
Exabyte 8200 8mm tape drive
Apple CD 400 (pull from 7100)
Quantum 40mb (pull from NeXT cube, was originally a swap drive!)

The kernel probes the ID's correctly and establishes a sync connection to
each except for the Exabyte tape drive.  Later when the kernel probes for
partitions on the 40mb drive, it times out and eventually reboots.  I
haven't recorded the information in the big MESH dump that is provided.  If
somebody wants that, I will get it.

I swapped the 40mb with a 250mb Quantum (pull from 7100).  This establishes
a sync connection at 10mb/s and runs great.  I don't mind ditching the 40mb
but I would like to understand the problem.  It seems that the MESH driver
could still use some work OR, I need to recompile a kernel that does not do
sync. transfers.  Perhaps I need to blacklist this 40mb drive.  Is there a
no-sync blacklist?

Thanks,
Joe Julicher

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
