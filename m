Message-ID: <3905650C.FBCBB453@ucdavis.edu>
Date: Tue, 25 Apr 2000 05:27:40 -0400
From: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
MIME-Version: 1.0
To: daenzerm@student.ethz.ch
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
References: <200004240616.XAA02709@pop3.ucdavis.edu> <39058023.39877695@relog.ch>
Content-Type: multipart/mixed;
 boundary="------------A0E3180AF6DFF8492E78154D"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------A0E3180AF6DFF8492E78154D
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Michel Dänzer wrote:

> Let me guess, you're using the fbdev driver for the secondary card? It needs
> the BusID of the gfx chip to be specified in the Device Section or the server
> will hang the machine.
>
> Michel

I specified the busID. According to /proc/pci, my AGP card is 0:16:0 and my PCI
card is 1:3:0.
The server hangs the system using both fbdev and r128. I'm running kernel
2.2.15pre19.

Atteched are my /proc/pci and XF86Config files (configs for second monitor only).

thanks
- Taylor

--------------A0E3180AF6DFF8492E78154D
Content-Type: text/plain; charset=us-ascii;
 name="proc_pci"
Content-Disposition: inline;
 filename="proc_pci"
Content-Transfer-Encoding: 7bit

PCI devices found:
  Bus  0, device  11, function  0:
    Host bridge: Apple Unknown device (rev 0).
      Vendor id=106b. Device id=20.
      Medium devsel.  Master Capable.  Latency=16.
  Bus  0, device  13, function  0:
    PCI bridge: DEC DC21154 (rev 5).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.
  Bus  0, device  16, function  0:
    VGA compatible controller: ATI Unknown device (rev 0).
      Vendor id=1002. Device id=5246.
      Medium devsel.  Fast back-to-back capable.  IRQ 48.  Master Capable.  Latency=255.  Min Gnt=8.
      Prefetchable 32 bit memory at 0x94000000 [0x94000008].
      I/O at 0x400 [0x401].
      Non-prefetchable 32 bit memory at 0x90000000 [0x90000000].
  Bus  1, device   2, function  0:
    SCSI storage controller: Adaptec AIC-7850 (rev 3).
      Medium devsel.  Fast back-to-back capable.  IRQ 52.  Master Capable.  Latency=16.  Min Gnt=4.Max Lat=4.
      I/O at 0x0 [0x1].
      Non-prefetchable 32 bit memory at 0x80084000 [0x80084000].
  Bus  1, device   3, function  0:
    VGA compatible controller: ATI Unknown device (rev 0).
      Vendor id=1002. Device id=5245.
      Medium devsel.  Fast back-to-back capable.  IRQ 53.  Master Capable.  Latency=16.  Min Gnt=8.
      Prefetchable 32 bit memory at 0x84000000 [0x84000008].
      I/O at 0x1000 [0x1001].
      Non-prefetchable 32 bit memory at 0x8008c000 [0x8008c000].
  Bus  1, device   7, function  0:
    Hot Swap Controller: Apple Unknown device (rev 2).
      Vendor id=106b. Device id=22.
      Medium devsel.  Master Capable.  Latency=16.
      Non-prefetchable 32 bit memory at 0x80000000 [0x80000000].
  Bus  1, device   8, function  0:
    USB Controller: Apple Unknown device (rev 0).
      Vendor id=106b. Device id=19.
      Medium devsel.  IRQ 27.  Master Capable.  Latency=16.  Min Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0x80083000 [0x80083000].
  Bus  1, device   9, function  0:
    USB Controller: Apple Unknown device (rev 0).
      Vendor id=106b. Device id=19.
      Medium devsel.  IRQ 28.  Master Capable.  Latency=16.  Min Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0x80082000 [0x80082000].
  Bus  1, device  10, function  0:
    FireWire (IEEE 1394): Texas Instruments Unknown device (rev 0).
      Vendor id=104c. Device id=8019.
      Medium devsel.  IRQ 63.  Master Capable.  Latency=16.  Min Gnt=2.Max Lat=4.
      Non-prefetchable 32 bit memory at 0x80081000 [0x80081000].
      Non-prefetchable 32 bit memory at 0x80088000 [0x80088000].
  Bus  1, device  11, function  0:
    Ethernet controller: DEC DC21142 (rev 65).
      Medium devsel.  Fast back-to-back capable.  IRQ 58.  Master Capable.  Latency=96.  Min Gnt=20.Max Lat=40.
      I/O at 0x1000 [0x1001].
      Non-prefetchable 32 bit memory at 0x80080000 [0x80080000].

