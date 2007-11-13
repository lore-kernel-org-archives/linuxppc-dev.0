Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 0E470DDE39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 21:29:16 +1100 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	C4F7D1000A16for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 11:29:06 +0100 (CET)
Message-ID: <47397C70.9000106@fz-juelich.de>
Date: Tue, 13 Nov 2007 11:29:04 +0100
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: MTD Devices
Content-Type: text/plain;
	charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi again,

i have some problems to copy a cramfs image to flash.  the situation as
follows:

cat /proc/mtd:
dev:    size   erasesize  name
mtd0: 00180000 00010000 "kernel"
mtd1: 00280000 00010000 "rootfs"

cat /proc/partitions:
major minor  #blocks  name

 254     0      62720 xsa
 254     1       9840 xsa1
 254     2      52864 xsa2
  31     0       1536 mtdblock0
  31     1       2560 mtdblock1

ls -l /dev/mtd*:
crw-r--r--    1 root     root      90,   0 Jan  1 00:14 /dev/mtd0
crw-r--r--    1 root     root      90,   2 Jan  1 00:21 /dev/mtd1
brw-r--r--    1 root     root      31,   0 Jan  1 00:01 /dev/mtdblock0
brw-r--r--    1 root     root      31,   1 Jan  1 00:08 /dev/mtdblock1


now, imho it is possible to make a

- eraseall /dev/mtd1 to erase the flash
- dd if=cramfs.img of=/dev/mtd1 to copy image to flash

but if i read the mtd1 device back, the flash is emtpy :(((

what is my mistake ?

Georg



-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
Forschungszentrum Jülich GmbH
52425 Jülich

Sitz der Gesellschaft: Jülich
Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
Geschäftsführung: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stellv. 
Vorsitzender)
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
