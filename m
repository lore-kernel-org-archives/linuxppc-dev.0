Message-ID: <37F25E9D.282C83B0@chpc.utah.edu>
Date: Wed, 29 Sep 1999 12:46:54 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
References: <Pine.LNX.3.96LJ1.1b7.990929021435.16135B-100000@ofey.inetnebr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe wrote:

> On Wed, 29 Sep 1999, Lou Langholtz wrote:
>
> > What might happen if a driver does:
> >
> > save_flags(old_flags);
> > cli();
> > restore_flags(old_flags);
> > save_flags(new_flags);
> > cli();
> > restore_flags(new_flags);
> > /* can't we be interupted here? Assume yes, if so */
> > restore_flags(old_flags);
> >. . .

> I'm fairly certain it's a bug.  Good spotting.  The last restore_flags()
> shouldn't be there.
>
> --- macserial.c.ORIG    Wed Sep 29 02:05:14 1999
> +++ macserial.c Wed Sep 29 02:05:31 1999
> @@ -1381,7 +1381,6 @@
>         if (info->xmit_cnt && !tty->stopped && !info->tx_stopped
>             && !info->tx_active)
>                 transmit_chars(info);
> -       restore_flags(flags);
>         return ret;
>  }
>
> Takashi Oe

If this is true, then what about wherever else transmit_chars() is called. There's
numerous instances where because transmit_chars() itself goes into a save_flags();
cli(); ...; restore_flags() where we have these nested cli()... restore_flags().
For instance in rs_throttle() transmit_chars() is called while cli()'s already in
effect. If the real problem is the nesting of the locks introduced by
transmit_chars() then this would also seem to explain the TCP die-off phenomena.
Opinions?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
