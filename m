Date: Mon, 15 Sep 2003 20:37:44 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: Problem of concurrency in arch/ppc/8260_io/uart.c
In-reply-to: <AB5AF73EAF23304EA1B932174137CED70303EA@m5tmail.m5t.com>
To: Jean-Denis Boyer <jdboyer@m5t.com>,
	Steffen Rumler <Steffen.Rumler@siemens.com>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIEFCFPAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I have just tested your patch on 8260 and it fixes the problem when printk is called from interrupt context while data is
> printed from user mode application. GREAT!
>
> I also ported the patch to 860 (as said earlier, code is almost the same), but it hung at boot up, just after printing
> "Calibrating delay loop..." :-(
>
> I remember I had such problems in the past (on 860), when calling "spin_lock_irqsave/restore" from interrupt context. If
> I use function "in_interrupt()" to avoid calling them from interrupt, everything works fine, and the bug is effectively fixed.
>
> I just don't know where is the problem??? It looks like there is a bug on 860 using "local_irq_save/restore" in interrupt
> context?!?

The patch is a little broken w.r.t my_console_write, the last "if(info)" should be a
"if(ser->info)". Don't know why it works on 82xx as is, it should not.

However, this patch also adds lots of IRQ latency. I think the idea is right, but one must
reduce time with IRQ's off. It looks easy for all functions, but not for my_console_write()

    Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
