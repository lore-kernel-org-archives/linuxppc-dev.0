Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25AB2DDE27
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:38:25 +1100 (EST)
Date: Fri, 16 Feb 2007 17:38:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 1/4 (updated)] ps3fb: thread updates
Message-ID: <20070216163811.GB32051@lst.de>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
	<20070215175007.GA10817@lst.de>
	<1171575817.5644.44.camel@localhost.localdomain>
	<20070215165916.de546f0d.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0702161658530.8263@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0702161658530.8263@pademelon.sonytel.be>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	DEFINE_WAIT(wait);
> +	DECLARE_WAIT_QUEUE_HEAD(wq);
> +
> +	while (!kthread_should_stop()) {
> +		prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
> +		if (!ps3fb.is_kicked)
> +			schedule();
> +		finish_wait(&wq, &wait);
> +		ps3fb.is_kicked = 0;
> +		ps3fb_sync(0);	/* single buffer */

should probably be just:

	while (!kthread_should_stop()) {
		ps3fb_sync(0);
		schedule();
	}

given that you don't need a waitqueue and a spurious wakeup here
seems harmless.
		
