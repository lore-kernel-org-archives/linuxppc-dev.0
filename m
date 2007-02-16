Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8EE8DDE24
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:36:51 +1100 (EST)
Date: Fri, 16 Feb 2007 17:36:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/4] ps3fb: thread updates
Message-ID: <20070216163615.GA32051@lst.de>
References: <20070215152301.573853000@sonycom.com>
	<20070215152432.264415000@sonycom.com>
	<20070215175007.GA10817@lst.de>
	<1171575817.5644.44.camel@localhost.localdomain>
	<20070215165916.de546f0d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070215165916.de546f0d.akpm@linux-foundation.org>
Cc: Geert.Uytterhoeven@sonycom.com, linux-fbdev-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2007 at 04:59:16PM -0800, Andrew Morton wrote:
> No, it won't get you out of down_interruptible().  But the code would have
> failed trivial testing so perhaps we're missing something.
> 
> It seems crufty to use semaphores in this manner.  afaict all we're doing
> here is poking a kernel thread and asking it to do a bit of work.  The
> standard way of doing this is to go to sleep on a waitqueue_head.

We don't even need the waitqueue.  Because it's just a single thread
waiting we can simply use wake_up_process.  (.. which you actually
used in the second half of the example, humm..)
