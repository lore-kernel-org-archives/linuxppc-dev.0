Date: Wed, 19 May 2004 10:48:50 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Ho <DavidHo@nanometrics.ca>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: getting linux console on a frame buffer.
In-Reply-To: <OF3B6896EC.3575AD9B-ON85256E98.004FD727-85256E98.00510EB2@nanometrics.ca>
Message-ID: <Pine.GSO.4.58.0405191047150.23702@waterleaf.sonytel.be>
References: <OF3B6896EC.3575AD9B-ON85256E98.004FD727-85256E98.00510EB2@nanometrics.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 18 May 2004, David Ho wrote:
> I have a 240*320 16bpp LCD (framebuffer) attached to a MPC852T that I have
> trouble running simple tests like rendering an image directly to the
> framebuffer using fbi from Gerd Knorr.  I have already dump rawimage by
> catting to the /dev/fb0 device.  I am at a point where I like to understand
> the byte ordering and image rendering issues with jpeg and png files.

Have you tried fbtest (CVS module fbtest at www.sf.net/projects/linux-fbdev/)?

> The problem may be that I don't have a linux console running on the frame
> buffer device.  Would anyone know how to get the linux console on the frame
> buffer but still receives input from a serial port (I don't have a keyboard
> attached to the board.  I have been doing most things from the serial
> console and remotely).

Append `console=tty0 console=ttyS0' to the kernel command line, and kernel
messages will appear on both tty0 (fb) and ttyS0 (serial), while console input
will be taken from the last one (ttyS0).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
