Return-Path: <SRS0+a8b6c66dfb3496e0fc75+1201+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 889F767C87
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 21:12:07 +1100 (EST)
Date: Thu, 7 Dec 2006 10:11:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/16] Spidernet DMA coalescing
Message-ID: <20061207101151.GB27904@infradead.org>
References: <20061206223223.GH17931@austin.ibm.com>
	<20061206232745.GA4649@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061206232745.GA4649@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 06, 2006 at 05:27:45PM -0600, Linas Vepstas wrote:
> 
> The current driver code performs 512 DMA mappings of a bunch of 
> 32-byte structures. This is silly, as they are all in contiguous 
> memory. Ths patch changes the code to DMA map the entie area
> with just one call.

This is still wrong.  The descriptor array must be in dma_alloc_coherent
memory, not a streaming mapping.  (I also think I pointed this out a while
ago when I made dma_alloc_coherent node-aware)
