Message-ID: <20010205023918.21795.qmail@kunk.jriver.com>
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in
To: linuxppc-dev@lists.linuxppc.org
Date: Sun, 4 Feb 2001 20:39:18 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Michael Schmitz said:

> Disconnect and reselect are implemented in the ESP driver which was used
> as template for the 68k Mac 53C9x driver at one time. Maybe take a
> page or two from these drivers to implement disconnect. That driver uses a
> trick that might help avoiding the data direction lockup with MESH as
> well: the chip is programmed for the whole arbitration/selection/command
> phases but will interrupt right before data phase, at which point you
> could check the data direction before setting up the DMA (assuming the
> target asserts the data direction after seeing the command byte). One
> additional interrupt taken. No additional overhead if you skip this step
> for some well known commands like WRITE_* and READ_* :-)

This data direction table thing rings a bell. I helped implement a
scsi driver on SVR4 for the DPT (EATA) and it had the tables.
By SVR4.2 they were gone.

I noticed the same problems as Daniel writing dao CD's on my 7500.
I have the hard drive on the mesh and the tape drive and cdrw on
the 53c94.

In a post about 6 months ago I noted that the 53c94 didn't appear to
do disconnect because I couldn't write a CD even at 1x on a 7200.

As expected though, the cdrw will write on the 7500 on the 53c94
(not in dao) because the hard drive being on the mesh doesn't have to
wait for the 53c94 cd data transfer to finish before doing another read.

The tape drive was another clue. It did endless start/stops on the
7200 53c94 but on the 7500 53c94 by itself, streams nicely.

Thanks Daniel for digging this stuff out. A fix for the 53c94
disconnect problem would sure make the 7200 a  better platform.

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
