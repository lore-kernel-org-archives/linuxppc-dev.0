Subject: Re: rpx8260_defconfig problems
From: Jeff Angielski <jeff@theptrgroup.com>
To: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1091647026.4233.95.camel@localhost.localdomain>
References: <1091647026.4233.95.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1091811981.4179.20.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 06 Aug 2004 13:06:21 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-08-04 at 15:17, Jeff Angielski wrote:
> Doing a bk pull on the latest linuxppc-2.4 says that as of July 2004,
> support for the Embedded Planet EP8260 was working.  However, using the
> default rpx8260_defconfig will not work on my board.

I finally managed to get a booting linuxppc-2.4 kernel and some console
output.  Now onto getting a working rootfs...

For reference in case anybody tries this at home, the problems were:

1) arch/ppc/platforms/rpx8260.h defined it's own bd_info structure which
was not consistent with u-boot.  This caused the time settings to be
wrong, which in turn caused the decrementer to be set to zero... "That's
it man, game over man, game over, man!"

2) drivers/char/tty_io.c has a typo on the CPM2 support in
console_init() that prevents it from working with anything but 8xx
architectures

- #if defined(CONFIG_8xx) || defined(CONFIG_CONFIG_CPM2_UART)
+ #if defined(CONFIG_8xx) || defined(CONFIG_CPM2_UART)


Cheers,

Jeff Angielski
The PTR Group


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