--------------A0E3180AF6DFF8492E78154D
Content-Type: text/plain; charset=us-ascii;
 name="XF86Config.fbdev-2"
Content-Disposition: inline;
 filename="XF86Config.fbdev-2"
Content-Transfer-Encoding: 7bit

# Amiga users have to adapt quite some things here

Section "ServerLayout"
        Identifier     "XFree86 Configured"
        Screen      0  "Screen0" 0 0
        InputDevice    "Mouse0" "CorePointer"
        InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"
# The location of the RGB database.  Note, this is the name of the
# file minus the extension (like ".txt" or ".db").  There is normally
# no need to change the default.

    RgbPath     "/usr/X11R6/lib/X11/rgb"

# Multiple FontPath entries are allowed (which are concatenated together),
# as well as specifying multiple comma-separated entries in one FontPath
# command (or a combination of both methods)

    FontPath    "/usr/X11R6/lib/X11/fonts/local/"
    FontPath    "/usr/X11R6/lib/X11/fonts/misc/"
    FontPath    "/usr/X11R6/lib/X11/fonts/75dpi/:unscaled"
    FontPath    "/usr/X11R6/lib/X11/fonts/100dpi/:unscaled"
    FontPath    "/usr/X11R6/lib/X11/fonts/Type1/"
    FontPath    "/usr/X11R6/lib/X11/fonts/CID/"
    FontPath    "/usr/X11R6/lib/X11/fonts/Speedo/"
    FontPath    "/usr/X11R6/lib/X11/fonts/75dpi/"
    FontPath    "/usr/X11R6/lib/X11/fonts/100dpi/"
    FontPath    "unix/:-1"

# ModulePath can be used to set a search path for the X server modules.
# The default path is shown here.

#    ModulePath "/usr/X11R6/lib/modules"

EndSection

Section "Module"
        Load  "GLcore"
        Load  "dbe"

# This loads the miscellaneous extensions module, and disables
# initialisation of the XFree86-DGA extension within that module.
    SubSection  "extmod"
      Option    "omit xfree86-dga"   # don't initialise the DGA extension
    EndSubSection

        Load  "glx"
        Load  "pex5"
        Load  "record"
        Load  "xie"
        Load  "type1"
        Load  "speedo"
EndSection

Section "InputDevice"
        Identifier  "Keyboard0"
        Driver      "keyboard"
#        Option      "XkbDisable"
        Option "XkbModel"  "macintosh"
        Option "XkbLayout"  "us"
EndSection

Section "InputDevice"
        Identifier  "Mouse0"
        Driver      "mouse"
        Option      "Protocol" "IMPS/2"
        Option      "Device" "/dev/usbmouse"
EndSection

Section "Monitor"
        Identifier   "Monitor0"
        VendorName   "Apple Computer"
        ModelName    "Studio 17"
        HorizSync    30-85
        VertRefresh  48-160
EndSection

Section "Device"
        ### Available Driver options are:-
#If you don't want to use the shadow framebuffer (try if it's faster with or without)
        #Option      "ShadowFB" "Off"

        Identifier  "fbdev"
        Driver      "fbdev"

# You _have_ to specify the correct PCI bus ID of your graphics chip!
# Look at /proc/pci to find out (or try XFree86 -probeonly)
        BusID       "PCI:1:3:0"
