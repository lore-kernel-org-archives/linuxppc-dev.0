Return-Path: <hugh_dickins@symantec.com>
Received: from extu-mxob-1.symantec.com (extu-mxob-1.symantec.com
	[216.10.194.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "extu-mxob-1.symantec.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9EF92DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 05:19:26 +1000 (EST)
Date: Mon, 14 May 2007 20:19:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: vm changes from linux-2.6.14 to linux-2.6.15
In-Reply-To: <20070510.001234.126579706.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0705142018090.18453@blonde.wat.veritas.com>
References: <Pine.LNX.4.61.0705012354290.12808@mtfhpc.demon.co.uk>
	<20070509231937.ea254c26.akpm@linux-foundation.org>
	<1178778583.14928.210.camel@localhost.localdomain>
	<20070510.001234.126579706.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mark@mtfhpc.demon.co.uk, linuxppc-dev@ozlabs.org, wli@holomorphy.com,
	linux-mm@kvack.org, andrea@suse.de, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 May 2007, David Miller wrote:
> > > We never seemed to reach completion here?
> > 
> > Well, I'm waiting for other people comments too... as I said earlier,
> > I'm not too fan of burrying the update_mmu_cache() inside
> > ptep_set_access_flags(), but perhaps we could remove the whole logic of
> > reading the old PTE & comparing it, and instead have
> > ptep_set_access_flags() do that locally and return to the caller wether
> > a change occured that requires update_mmu_cache() to be called.
> > 
> > That way, archs who don't actually need update_mmu_cache() under some
> > circumstances will be able to return 0 there.
> > 
> > What do you guys thing ?
> 
> I think that's a good idea.

I agree.

Hugh
