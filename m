Message-ID: <3905CD24.A0FC8A9F@relog.ch>
Date: Tue, 25 Apr 2000 18:51:48 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
References: <200004240616.XAA02709@pop3.ucdavis.edu>
	 <39058023.39877695@relog.ch> <3905650C.FBCBB453@ucdavis.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"W. Taylor Holliday" wrote:
>
> Michel Dänzer wrote:
>
> > Let me guess, you're using the fbdev driver for the secondary card? It
> > needs the BusID of the gfx chip to be specified in the Device Section or
> > the server will hang the machine.
>
> I specified the busID. According to /proc/pci, my AGP card is 0:16:0 and my
> PCI card is 1:3:0.

Looks right. But you have to specify the framebuffer device for the secondary
card as well, and you only have to start one server.


> The server hangs the system using both fbdev and r128. I'm running kernel
> 2.2.15pre19.

If my suggestion doesn't work, the log(s) (/var/log/XFree86.[01].log) may be
helpful.


I suggest the following XF86Config:


Section "ServerLayout"
        Identifier     "XFree86 Configured"
        Screen      0  "Screen0" 0 0
# If it complains about the Layout Section, try enclosing RightOf in double
# quotes
	Screen      1  "Screen1" RightOf 0
        InputDevice    "Mouse0" "CorePointer"
        InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"
    RgbPath     "/usr/X11R6/lib/X11/rgb"
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
EndSection

Section "Module"
        Load  "GLcore"
        Load  "dbe"
	Load  "extmod"
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
        Option "XkbModel"  "macintosh"
        Option "XkbLayout"  "us"
EndSection

Section "InputDevice"
        Identifier  "Mouse0"
        Driver      "mouse"
        Option      "Protocol" "IMPS/2"
        Option      "Device" "/dev/usbmouse"
EndSection

# Change this to reflect the first monitor
Section "Monitor"
        Identifier   "Monitor0"
        VendorName   "Apple Computer"
        ModelName    "Studio 17"
        HorizSync    30-85
        VertRefresh  48-160
EndSection

Section "Monitor"
        Identifier   "Monitor1"
        VendorName   "Apple Computer"
        ModelName    "Studio 17"
        HorizSync    30-85
        VertRefresh  48-160
EndSection

Section "Device"
        Identifier  "AGP"
        Driver      "r128"
        Option     "HWcursor"
        Option     "UseFBDev"
        BusID       "PCI:0:16:0"
EndSection

Section "Device"
        Identifier  "PCI"
        Driver      "r128"
        Option     "HWcursor"
        Option     "UseFBDev"
	Option     "fbdev" "/dev/fb1"
        BusID       "PCI:1:3:0"
EndSection

Section "Screen"
        Identifier "Screen0"
        Device     "AGP"
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

Section "Screen"
        Identifier "Screen1"
        Device     "PCI"
        Monitor    "Monitor1"
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



This assumes that fb0 is on the AGP card and that its monitor is on the left
side.


Now to get some extra candy, start the server with the +Xinerama option and it
will combine both screens as if they were one big one! :)


Hope it works,

Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
