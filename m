Message-ID: <36E2FB05.C877DD6@mail.esiea.fr>
Date: Sun, 07 Mar 1999 23:17:48 +0100
From: "G. =?iso-8859-1?Q?Laur=E8s?=" <laures@hp1.esiea.fr>
Reply-To: laures@hp1.esiea.fr
MIME-Version: 1.0
To: "Dev @ LinuXppc" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PBG3Series and pre-R5: a lot further
References: <XFMail.990307023826.hcaley@loomer.com> <36E29D89.B6877224@mail.esiea.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Finally, I got it !
XFBDev on PBG3 series, now the TFT screams ! I never though it would be
that good.

So it turns out that it was the lack of valid video mode that prevented
XFBDev to work properly (actually, to display properly). Now I have the
following /etc/XF86Config :

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
    Identifier "Apple PowerBook G3 Series 14,1 TFT"
    VendorName "Unknown"
    ModelName  "Unknown"

    HorizSync  31.5-48.5
    VertRefresh 55-90

Mode "1024x768"
    DotClock 65.00
    HTimings 1024 1032 1176 1344
    VTimings 768 771 777 806
    Flags    "+HSync" "+VSync" "-CSync"
EndMode

#Mode "800x600"
#    DotClock 50.00
#    HTimings 800 856 976 1040
#    VTimings 600 637 643 666
#    Flags    "+HSync" "+VSync" "-CSync"
#EndMode

#Mode "640x480"
#    DotClock 36.00
#    HTimings 640 696 752 832
#    VTimings 480 481 484 509
#    Flags    "+HSync" "+VSync" "-CSync"
#EndMode

EndSectionSection "Device"
    Identifier "Linux Frame Buffer Device"
EndSection
Section "Screen"
    Driver "fbdev"
    Device "Linux Frame Buffer Device"
    Monitor "Apple PowerBook G3 Series 14,1 TFT"
    DefaultColorDepth 32
    SubSection "Display"
	Depth 32
	Modes "640x480" "800x600" "832x624" "1024x768" "1152x870"
	ViewPort 0 0
	Virtual 1024 768
    EndSubsection
    SubSection "Display"
	Depth 24
	Modes "640x480" "800x600" "832x624" "1024x768" "1152x870"
	ViewPort 0 0
	Virtual 1152 870
    EndSubsection
    SubSection "Display"
	Depth 16
	Modes "640x480" "800x600" "832x624" "1024x768" "1152x870" "1152x900" "1280x1024"
	ViewPort 0 0
	Virtual 1280 1024
    EndSubsection
    SubSection "Display"
	Depth 8
	Modes "640x480" "800x600" "832x624" "1024x768" "1152x870" "1152x900" "1280x1024"
	ViewPort 0 0
	Virtual 1280 1024
    EndSubsection
EndSection

Please note that the 3 modes defined for the LCD are taken from a
Toshiba laptop screen... I didn't had enough info to build the right
ones, however they work quite well.
Two are commented because if not, they are taken instead the 1024x768,
which is obviously nicer. I don't know why.

The server is stable now, no more freezes as before. I just lack a
french keyboard and 3 buttons and enlightenment and gnome and java and....

This machine is now really a screamer, I'd like to thank G.U. for his
amazing work, of which I can finally make some use !

The whole process to make this working from a fresh pre-R5 installation
is: (by memory)
make sure the XFree86-FBDev rpm is installed
go to /etc/X11 and there ln -s /usr/X11R6/bin/XF69_FBDev X
copy the enclosed /etc/XF86Config
startx !!!
-- 
GoM

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
