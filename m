Message-ID: <36E29D89.B6877224@mail.esiea.fr>
Date: Sun, 07 Mar 1999 16:38:56 +0100
From: "G. =?iso-8859-1?Q?Laur=E8s?=" <laures@hp1.esiea.fr>
Reply-To: laures@hp1.esiea.fr
MIME-Version: 1.0
To: Batmensch <hcaley@loomer.com>,
        "Dev @ LinuXppc" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PBG3Series and pre-R5: a little bit further
References: <XFMail.990307023826.hcaley@loomer.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello *,

Batmensch : to be continued on the list

This afternoon I discovered the XF86Config.controlfb of Mr T. Oe I believe.
I tried it on my 8600, thinking it would accelerate somethings...(may be
later with the controlfb.c took at the same archive) but instead I took
some time to better use the "Monitor" statement of the XF86Config.
I set the good values for my monitor (Hitachi CM751ET) and now XFBDev
behaves slightly better to my taste.
For example I now get rid of the strange 1280x1024 real over 1280x16XX
virtual resolution of the very generic XF86Config.pmac.

Wich leaded me to this : what about if XFBDev tryied the same weird
resolutions on the poor LCD of my PBG3 ? (I use XF86Config.pmac on the
PBG3). Since the beginning I though it would be an error in the
resolution , this strange behavior of two small X screens in two
quarters etc..

I tried to include in my 8600's XF86Config the LCD settings, but I lack
some info (how to set 1024x768@60Hz)
Well, I hooked up the hitachi on the PBG3, with the SAME config as the
8600 (works here in 1280x1024@75Hz) and it didn't work.
I got basically the same error than here (no valid modes found, after
having eliminated all modes), using my half definition for the PBG3 14,1
LCD :

XFree86 Version 3.3.3 / X Window System
(protocol Version 11, revision 0, vendor release 6300)
Release Date: November 18 1998
	If the server is older than 6-12 months, or if your card is newer
	than the above date, look for a newer version before reporting
	problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.1.130 ppc [ELF] 
Configured drivers:
   FBDev: Server for frame buffer device
   (Patchlevel 10): mfb, afb, cfb8, cfb16, cfb32, NCR 77C32BLT (accel),
ATI Mach64 (accel), IMS TwinTurbo (accel)
(using VT number 7)

XF86Config: /etc/XF86Config
(**) stands for supplied, (--) stands for probed/default values
(**) XKB: keymap: "macintosh" (overrides other XKB settings)
(**) Mouse: type: BusMouse, device: /dev/adbmouse, buttons: 3
(**) FBDev: Graphics device ID: "Linux Frame Buffer Device"
(**) FBDev: Monitor ID: "Apple PowerBook G3 Series 14,1 TFT"
(--) FBDev: Mode "1024x768" needs hsync freq of 59.91 kHz. Deleted.
Warning: The directory "/usr/X11R6/lib/X11/fonts/local/" does not exist.
         Entry deleted from font path.
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(**) FBDev: Using XF86Config video mode database
(--) FBDev: Removing mode "640x480" from list of valid modes.
(--) FBDev: Removing mode "800x600" from list of valid modes.
(--) FBDev: Removing mode "832x624" from list of valid modes.
(--) FBDev: Removing mode "1024x768" from list of valid modes.
(--) FBDev: Removing mode "1152x870" from list of valid modes.
(--) FBDev: Removing mode "1152x900" from list of valid modes.

Fatal server error:
No valid modes found.


When reporting a problem related to a server crash, please send
the full server output, not just the last messages

X connection to :0.0 broken (explicit kill or server shutdown).

Here is my long-awaited ;-) XF86Config :

# /etc/XF86Config
# makes XF68_FBDev emulate Xpmac by using the current video mode
# and the mac mouse. be sure to compile macintosh mouse
# support into your kernel and to create /dev/adbmouse.
# major=10 minor=10
# (Courtesy Brad Midgley <brad@pht.com>)

Section "Files"
    RgbPath "/usr/X11R6/lib/X11/rgb"
    FontPath "/usr/X11R6/lib/X11/fonts/misc/"
    FontPath "/usr/X11R6/lib/X11/fonts/local/"
    FontPath "/usr/X11R6/lib/X11/fonts/Type1/"
    FontPath "/usr/X11R6/lib/X11/fonts/Speedo/"
    FontPath "/usr/X11R6/lib/X11/fonts/75dpi/"
    FontPath "/usr/X11R6/lib/X11/fonts/100dpi/"
