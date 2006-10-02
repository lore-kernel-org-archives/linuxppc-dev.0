Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 272AC67BCB
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 03:47:26 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k92HlNq9018203
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 13:47:23 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k92HlNZv282242
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 13:47:23 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k92HlMcH011473
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 13:47:23 -0400
Date: Mon, 2 Oct 2006 12:47:22 -0500
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 6/6]: powerpc/cell spidernet refine locking
Message-ID: <20061002174722.GE4546@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com>
	<20060929232911.GN6433@austin.ibm.com>
	<20060929194752.2194f94f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060929194752.2194f94f.akpm@osdl.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 29, 2006 at 07:47:52PM -0700, Andrew Morton wrote:
> On Fri, 29 Sep 2006 18:29:11 -0500
> linas@austin.ibm.com (Linas Vepstas) wrote:
> 
> > The transmit side of the spider ethernet driver currently
> > places locks around some very large chunks of code. This
> > results in a fair amount of lock contention is some cases. 
> > This patch makes the locks much more fine-grained, protecting
> > only the cirtical sections. One lock is used to protect 
> > three locations: the queue head and tail pointers, and the 
> > queue low-watermark location.
> 
> You have spider_net_set_low_watermark() walking the tx_chain outside
> tx_chain.lock.  Are you sure about that?

Yes. Its making an approximate count of the queue length, and I figured
that if its approximate to begin with, an unlocked version should be
just fine.

--linas
