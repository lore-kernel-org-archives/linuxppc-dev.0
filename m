Message-ID: <37F241DB.94C9BF00@chpc.utah.edu>
Date: Wed, 29 Sep 1999 10:44:11 -0600
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

> > . . . .seems like this might introduce a bug if we could get interrupted after
> the
> > restore of the new_flags but before the second restore of old flags in such a
> > way such that the proper state of old_flags could change. I'm not comfortable
> > enough though with my understanding of interrupts and driver routines to be
> > certain one way or another. To be more specific, consider the case on just a
> > single processor system. If this strikes anyone else as a possible race
> > condition that could introduce a bug, then this is what we need to fix in
> > macserial.c's rs_write routine since this code can potentially happen.
>
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

This is pretty much the kernel I'm running now. I haven't had the "FB. overflow"
message yet nor system-freeze but I've experienced the TCP slowdown already.
Evidence that we've got other problems as well (IMO). It's only been 20 hours or
so with new kernel so not enough time for me to feel confident though about these
results.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
