Content-Type: text/plain;
  charset="iso-8859-15"
From: Rakesh jagota <j.rakesh@gdatech.co.in>
Reply-To: j.rakesh@gdatech.co.in
To: linuxppc-embedded@lists.linuxppc.org
Subject: Unable to mount jffs2 file system
Date: Mon, 16 Jun 2003 19:15:34 +0530
MIME-Version: 1.0
Message-ID: <xpm1c2kre0rvtkh.160620031905@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am working on custom design board based on IBM405 PPC. I am using OpenBios
code and Linux -2.4.17 version from montavista. I have compiled the kernel
with JFFS2 support.

In linux/drivers/mtd/maps/redwood.c files, we have modified the partitions as
per our board

Our board is having 4MB flash and 32MB sdram.

#define WINDOW_ADDR      0xFFC00000
#define WINDOW_SIZE 	     0x00400000


we filled the  redwood_flash_partitions structure as below

		name: "Redwood kernel",					//"/dev/mtd0"
		offset: 0x00010000,
		size: 	0x00110000

		name: "Redwood OpenBIOS Vital Product Data",		//"/dev/mtd1"

		offset: 0x00000000,
		size: 0x00010000,
		mask_flags: MTD_WRITEABLE

		name: "Redwood filesystem",				//"/dev/mtd2"
		offset: 0x00110000,
		size: 0x002D0000

		name: "Redwood OpenBIOS",				//"/dev/mtd3"
		offset: 0x003E0000,
		size: 0x00020000,
		mask_flags: MTD_WRITEABLE	/* force read-only */


i have created a jff2 image and flashed in the mtd2 block. But while booting
i am  getting kernel panic
===============================================

kernel panic: I have no root and I want to scream

===============================================

how to tell the kernel that the root filesystems is in mtdblock2


Thanks & Regards,

rakesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
