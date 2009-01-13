Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 706D8DDFAD
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 08:04:36 +1100 (EST)
Subject: Re: [PATCH 1/4] hvc_console: do not set low_latency
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <1998eda55e236b70f63c7fb4b956b487@bga.com>
References: <hvc-console-29-3-1@bga.com>
	<200901131004.22609.borntraeger@de.ibm.com>
	<20090113113545.GB26819@cetus.boeblingen.de.ibm.com>
	<1998eda55e236b70f63c7fb4b956b487@bga.com>
Content-Type: text/plain
Date: Wed, 14 Jan 2009 08:04:04 +1100
Message-Id: <1231880644.22571.47.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Joe Peterson <joe@skyrush.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> So the simplest is to never set it.

I already applied your previous patch. Please send an incremental fix.

Cheers,
Ben.

> milton
> 
> > BUG: sleeping function called from invalid context at 
> > /root/cvs/linux-2.6.git/kernel/mutex.c:207
> > in_atomic(): 1, irqs_disabled(): 0, pid: 748, name: khvcd
> > 1 lock held by khvcd/748:
> >  #0:  (hvc_structs_lock){--..}, at: [<00000000002ceb50>] 
> > khvcd+0x58/0x12c
> > CPU: 0 Not tainted 2.6.29-rc1git #29
> > Process khvcd (pid: 748, task: 000000002fb9a480, ksp: 000000002f66bd78)
> > 070000000000000a 000000002f66ba00 0000000000000002 (null)
> >        000000002f66baa0 000000002f66ba18 000000002f66ba18 
> > 0000000000104f08
> >        ffffffffffffc000 000000002f66bd78 (null) (null)
> >        000000002f66ba00 000000000000000c 000000002f66ba00 
> > 000000002f66ba70
> >        0000000000466af8 0000000000104f08 000000002f66ba00 
> > 000000002f66ba50
> > Call Trace:
> > ([<0000000000104e7c>] show_trace+0x138/0x158)
> >  [<0000000000104f62>] show_stack+0xc6/0xf8
> >  [<0000000000105740>] dump_stack+0xb0/0xc0
> >  [<000000000013144a>] __might_sleep+0x14e/0x17c
> >  [<000000000045e226>] mutex_lock_nested+0x42/0x3b4
> >  [<00000000002c443e>] echo_char_raw+0x3a/0x9c
> >  [<00000000002c688c>] n_tty_receive_buf+0x1154/0x1208
> >  [<00000000002ca0a2>] flush_to_ldisc+0x152/0x220
> >  [<00000000002ca1da>] tty_flip_buffer_push+0x6a/0x90
> >  [<00000000002cea74>] hvc_poll+0x244/0x2c8
> >  [<00000000002ceb68>] khvcd+0x70/0x12c
> >  [<000000000015bbd0>] kthread+0x68/0xa0
> >  [<0000000000109d5a>] kernel_thread_starter+0x6/0xc
> >  [<0000000000109d54>] kernel_thread_starter+0x0/0xc
> > 1 lock held by khvcd/748:
> >  #0:  (hvc_structs_lock){--..}, at: [<00000000002ceb50>] 
> > khvcd+0x58/0x12c
> >
> >> This wont work, since the call to notifier_add is done later:
> >> What about:
> >> ---
> >>  drivers/char/hvc_console.c |    5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> Index: linux-2.6/drivers/char/hvc_console.c
> >> ===================================================================
> >> --- linux-2.6.orig/drivers/char/hvc_console.c
> >> +++ linux-2.6/drivers/char/hvc_console.c
> >> @@ -318,8 +318,6 @@ static int hvc_open(struct tty_struct *t
> >>  	} /* else count == 0 */
> >>
> >>  	tty->driver_data = hp;
> >> -	tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
> >> -
> >>  	hp->tty = tty;
> >>
> >>  	spin_unlock_irqrestore(&hp->lock, flags);
> >> @@ -327,6 +325,9 @@ static int hvc_open(struct tty_struct *t
> >>  	if (hp->ops->notifier_add)
> >>  		rc = hp->ops->notifier_add(hp, hp->data);
> >>
> >> +	if (!hp->irq_requested)
> >> +		tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
> >> +
> >>  	/*
> >>  	 * If the notifier fails we return an error.  The tty layer
> >>  	 * will call hvc_close() after a failed open but we don't want to 
> >> clean
> >
> > Acked-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> >
