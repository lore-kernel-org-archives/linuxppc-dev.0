From: mutex@kerneli.org
Date: Wed, 4 Jun 2003 09:28:37 -0700
To: Michel D?nzer <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: new ATI sleep code freezes
Message-ID: <20030604162837.GF1982@heliosphan>
References: <20030529154143.GC7896@heliosphan> <1054496170.25677.28.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
In-Reply-To: <1054496170.25677.28.camel@thor.holligenstrasse29.lan>
Content-Type: multipart/mixed; boundary="SxgehGEc6vB0cZwN"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

see below...

On Sun, Jun 01, 2003 at 09:36:11PM +0200 or thereabouts, Michel D?nzer wrote:
>
> On Thu, 2003-05-29 at 17:41, mutex@kerneli.org wrote:
> >
> > This has taken me a while to decide it was a bug and not a freak
> > accident. About one to two times a week I have noticed that my powerbook
> > will hand during the sleep process. Usually, when the sleep operation
> > completes, there is a quick screen power blank. Then about another 1.5
> > seconds of the LCD being illuminated, with what looks like some random
> > part of video memory being displayed, then finally the machine goes
> > to sleep. Occasionally I am seeing a freeze during the step where the
> > machine stays on for 1.5 seconds and has not quite been put to sleep. I
> > have been unable to diagnose this, as it happens so infrequently, but I
> > figured by posting I could hopefully get some more people experiencing
> > this as well. my specs:
> > 	1ghz tipb, 1gig ram, radeon 9M, 2.4.20-ben8
>
> Pretty much the same configuration here, but I haven't seen this, even
> though I've been enjoying uptimes of weeks, usually with at least one
> sleep cycle a day.
>
> What's your DRI related setup?

hmmm well i don't seem to have _any_ sort of DRI setup. Although
you noting for me to look at my XF86Config, i noticed i had left
AGPFastWrite enabled for a test i was running for benh a while ago.
I will set that off and see if that helps at all. I have attached my
XF86Config

Dave

--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=XF86Config-4
Content-Transfer-Encoding: quoted-printable

Section "ServerLayout"
Identifier     "XFree86 Configured"
Screen      0  "Screen0" 0 0
InputDevice    "Mouse0" "CorePointer"
InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"
RgbPath      "/usr/X11R6/lib/X11/rgb"
ModulePath   "/usr/X11R6/lib/modules"
FontPath	"/usr/X11R6/lib/X11/fonts/truetype"
FontPath     "/usr/X11R6/lib/X11/fonts/misc/"
FontPath     "/usr/X11R6/lib/X11/fonts/Speedo/"
FontPath     "/usr/X11R6/lib/X11/fonts/Type1/"
FontPath     "/usr/X11R6/lib/X11/fonts/CID/"
FontPath     "/usr/X11R6/lib/X11/fonts/75dpi/"
FontPath     "/usr/X11R6/lib/X11/fonts/100dpi/"
EndSection

Section "Module"
Load  "extmod"
#Load  "dri"
#Load  "drm"
Load  "dbe"
Load  "record"
Load  "xtrap"
Load  "glx"
Load  "speedo"
Load  "type1"
EndSection

Section "InputDevice"
Identifier  "Keyboard0"
Driver      "keyboard"
#Option          "CustomKeycodes"
Option          "XkbModel"      "Macintosh"
Option          "XkbLayout"     "us"
Option          "XkbRules"      "xfree"
EndSection

Section "InputDevice"
Identifier  "Mouse0"
Driver      "mouse"
Option 	"Protocol"        "IMPS/2"
Option          "ZAxisMapping"  "4 5"
Option          "Device"        "/dev/input/mice"
EndSection

Section "Monitor"
Identifier   "Monitor0"
VendorName   "Monitor Vendor"
ModelName    "Monitor Model"
UseModes	"Modes0"
HorizSync       30-70
VertRefresh     50-160
EndSection

Section "Device"
### Available Driver options are:-
### Values: <i>: integer, <f>: float, <bool>: "True"/"False",
### <string>: "String", <freq>: "<f> Hz/kHz/MHz"
### [arg]: arg optional
#Option     "NoAccel"            	# [<bool>]
#Option     "SWcursor"           	# [<bool>]
#Option     "Dac6Bit"            	# [<bool>]
#Option     "Dac8Bit"            	# [<bool>]
#Option     "ForcePCIMode"       	# [<bool>]
#Option     "CPPIOMode"          	# [<bool>]
#Option     "CPusecTimeout"      	# <i>
#Option     "AGPMode"            	# <i>
Option     "AGPFastWrite"       	"True"# [<bool>]
#Option     "AGPSize"            	# <i>
#Option     "RingSize"           	# <i>
#Option     "BufferSize"         	# <i>
#Option     "EnableDepthMoves"   	# [<bool>]
#Option     "EnablePageFlip"     	# [<bool>]
#Option     "NoBackBuffer"       	# [<bool>]
#Option     "PanelOff"           	# [<bool>]
#Option     "DDCMode"            	# [<bool>]
#Option     "CloneDisplay"       	# <i>
#Option     "CloneMode"          	# [<str>]
#Option     "CloneHSync"         	# [<str>]
#Option     "CloneVRefresh"      	# [<str>]
Option     "UseFBDev"          "True"	# [<bool>]
#Option     "VideoKey"           	# <i>
Identifier  "Card0"
Driver 		"ati"
VendorName  "ATI Technologies Inc"
BoardName   "Radeon R250 Lf [Radeon Mobility 9000]"
BusID       "PCI:0:16:0"
EndSection

Section "Screen"
Identifier "Screen0"
Device     "Card0"
Monitor    "Monitor0"
DefaultDepth 16
SubSection "Display"
Depth 1
Modes  	"1280x854"=20
EndSubSection
SubSection "Display"
Depth 4
Modes  	"1280x854"=20
EndSubSection
SubSection "Display"
Depth 8
Modes  	"1280x854"=20
EndSubSection
SubSection "Display"
Depth 15
Modes  	"1280x854"=20
EndSubSection
SubSection "Display"
Depth 16
Modes  	"1280x854"=20
EndSubSection
SubSection "Display"
Depth 24
Modes  	"1280x854"=20
EndSubSection
SubSection "Display"
Depth 32
Modes  	"1280x854"=20
EndSubSection
EndSection

Section "DRI"
	Mode 0666
EndSection

Section "Modes"
        Identifier      "Modes0"
	# mode generated by Xeasyconf
	Modeline "1280x854" 79.815 1280 1296 1408 1536  854 855 858 866  -HSync -V=
Sync
EndSection

--SxgehGEc6vB0cZwN--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
