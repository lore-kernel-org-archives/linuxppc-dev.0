Message-ID: <000701c10782$96a31e60$0401a8c0@trex>
From: "Jeff Rugen" <jprugen@earthlink.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: RTC and SCSI for PowerStack/2.4.6 Kernel
Date: Sun, 8 Jul 2001 00:49:58 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've finally gotten a 2.4.x kernel to boot on my Motorola Powerstack (100MHz
604), but I'm having two problems.  I haven't found any info about them
searching the archives, so I'm wondering if anyone has seen/resolved the
problems I have, or can direct me to more information.

First of all, the boot hangs when executing /sbin/hwclock.  I have (or maybe
'had' now) the real-time-clock built as a module (in
drivers/macintosh/rtc.o), but the only thing I determined before commenting
out that line in rc.sysinit was that the machine hung when reaching that
point.  Is anyone successfully using the realtime clock on a Powerstack with
2.4.x, and if so, is there anything in particular that needs to be
done/patched/whatever?  /sbin/hwclock is from util-linux-2.10m-7c.

Second, I am getting SCSI timeouts when running 2.4.6.  I don't know enough
about SCSI, but the log to the console is the following:

scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 2, lun
0 0x
2a 00 00 0c 40 18 00 00 08 00
ncr53c8xx_abort: pid=0 serial_number=4257 serial_number_at_timeout=4257
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 2, lun
0 0x
2a 00 00 0c 40 48 00 00 08 00
ncr53c8xx_abort: pid=0 serial_number=4258 serial_number_at_timeout=4258
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 2, lun
0 0x
2a 00 00 0f 40 58 00 00 08 00
ncr53c8xx_abort: pid=0 serial_number=4259 serial_number_at_timeout=4259
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 2, lun
0 0x
2a 00 00 11 40 10 00 00 08 00
ncr53c8xx_abort: pid=0 serial_number=4260 serial_number_at_timeout=4260

When booting, the SCSI device is recognized as:
ncr53c8xx: at PCI bus 0, device 12, function 0
ncr53c8xx: 53c810 detected
ncr53c810-0: rev 0x2 on pci bus 0 device 12 function 0 irq 15
ncr53c810-0: ID 7, Fast-10, Parity Checking

Which leads me to believe that I at least have the correct SCSI driver build
(NCR53C8XX, as the revision of 0x2 is less than the 16 that Configure.help
seems to indicate).  Should I instead be using the 53c7,8xx driver?  Or the
sym53c8xx?

Thanks for any help.

Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
