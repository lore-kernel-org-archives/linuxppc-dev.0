Message-ID: <37F26FE5.98B8B00@chpc.utah.edu>
Date: Wed, 29 Sep 1999 14:00:37 -0600
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

> . . .I'm fairly certain it's a bug.  Good spotting.  The last restore_flags()
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

Bummer...

I just locked up my system and had to reboot. The above change then doesn't seem
to fix the system hangs. On the other hand I never did see the "FB. overflow"
message at least.

I've been trying to search around HOWTOs and FAQs and mailing lists to get a
better idea of wether nesting save_flags(flags); cli(); stuff...;
save_flags(new_flags); cli(); restore_flags(new_flags); restore_flags(flags); is
ever even ok. Haven't found anything conclusive yet though. Whatever the case, it
doesn't seem like it'd be good practice anyhow. All the other serial support C
files I've found so far seem to avoid this except for macserial.c.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
