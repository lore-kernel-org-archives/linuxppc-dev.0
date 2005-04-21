Return-Path: <Schramel.Linux@go.bartec.de>
Received: from mail.bartec.de (mail.bartec.de [217.5.168.170])
	by ozlabs.org (Postfix) with SMTP id 03DF967A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 18:46:12 +1000 (EST)
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: "PPC_LINUX" <linuxppc-embedded@ozlabs.org>
Date: Thu, 21 Apr 2005 11:17:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200504211117.25584.Schramel.Linux@go.bartec.de>
Subject: mtd mount problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

in our system (MPC8270, 2.4.25) i can't mount the mtd devices (two AM29LV256MH)

I created a map based on tqm8260.c. I can use the "eraseall" command and i can write the mtdx devices.
But if i try to mount the mtd devices (jffs or jffs2) then it fails.
Output:
The eraseall command
/dev # eraseall /dev/mtd1
MTD_open
MTD_ioctl
MTD_write
Erased 8192 Kibyte @ 0 -- 100% complete.
MTD_close

try to write
/dev # date > /dev/mtd1
MTD_open
MTD_ioctl
MTD_write
MTD_close

ok, now try onesmore
/dev # date > /dev/mtd1
MTD_open
MTD_ioctl
MTD_write
MTD do_write_buffer(): software timeout
MTD_close
/dev #

It all seems to be fine, but...

dev # mount -t jffs2 /dev/mtdblock1 /mnt/Flash1
mount: Mounting /dev/mtdblock1 on /mnt/Flash1 failed: No such device

I checked out the Majors of my ramdisk, they are ok.

Any ideas.

Best regards and thank you in advance.

Marco



-- 
---------
Marco Schramel
