Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E872DDF03
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 11:48:17 +1100 (EST)
Subject: Re: Booting 2.6.29-rc3 on mpc8661d_hpcn failing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <498867C0.2000607@gefanuc.com>
References: <4982F311.4050507@gefanuc.com>
	<F764D461-8EFB-4B31-ABFC-ECBB7A3FBA01@kernel.crashing.org>
	<9B0CCADB-C891-42B2-BE94-0927B5715A00@kernel.crashing.org>
	<4986BEB9.3030606@gefanuc.com>
	<E00697F4-1313-49C2-9F8A-79FC9E511022@kernel.crashing.org>
	<498718B6.3030307@gefanuc.com>
	<D06DAB0F-1477-4CA6-A06D-0F7B62939C86@kernel.crashing.org>
	<49871D3E.80809@gefanuc.com> <1233607753.18767.103.camel@pasglop>
	<49883719.9030300@gefanuc.com>  <498867C0.2000607@gefanuc.com>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 11:47:59 +1100
Message-Id: <1233708479.16867.129.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-02-03 at 15:50 +0000, Martyn Welch wrote:
> 
> The primary CPU is spinning in smp_generic_give_timebase() waiting for
> "!tbsync->ack". The secondary CPU has made it into
> smp_generic_take_timebase() and has apparently (according to some
> printk's I put in there) set "tbsync->ack=1". After that I don't get
> any printk's, I guess that the one I have put in the "!
> tbsync->handshake" while loop is making it to the print buffer, but
> with both processors spinning it's not getting to the serial console.
> 
> At a guess, given that commit 64b3d0e8122b422e879b23d42f9e0e8efbbf9744
> seems to be the point that it stopped working correctly, that "tbsync"
> is now somehow becoming cached?
> 
Maybe we are missing the M bit in the mapping ?

Let's see... the kernel mapping is done via BATs on those guys (ie, e600
is a hash table based processor right ? some kind of 74xx). The code
that sets them up is in

arch/powerpc/mm/ppc_mmu_32.c

In mmu_mapin_ram() we call setbat() multiple times. The last argument is
the "flags" which is set to _PAGE_RAM. That should contain
_PAGE_COHERENT when CONFIG_SMP is set unless I screwed up. IE. _PAGE_RAM
is _PAGE_KERNEL | _PAGE_HWEXEC. _PAGE_KERNEL is _PAGE_BASE plus things,
and _PAGE_BASE should contains _PAGE_COHERENT if CONFIG_SMP or
CONFIG_PPC_STD_MMU are set and they should both be in your case.

setbat() itself will clear _PAGE_COHERENT under some circumstances
however. Either if the flags contain _PAGE_NO_CACHE, which should not be
the case here, or if the CPU feature bit CPU_FTR_NEED_COHERENT is -not-
set. I think that could be the cause of the problem.

CPU_FTR_NEED_COHERENT is set as part of CPU_FTR_COMMON if CONFIG_SMP
is set (among other things). So it -should- be set for you. since
CPU_FTR_COMMON should be OR'ed with all CPU table entries.

So I'm a bit at a loss here... unless something else went wrong.

Please let me know what you find out.

Cheers,
Ben.
