Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20031218180858.55548.qmail@web41902.mail.yahoo.com>
Date: Thu, 18 Dec 2003 10:08:58 -0800 (PST)
From: lihong wei <lihongwlh@yahoo.com>
Subject: Serial console failure on DENX Linux on MPC850 board
To: ppclinux <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am porting latest version  Denx linux
linuxppc_2_4_devel kernel and U-boot 3.0 to our MPC850
 board. I also used SELF to generate the ext2 file
system. I am using the TQM850L configuration
 on my board, and configured the SCC2 as serial
console(because the hardware designed like this).
  After the kernel started the /sbin/init, which is
the last step of booting, the console stop
   response. I have studied several discussion groups
and did the following changes, but it still
    doesn't work:

1. set boot command line in u-boot like this:
    setenv bootargs console=ttyS0,115200 root=/dev/ram
rw

2. when creating root file system in SELF, under /dev
directory, create devices with
ELDK_MAKEDEV, ELDK_FIXOWNER, and then delete
/dev/console, then link ttyS0 to /dev/console,
(this is from some discussion group).

3. in /etc/inittab, added:
ttyS0::respawn:-/bin/sh

4. The SELF used busybox-0.51, and I also tried
busybox-0.61.1, there's no difference.
 I also tried  modifying the init_main() in
busybox../init.c, and foreced the console_init()
  routine to open("/dev/console"...) instead of using
the parameters passed from kernel.
Because after kernel started run /sbin/init, I can not
trace the code, neither can I post
debugging info from serail console, I can only tell
the difference from the behavior of the
 last few lines of console output. It seems that the
init routine can open the console device.
  and the serial IOCTL in console_init() can also
detect the device. but there's still no
  output on the screen.

I also tried to use the files system coming with ELDK
distribution, but it's too big (1.5M)
 and my system has only 2M flash, including u-boot,
and kernel. I tried to make a smaller
 image to cut everything except files like /bin/bash,
/dev/console, /sbin/init. and somehow
  it's still 1M. and system doesn't work either.

I am stuck here and any response will be cordially
appreciated!

Best Regards,

Vincent


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
