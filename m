Content-Type: text/plain;
  charset="iso-8859-1"
From: Alban Fellows <Alban.Fellows@blueyonder.co.uk>
To: brad allison <jackal@aol.net>,
	YellowDog Linux General <yellowdog-general@lists.terrasoftsolutions.com>
Subject: Re: Nvidia support
Date: Mon, 20 May 2002 20:53:37 +0100
Cc: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.4.44.0205201347260.24446-100000@horus.office.aol.com>
In-Reply-To: <Pine.LNX.4.44.0205201347260.24446-100000@horus.office.aol.com>
MIME-Version: 1.0
Message-Id: <200205202053.37952.Alban.Fellows@blueyonder.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Monday 20 May 2002 06:54, brad allison wrote:
> On Fri, 17 May 2002, Bill Fink wrote:
> > On Fri May 17 2002, brad allison wrote:
> > > I was talking about my G4 900Mhz Quicksilver which came with a GeForce4
> > > card.
> > >
> > > I was able to find a co-worker who has an older G4 with a GeForce2 MX
> > > card and we traded.
> > >
> > > So I'm now testing against the GeForce2 MX card which is listed as
> > > "supported".
> > >
> > > I was able to X working with it using the "nv" driver however it seems
> > > to ignore everything in /etc/X11/XF86Config-4 and it boots into
> > > whatever resolution it wants.  The numbers don't match.
> > >
> > > I figured this would be the fb settings so I checked what fbset says.
> > > fbset says I'm at mode "640x480-283" which is what my consoles are
> > > running at.
> > >
> > > I selected 1280x1024 in Xconfigurator, when X starts it's coming up in
> > > 1280x960.
> > >
> > > Anyone know why?  Or how to fix this?
> >
> > You might give this a try:
> >
> > First boot a kernel with the riva kernel driver enabled but don't start
> > X, i.e. boot into runlevel 3.  Create a new entry in /etc/yaboot.conf
> > with something like the following line added:
> >
> > 	append="video=riva:1280x1024-24@60 3"
>
> Nothing I did on the command line changed resolution.
>
> So, then I installed MacOSX on one of the other partitions.  Inside MacOSX
> I set the resolution to 1280x1024, then rebooted.  Now the yaboot prompt,
> boot prompt, and console messages all come up at 1280x1024.
>
> I booted with ben's kernel with the "novideo" option in yaboot.conf into
> init 3.
>
> Then I re-ran Xconfiguration.  Added lines to /etc/X11/XF86Config-4 from
> fbset -x, and changed the driver to "nv".
>
> When I run X it -still- comes up in 1280x960 @ 60.00.
>
> So it's ignoring both the fb settings -and- the XF86Config-4 and booting
> into whatever resolution it can sync too.

I have the G4/733 DVD-R Mac ( The one before the quicksilver I think) with the NVidia GeForce 2MX

I use two configurations with YDL 2.2 and XFree 4.0.2
1) video=riva:1280x1024-8@85 console driver and fbdev XFree driver
I can choose the resolution of the console at boot time and XFree at multiple resolutions
2) video=ofonly for the console and nv driver in XFree
I am fixed at the last Mac resolution for the console, but XFree can run at multiple resolutions.

I enclose the relevant entries from my XF86Config-4
Note: not all resolutions listed actually work (maybe dot clock, hsync or vsync limits)

# **********************************************************************
# Monitor section
# **********************************************************************

# Any number of monitor sections may be present

Section "Monitor"

   Identifier  "ProNitron 19/800"

   HorizSync	50-120

   VertRefresh 70-100

   Option "DPMS"
   DisplaySize	360 270

Modeline "1280x1024"  157.50  1280 1344 1504 1728  1024 1025 1028 1072 +hsync +vsync -csync
Modeline "1600x1200"  220.02  1600 1624 1808 2080  1200 1204 1207 1244 +hsync +vsync -csync

EndSection

# **********************************************************************
# Graphics device section
# **********************************************************************

# Any number of graphics device sections may be present


Section "Device"
    Identifier  "NVIDIA GeForce"
    Driver      "nv"
    BusID       "PCI:0:16:0"
    VideoRam    32768
#    Option      "HWCursor"	"true"
#    Option	"NoINT10"
#    Option	"NoDDC"
#    Option      "NoAccel"	"true"
#    Option	"UseFBDev"

    # Insert Clocks lines here if appropriate
EndSection

Section "Device"
    Identifier  "Frame Buffer"
    Driver      "fbdev"
    BusID       "PCI:0:16:0"
    VideoRam    32768
    # Insert Clocks lines here if appropriate
EndSection


# **********************************************************************
# Screen sections
# **********************************************************************

Section "Screen"
    Identifier  "Screen 1"
    #Device      "NVIDIA GeForce"
    Device      "Frame Buffer"
    Monitor     "ProNitron 19/800"
    #Option      "NoAccel"
    DefaultDepth 16

    Subsection "Display"
        Depth       1
        Modes       "1600x1200" "1280x1024" "1024x768" "800x600" "640x480-75"
        ViewPort    0 0
    EndSubsection
    Subsection "Display"
        Depth       8
        Modes       "1600x1200" "1280x1024" "1024x768" "800x600" "640x480-75"
        ViewPort    0 0
    EndSubsection
    Subsection "Display"
        Depth       16
        Modes       "1600x1200" "1280x1024" "1024x768" "800x600" "640x480-75"
        ViewPort    0 0
    EndSubsection
    Subsection "Display"
        Depth       24
        Modes       "1600x1200" "1280x1024" "1024x768" "800x600" "640x480"
        ViewPort    0 0
    EndSubsection
    Subsection "Display"
        Depth       32
        Modes       "1600x1200" "1280x1024" "1024x768" "800x600" "640x480-75"
        ViewPort    0 0
    EndSubsection
EndSection


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
