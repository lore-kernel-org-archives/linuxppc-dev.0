Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BADF267A62
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 07:06:32 +1000 (EST)
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20060420203848.GA23192@gate.ebshome.net>
References: <28892.1145559466@www088.gmx.net>
	<20060420203848.GA23192@gate.ebshome.net>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 07:06:13 +1000
Message-Id: <1145567174.4517.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > 3. How are DMA buffers used outside the kernel? Do user programs get a
> > pointer to the DMA buffer (in theory) from the device driver or is the data
> > copied to another buffer allocated by an user program?
> 
> 
> There are already non-coherent cache PPC archs (8xx, 4xx) just look 
> how all this implemented there, don't reinvent the wheel.

Unfortunately, he has to do things a bit differently. He can't afford to
have the kernel BAT mapping cover his non-cacheable pages. Thus he needs
a reserved pool. Last I looked at our coherent code, it didn't reserve
memory at all, just address space, thus assuming the CPU can handle
having both a caheable and a non-cacheable mapping of the same pages...
(On 6xx this is deadly even if you don't access those cacheable pages
because the CPU prefetch may do it for you).

Ben.
