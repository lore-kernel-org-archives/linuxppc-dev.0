Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5510DDE48
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 23:25:52 +1000 (EST)
Subject: Re: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448.
From: Adrian Cox <adrian@humboldt.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1178317526.6353.106.camel@localhost.localdomain>
References: <1178141683.32136.46.camel@ld0161-tx32>
	<1178187440.20944.12.camel@localhost.localdomain>
	<1178208838.17201.52.camel@ld0161-tx32>
	<1178228208.6353.55.camel@localhost.localdomain>
	<E1HjzWH-0001Wg-Ps@jdl.com>
	<1178317526.6353.106.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 05 May 2007 14:25:37 +0100
Message-Id: <1178371537.6269.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-05-05 at 08:25 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2007-05-04 at 10:16 -0500, Jon Loeliger wrote:
> > So, could you comment on my proposed solution doing
> > things exactly this way?  Speifically, would folks
> > prefer the dynamic 
> > 
> >     number_of_cpus() == 1 
> 
> Sorry I don't remember the actual patch, must have missed it... I
> suppose we could have generic code in early_init_devtree set the default
> for this based on cpu_possible_map() containing more than one bit and
> have platforms using one of those broken bridges force the bit in from
> their probe routine.

Having looked into it further, the MPC106/7 are probably unique in
containing an internal cache which must be coherent with the CPU.
Presumably the designers intended it as a performance enhancement for
other PCI bus masters accessing PowerPC memory, but for most
applications the cost of turning on coherent memory would have
outweighed it.

So I'm now happy about removing CPU_FTR_NEED_COHERENT from the 7448. I
also agree that platforms with this quirk should turn it on during
probing, but there aren't any boards in arch/powerpc that need this. The
static method based on CONFIG_MPC10X_BRIDGE is probably good enough for
arch/ppc. 

-- 
Adrian Cox <adrian@humboldt.co.uk>
