Date: Thu, 30 Sep 1999 07:33:43 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Lou Langholtz <ldl@chpc.utah.edu>
cc: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
In-Reply-To: <37F26FE5.98B8B00@chpc.utah.edu>
Message-ID: <Pine.GSO.4.10.9909300726510.8003-100000@begonia.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 29 Sep 1999, Lou Langholtz wrote:
> Takashi Oe wrote:
> 
> > . . .I'm fairly certain it's a bug.  Good spotting.  The last restore_flags()
> > shouldn't be there.
> >
> > --- macserial.c.ORIG    Wed Sep 29 02:05:14 1999
> > +++ macserial.c Wed Sep 29 02:05:31 1999
> > @@ -1381,7 +1381,6 @@
> >         if (info->xmit_cnt && !tty->stopped && !info->tx_stopped
> >             && !info->tx_active)
> >                 transmit_chars(info);
> > -       restore_flags(flags);
> >         return ret;
> >  }
> >
> > Takashi Oe
> 
> Bummer...
> 
> I just locked up my system and had to reboot. The above change then doesn't seem
> to fix the system hangs. On the other hand I never did see the "FB. overflow"
> message at least.
> 
> I've been trying to search around HOWTOs and FAQs and mailing lists to get a
> better idea of wether nesting save_flags(flags); cli(); stuff...;
> save_flags(new_flags); cli(); restore_flags(new_flags); restore_flags(flags); is
> ever even ok. Haven't found anything conclusive yet though. Whatever the case, it
> doesn't seem like it'd be good practice anyhow. All the other serial support C
> files I've found so far seem to avoid this except for macserial.c.

Nesting `save_flags(); cli(); ... restore_flags();' is perfectly legal. That's
exactly the reason why `save_flags()' and `restore_flags()' were invented!

Normally, to disable interrupts to make sure a critical code section is not
interrupted, you do:

    cli();
    ...
    sti();

The problem with this construct is that the `sti()' will always re-enable the
interrupts, even when they were disabled when the `cli()' was called, like in

void func(void)
{
    ...
    cli();
    ...
    sti();
    ...		// interrupts accidentally re-enabled here!
}

    cli();
    ...
    func();
    ...
    sti();

So `save_flags()' saves the current interrupt mask, and `restore_flags()'
restores it. Problem solved by writing:

void func(void)
{
    ...
    save_flags(flags);
    cli();
    ...
    restore_flags(flags);
    ...		// interrupts accidentally re-enabled here!
}

For former AmigaOS programmers: it's a bit like the Disable()/Enable() Exec
functions, which allowed nestings:

    int interrupt_disable_cnt = 0;

    void Disable(void)
    {
	cli();
	interrupt_disable_cnt++;

    }

    void Enable(void)
    {
	if (--interrupt_disable_cnt == 0)
	    sti();
    }

Conclusion: use `cli()/sti()' when you're 100% sure interrupts were enabled
before the cli() was called, and `save_flags()/cli()/restore_flags()' when
interrupts may be disabled when entering your code.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248648 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
