Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7725DE215
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 20:52:11 +1000 (EST)
Date: Fri, 22 May 2009 19:51:44 +0900
To: Ian.Campbell@eu.citrix.com
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1242932497.25553.230.camel@localhost.localdomain>
References: <4A1592CF.8000208@goop.org>
	<E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
	<1242932497.25553.230.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20090522194810X.fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org, jeremy@goop.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 21 May 2009 20:01:37 +0100
Ian Campbell <Ian.Campbell@eu.citrix.com> wrote:

> > It's not actually clear to me that we need that check, though.  Can 
> > someone explain what case that was designed to catch?
> 
> If map_single fails and returns NULL then we try to use
> io_tlb_overflow_buffer, if that is somehow not DMA-able (for the
> particular device) then the check will trigger. I would have thought we
> could arrange that the overflow buffer is always OK and really if
> map_page is failing we must be close the edge already.

And iotlb buffers are not guaranteed to be DMA-capable; it's possible
that some drivers (with poor dma address restrictions) can't handle
some part of iotlb buffers.

So after allocating some ioblb buffer, we need to check if the buffers
are DMA-capable for a driver. Well, it's unlikely though.

Well, it would be better to move the check to map_single().