EndSection
Section "ServerFlags"
EndSection
Section "Keyboard"
    Protocol "Standard"
    AutoRepeat 300 5
    XkbKeymap "macintosh"
EndSection
Section "Pointer"
    Protocol "BusMouse"
    Device "/dev/adbmouse"
EndSection
Section "Monitor"
    Identifier "Generic"

EndSection
Section "Monitor"
    Identifier "Apple PowerBook G3 Series 14,1 TFT"
    VendorName "Unknown"
    ModelName  "Unknown"

    HorizSync  31.5
    VertRefresh 60

Mode "1024x768"
    # H: 59.905 kHz, V: 74.509 Hz
    DotClock 79.555
    HTimings 1024 1068 1164 1328
    VTimings 768 771 774 804
EndMode

EndSection
Section "Monitor"
    Identifier "Hitachi CM751ET"
    VendorName "Hitachi"
    ModelName "CM751ET"

    HorizSync	31-93
    VertRefresh	50-160
    Gamma 1.5

ModeLine "1280x1024" 155.000 1280 1384 1528 1688 1024 1025 1028 1066
+HSync +VSync -CSync
#ModeLine "1280x1024" 144.551 1280 1352 1496 1632 1024 1025 1028 1059
+HSync +VSync -CSync

ModeLine "1152x900" 146.606 1152 1320 1360 1620 900 901 905 943 +HSync
+VSync -CSync
#ModeLine "1152x900" 130.000 1152 1320 1360 1620 900 901 905 943 +HSync
+VSync -CSync

ModeLine "1152x870" 94.358 1152 1216 1280 1344 870 902 904 936 -HSync
-VSync -CSync

Mode "1024x768"
    # H: 59.905 kHz, V: 74.509 Hz
    DotClock 79.555
    HTimings 1024 1068 1164 1328
    VTimings 768 771 774 804
    Flags    "+HSync" "+VSync" "-CSync"
EndMode

Mode "832x624"
    # H: 49.538 kHz, V: 74.270 Hz
    DotClock 57.069
    HTimings 832 876 940 1152
    VTimings 624 625 628 667
    Flags    "-HSync" "-VSync" "-CSync"
EndMode

Mode "800x600"
    # H: 46.507 kHz, V: 74.411 Hz
    DotClock 49.112
    HTimings 800 828 908 1056
    VTimings 600 601 604 625
    Flags    "+HSync" "+VSync" "-CSync"
EndMode

Mode "640x480"
    # H: 34.880 kHz, V: 66.437 Hz
    DotClock 30.137
    HTimings 640 716 780 864
    VTimings 480 483 486 525
    Flags    "-HSync" "-VSync" "-CSync"
EndMode

EndSection
Section "Device"
    Identifier "Linux Frame Buffer Device"
EndSection
Section "Screen"
    Driver "fbdev"
    Device "Linux Frame Buffer Device"
    Monitor "Apple PowerBook G3 Series 14,1 TFT"
#    DefaultColorDepth 32
    DefaultColorDepth 16
#    DefaultColorDepth 8
    SubSection "Display"
	Depth 32
	Modes "640x480" "800x600" "832x624" "1024x768" "1152x870"
#	ViewPort 0 0
	Virtual 1152 870
    EndSubsection
    SubSection "Display"
	Depth 24
	Modes "640x480" "800x600" "832x624" "1024x768" "1152x870"
#	ViewPort 0 0
	Virtual 1152 870
    EndSubsection
    SubSection "Display"
	Depth 16
	Modes "640x480" "800x600" "832x624" "1024x768" "1152x870" "1152x900" "1280x1024"
#	ViewPort 0 0
	Virtual 1280 1024
    EndSubsection
    SubSection "Display"
	Depth 8
	Modes "640x480" "800x600" "832x624" "1024x768" "1152x870" "1152x900" "1280x1024"
#	ViewPort 0 0
	Virtual 1280 1024
    EndSubsection
EndSection


My question is : is it necessary to tune things to this end to get this
[snip] of XFBdev working ?
Has it already be done ? If yes where ?
-- 
GoM

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
