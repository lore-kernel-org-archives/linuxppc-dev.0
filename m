Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 45384B7C67
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Apr 2010 22:11:38 +1000 (EST)
Date: Tue, 6 Apr 2010 17:39:05 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 4/7] hvc_console: Fix race between hvc_close and hvc_remove
Message-ID: <20100406120905.GQ4135@amit-x200.redhat.com>
References: <20100319151326.GC8541@kroah.com>
	<1269011916-8836-4-git-send-email-gregkh@suse.de>
	<1269119079.8599.65.camel@pasglop>
	<20100321043725.GA21566@amit-x200.redhat.com>
	<20100324121902.GJ15789@amit-x200.redhat.com>
	<4BAC7AD4.4030309@in.ibm.com>
	<20100326095821.GA7039@amit-x200.redhat.com>
	<4BAC9D9E.5070901@in.ibm.com>
	<20100326124340.GB7039@amit-x200.redhat.com>
	<20100406114238.GN5594@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100406114238.GN5594@kryten>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, a.p.zijlstra@chello.nl,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Tue) Apr 06 2010 [21:42:38], Anton Blanchard wrote:
> 
> Hi,
> 
> > > Looking at the commit e74d098c66543d0731de62eb747ccd5b636a6f4c,
> > > i see that for every tty_kref_get() there is a corresponding
> > > tty_kref_put() except maybe for the one in the following patch snippet
> > >
> > >        spin_lock_irqsave(&hp->lock, flags);
> > >        /* Check and then increment for fast path open. */
> > >        if (hp->count++ > 0) {
> > > +               tty_kref_get(tty);
> > >                spin_unlock_irqrestore(&hp->lock, flags);
> > >                hvc_kick();
> > >                return 0;
> > >
> > > I don't know this code very well but we might be missing a
> > > corresponding tty_kref_put() some place ?
> > 
> > See hvc_hangup:
> > 
> > 	temp_open_count = hp->count;
> > 	...
> > 	while(temp_open_count) {
> > 		--temp_open_count;
> > 		tty_kref_put(tty);
> > 		kref_put(&hp->kref, destroy_hvc_struct);
> > 	}
> 
> I don't claim to understand the tty layer, but it seems like hvc_open and
> hvc_close should be balanced in their kref reference counting.
> 
> Right now we get a kref every call to hvc_open:
> 
>         if (hp->count++ > 0) {
>                 tty_kref_get(tty); <----- here
>                 spin_unlock_irqrestore(&hp->lock, flags);
>                 hvc_kick();
>                 return 0;
>         } /* else count == 0 */
> 
>         tty->driver_data = hp;
> 
>         hp->tty = tty_kref_get(tty); <------ or here if hp->count was 0
> 
> But hvc_close has:
> 
>         tty_kref_get(tty);
> 
>         if (--hp->count == 0) {
> ...
>                 /* Put the ref obtained in hvc_open() */
>                 tty_kref_put(tty);
> ...
>         }
> 
>         tty_kref_put(tty);
> 
> Since the outside kref get/put balance we only do a single kref_put when
> count reaches 0.

OK, makes sense and since it works for you,

Acked-by: Amit Shah <amit.shah@redhat.com>

> The patch below changes things to call tty_kref_put once for every
> hvc_close call, and with that my machine boots fine.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
