Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 97DA967A39
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 07:33:18 +1000 (EST)
Date: Thu, 20 Apr 2006 14:33:16 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <20060420213316.GD25755@gate.ebshome.net>
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
> (On 6xx this is deadly even if you don't access those cacheable pages
> because the CPU prefetch may do it for you).

Here is another thought if this "prefetch" theory is correct.

You guys seems to focus on 
dma_alloc_coherent()/pci_alloc_consistent(), but forgeting about so 
called "streaming" mappings.

You cannot just flush/invalidate cache any more, because "CPU can 
prefetch this data back". So, to be completely correct (if you insist 
on "6xx can prefetch"-theory), you have to actually _copy_ data to 
your consistent memory on dma_map_single(). You can imagine 
performance implications. I suspect even 440 will be faster in this 
case than G4 :).

-- 
Eugene
