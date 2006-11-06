Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8B9F167C2B
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 14:43:23 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA63hKh3027444
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 22:43:20 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA63hKwg332964
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 20:43:20 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA63hJHw014032
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 20:43:19 -0700
Subject: Re: fixup_bigphys_addr and ioremap64 question
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1162783045.28571.283.camel@localhost.localdomain>
References: <1162783045.28571.283.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 21:44:21 -0600
Message-Id: <1162784661.19697.4.camel@crusty.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 14:17 +1100, Benjamin Herrenschmidt wrote:
> While merging io.h between 32 and 64 bits arch/powerpc, I stumbled upon
> this little gem :-)
> 
> So we have these:
> 
>  - If CONFIG_PHYS_64BIT is not set, nothing special. phys_addr_t is
> defined to be 32 bits.
> 
>  - If it is set however, we have phys_addr_t defined to be 64 bits in
> asm-ppc/mmu.h. 
> 
> So why do we have both ioremap and ioremap64 knowing that the former is
> defined to take a phys_addr_t argument ?
> 
> Currently, we have both, with the only difference being that ioremap
> calls ioremap64 but also passes the argument through a
> fixup_bigphys_addr() function first.
> 
> It took me a while to find it ... it's not defined in generic code but
> in platform code (ugh !). In fact, the only version of it we have in
> arch/powerpc is in the 85xx support and does:

It's in arch/ppc/syslib/44x_common.c and it's used to trap the least
significant 32 bits of an address and set the right ERPN for io space on
44x.  Something like that might be needed when 44x merges to
arch/powerpc.

josh
