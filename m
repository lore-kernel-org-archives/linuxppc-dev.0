Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C125067B71
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 12:51:22 +1000 (EST)
Date: Fri, 29 Sep 2006 19:47:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH 6/6]: powerpc/cell spidernet refine locking
Message-Id: <20060929194752.2194f94f.akpm@osdl.org>
In-Reply-To: <20060929232911.GN6433@austin.ibm.com>
References: <20060929230552.GG6433@austin.ibm.com>
	<20060929232911.GN6433@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 29 Sep 2006 18:29:11 -0500
linas@austin.ibm.com (Linas Vepstas) wrote:

> The transmit side of the spider ethernet driver currently
> places locks around some very large chunks of code. This
> results in a fair amount of lock contention is some cases. 
> This patch makes the locks much more fine-grained, protecting
> only the cirtical sections. One lock is used to protect 
> three locations: the queue head and tail pointers, and the 
> queue low-watermark location.

You have spider_net_set_low_watermark() walking the tx_chain outside
tx_chain.lock.  Are you sure about that?
