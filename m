To: linuxppc-embedded@lists.linuxppc.org
Subject: USB hostcontroller for TQM823L boards seems to work
Message-ID: <1023360528.3cff3e10175e5@imp.imms.de>
Date: Thu, 06 Jun 2002 12:48:48 +0200 (MEST)
From: Christian Schroeder <christian.schroeder@imms.de>
Cc: karsten.pahnke@emsys.de, reklies@mazet.de
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I succeded testing the usb hostcontroller (sources from www.heeltoe.com
written by Brad Parker).

1. Hardware

- TQM823L board with mpc823e (PPC823EZTnnB2)
- connection between X7/7 (Timer 1 output) and X9/16 (/DREQ1) to
  enable the spi/iic microcode patch
- 4 delay gates (74LVT244A) beetwen X32/1 resp. X32/3 (VM/VP outputs
  of the PDIUSBP11A) and X32/2 resp. X32/4 (USBXRM and USBXRP inputs
  of the mpc823e) required , power supply from X3/9 (+3,3V) an X3/3 (GND)
- connection of a high speed device (hub) to the usb connector required
  (low speed devices are only detected behind this hub)

2. Software

- linux-2.4.4 kernel sources from ftp.denx.de
- m8xxhci.c from www.heeltoe.com (added as config option CONFIG_USB_MPC8xx
  and to .../drivers/usb/...)
  #ifdef CONFIG_TQM823L
  #define USE_TIMER1_FOR_SOF
  #define USE_PA4_CLK4
  #undef POLL_FOR_HUB
  #endif
- kernel configuration (.config)
  CONFIG_UCODE_PATH=y
  CONFIG_USB=y
  CONFIG_USB_DEBUG=y
  (for testing)
  CONFIG_USB_MPC8xx=y
  (don't include usb mouse and usb keyboard drivers for testing,
   because the mouse an keyboard drivers claim the interfaces and
   the sample driver cannot see any data transfers)
  CONFIG_INPUT=y
  CONFIG_INPUT_EVDEV=y
  (mousedev and keybdev drivers don't link for ppc - undefined symbols)

3. Testing

- I used the sample usb driver from Alessandro Rubini and Jonathan Corbet
  and plugged it as a module to the running kernel.
  (http://examples.oreilly.com/linuxdrive2/ldd2-samples-1.0.1.tar.gz)
- I plugged a usb mouse and a usb keyboard to the external usb hub, connected to
  the board.
- When I moved the mouse, pressed mouse buttons or keys on the keybord,
  the kernel dumped the results to the console, so I think the host con-
  troller works correctly.

Thanks a lot for all help and comments.

Now I want to check, if I can repeat the results with my FADS823 board,
but I'm not sure if there is a possibility to do the necessary hardware
modifications. Specially I don't have any idea how to insert the delay
gates. Any hints would be greatly appreciated

Christian Schroeder

Dr.-Ing. Christian Schroeder
Institut fuer Mikroelektronik- und Mechatronik-Systeme
Langewiesener Strasse 22
98693 Ilmenau
Telefon: +49 3677 678315
Telefax: +49 3677 678337
Mobil:   +49 173 5789172
e-mail:  christian.schroeder@imms.de
www:     http://www.imms.de/~christi/cs.html
pgp:     finger christi@finger.imms.de


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
