Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Michel =?iso-8859-1?q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Subject: Re: xfree86/fbdevhw not sending right mode to radeonfb.c
Date: Sun, 18 Nov 2001 13:45:23 -0500
Cc: linuxppc-dev@lists.linuxppc.org
References: <20011118140926.MNTJ9849.tomts10-srv.bellnexxia.net@there> <1006104678.9556.7.camel@pismo>
In-Reply-To: <1006104678.9556.7.camel@pismo>
MIME-Version: 1.0
Message-Id: <20011118184235.QSWE9849.tomts10-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

fbdevhw.c with DEBUG turned on shows the exact same thing I just reported.
 XFree86 is passing in the wrong mode info (missing detailed timings).

Here is a snippet of the XFree86.log

(--) RADEON(0): Virtual size is 1280x1024 (pitch 1296)
(**) RADEON(0): Mode "1280x1024-FP"
...
fbdevHW: MapMMIO 0
fbdevHW: MapVidmem 0
(**) RADEON(0): RADEONSave
fbdevHW: Save 0
fbdevHW: ModeInit 0
xfree init mode:        108000   1280 0 0 0   1024 0 0 0
fbdev init mode:        9259   1280 -1280 0 0   1024 -1024 0 0   32 8:8:8
fbdevHW: AdjustFrame 0


And here is the 1280x1024-FP mode taken from my XF86Config-4 file:

Mode    "1280x1024-FP"     # vfreq 60.020Hz, hfreq 63.981kHz
    DotClock        108.000000
    HTimings        1280 1408 1520 1688
    VTimings        1024 1028 1031 1066
    Flags   "-HSync" "-VSync"
EndMode

So for some reason xfree is missing all of the detailed timing info when
the fbdevHWModeInit is invoked.

I assume this is why others have reported problems when using different
modes than what the framebuffer devise has set to start up X11 (with
useFBDev) seems to have some problems.

I am willing to dig deeper to track this one down if someone can point me
to the code that parses the mode info from the XF86Config-4 file and loads
it into the mode structure.

Thanks,

Kevin


On November 18, 2001 12:31, Michel Dänzer wrote:
> On Sun, 2001-11-18 at 15:12, Kevin B. Hendricks wrote:
> > I am still working on the radeon driver for XFree86 and trying to get
> > the useFBDev options to work properly.
> >
> > I have a properly constructued mode line in my XF86Config-4 which I
> > specifiy.
> >
> > However when the XFree86 radeon_driver passes this initial mode to the
> > radeonfb.c kernel framebuffer driver, most of the mode information is
> > missing (no detailed timing info, just xres and yres, etc.
> >
> > The radeonfb.c messes up when this incomplete mode information is
> > passed to it (from fbdevHWModeInit ?).
> >
> > So where should I look to see where this is messing up.  It does not
> > appear to be an issue with the framebuffer kernel driver since it is
> > the victim of the receiving end of the bad data.
> >
> > It is almost like the the xfree86 code that parses the XF86Config-4
> > config file is not properly grabbing the specific mode information (or
> > somehow later it is being mangled).
> >
> > Any hints or guidance of where to look in xfree86, would be greatly
> > appreciated.
>
> fbdevHW and fbdevHWModeInit in particular are probably good places to
> start. If you enable debugging in fbdevHW, it will print detailed mode
> information.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
