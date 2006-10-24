Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-res-R.bigfish.com (outbound-res.frontbridge.com
	[63.161.60.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D167D679E9
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 10:50:41 +1000 (EST)
Message-ID: <453D635B.20405@am.sony.com>
Date: Mon, 23 Oct 2006 17:50:35 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [RFC]: map 4K iommu pages even on 64K largepage systems.
References: <20061024002540.GA6360@austin.ibm.com>
In-Reply-To: <20061024002540.GA6360@austin.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> Subject: [RFC]: map 4K iommu pages even on 64K largepage systems.
...
> Some experimentaiton indicates that this is essentially because
> one 1500 byte ethernet MTU gets mapped as a 64K DMA region when
> the large 64K pages are enabled. Thus, it doesn't take much to
> exhaust all of the available DMA mappings for a high-speed card.
> 
> This patch changes the iommu allocator to work with its own 
> unique, distinct page size. Although the patch is long, its
> actually quite simple: it just #defines  distinct IOMMU_PAGE_SIZE
> and then uses this in al the places tha matter.

This is a step in the right direction.  Cell allows each device to
have its own io pagesize, from among those that the io controller
supports (4k, 64k, 1m,16m).  This limitation of the current iommu
code that you try to address here has caused me to use platform
specific dma alloc routines.

-Geoff
