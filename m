Date: Sat, 13 Feb 1999 13:28:38 -0700 (MST)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
cc: linux-fbdev@vuser.vu.union.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: [linux-fbdev] some modes "default" solutions
Message-ID: <Pine.LNX.3.96LJ1.1b7.990213120624.657A-100000@cricket>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


geert,

> With `mode default' XF68_FBDev will use this virtual screen, unless you
> override the virtual screen size with `Virtual x y' in your XF86Config.
                                         ^^^^^^^^^^^ 

"Virtual" is ignored in Xfb when using modes default. i looked at fbdev.c
in xfree to find a reason for this. i think it's because this line of code

 fbdevInfoRec.SwitchMode = fbdevSwitchMode;

is only executed if the mode is NOT default. fbdevSwitchMode() is
responsible for ultimately making the ioctl call that changes mode
(including virtual size) so the higher layers of the X server won't even
know how to change the virtual size. 

it's probably not a simple matter of adding that line however. i'm not
sure how you'd make sure all the other parameters of the graphics mode
match up. 

The config below comes up with virtual 1024x1024 on my 7500 and 1024x6128
on the imac. (using v3.3.3 18Nov1998) 

brad

---------- Forwarded message ----------
Section "Files"
    RgbPath	"/usr/X11R6/lib/X11/rgb"
    FontPath	"/usr/X11R6/lib/X11/fonts/misc/"
    FontPath	"/usr/X11R6/lib/X11/fonts/Type1/"
    FontPath	"/usr/X11R6/lib/X11/fonts/Speedo/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/"
EndSection
Section "ServerFlags"
EndSection
Section "Keyboard"
    Protocol	"Standard"
    AutoRepeat	500 5
XkbDisable
EndSection
Section "Pointer"
    Protocol	"busmouse"
    Device	"/dev/mouse"
EndSection
Section "Monitor"
    Identifier	"Generic"
EndSection
Section "Device"
    Identifier "Linux Frame Buffer Device"
    Option "noaccel"
EndSection
Section "Screen"
    Driver	"fbdev"
    Device	"Linux Frame Buffer Device"
    Monitor	"Generic"
    SubSection	"Display"
        Modes	"default"
	Virtual 1024 768
    EndSubsection
EndSection



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
