Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20031219184927.4885.qmail@web41901.mail.yahoo.com>
Date: Fri, 19 Dec 2003 10:49:27 -0800 (PST)
From: lihong wei <lihongwlh@yahoo.com>
Subject: Re: AW: Serial console failure on DENX Linux on MPC850 board
To: Graf Alex <alex.graf@siemens.com>,
	ppclinux <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <791B3205DB661A42B4BFE5464A7D1D0204B36D86@chzugexch01.abatos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes, I configured in scc2 as serial console in
menuconfig.

I just found out that the serial driver only call
rs_init, rs_write, instead of calling rs_8xx_init(),
etc. I just download the latest develop source from
denx. Its serial driver seems to be very inchoate. I
am trying to fix this. Any help will be appreciated!


Thanks,

Vincent



--- Graf Alex <alex.graf@siemens.com> wrote:
>
> Do you use SCC1 / SMCx for UARTs? This gives an
> offset! --> ttyS1, ...
>
> cheers
>
> Alex
>
> -----Ursprüngliche Nachricht-----
> Von: lihong wei [mailto:lihongwlh@yahoo.com]
> Gesendet: Donnerstag, 18. Dezember 2003 19:09
> An: ppclinux
> Betreff: Serial console failure on DENX Linux on
> MPC850 board
>
>
>
> Hi all,
>
> I am porting latest version  Denx linux
> linuxppc_2_4_devel kernel and U-boot 3.0 to our
> MPC850
>  board. I also used SELF to generate the ext2 file
> system. I am using the TQM850L configuration
>  on my board, and configured the SCC2 as serial
> console(because the hardware designed like this).
>   After the kernel started the /sbin/init, which is
> the last step of booting, the console stop
>    response. I have studied several discussion
> groups
> and did the following changes, but it still
>     doesn't work:
>
> 1. set boot command line in u-boot like this:
>     setenv bootargs console=ttyS0,115200
> root=/dev/ram
> rw
>
> 2. when creating root file system in SELF, under
> /dev
> directory, create devices with
> ELDK_MAKEDEV, ELDK_FIXOWNER, and then delete
> /dev/console, then link ttyS0 to /dev/console,
> (this is from some discussion group).
>
> 3. in /etc/inittab, added:
> ttyS0::respawn:-/bin/sh
>
> 4. The SELF used busybox-0.51, and I also tried
> busybox-0.61.1, there's no difference.
>  I also tried  modifying the init_main() in
> busybox../init.c, and foreced the console_init()
>   routine to open("/dev/console"...) instead of
> using
> the parameters passed from kernel.
> Because after kernel started run /sbin/init, I can
> not
> trace the code, neither can I post
> debugging info from serail console, I can only tell
> the difference from the behavior of the
>  last few lines of console output. It seems that the
> init routine can open the console device.
>   and the serial IOCTL in console_init() can also
> detect the device. but there's still no
>   output on the screen.
>
> I also tried to use the files system coming with
> ELDK
> distribution, but it's too big (1.5M)
>  and my system has only 2M flash, including u-boot,
> and kernel. I tried to make a smaller
>  image to cut everything except files like
> /bin/bash,
> /dev/console, /sbin/init. and somehow
>   it's still 1M. and system doesn't work either.
>
> I am stuck here and any response will be cordially
> appreciated!
>
> Best Regards,
>
> Vincent
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