EndSection

Section "Screen"
        Identifier "Screen0"
        Device     "fbdev"
        Monitor    "Monitor0"
        DefaultDepth      15
        SubSection "Display"
                Depth     1
                Modes "1024x768"
        EndSubSection
        SubSection "Display"
                Depth     4
                Modes "1024x768"
        EndSubSection
        SubSection "Display"
                Depth     8
                Modes "1024x768"
        EndSubSection
        SubSection "Display"
                Depth     15
                Modes "1024x768"
        EndSubSection
        SubSection "Display"
                Depth     16
                Modes "1024x768"
        EndSubSection
        SubSection "Display"
                Depth     24
                Modes "1024x768"
        EndSubSection
EndSection


--------------A0E3180AF6DFF8492E78154D
Content-Type: text/plain; charset=us-ascii;
 name="XF86Config.r128-2"
Content-Disposition: inline;
 filename="XF86Config.r128-2"
Content-Transfer-Encoding: 7bit

Section "ServerLayout"
	Identifier     "XFree86 Configured"
	Screen      0  "Screen0" 0 0
	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"
# The location of the RGB database.  Note, this is the name of the
# file minus the extension (like ".txt" or ".db").  There is normally
# no need to change the default.

    RgbPath	"/usr/X11R6/lib/X11/rgb"

# Multiple FontPath entries are allowed (which are concatenated together),
# as well as specifying multiple comma-separated entries in one FontPath
# command (or a combination of both methods)

    FontPath	"/usr/X11R6/lib/X11/fonts/local/"
    FontPath	"/usr/X11R6/lib/X11/fonts/misc/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/:unscaled"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/:unscaled"
    FontPath	"/usr/X11R6/lib/X11/fonts/Type1/"
    FontPath	"/usr/X11R6/lib/X11/fonts/CID/"
    FontPath	"/usr/X11R6/lib/X11/fonts/Speedo/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/"
    FontPath    "unix/:-1"

# ModulePath can be used to set a search path for the X server modules.
# The default path is shown here.

#    ModulePath	"/usr/X11R6/lib/modules"

EndSection

Section "Module"
	Load  "GLcore"
	Load  "dbe"

# This loads the miscellaneous extensions module, and disables
# initialisation of the XFree86-DGA extension within that module.
    SubSection  "extmod"
      Option    "omit xfree86-dga"   # don't initialise the DGA extension
    EndSubSection

	Load  "glx"
	Load  "pex5"
	Load  "record"
	Load  "xie"
	Load  "type1"
	Load  "speedo"
EndSection

Section "InputDevice"
	Identifier  "Keyboard0"
	Driver      "keyboard"
#        Option      "XkbDisable"
	Option "XkbModel"  "macintosh"
	Option "XkbLayout"  "us"
EndSection

Section "InputDevice"
	Identifier  "Mouse0"
	Driver      "mouse"
	Option      "Protocol" "IMPS/2"
	Option      "Device" "/dev/usbmouse"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	VendorName   "Apple Computer"
	ModelName    "Studio 17"
        HorizSync    30-85
        VertRefresh  48-160
EndSection

Section "Device"
	### Available Driver options are:-
        #Option     "NoAccel"
        #Option     "SWcursor"
        Option     "HWcursor"
        #Option     "Dac6Bit"
        #Option     "Dac8Bit"
        Option     "UseFBDev"
	Identifier  "r128"
	Driver      "r128"
	BusID       "PCI:1:3:0"
EndSection

Section "Screen"
	Identifier "Screen0"
	Device     "r128"
	Monitor    "Monitor0"
        DefaultDepth      15
	SubSection "Display"
		Depth     1
		Modes "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     4
		Modes "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     8
		Modes "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     15
		Modes "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     16
		Modes "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     24
		Modes "1024x768"
	EndSubSection
EndSection

--------------A0E3180AF6DFF8492E78154D--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
