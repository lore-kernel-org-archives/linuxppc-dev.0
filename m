Message-ID: <20040304143448.95898.qmail@web10603.mail.yahoo.com>
Date: Thu, 4 Mar 2004 06:34:48 -0800 (PST)
From: sudhakar rajashekhara <rsudhakar_blr@yahoo.com>
Subject: Serial ATA driver problem
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

We have ported u-boot and linux-2.4.22 on to a custom
POwerPC MPC8280 board. Everything is working fine
except the Serial ATA driver. We are using SATA150
Tx2plus serial ata card which sits on PCI. We got the
driver source code from the public domain. We have
integrated the driver source code to the kernel and
driver module loads itself when linux kernel is coming
up. As soon the module is loaded we get a device
information string as "aMtxro6 0Y080M". (We have
tested the same driver on a x86 machine and there the
driver works perfectly and the device identification
string got there is "Maxtor 6Y080M0".) After this the
board comes up correctly. When we try to partition the
device using the fdisk command (fdisk /dev/sda), we
get the following errors:

=======================================================
# fdisk /dev/sda
pdc-ultra:[warning] disk1 ATA timeoutat LBA 0x0
        pdc-ultra:[warning] submit cam busy
scsi : aborting command due to timeout : pid 10,
scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00
00 08 00
pdc-ultra:[info] scsi abort success
pdc-ultra:[warning] disk1 ATA timeoutat LBA 0x0
        pdc-ultra:[warning] submit cam busy
scsi : aborting command due to timeout : pid 11,
scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00
00 08 00
pdc-ultra:[info] scsi abort success
pdc-ultra:[warning] disk1 ATA timeoutat LBA 0x0
        pdc-ultra:[warning] submit cam busy
scsi : aborting command due to timeout : pid 12,
scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00
00 08 00
pdc-ultra:[info] scsi abort success
scsi0 channel 0 : resetting for second half of
retries.
SCSI bus is being reset for host 0 channel 0.
pdc-ultra:[warning] scsi reset channel1 OK
pdc-ultra:[warning] disk1 ATA timeoutat LBA 0x0
        pdc-ultra:[warning] submit cam busy
scsi : aborting command due to timeout : pid 13,
scsi0, channel 0, id 0, lun 0 0x28 00 00 00 00 00 00
00 08 00
pdc-ultra:[info] scsi abort success
pdc-ultra:[warning] disk1 ATA timeoutat LBA 0x0
        pdc-ultra:[warning] submit cam busy
SCSI disk error : host 0 channel 0 id 0 lun 0 return
code = 27070000
 I/O error: dev 08:00, sector 0
        pdc-ultra:[warning] submit cam busy
        pdc-ultra:[warning] submit cam busy
scsi0 channel 0 : resetting for second half of
retries.
SCSI bus is being reset for host 0 channel 0.
pdc-ultra:[warning] scsi reset channel1 OK
        pdc-ultra:[warning] submit cam busy
        pdc-ultra:[warning] submit cam busy
        pdc-ultra:[warning] submit cam busy
SCSI disk error : host 0 channel 0 id 0 lun 0 return
code = 27070000
 I/O error: dev 08:00, sector 2
        pdc-ultra:[warning] submit cam busy
        pdc-ultra:[warning] submit cam busy
scsi0 channel 0 : resetting for second half of
retries.
SCSI bus is being reset for host 0 channel 0.
pdc-ultra:[warning] scsi reset channel1 OK
        pdc-ultra:[warning] submit cam busy
        pdc-ultra:[warning] submit cam busy
        pdc-ultra:[warning] submit cam busy
SCSI disk error : host 0 channel 0 id 0 lun 0 return
code = 27070000
 I/O error: dev 08:00, sector 4
        pdc-ultra:[warning] submit cam busy
        pdc-ultra:[warning] submit cam busy
scsi0 channel 0 : resetting for second half of
retries.
SCSI bus is being reset for host 0 channel 0.
pdc-ultra:[warning] scsi reset channel1 OK
        pdc-ultra:[warning] submit cam busy
        pdc-ultra:[warning] submit cam busy
        pdc-ultra:[warning] submit cam busy
SCSI disk error : host 0 channel 0 id 0 lun 0 return
code = 27070000
 I/O error: dev 08:00, sector 6

Unable to read /dev/sda
#
=======================================================
During kernel compilation we have selected the SCSI
support and SCSI Disk support. Apart from these do we
have to select any other configuration during
menuconfig? If anyone has any idea as what is causing
this problem, please help.

regards,
Sudhakar.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
