Message-ID: <39AA6F8C.50707@in.tum.de>
Date: Mon, 28 Aug 2000 13:56:28 +0000
From: sprenger <sprenger@in.tum.de>
MIME-Version: 1.0
To: Stefan Berndtsson <stefan@nocrew.org>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xf4 and lombard
References: <39A5E3F7.1030409@in.tum.de> <87em3dyy5m.fsf@hades.nocrew.org>
Content-Type: multipart/mixed;
 boundary="------------010100030903050201030706"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------010100030903050201030706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> May I just ask.. how the heck did you get xf4 running on lombard? :)
>
> All I manage to get is a black screen and I can't do anything anymore.
> The machine is still running, so I can reboot it via network.
>
> It's a lombard/333 running 2.4.0-test6.
>
> xf4 is compiled from sources found on a link from the instructions
> at linuxppc.org and the rsynced version of the ati-driver, as of
> about 17.00 CET 2000-08-25.
>
use yaboot as said. at the moment i am running  2.4.0-t7 paulus-kernel.
sometimes i have some blue dots on my screen but  the rest is fine.

i have also attached my xf86config-file. the values in the screen
section were floating around in the net - do not ask me where i found
them. as you see i do not use them, the ati-driver determines its own
values and they are much better. comment out the lines with "Xkb..." i
need them because of my german keyboard layout.

it should work now - good luck ;-)
/thorsten


--------------010100030903050201030706
Content-Type: text/plain;
 name="XF86Config"
Content-Disposition: inline;
 filename="XF86Config"
Content-Transfer-Encoding: 7bit



Section "Files"

    RgbPath	"/usr/X11R6/lib/X11/rgb"

    FontPath	"/usr/X11R6/lib/X11/fonts/local/"
    FontPath	"/usr/X11R6/lib/X11/fonts/misc/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/:unscaled"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/:unscaled"
    FontPath	"/usr/X11R6/lib/X11/fonts/Type1/"
    FontPath	"/usr/X11R6/lib/X11/fonts/CID/"
    FontPath	"/usr/X11R6/lib/X11/fonts/Speedo/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/"
    FontPath	"/usr/X11R6/lib/X11/fonts/latin2/"
    FontPath	"/usr/X11R6/lib/X11/fonts/PEX/"

EndSection


Section "Module"

    Load	"dbe"

    SubSection	"extmod"
	Option	"omit xfree86-dga"
    EndSubSection

    Load	"type1"
    Load	"freetype"

EndSection


Section "ServerFlags"

    Option	"standby time"	"20"
    Option	"suspend time"	"30"
    Option	"off time"	"60"

EndSection


Section "InputDevice"

    Identifier	"Keyboard1"
    Driver	"keyboard"

    Option	"AutoRepeat"	"500 5"
    Option	"XkbKeymap"	"macintosh"
    Option	"XkbKeycodes"	"macintosh"
    Option	"XkbTypes"	"default"
    Option	"XkbCompat"	"default"
    Option	"XkbSymbols"	"de(extended)"
    Option	"XkbGeometry"	"macintosh"

EndSection


Section "InputDevice"

    Identifier	"Mouse1"
    Driver	"mouse"

    Option	"Protocol"	"busmouse"
    Option	"Device"	"/dev/adbmouse"

    Option	"Emulate3Buttons"

EndSection


Section "Monitor"

    Identifier	"PowerBookG3"

    HorizSync  1.0 - 300
    VertRefresh  1.0 - 300

#    Mode "1024x768"
#	DotClock	64.966
#	HTimings	1024 1064 1200 1344
#	VTimings	768 771 777 806
#	Flags		"-HSync" "-VSync" "-CSync"
#    EndMode

EndSection


Section "Device"

    Identifier	"ATIMach64"
    BusID	"PCI:0:17:0"
    Driver	"ati"

EndSection


Section "Screen"

    Identifier	"Screen1"
    Device	"ATIMach64"
    Monitor	"PowerBookG3"

    DefaultDepth 24

    SubSection "Display"
        Depth		8
        Modes		"1024x768"
        ViewPort	0 0
        Virtual 	1024 768
    EndSubsection

    SubSection "Display"
	Depth		16
        Modes		"1024x768"
	ViewPort	0 0
	Virtual		1024 768
    EndSubSection

    SubSection "Display"
	Depth		24
	Modes		"1024x768"
	ViewPort	0 0
	Virtual		1024 768
    EndSubSection

    SubSection "Display"
	Depth		32
        Modes		"1024x768"
	ViewPort	0 0
	Virtual		1024 768
    EndSubSection

EndSection


Section "ServerLayout"

    Identifier	"Main Layout"

    Screen	"Screen1"

    InputDevice	"Mouse1" "CorePointer"
    InputDevice "Keyboard1" "CoreKeyboard"

EndSection



--------------010100030903050201030706--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
