Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B604667C02
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 14:17:32 +1100 (EST)
Subject: fixup_bigphys_addr and ioremap64 question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 14:17:25 +1100
Message-Id: <1162783045.28571.283.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While merging io.h between 32 and 64 bits arch/powerpc, I stumbled upon
this little gem :-)

So we have these:

 - If CONFIG_PHYS_64BIT is not set, nothing special. phys_addr_t is
defined to be 32 bits.

 - If it is set however, we have phys_addr_t defined to be 64 bits in
asm-ppc/mmu.h. 

So why do we have both ioremap and ioremap64 knowing that the former is
defined to take a phys_addr_t argument ?

Currently, we have both, with the only difference being that ioremap
calls ioremap64 but also passes the argument through a
fixup_bigphys_addr() function first.

It took me a while to find it ... it's not defined in generic code but
in platform code (ugh !). In fact, the only version of it we have in
arch/powerpc is in the 85xx support and does:

phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size)
{
	return addr;
};

So here's my question: Is it, as I think, some old mecanism that was
useful when ioremap didn't take a phys_addr_t argument and resources
didn't have 64 bits fields and thus we had a way to "remap" IOs from a
32 bits space into a 64 bits space in a platform specific way ?

Now, the big question is: do we still need that ?

If, as I expect, the answer is no, then I'll just remove it. I'll also
remove ioremap64 from arch/powerpc since ioremap can take a 64 bits
value directly.

Now, if the answer is yes, then I'll turn it into a ppc_md. call since
it its current form, it's just broken.

Ben.
