Mime-Version: 1.0
Message-Id: <p06100402bcd3b533403f@[192.168.9.138]>
Date: Fri, 21 May 2004 10:06:08 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Radeon 7000 dual head issues?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Can anyone state that they have dual monitors working with a Radeon
7000 card? XFree86.org implies, nay, states outright, that this card
is fully supported, including dual head mode. So methinks there
should be someone out there on the planet that has made this work,
but that maybe there is a ppc issue...

YDL 3.0.1
kernel 2.4.26
XFree 4.3.0-2.1e
PowerTowerPro
7000 card is in one of the top 3 slots

I have had no luck with this configuration (the second monitor never
even blinks a single pixel other than dead black). So I switched to
XFree86 4.4.0 (built source from scratch, default config all the way)
and made some progress: without changing the XF86Config file at all,
I went from dead black with 4.3.0 to the following with 4.4.0 on the
second monitor (the main monitor works all along):

1. Got the semblance of a plain colored desktop background. It
actually looks correct in 15 bit mode; 8, 16, and 24 cause lots of
the graininess and weird coloring one sees when the bit depth is off.

2. Got a mouse cursor that exactly tracks the cursor on the main
(good) monitor.

3. Got a lower resolution than expected (everything is bigger and pixelated).

4. Am seeing 4 replications of what is on the main screen. The
replications are 4 across, not 2x2 or anything more complicated.

I've played with the config file and this is what I've noticed:

1. Same result with either the ati driver or the radeon driver. Same
result regardless of any video RAM setting. Same result regardless of
whether I specify the PCI bus ID. I suspect these are all probed
anyway, although I cannot leave the "Driver" entry empty. I switched
to a nonsensical driver just as a sanity check, and sure enough could
not launch X at all then. There used to be an open firmware frame
buffer (Driver "OFfb" ?) that I used on the old world boxes to avoid
the driver entirely, but this seems to either not work any more or I
forget how to instantiate it.

2. If I set Option "UseFBDev" to false, the second monitor goes "out
of range" and although the main monitor works in X as always, when I
kill X I no longer have console video on the main monitor. So is
seems that UseFBDev must be set to true for both heads.

Below is my XF86Config file. Any hints, clues, or development code I
can try? Or a better forum? I have stayed with the 2 resolutions
shown - they ought to be pretty standard, and the card works in both
OSX and OS9 fine at those resolutions (BTW, this is a genuine Mac
7000 card, not a flashed PC version). One things does confuse me:
this is a single dual-head video card - must there still be a Card1
and Card0 setting in the config?


Stefan Jeglinski


--------------------------------------------
Section "ServerLayout"
	Identifier     "XFree86 Configured"
	Screen         "Screen0"
	Screen         "Screen1" LeftOf "Screen0"
	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "ServerFlags"
   Option "Xinerama" "true"
EndSection

Section "Files"

# RgbPath is the location of the RGB database.  Note, this is the name of the
# file minus the extension (like ".txt" or ".db").  There is normally
# no need to change the default.
# Multiple FontPath entries are allowed (they are concatenated together)
# By default, Red Hat 6.0 and later now use a font server independent of
# the X server to render fonts.
	RgbPath      "/usr/X11R6/lib/X11/rgb"
	FontPath     "unix/:7100"
EndSection

Section "Module"
	Load  "dbe"
	Load  "extmod"
	Load  "fbdevhw"
	Load  "glx"
	Load  "record"
	Load  "freetype"
	Load  "type1"
	#Load	"dri"
EndSection

Section "InputDevice"

# Change "XkbModel" to "macintosh_old" if you are using
# the deprecated adb keycodes.
	Identifier  "Keyboard0"
	Driver      "keyboard"
	Option	    "XkbRules" "xfree86"
	Option	    "XkbModel" "macintosh"
	Option	    "XkbLayout" "us"
EndSection

Section "InputDevice"
	Identifier  "Mouse0"
	Driver      "mouse"
	Option	    "ZAxisMapping" "4 5"
	Option	    "Protocol" "IMPS/2"
	Option	    "Device" "/dev/input/mice"
EndSection

Section "Modes"
	Identifier     "Modes0"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	ModelName    "PHL_MGV 109S"
	HorizSync    30.0 - 100.0
	VertRefresh  50.0 - 160.0
	Option	    "DPMS"
EndSection

Section "Monitor"
	Identifier   "Monitor1"
	ModelName    "Viewsonic A90"
	HorizSync    30.0 - 100.0
	VertRefresh  50.0 - 160.0
	Option	    "DPMS"
EndSection

Section "Device"
	Identifier  "Card0"
	Driver      "radeon"
	BoardName   "ATI Radeon 7000"
	Option	    "UseFBDev" "true"
	BusID       "PCI:0:13:0"
EndSection

Section "Device"
	Identifier  "Card1"
	Driver      "radeon"
	BoardName   "ATI Radeon 7000"
	Option	    "UseFBDev" "true"
	BusID       "PCI:0:13:0"
EndSection

Section "Screen"
	Identifier "Screen0"
	Device     "Card0"
	Monitor    "Monitor0"
	DefaultDepth     15
	SubSection "Display"
		Depth     8
		Modes    "1280x1024" "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     16
		Modes    "1280x1024" "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     15
		Modes    "1280x1024" "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     24
		Modes    "1280x1024" "1024x768"
	EndSubSection
EndSection

Section "Screen"
	Identifier "Screen1"
	Device     "Card1"
	Monitor    "Monitor1"
	DefaultDepth     15
	SubSection "Display"
		Depth     8
		Modes    "1280x1024" "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     16
		Modes    "1280x1024" "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     15
		Modes    "1280x1024" "1024x768"
	EndSubSection
	SubSection "Display"
		Depth     24
		Modes    "1280x1024" "1024x768"
	EndSubSection
EndSection

Section "DRI"
	Group        0
	Mode         0666
EndSection

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
