Date: Wed, 29 Sep 1999 02:16:35 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Lou Langholtz <ldl@chpc.utah.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
In-Reply-To: <37F1AD4B.585E99AB@chpc.utah.edu>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990929021435.16135B-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 29 Sep 1999, Lou Langholtz wrote:

> What might happen if a driver does:
> 
> save_flags(old_flags);
> cli();
> restore_flags(old_flags);
> save_flags(new_flags);
> cli();
> restore_flags(new_flags);
> /* can't we be interupted here? Assume yes, if so */
> restore_flags(old_flags);
> 
> seems like this might introduce a bug if we could get interrupted after the
> restore of the new_flags but before the second restore of old flags in such a
> way such that the proper state of old_flags could change. I'm not comfortable
> enough though with my understanding of interrupts and driver routines to be
> certain one way or another. To be more specific, consider the case on just a
> single processor system. If this strikes anyone else as a possible race
> condition that could introduce a bug, then this is what we need to fix in
> macserial.c's rs_write routine since this code can potentially happen.

I'm fairly certain it's a bug.  Good spotting.  The last restore_flags()
shouldn't be there.

--- macserial.c.ORIG	Wed Sep 29 02:05:14 1999
+++ macserial.c	Wed Sep 29 02:05:31 1999
@@ -1381,7 +1381,6 @@
 	if (info->xmit_cnt && !tty->stopped && !info->tx_stopped
 	    && !info->tx_active)
 		transmit_chars(info);
-	restore_flags(flags);
 	return ret;
 }


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
