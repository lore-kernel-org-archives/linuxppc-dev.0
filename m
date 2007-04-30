Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D70B8DDF25
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 19:32:56 +1000 (EST)
Date: Mon, 30 Apr 2007 11:18:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: powerpc: Remove arch/powerpc's dependence on asm-ppc/pg{alloc,
	table}.h
Message-ID: <20070430091846.GA15581@lst.de>
References: <20070430053723.GG6436@localhost.localdomain>
	<20070430063056.GB4683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070430063056.GB4683@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 30, 2007 at 04:30:56PM +1000, David Gibson wrote:
> powerpc: Remove arch/powerpc's dependence on asm-ppc/pg{alloc,table}.h
> 
> Currently, all 32-bit powerpc platforms use asm-ppc/pgtable.h and
> asm-ppc/pgalloc.h, even when otherwise compiled with ARCH=powerpc.
> Those asm-ppc files are a fairly nasty tangle of #ifdefs including a
> bunch of things which shouldn't be necessary any more in arch/powerpc.
> 
> Cleaning up that mess is going to take a while, but this patch is a
> first step.  It separates the asm-powerpc/pg{alloc,table}.h into 64
> bit and 32 bit versions in asm-powerpc, which the basic .h files in
> asm-powerpc select based on config.  We make a few tiny tweaks to the
> innards of the files along the way, making the outermost ifdefs
> (double-inclusion protection and __KERNEL__) a little cleaner, and
> #including asm-generic/pgtable.h from the top-level
> asm-powerpc/pgtable.h (since both the old 32-bit and 64-bit versions
> ended with such an #include).

Nice cleanup.  Btw, you can just kill the __KERNEL__ completely,
neither pgalloc.h nor pgtable are exported to userspace (as in
part of header-y or unifdef-y in include/asm-powerpc/Kbuild)
