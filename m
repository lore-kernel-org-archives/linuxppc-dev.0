Date: Tue, 20 Jan 2004 11:03:41 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: local_irq_enable() problem...
In-Reply-To: <4824AFEC-4B0A-11D8-A780-00039394E428@ees.hokudai.ac.jp>
Message-ID: <Pine.GSO.4.58.0401201102450.18625@waterleaf.sonytel.be>
References: <4824AFEC-4B0A-11D8-A780-00039394E428@ees.hokudai.ac.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Jan 2004, Etsushi Kato wrote:
> I just started porting Linux 2.6 for nubus powermac.  I've applied most
> of 2.4 nubus patch to 2.6.1-rc2, and kernel compiles fine now.  But in
> the early booting of kernel, it hangs while doing local_irq_enable()
> just after profile_init() in start_kernel() of init/main.c.
>
> How can I debug kernel in this situation?  printk() is working, and
> boot messages are shown with serial connection until "Console: colour
> dummy device 80x25".

Did you pass `console=ttyS0'?

If all else fails, add a call to your serial print routine in
kernel/printk.c:printk(), right after the va_end.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
