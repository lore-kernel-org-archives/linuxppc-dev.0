Date: Wed, 19 May 2004 15:36:47 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?gb2312?q?Song=20Sam?= <samlinuxppc@yahoo.com.cn>
Cc: David Ho <DavidHo@nanometrics.ca>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: getting linux console on a frame buffer.
In-Reply-To: <20040519131316.49507.qmail@web15203.mail.bjs.yahoo.com>
Message-ID: <Pine.GSO.4.58.0405191535380.23702@waterleaf.sonytel.be>
References: <20040519131316.49507.qmail@web15203.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 May 2004, [gb2312] Song Sam wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > The problem may be that I don't have a linux
> > > console running on the frame buffer device.
> > > Would anyone know how to get the linux console on
> > > the frame buffer but still receives input from a
> > > serial port (I don't have a keyboard
> > > attached to the board.  I have been doing most
> > > things from the serial console and remotely).
> >
> > Append `console=tty0 console=ttyS0' to the kernel
> > command line, and kernel
> > messages will appear on both tty0 (fb) and ttyS0
> > (serial), while console input
> > will be taken from the last one (ttyS0).
>
> But this isn't a solution to have a LINUX console on
> the frame buffer with serial port input.It DID output
> some boot message to LCD but the work console is still
> ttyS0.And you can type a command like "echo a >
> /dev/tty0" to make the 'a' to LCD.Without such
> command,however,the input result still is displayed on
> serial console.Am I right?

You are right. I misunderstood the question.

If you would modify the serial port driver to send keyboard events to the input
subsystem, it would work, though.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
