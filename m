Message-ID: <37BC482D.7EB2A4AF@pop.agri.ch>
Date: Thu, 19 Aug 1999 20:08:50 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux-Dev <linuxppc-dev@lists.linuxppc.org>,
        kernel <x-linux-kernel@vger.rutgers.edu>
Subject: MO-Disk on PPC with 53C94 SCSI-chip
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have a LinuxPPC R5 system running on a PowerMac 7200 with the
2.2.12pre8 kernel. 
My problem is my MO-drive from HP see below for type and SCSI-Spec (it's
not SCSI-2)
I got it to work when I preformatted it under MacOS ->  partition-table, partition.
When I boot with the medium inserted the kernel recognizes the MO
without any problem.
I can create a fs on the partiton, I can read/write from/to it. BUT,
when I try to change the side of the media I get the same fs tree as on
the first side.

So I tried booting without media in to verify if it works on the clean
way. This what the dmesg says:

----
[snip]
(scsi0) <Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 14/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Warning - detected auto-termination
(scsi0) Please verify driver detected settings are correct.
(scsi0) If not, then please properly set the device termination
(scsi0) in the Adaptec SCSI BIOS by hitting CTRL-A when prompted
(scsi0) during machine bootup.
(scsi0) Cables present (Int-50 NO, Int-68 YES, Ext-68 NO)
(scsi0) Downloading sequencer code... 413 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.19/3.2.4
       <Adaptec AHA-294X Ultra SCSI host adapter>
scsi1 : 53C94
scsi : 2 hosts.
(scsi0:0:0:0) Synchronous at 20.0 Mbyte/sec, offset 8.
  Vendor: Quantum   Model: XP32150W          Rev: L912
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: HP        Model: C3324A            Rev: 5144
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi1, channel 0, id 1, lun 0
  Vendor: QUANTUM   Model: LIGHTNING 730S    Rev: 241E
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi1, channel 0, id 2, lun 0
  Vendor: SONY      Model: CD-ROM CDU-8005   Rev: 1.0j
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 3, lun 0
  Vendor: QUANTUM   Model: FIREBALL1280S     Rev: 630G
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdd at scsi1, channel 0, id 4, lun 0
  Vendor: HP        Model: C1716T            Rev: 3404
  Type:   Optical Device                     ANSI SCSI revision: 01 CCS
Detected scsi disk sde at scsi1, channel 0, id 5, lun 0
scsi : detected 1 SCSI cdrom 5 SCSI disks total.
Uniform CDROM driver Revision: 2.55
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4406960 [2151 MB] [2.2 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2354660 [1149 MB] [1.1 GB]
SCSI device sdc: hdwr sector= 512 bytes. Sectors= 1431760 [699 MB] [0.7 GB]
SCSI device sdd: hdwr sector= 512 bytes. Sectors= 2503872 [1222 MB] [1.2 GB]
sde: Spinning up
disk.......................................................................................................not responding...
sde : READ CAPACITY failed.
sde : status = 0, message = 00, host = 0, driver = 28 
sde : extended sense code = 2 
sde : block size assumed to be 512 bytes, disk size 1GB.  
eth0: MACE at 00:05:02:44:21:ad, chip revision 9.64
eth1: DE450-CA at 0x0400 (PCI bus 0, device 15), h/w address 00:00:f8:30:76:00,
      and requires IRQ25 (provided by PCI BIOS).
de4x5.c:V0.544 1999/5/8 davies@maniac.ultranet.com
Partition check:
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6
 sdc: sdc1 sdc2 sdc3 sdc4
 sdd: sdd1 sdd2 sdd3
 sde:SCSI disk error : host 1 channel 0 id 5 lun 0 return code = 28000000
[valid=0] Info fld=0x0, Current sd08:40: sense key Not Ready
Additional sense indicates Medium not present
scsidisk I/O error: dev 08:40, sector 0
 unable to read partition table
VFS: Mounted root (ext2 filesystem) readonly.
[snip]
------
 
The MO is attached to the 53c94, the behavior on the AHA is the same.
(as I tried last time)
After logging in I inserted a medium and I tried to prepare a fs. It
gave tons of errors on 53c94 which forced me to reboot due to SCSI-bus resetting.
I used pdisk to try to format the media, this is what it complained:
--
53c94: illegal cmd, intr=40 stat=83 seq=83 phase=1
scsi1 channel 0: resetting for second half of retries.
SCSI bus is being reset for host one channel 0.
53c94: illegal cmd, intr=40 stat=83 seq=83 phase=1
SCSI disk error : host 1 channel 0 id 1 lun 0 return code 27070000
scsidisk I/O error: dev 08:14, sector 2
--repeating
--

This repeats and I have to do the reboot (hard way) becomming stable
without the MO.

Has anybody of you same experiences with this type of MO under x86 Linux?
Is it an unsolvable problem due to the fact that it is a SCSI revision
01:CCS device?
Or can I hope?

Thanks for any hints, and sorry for the long post but I felt to include
this msgs to explain.


Andreas

P.S: this is the line when the media is inserted on booting

SCSI device sde: hdwr sector= 1024 bytes. Sectors= 637041 [622 MB] [0.6 GB]


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
