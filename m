Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 08056680D4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 08:41:22 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so463985wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Aug 2005 15:41:21 -0700 (PDT)
Message-ID: <c3d0340b050811154148164691@mail.gmail.com>
Date: Thu, 11 Aug 2005 15:41:21 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: What's wrong with the serial port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm porting linux 2.6.11.4 to a custom SoC with ppc440 core. The UART
is 16550 compatible. U-Boot is already running fine.

When the kernel is booting, it gets to the point where console_init()
is called, which calls individual early console initialization
functions. In my case it's serial8250_console_init(). Before
register_console() is called in serial8250_console_init(), everything
seems fine because the debugging logs are printed on the serial port.
But once register_console() is called, the serial port continues
spitting out =E0. See the following message. What's wrong?

Any hints are appreciated!

Boot reached stage 4                                                       =
    =20
Boot reached stage 5                                                       =
    =20
Boot reached stage 6                                                       =
    =20
OK                                                                         =
    =20
Boot reached stage 7                                                       =
    =20
Boot reached stage 8                                                       =
    =20
## Current stack ends at 0x01FC6B80 =3D> set upper limit to 0x00800000     =
      =20
## cmdline at 0x007FFF00 ... 0x007FFF10                                    =
    =20
bd address  =3D 0x01FC6F90                                                 =
      =20
memstart    =3D 0x00000000                                                 =
      =20
memsize     =3D 0x02000000                                                 =
      =20
flashstart  =3D 0x00000000                                                 =
      =20
flashsize   =3D 0x00000000                                                 =
      =20
flashoffset =3D 0x00000000                                                 =
      =20
sramstart   =3D 0x00000000                                                 =
      =20
sramsize    =3D 0x00000000                                                 =
      =20
bootflags   =3D 0x00000000                                                 =
      =20
intfreq     =3D    400 MHz                                                 =
      =20
busfreq     =3D    266 MHz                                                 =
      =20
ethaddr     =3D 00:00:00:00:00:00                                          =
      =20
IP addr     =3D 0.0.0.0                                                    =
      =20
baudrate    =3D 115200 bps                                                 =
      =20
Boot reached stage 14                                                      =
    =20
No initrd                                                                  =
    =20
## Transferring control to Linux (at address 00000000) ...                 =
    =20
Boot reached stage 15                                                      =
    =20
id mach(): done                                                            =
    =20
MMU:enter                                                                  =
    =20
MMU:hw init                                                                =
    =20
MMU:mapin                                                                  =
    =20
MMU:setio                                                                  =
    =20
MMU:exit                                                                   =
    =20
setup_arch: enter                                                          =
    =20
setup_arch: bootmem                                                        =
    =20
arch: exit                                                                 =
    =20
=E0=E0=E0=E0=E0=E0                                             =20

-Shawn.
