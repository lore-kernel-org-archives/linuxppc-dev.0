Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Derrik Pates <dpates@dsdk12.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Rage128 support for resolutions less than panel resolution?
Date: Tue, 4 Dec 2001 12:58:46 -0500
References: <Pine.LNX.4.40.0112041017530.8200-100000@andromeda.dsdk12.net>
In-Reply-To: <Pine.LNX.4.40.0112041017530.8200-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Message-Id: <20011204175547.WVJL16262.tomts14-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I don't think the EDID code has any impact on this.  It simply sets the
flatpanel monitor to its native resolution.  It isn't even used for LCD
monitors in the radeonfb.c

However if you have the correct timing info, you should be able to write a
mode to use and then use fbset to set rage128 frame buffer to that mode.

This should work to change your resolution to whatever you want as long as
the "scaling register code" patch I saw fly by recently (a couple of weeks
ago) actually made it into the aty128fb.c code yet.

If it did you should be in luck.  Just take the timing from the the full
native resolution and just change the x and y resolution and leave all of
the rest untouched.  The scaling registers code should figure out the rest.
as long as the real native panel resolution is known by the driver.

Here is what I do with a slightly modified version of the radeonfb.c

I edited my /etc/fb.modes to add the native resolution 1280x1024-FP
timings and them simply modified them to get 1024x768.  The radeonfb code
parses my monitor's EDID code so the true resolution of the flatpanel
monitor is known.  If is it not, you can pass in a panel_yres parameter
via the kernel parameters line.  aty128fb.c might have the same features.

mode "1024x768-FP"
    # D: 108.00 MHz, H: 63.981 kHz, V: 60.02 Hz
    geometry 1024 768 1024 768 8
    timings 9259 168 128 35 4 112 3
endmode


mode "1280x1024-FP"
    # D: 108.00 MHz, H: 63.981 kHz, V: 60.02 Hz
    geometry 1280 1024 1280 1024 8
    timings 9259 168 128 35 4 112 3
endmode

Hope this helps,

Kevin

On December 4, 2001 12:22, Derrik Pates wrote:
> I know it's not in Ben's kernel yet, but I read something about adapting
> the code that had been added to the Radeon framebuffer code to allow
> resolutions lower than the LCD panel's native resolution (like on
> laptops). I tried looking at the radeonfb source, and it's looking up a
> devnode property on the display device that I don't see on this iBook
> FireWire I'm using. (Specifically in the EDID reading code.)
>
> What would need to be done to get (and set?) the EDID parameters on a
> Rage128 with an LCD panel to make lower-than-native resolutions work on
> the display? Any pointers?
>
> Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
> dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
