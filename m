Date: Sun, 8 Feb 2004 20:32:14 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
In-Reply-To: <20040208145326.GC25453@permusion.kilzer.net>
Message-ID: <Pine.GSO.4.58.0402082031350.6076@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
 <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be>
 <20040208145326.GC25453@permusion.kilzer.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 8 Feb 2004, David D. Kilzer wrote:
> On Sun, Feb 08, 2004 at 03:25:50PM +0100, Geert Uytterhoeven wrote:
> > On Fri, 6 Feb 2004, Linus Torvalds wrote:
> > > Benjamin Herrenschmidt:
> > >   o ppc32: Use drivers/Kconfig and move some Mac stuffs to
> > >     drivers/macintosh/Kconfig
> >
> > And of course we just started to use drivers/Kconfig on m68k in CVS ;-)
> >
> > This patch is a first attempt to fix the issues. What do you think?
> >
> > ADB_CUDA is shared between m68k and PPC. Anyone who knows which m68k
> > models use it, so we can list them in the help text?
>
> According to arch/m68k/mac/config.c:
>
> Color Classic
> Mac TV
> Performa 475
> Performa 520
> Performa 550
> Performa 575
> Performa 588
> Quadra 605
> Quadra 630
> Quadra/Centris 660AV
> Quadra 840AV

Thanks! So my second version looks like:

--- linux-m68k-2.6.3-rc1/arch/m68k/Kconfig.orig	2004-02-02 22:27:03.000000000 +0100
+++ linux-m68k-2.6.3-rc1/arch/m68k/Kconfig	2004-02-08 20:13:45.000000000 +0100
@@ -550,80 +550,6 @@
 	tristate "Macintosh serial support"
 	depends on MAC

-config ADB
-	bool "Apple Desktop Bus (ADB) support"
-	depends on MAC
-	help
-	  Apple Desktop Bus (ADB) support is for support of devices which
-	  are connected to an ADB port.  ADB devices tend to have 4 pins.
-	  If you have an Apple Macintosh prior to the iMac, or a
-	  "Blue and White G3", you probably want to say Y here.  Otherwise
-	  say N.
-
-config ADB_MACII
-	bool "Include Mac II ADB driver"
-	depends on ADB
-	help
-	  Say Y here if want your kernel to support Macintosh systems that use
-	  the Mac II style ADB.  This includes the II, IIx, IIcx, SE/30, IIci,
-	  Quadra 610, Quadra 650, Quadra 700, Quadra 800, Centris 610 and
-	  Centris 650.
-
-config ADB_MACIISI
-	bool "Include Mac IIsi ADB driver"
-	depends on ADB
-	help
-	  Say Y here if want your kernel to support Macintosh systems that use
-	  the Mac IIsi style ADB.  This includes the IIsi, IIvi, IIvx, Classic
-	  II, LC, LC II, LC III, Performa 460, and the Performa 600.
-
-config ADB_CUDA
-	bool "Include CUDA ADB driver"
-	depends on ADB
-	help
-	  This provides support for CUDA based Power Macintosh systems.  This
-	  includes most OldWorld PowerMacs, the first generation iMacs, the
-	  Blue&White G3 and the Yikes G4 (PCI Graphics).  All later models
-	  should use CONFIG_ADB_PMU instead.
-
-	  If unsure say Y.
-
-config ADB_IOP
-	bool "Include IOP (IIfx/Quadra 9x0) ADB driver"
-	depends on ADB
-	help
-	  The I/O Processor (IOP) is an Apple custom IC designed to provide
-	  intelligent support for I/O controllers.  It is described at
-	  <http://www.angelfire.com/ca2/dev68k/iopdesc.html> to enable direct
-	  support for it, say 'Y' here.
-
-config ADB_PMU68K
-	bool "Include PMU (Powerbook) ADB driver"
-	depends on ADB
-	help
-	  Say Y here if want your kernel to support the m68k based Powerbooks.
-	  This includes the PowerBook 140, PowerBook 145, PowerBook 150,
-	  PowerBook 160, PowerBook 165, PowerBook 165c, PowerBook 170,
-	  PowerBook 180, PowerBook, 180c, PowerBook 190cs, PowerBook 520,
-	  PowerBook Duo 210, PowerBook Duo 230, PowerBook Duo 250,
-	  PowerBook Duo 270c, PowerBook Duo 280 and PowerBook Duo 280c.
-
-config INPUT_ADBHID
-	bool "Use input layer for ADB devices"
-	depends on MAC && INPUT=y
-	---help---
-	  Say Y here if you want to have ADB (Apple Desktop Bus) HID devices
-	  such as keyboards, mice, joysticks, or graphic tablets handled by
-	  the input layer.  If you say Y here, make sure to say Y to the
-	  corresponding drivers "Keyboard support" (CONFIG_INPUT_KEYBDEV),
-	  "Mouse Support" (CONFIG_INPUT_MOUSEDEV) and "Event interface
-	  support" (CONFIG_INPUT_EVDEV) as well.
-
-	  If you say N here, you still have the option of using the old ADB
-	  keyboard and mouse drivers.
-
-	  If unsure, say Y.
-
 config MAC_HID
 	bool
 	depends on INPUT_ADBHID
@@ -643,18 +600,6 @@

 	  If unsure, say Y here.

