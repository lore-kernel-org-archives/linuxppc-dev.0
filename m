Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: Help from Gurus on modes and timing and frame buffers needed!
Date: Thu, 8 Nov 2001 20:49:47 -0500
Cc: Daniel Berlin <dan@cgsoftware.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
MIME-Version: 1.0
Message-Id: <20011109014750.QFJJ10804.tomts19-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I really could use some help understanding the difference in the info
stored in modes and the information you get by decoding the detailed
timing info from an EDID block.

I am trying to get my Apple Studio flat panel working (1280 by 1024) and
was able to decode the EDID block and got the following info:

PIXEL_CLOCK = 10,800
H_ACTIVE = 1280
H_BLANK = 408
V_ACTIVE = 1024
V_BLANK = 42
H_SYNC_OFF = 128
H_SYNC_WIDTH = 112
V_SYNC_OFF = 4
V_SYNC_WIDTH = 3
H_SIZE = 337
V_SIZE = 270
H_BORDER = 0
V_BORDER = 0
INTERLACED = 0
STEREO = 0
SYNC_T = 1
MISC = 0


Now when I run that through Ani's  program to print timing info from the
EDID block I get the following info:

        Mode    "1280x1024"     # vfreq 60.020Hz, hfreq 63.981kHz
                DotClock        108.000000
                HTimings        1280 1408 1520 1688
                VTimings        1024 1028 1031 1066
                Flags   "-HSync" "-VSync"
        EndMode

This actually looks alot like the mac-modes timing for the Apple 21 inch
display.  Given Daniel's Radeon patch to support LCD and his use of
mac-modes, I want to make similar Radeon patches to help my FlatPanel.

Here is that info from the kernel source:

  /* 1280x1024, 60Hz, Non-Interlaced (108.00 MHz dotclock) */
  "mac21", 60, 1280, 1024, 9260, 248, 48, 38, 1, 112, 3,
        FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED

Looking at the definition of a fb_videomode from include/linux/fb.h I can
see the following mapping:

struct fb_videomode {
    const char *name;   = "mac21"
    u32 refresh;            = 60
    u32 xres;                = 1280
    u32 yres;                = 1024
    u32 pixclock;           = 9260 = 1,00,000,000 / 10,800
    u32 left_margin;       = ?
    u32 right_margin;     = ?
    u32 upper_margin;   = ?
    u32 lower_margin;    = ?
    u32 hsync_len;        = 112
    u32 vsync_len;        = 3
    u32 sync;               = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT
    u32 vmode;             = FB_VMODE_NONINTERLACED
};


With most of the information decoded  from the EDID block allowing me to
see that hsync_len is the H_SYNC_WIDTH and vsync_len  is the V_SYNC_WIDTH,
and how the pixelclock and dotclock are related, and H_ACTIVE and V_ACTIVE
give the xres and yres information.


But how are the  left_margin, right_margin, upper_margin, and lower_margin
determined?

Are they based on the H_SYNC_OFF, V_SYNC_OFF, H_BLANK and V_BLANK?

Or are the related to H_BORDER and V_BORDER?

Or are they something else entirely?

Do Flat Panels have margins?

Also why are there so many many ways to store video mode timing
information?  This is all very confusing.

Any guidance here on how to relate mode info and timing info and how to
determine values for the margins from the EDID block info would be greatly
appreciated.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
