Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF7C1DDEE4
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 20:56:42 +1000 (EST)
Date: Tue, 15 May 2007 12:56:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
Message-ID: <20070515105635.GA1258@lst.de>
References: <20070514075415.7999BDDEC8@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070514075415.7999BDDEC8@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some comments:

 - the comment above __iounmap_at needs some updates
 - instead of the fake vm_struct in __iounmap_at just changed the
   calling conventions for unmap_vm_area to take a start and len
   value - there's only two callers including the powerpc ioremap
   code for this.  At the same time it might also get a better name.
