Date: Tue, 13 Jul 1999 14:53:09 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Joe Julicher <joe_julicher@macktrucks.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: FB stuff from Rev 1 G3
In-Reply-To: <3.0.5.32.19990713084345.00807570@mailhost.bulldog.com>
Message-ID: <Pine.LNX.4.10.9907131449000.6336-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 13 Jul 1999, Joe Julicher wrote:
> I am trying to get 1600x1200-75 running on my G3.  The fb.modes database
> does not have such an entry.  The closest being 1600x1200-76, which my
> monitor complains about, or 1600x1200-66 which I complain about.  The MacOS
> can do 1600x1200-75 (or so my monitor tells me) and the G3 documentation
> says that is the greatest that my Rev 1 machine can do.  I CAN get this
> setup with the no-video driver setting at boot.  BUT of course I want the
> accel video.  How do I glean the video timing for this video mode.  Is
> there a MacOS utility to measure the mode?  Is there a FB method to report
> the mode when using the generic FB driver?  I tried fbset while I was in
> no-driver mode, but it reported strange things that made no sense.  I

Offb doesn't know the real timings: all it knows is the resolution.

> haven't yet sat down with a calculator and tweaked the 76hz & 66hz settings
> into a 75hz setting.  I suppose that is what I need to do.

Yes, that's indeed what you need to do :-)

XFree86 has this modeline for 1600x1200 @ 75 Hz, 93.75 kHz hsync:

    Modeline "1600x1200"  202.5  1600 1664 1856 2160  1200 1201 1204 1250 +HSync +VSync

Read linux/Documentation/fb/framebuffer.txt to learn how to convert the
timings.

Oh, I have them at hand here:

    pixclock = 4938
    left_margin = 304
    right_margin = 64
    upper_margin = 46
    lower_margin = 1
    hsync_length = 192
    vsync_length = 3
    syncflags = FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
