Mime-Version: 1.0
Message-Id: <v04220800b65b752a7944@[10.0.0.42]>
In-Reply-To: <B65A6D8D.4932%shiloh@ comtechmobile.com>
References: <B65A6D8D.4932%shiloh@ comtechmobile.com>
Date: Mon, 11 Dec 2000 22:51:40 -0800
To: Shiloh Heurich <shiloh@comtechmobile.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Ultra/160 SCSI
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:39 AM -0500 12/11/00, Shiloh Heurich wrote:
>What is the current compatibility status of Linux (either 2.2.18 or 2.4.0)
>with Ultra/160 SCSI hardware (both cards and hard drives)?

All that matters is driver support for the card.  As long as a stable
driver exists and it has no endianness or PCI initialization problems
on PPC, it should work.  The only way the exact drive you use could
matter is if there is some interaction (read: bug) between a specific
controller and drive which must be worked around in the kernel's card
driver.

I've been successfully using an Adaptec 39160 with the PPC bitkeeper
2.2.18preX tree.  The universal Adaptec driver (aic7xxx) has been
working well on PPC for a long time; the only recent problems have
been the occasional failure to recognize and use a card, but these
are due to generic problems with PCI init code on PPC.  And it's an
all-or-nothing kind of problem: if you had it, you'd not be able to
use the card at all.

>The question comes about because I am currently running Linux/PPC (Yellow
>Dog CS 1.2.1 / Linux 2.4.0-test11 [rsync from penguinppc::linux-pmac-devel])
>on a B/W G3/350 with an Adaptec AHA-29160 card and a Quantum Atlas V 9GB
>Ultra/160 drive.  I have used the same SCSI card with other drives (not
>U160, but U2W drives) in the past with no problems; however, I have been
>experiencing intermittent SCSI problems with this current setup.

Have you considered whether it's really a software problem?  Your
cabling and/or terminator might be damaged or not up to spec.  This
is definitely something to look at since you've only used your setup
with U2W drives in the past.  Ultra 160 is naturally more demanding
of cabling than U2.

>(In case you are wondering, this is an x86 'PC' version of the Adaptec 29160
>card.  However, my experience has been that the x86 versions of the Adaptec
>cards work fine in a PPC, with the exception that you can not boot from a
>device on the card, since it does not have Open Firmware support.  If my
>logic or thinking in this matter is incorrect, please let me know.)

AFAIK this is correct.  The only thing I can think of is that some
cards might need to execute some OF fcode stored in their firmware
for correct initialization, but even then once the kernel is running
the driver should be able to perform any fixups required.

>The messages log shows entries as follows:
>----------------------------------------------------
>Dec 11 10:48:51 stan kernel: scsi : aborting command due to timeout : pid 0,
>scsi0, channel 0, id 0, lun 0 0x28 00 00 92 4f 80 00 00 0e 00
>Dec 11 10:48:52 stan kernel: SCSI host 0 abort (pid 0) timed out - resetting
>Dec 11 10:48:52 stan kernel: SCSI bus is being reset for host 0 channel 0.
>Dec 11 10:48:53 stan kernel: SCSI host 0 channel 0 reset (pid 0) timed out -
>trying harder
>Dec 11 10:48:53 stan kernel: SCSI bus is being reset for host 0 channel 0.
>Dec 11 10:48:56 stan kernel: (scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec,
>offset 63.
>Dec 11 10:49:26 stan kernel: scsi : aborting command due to timeout : pid 0,
>scsi0, channel 0, id 0, lun 0 0x2a 00 00 79 04 fe 00 00 02 00
>----------------------------------------------------
>
>When the machine starts encountering these errors, I am unable to initiate
>disc activity or even run 'ps' on the machine (things start to hang).  The
>only recourse at that point is to physically reset the machine - not a
>pleasant thing to do to a Linux box!

Aborts and channel resets in the logs are usually symptoms of a flaky bus...

>As an aside, you will notice that even though I am using an Ultra/160 card
>and drive, the bus speed is given as 80.0 MB/s (although it is still a
>pretty fast setup -- hdparm show read/write speeds of 28 MB/s).

Ultra 160 has a feature called "domain validation" which checks bus
integrity during initialization and will reduce the clock frequency
of the bus as necessary to avoid data corruption.  If I'm right about
it being a flaky bus problem, the card and drive may be negotiating
down to a lower clock rate (evidently not low enough).

For what it's worth, here's a chunk of my boot log showing that the
aic7xxx driver recognizes a card very similar to yours and
successfully negotiates U160 speed with some drives:

(scsi0) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 1/3/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
(scsi1) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 1/3/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
        <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
        <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi : 2 hosts.
(scsi0:0:0:0) Synchronous at 160.0 Mbyte/sec, offset 63.
   Vendor: SEAGATE   Model: ST39204LW         Rev: 0002
   Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:0:1:0) Synchronous at 160.0 Mbyte/sec, offset 63.
   Vendor: SEAGATE   Model: ST39204LW         Rev: 0002
   Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
(scsi0:0:2:0) Synchronous at 160.0 Mbyte/sec, offset 63.
   Vendor: SEAGATE   Model: ST39204LW         Rev: 0002
   Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdc at scsi0, channel 0, id 2, lun 0
scsi : detected 3 SCSI generics 3 SCSI disks total.


   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
