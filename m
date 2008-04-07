Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9EA0DDD01
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 10:43:09 +1000 (EST)
Subject: Re: [RFC][PATCH] initial port of fixmap over from x86 for ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18425.24938.332852.315571@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
	<18425.24938.332852.315571@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 07 Apr 2008 10:43:01 +1000
Message-Id: <1207528981.10388.463.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You have FIX_PCIE_MCFG in there too (keyed off CONFIG_PCI_MMCONFIG
> which we don't have and don't want to have).  If you need to map in
> PCIe config space, what's wrong with just using ioremap?  Why do you
> need to have a fixed virtual address for it?

Well, that was the whole point for doing the fixmap stuff actually, to
be able to have a non-HIGHMEM version of a quick kmap_atomic for ...
PCIe config space :-)

On some PCIe host brigdes like the ones used on 4xx or FSL chips, the
config space is physically mapped as a large linear space, too large to
ioremap permanently, and we can't ioremap from within the low level
config ops.

So the idea is to use a fixmap as a "window" to the config space,
possibly per-cpu. Ultimately, we should even be able to directly insert
TLB entries in kmap_atomic/fixmap to make it even faster.

> More generally, I think we need to take an overall look at what things
> we are using fixed virtual addresses for, and why they need to be
> fixed.  If there are indeed several such things then we can introduce
> the fixmap stuff.

The virtual address doesn't _need_ to be fixed in our case. It's more
like x86 builds kmap on top of fixmap and we were thinking about doing
the same, having it fixed makes it slightly easier to whack things but I
agree it's not necessarily the best option.

We could instead have something allocated a chunk of virtual space at
boot and provide a quick map/unmap.

But by using fixmap, we can use common code with kmap_atomic quickly and
easily.

Ben.
