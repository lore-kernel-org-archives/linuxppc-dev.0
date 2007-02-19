Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 77B1EDDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 01:07:31 +1100 (EST)
Date: Mon, 19 Feb 2007 15:07:25 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/4 (updated)] ps3fb: thread updates
In-Reply-To: <Pine.LNX.4.62.0702161832200.22939@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0702191505510.32160@pademelon.sonytel.be>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
	<20070215175007.GA10817@lst.de>
	<1171575817.5644.44.camel@localhost.localdomain>
	<20070215165916.de546f0d.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0702161658530.8263@pademelon.sonytel.be>
	<20070216163811.GB32051@lst.de>
	<Pine.LNX.4.62.0702161832200.22939@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 Feb 2007, Geert Uytterhoeven wrote:
> On Fri, 16 Feb 2007, Christoph Hellwig wrote:
> > > +	DEFINE_WAIT(wait);
> > > +	DECLARE_WAIT_QUEUE_HEAD(wq);
> > > +
> > > +	while (!kthread_should_stop()) {
> > > +		prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
> > > +		if (!ps3fb.is_kicked)
> > > +			schedule();
> > > +		finish_wait(&wq, &wait);
> > > +		ps3fb.is_kicked = 0;
> > > +		ps3fb_sync(0);	/* single buffer */
> > 
> > should probably be just:
> > 
> > 	while (!kthread_should_stop()) {
> > 		ps3fb_sync(0);
> > 		schedule();
> > 	}
> > 
> > given that you don't need a waitqueue and a spurious wakeup here
> > seems harmless.
> 
> Not always. If flipping is disabled, or external flip is enabled, you don't
> want a spurious flip.

Looks like the waitqueue is needed. Without it ps3fbd runs at 100% CPU and +15
million loops per second.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
