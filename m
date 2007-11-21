Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CB118DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 02:41:32 +1100 (EST)
Date: Wed, 21 Nov 2007 16:41:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/8] ibm_newemac: Fix possible lockup on close
Message-ID: <20071121154123.GB23589@lst.de>
References: <1195625198.76200.922309668615.qpush@grosgo>
	<20071121060729.71A1FDDE01@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071121060729.71A1FDDE01@ozlabs.org>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 21, 2007 at 05:06:39PM +1100, Benjamin Herrenschmidt wrote:
> It's a bad idea to call flush_scheduled_work from within a
> netdev->stop because the linkwatch will occasionally take the
> rtnl lock from a workqueue context, and thus that can deadlock.
> 
> This reworks things a bit in that area to avoid the problem.

So from the name of the driver you want to keep the previous emac
driver around.  Is there a good reason for that?
