Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F330DDF46
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 12:06:09 +1000 (EST)
Subject: Re: vm changes from linux-2.6.14 to linux-2.6.15
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0705010223040.3556@mtfhpc.demon.co.uk>
References: <20070430145414.88fda272.akpm@linux-foundation.org>
	<20070430.150407.07642146.davem@davemloft.net>
	<1177977619.24962.6.camel@localhost.localdomain>
	<20070430.173806.112621225.davem@davemloft.net>
	<Pine.LNX.4.61.0705010223040.3556@mtfhpc.demon.co.uk>
Content-Type: text/plain
Date: Tue, 01 May 2007 12:05:36 +1000
Message-Id: <1177985136.24962.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, wli@holomorphy.com, linuxppc-dev@ozlabs.org,
	andrea@suse.de, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> At present, update_mmu_cache() and lazy_mmu_prot_update() are always 
> called when ptep_set_access_flags() is called so why not move them into 
> ptep_set_access_flags() and change ptep_set_access_flags() to have an 
> additional boolean parameter (__update) that would when set, cause 
> update_mmu_cache() and lazy_mmu_prot_update() to be called.

Well, ptep_set_access_flags() is a low level arch hook, I'd rather not
start hiding update_mmu_cache() calls in it ...

Ben.
