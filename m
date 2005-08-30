Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D292681CB
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 05:09:54 +1000 (EST)
Date: Tue, 30 Aug 2005 21:09:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas DET <nd@bplan-gmbh.de>
Message-ID: <20050830190939.GA17133@lst.de>
References: <20050830181119.E3A491C000B2@mwinf1203.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050830181119.E3A491C000B2@mwinf1203.wanadoo.fr>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>,
	Kumar Gala <galak@freescale.com>
Subject: Re: Marvell MV6436xx ethernet driver patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 30, 2005 at 08:07:33PM +0100, Nicolas DET wrote:
> By the way, I noticed that page_address() sometimes returns NULL when using
> highmem (with a lot of mem).

You can only use page_address() on kernel-mapped memory.  For
non-GFP_KERNEL allocation you need to use kmap/kmap_atomic to map it
into kernel-virtual memory space.
