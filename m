Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1432567B1E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 07:13:23 +1000 (EST)
Date: Thu, 20 Apr 2006 14:13:21 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <20060420211321.GB25755@gate.ebshome.net>
References: <28892.1145559466@www088.gmx.net>
	<20060420203848.GA23192@gate.ebshome.net>
	<1145567174.4517.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1145567174.4517.1.camel@localhost.localdomain>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 21, 2006 at 07:06:13AM +1000, Benjamin Herrenschmidt wrote:
> Unfortunately, he has to do things a bit differently. He can't afford to
> have the kernel BAT mapping cover his non-cacheable pages. Thus he needs
> a reserved pool. Last I looked at our coherent code, it didn't reserve
> memory at all, just address space, thus assuming the CPU can handle
> having both a caheable and a non-cacheable mapping of the same pages...
> (On 6xx this is deadly even if you don't access those cacheable pages
> because the CPU prefetch may do it for you).

Ben, is this _real_ problem on 6xx or just a theory? Does 6xx actually 
prefetch beyond page boundary?

So far, all "prefetching" I saw which broke non-coherent DMA was not 
due to the CPU doing prefetching, but _software_ prefetching being 
too aggressive.

-- 
Eugene
