Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1307567C5A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 04:27:24 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBDHRFP9002382
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 12:27:15 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBDHRFZi539764
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 10:27:15 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBDHREiP006501
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 10:27:15 -0700
Date: Wed, 13 Dec 2006 11:27:14 -0600
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/16] Spidernet DMA coalescing
Message-ID: <20061213172714.GQ4329@austin.ibm.com>
References: <20061206223223.GH17931@austin.ibm.com>
	<20061206232745.GA4649@austin.ibm.com>
	<20061207101151.GB27904@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061207101151.GB27904@infradead.org>
From: linas@austin.ibm.com (Linas Vepstas)
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

On Thu, Dec 07, 2006 at 10:11:51AM +0000, Christoph Hellwig wrote:
> On Wed, Dec 06, 2006 at 05:27:45PM -0600, Linas Vepstas wrote:
> > 
> > The current driver code performs 512 DMA mappings of a bunch of 
> > 32-byte structures. This is silly, as they are all in contiguous 
> > memory. Ths patch changes the code to DMA map the entie area
> > with just one call.
> 
> This is still wrong.  The descriptor array must be in dma_alloc_coherent
> memory, not a streaming mapping.  (I also think I pointed this out a while
> ago when I made dma_alloc_coherent node-aware)

Sorry, I missed this the first time. I'm splitting this off now; will 
resubmit shortly.

--linas
