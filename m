Message-Id: <38EF50E4.872D76ED@w-d.org>
Date: Sat, 08 Apr 2000 11:32:16 -0400
From: John Doty <jpd@yami.w-d.org>
Reply-To: jpd@yami.w-d.org
Mime-Version: 1.0
Cc: rshaw@linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Blue & White & SCSI & Ultra 2 SCSI & Kernel > 2.2.10 -> No Disks
Content-Type: text/plain; charset=iso-2022-jp; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


My Yosemite G3 (Rev 2) has *two* SCSI cards: an Adaptec 2930CU, and an
Adaptec 2940U2B (Ultra 2 Wide). Last summer, my son Matt (who
occasionally posts here on comp.os.linux.powerpc) set it up as a
LinuxPPC machine with a 2.2.10 kernel from Robert Shaw's site.  As a
compute/file server, it has been great.

However,  attempts to upgrade to a more recent kernel invariably
encountered SCSI problems. The most common symptom was an inability to
mount the root  filesystem.

We have finally gotten partway to the bottom of this. Apparently, if the
2930 controller is present the kernel cannot find the 2940 controller
(and the 2940 has the disks on it). With the 2930 pulled (I don't really
need it the way I'm currently using the system), SCSI works fine with
the newer kernels.

Finding this took quick eyes, as the evidence scrolls off the screen
before failure is obvious , but you can't do a dmesg until you're up.

Matt also speculated that it had to do with the slot order of the
controllers, so I switched them. That didn't help: the kernel still only
found the 2930.

I'm now running a Yellow Dog 1.2 system.

I think the lesson to be learned here is that if your machine is loaded
up with optional hardware, it might make sense to strip it down to
something simpler if you encounter problems.

--
John Doty  "You can't confuse me, that's my job."
Home: jpd@w-d.org
Work: jpd@space.mit.edu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
