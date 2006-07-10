Return-Path: <mel@skynet.ie>
Received: from calculon.skynet.ie (calculon.skynet.ie [193.1.99.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFAAC67B55
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 02:01:20 +1000 (EST)
Date: Mon, 10 Jul 2006 16:31:30 +0100
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 6/6] Account for memmap and optionally the kernel image as
	holes
Message-ID: <20060710153129.GA26077@skynet.ie>
References: <20060708111243.28664.74956.sendpatchset@skynet.skynet.ie>
	<20060708111042.28664.14732.sendpatchset@skynet.skynet.ie>
	<7220.1152531055@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <7220.1152531055@warthog.cambridge.redhat.com>
From: mel@skynet.ie (Mel Gorman)
Cc: akpm@osdl.org, davej@codemonkey.org.uk, tony.luck@intel.com,
	linuxppc-dev@ozlabs.org, ak@suse.de, bob.picco@hp.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (10/07/06 12:30), David Howells didst pronounce:
> Mel Gorman <mel@csn.ul.ie> wrote:
> 
> > +unsigned long __initdata dma_reserve;
> 
> Should this be static?  Or should it be predeclared in a header file
> somewhere?
> 

It should be static as it's set by set_dma_reserve(). Thanks.

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-mm6-106-account_kernel_mmap/mm/page_alloc.c linux-2.6.17-mm6-107-fixstatic/mm/page_alloc.c
--- linux-2.6.17-mm6-106-account_kernel_mmap/mm/page_alloc.c	2006-07-10 15:55:09.000000000 +0100
+++ linux-2.6.17-mm6-107-fixstatic/mm/page_alloc.c	2006-07-10 16:03:26.000000000 +0100
@@ -87,7 +87,7 @@ int min_free_kbytes = 1024;
 
 unsigned long __meminitdata nr_kernel_pages;
 unsigned long __meminitdata nr_all_pages;
-unsigned long __initdata dma_reserve;
+static unsigned long __initdata dma_reserve;
 
 #ifdef CONFIG_ARCH_POPULATES_NODE_MAP
   /*
