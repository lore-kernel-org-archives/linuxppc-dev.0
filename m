In-Reply-To: <Pine.LNX.3.96LJ1.1b7.990929021435.16135B-100000@ofey.inetnebr.com>
Date: Wed, 29 Sep 1999 11:13:38 +0200
To: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
Message-Id: <19990929111338.022344@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 29, 1999, Takashi Oe <toe@unlserve.unl.edu> wrote:

>I'm fairly certain it's a bug.  Good spotting.  The last restore_flags()
>shouldn't be there.
>
>--- macserial.c.ORIG	Wed Sep 29 02:05:14 1999
>+++ macserial.c	Wed Sep 29 02:05:31 1999
>@@ -1381,7 +1381,6 @@
> 	if (info->xmit_cnt && !tty->stopped && !info->tx_stopped
> 	    && !info->tx_active)
> 		transmit_chars(info);
>-	restore_flags(flags);
> 	return ret;
> }

This doesn't look like the only problem. For example, in rs_close, we
call tty_wait_until_sent with interrupt disabled. Can't this cause a
deadlock ? There may be other cases like this.

I'll look into adding some fixes and include them in the next kernel I
post on my page (along with a few other stuffs I'd want to get tested,
including your page_alloc() fix which _apparently_ increased the overall
perfs on my machine but I didn't do real benchmarks). But I'm wondering
if we shouldn't include your DMA driver right now and make sure it works
fine instead of doing yet another bunch of patches to the current
macserial. I didn't try the DMA driver yet, are there known problems with it ?

I'll try to make 2.3.x versions of my various patches if I find some time
this week (may have to wait next week end).

On another issue: Is there someone with a 3400 and this famous
interrupt-less ethernet combo out there who knows how to hack into
pmac_pic.c ? I have managed to get the interrupt working with an horrible
hack in de4x5.c, and I'm trying to implement a clean version with a
cascaded controller the way I did if for gatwick on the wallstreet.
Unfortuntately, the clean version doesn't work yet, I don't have one of
those machine to test, and my remote-tester was not able (or didn't have
time) to find out what's going on with the clean version. Any volunteer ?



-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