-config MAC_EMUMOUSEBTN
-	bool "Support for mouse button 2+3 emulation"
-	depends on INPUT_ADBHID
-	help
-	  This provides generic support for emulating the 2nd and 3rd mouse
-	  button with keypresses.  If you say Y here, the emulation is still
-	  disabled by default.  The emulation is controlled by these sysctl
-	  entries:
-	  /proc/sys/dev/mac_hid/mouse_button_emulation
-	  /proc/sys/dev/mac_hid/mouse_button2_keycode
-	  /proc/sys/dev/mac_hid/mouse_button3_keycode
-
 config ADB_KEYBOARD
 	bool "Support for ADB keyboard (old driver)"
 	depends on MAC && !INPUT_ADBHID
--- linux-2.6.3-rc1/drivers/macintosh/Kconfig.orig	2004-02-08 10:19:24.000000000 +0100
+++ linux-m68k-2.6.3-rc1/drivers/macintosh/Kconfig	2004-02-08 20:18:18.000000000 +0100
@@ -1,16 +1,66 @@

 menu "Macintosh device drivers"

+config ADB
+	bool "Apple Desktop Bus (ADB) support"
+	depends on MAC || PPC_PMAC
+	help
+	  Apple Desktop Bus (ADB) support is for support of devices which
+	  are connected to an ADB port.  ADB devices tend to have 4 pins.
+	  If you have an Apple Macintosh prior to the iMac, an iBook or
+	  PowerBook, or a "Blue and White G3", you probably want to say Y
+	  here.  Otherwise say N.
+
+config ADB_MACII
+	bool "Include Mac II ADB driver"
+	depends on ADB && MAC
+	help
+	  Say Y here if want your kernel to support Macintosh systems that use
+	  the Mac II style ADB.  This includes the II, IIx, IIcx, SE/30, IIci,
+	  Quadra 610, Quadra 650, Quadra 700, Quadra 800, Centris 610 and
+	  Centris 650.
+
+config ADB_MACIISI
+	bool "Include Mac IIsi ADB driver"
+	depends on ADB && MAC
+	help
+	  Say Y here if want your kernel to support Macintosh systems that use
+	  the Mac IIsi style ADB.  This includes the IIsi, IIvi, IIvx, Classic
+	  II, LC, LC II, LC III, Performa 460, and the Performa 600.
+
+config ADB_IOP
+	bool "Include IOP (IIfx/Quadra 9x0) ADB driver"
+	depends on ADB && MAC
+	help
+	  The I/O Processor (IOP) is an Apple custom IC designed to provide
+	  intelligent support for I/O controllers.  It is described at
+	  <http://www.angelfire.com/ca2/dev68k/iopdesc.html> to enable direct
+	  support for it, say 'Y' here.
+
+config ADB_PMU68K
+	bool "Include PMU (Powerbook) ADB driver"
+	depends on ADB && MAC
+	help
+	  Say Y here if want your kernel to support the m68k based Powerbooks.
+	  This includes the PowerBook 140, PowerBook 145, PowerBook 150,
+	  PowerBook 160, PowerBook 165, PowerBook 165c, PowerBook 170,
+	  PowerBook 180, PowerBook, 180c, PowerBook 190cs, PowerBook 520,
+	  PowerBook Duo 210, PowerBook Duo 230, PowerBook Duo 250,
+	  PowerBook Duo 270c, PowerBook Duo 280 and PowerBook Duo 280c.
+
 # we want to change this to something like CONFIG_SYSCTRL_CUDA/PMU
 config ADB_CUDA
-	bool "Support for CUDA based PowerMacs"
-	depends on PPC_PMAC && !POWER4
+	bool "Support for CUDA based Macs and PowerMacs"
+	depends on (ADB || PPC_PMAC) && !POWER4
 	help
-	  This provides support for CUDA based Power Macintosh systems.  This
-	  includes most OldWorld PowerMacs, the first generation iMacs, the
-	  Blue&White G3 and the "Yikes" G4 (PCI Graphics).  All later models
-	  should use CONFIG_ADB_PMU instead.  It is safe to say Y here even if
-	  your machine doesn't have a CUDA.
+	  This provides support for CUDA based Macintosh and Power Macintosh
+	  systems.  This includes many m68k based Macs (Color Classic, Mac TV,
+	  Performa 475, Performa 520, Performa 550, Performa 575,
+	  Performa 588, Quadra 605, Quadra 630, Quadra/Centris 660AV, and
+	  Quadra 840AV), most OldWorld PowerMacs, the first generation iMacs,
+	  the Blue&White G3 and the "Yikes" G4 (PCI Graphics).  All later
+	  models should use CONFIG_ADB_PMU instead.  It is safe to say Y here
+	  even if your machine doesn't have a CUDA.

 	  If unsure say Y.

@@ -81,19 +131,9 @@
 	  This driver is obsolete. Use CONFIG_SERIAL_PMACZILOG in
 	  "Character devices --> Serial drivers --> PowerMac z85c30" option.

-config ADB
-	bool "Apple Desktop Bus (ADB) support"
-	depends on PPC_PMAC
-	help
-	  Apple Desktop Bus (ADB) support is for support of devices which
-	  are connected to an ADB port.  ADB devices tend to have 4 pins.
-	  If you have an Apple Macintosh prior to the iMac, an iBook or
-	  PowerBook, or a "Blue and White G3", you probably want to say Y
-	  here.  Otherwise say N.
-
 config ADB_MACIO
 	bool "Include MacIO (CHRP) ADB driver"
-	depends on ADB && !POWER4
+	depends on ADB && PPC_CHRP && !POWER4
 	help
 	  Say Y here to include direct support for the ADB controller in the
 	  Hydra chip used on PowerPC Macintoshes of the CHRP type.  (The Hydra
@@ -151,6 +191,6 @@

 config ANSLCD
 	bool "Support for ANS LCD display"
-	depends on ADB_CUDA
+	depends on ADB_CUDA && PPC_PMAC

 endmenu

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
