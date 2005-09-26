Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <65BBD07F-B465-45E0-9422-9015D1FBF93A@freescale.com>
References: <Pine.LNX.4.61.0509231408170.3791@nylon.am.freescale.net>
	<20050924104827.114939ca.sfr@canb.auug.org.au>
	<BCC97EBE-6171-4FF9-A696-B98B11046391@freescale.com>
	<200509261157.37514.michael@ellerman.id.au>
	<1127774755.15882.104.camel@gaston>
	<65BBD07F-B465-45E0-9422-9015D1FBF93A@freescale.com>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 09:38:43 +1000
Message-Id: <1127777923.15882.114.camel@gaston>
Mime-Version: 1.0
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: merged asm/cputable.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> At the end of the day we should have the same init path for  
> everything.  We have to deal with the fact that some processors are  
> not going to have "real mode" to run in.  Anything Book-E 32 or 64- 
> bit is going to fall into this case.

I know, and real mode isn't necessarily useable on others, my point was,
there is this "pre-mmu-init" phase when we run into a kind of reduced
mmu environment but no need to use RELOC's or -mrelocatable. That is:

 - on ppc64, real mode
 - on CONFIG_6xx, memory mapped by BATs over first 16M or so
 - on others, typically, bolted TLB entries during early asm

This "pre-init" phase has common characteristics, that is

 - we can run code without reloc's as explained above
 - we can't access much memory above kernel text/data. on ppc64, it
ranges from all memory (lucky) to the limit of the RMO on lpar which
tend to get smaller. In fact, pSeries might even lose real mode sooner
or later and get into a similar "bolted initial mapping" case.

This is when early_setup() is run on ppc64. This is when machine_init()
and MMU_init() are called on ppc32. Those do fundamentally the same
thing. Some pre-init, typically based on device-tree bits & pieces, and
choosing the "right" ppc_md. They could be merged to look like the ppc64
version. The main issue is that ppc32 does a bit too much there (like
finish_device_tree which should be done later like ppc64). There is bits
& pieces there that should be moved around a bit, including in platform
code (ppc_md.probe() should replace {pmac,chrp,...}_init() for example).

Ben.
