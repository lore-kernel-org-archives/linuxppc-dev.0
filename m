Date: Tue, 20 Jan 2004 22:34:55 +0900
From: Etsushi Kato <ekato@ees.hokudai.ac.jp>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: local_irq_enable() problem...
References: <4824AFEC-4B0A-11D8-A780-00039394E428@ees.hokudai.ac.jp> <Pine.GSO.4.58.0401201102450.18625@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.58.0401201102450.18625@waterleaf.sonytel.be>
Message-Id: <20040120223457T.ekato@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 20, 2004 at 11:03:41AM +0100,
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Tue, 20 Jan 2004, Etsushi Kato wrote:
> > I just started porting Linux 2.6 for nubus powermac.  I've applied most
> > of 2.4 nubus patch to 2.6.1-rc2, and kernel compiles fine now.  But in
> > the early booting of kernel, it hangs while doing local_irq_enable()
> > just after profile_init() in start_kernel() of init/main.c.
> >
> > How can I debug kernel in this situation?  printk() is working, and
> > boot messages are shown with serial connection until "Console: colour
> > dummy device 80x25".
>
> Did you pass `console=ttyS0'?

Yup.  I set up 'console=ttyS0,38400n8 console=tty0' as a cmdline
option.

In the early boot sequence, 2.6 kernel freezes just after showing
'arch_exit' on the screen, and 'Console: colour dummy device 80x25' on
the serial console.  Even if I put printk() right after
local_irq_enable() in init/main.c, this debug print won't show up.  So
it seems something causes kernel hang while enabling MSR_EE bit, but I
can't figure out how to detect...  Does anyone have a clue?

> If all else fails, add a call to your serial print routine in
> kernel/printk.c:printk(), right after the va_end.

OK.  Thanks.
--
Etsushi Kato
ekato@ees.hokudai.ac.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
