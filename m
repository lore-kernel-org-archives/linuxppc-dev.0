Date: Mon, 11 Dec 2000 11:39:58 -0500
Subject: Ultra/160 SCSI
From: Shiloh Heurich <shiloh@comtechmobile.com>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B65A6D8D.4932%shiloh@ comtechmobile.com>
In-Reply-To: <200012110559.XAA04206@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What is the current compatibility status of Linux (either 2.2.18 or 2.4.0)
with Ultra/160 SCSI hardware (both cards and hard drives)?

The question comes about because I am currently running Linux/PPC (Yellow
Dog CS 1.2.1 / Linux 2.4.0-test11 [rsync from penguinppc::linux-pmac-devel])
on a B/W G3/350 with an Adaptec AHA-29160 card and a Quantum Atlas V 9GB
Ultra/160 drive.  I have used the same SCSI card with other drives (not
U160, but U2W drives) in the past with no problems; however, I have been
experiencing intermittent SCSI problems with this current setup.

(In case you are wondering, this is an x86 'PC' version of the Adaptec 29160
card.  However, my experience has been that the x86 versions of the Adaptec
cards work fine in a PPC, with the exception that you can not boot from a
device on the card, since it does not have Open Firmware support.  If my
logic or thinking in this matter is incorrect, please let me know.)

The messages log shows entries as follows:
----------------------------------------------------
Dec 11 10:48:51 stan kernel: scsi : aborting command due to timeout : pid 0,
scsi0, channel 0, id 0, lun 0 0x28 00 00 92 4f 80 00 00 0e 00
Dec 11 10:48:52 stan kernel: SCSI host 0 abort (pid 0) timed out - resetting
Dec 11 10:48:52 stan kernel: SCSI bus is being reset for host 0 channel 0.
Dec 11 10:48:53 stan kernel: SCSI host 0 channel 0 reset (pid 0) timed out -
trying harder
Dec 11 10:48:53 stan kernel: SCSI bus is being reset for host 0 channel 0.
Dec 11 10:48:56 stan kernel: (scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec,
offset 63.
Dec 11 10:49:26 stan kernel: scsi : aborting command due to timeout : pid 0,
scsi0, channel 0, id 0, lun 0 0x2a 00 00 79 04 fe 00 00 02 00
----------------------------------------------------

When the machine starts encountering these errors, I am unable to initiate
disc activity or even run 'ps' on the machine (things start to hang).  The
only recourse at that point is to physically reset the machine - not a
pleasant thing to do to a Linux box!

As an aside, you will notice that even though I am using an Ultra/160 card
and drive, the bus speed is given as 80.0 MB/s (although it is still a
pretty fast setup -- hdparm show read/write speeds of 28 MB/s).

Any thoughts?

--
Shiloh Heurich
Senior Software Engineer
Comtech Mobile Datacom Corporation

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
