Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBD09DDE29
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 04:50:29 +1100 (EST)
Date: Thu, 15 Feb 2007 18:50:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert.Uytterhoeven@sonycom.com
Subject: Re: [patch 1/4] ps3fb: thread updates
Message-ID: <20070215175007.GA10817@lst.de>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070215152432.264415000@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 04:23:02PM +0100, Geert.Uytterhoeven@sonycom.com wrote:
> +	do {
> +		try_to_freeze();
> +		error = down_interruptible(&ps3fb.sem);
> +		if (!error && !atomic_read(&ps3fb.ext_flip))
>  			ps3fb_sync(0);	/* single buffer */

this still can deadlock when calling kthread_stop.  You really want
to use wake_up_process to kick this thread or use a workqueue.
