Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A2F967D47
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:36:28 +1100 (EST)
Date: Wed, 15 Nov 2006 19:36:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 3/16] add base support for Celleb platform
Message-ID: <20061115183621.GB21633@lst.de>
References: <200611150931.kAF9VciJ023243@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200611150931.kAF9VciJ023243@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 15, 2006 at 06:31:36PM +0900, Ishizaki Kou wrote:
> diff -u linux-2.6.19/arch/powerpc/kernel/udbg.c:1.1.1.1 linux-2.6.19/arch/powerpc/kernel/udbg.c:1.2
> --- linux-2.6.19/arch/powerpc/kernel/udbg.c:1.1.1.1	Fri Oct  6 10:40:04 2006
> +++ linux-2.6.19/arch/powerpc/kernel/udbg.c	Fri Oct  6 12:26:35 2006
> @@ -45,6 +45,8 @@
>  #elif defined(CONFIG_PPC_EARLY_DEBUG_ISERIES)
>  	/* For iSeries - hit Ctrl-x Ctrl-x to see the output */
>  	udbg_init_iseries();
> +#elif defined(CONFIG_PPC_EARLY_DEBUG_BEAT)
> +	udbg_init_debug_beat();
>  #endif

At some point we should make this a machvec pointer :)

> Index: linux-2.6.19/arch/powerpc/platforms/Makefile
> diff -u linux-2.6.19/arch/powerpc/platforms/Makefile:1.1.1.1 linux-2.6.19/arch/powerpc/platforms/Makefile:1.2
> --- linux-2.6.19/arch/powerpc/platforms/Makefile:1.1.1.1	Fri Oct  6 10:40:06 2006
> +++ linux-2.6.19/arch/powerpc/platforms/Makefile	Fri Oct  6 12:26:35 2006
> @@ -16,3 +16,4 @@
>  obj-$(CONFIG_PPC_PASEMI)		+= pasemi/
>  obj-$(CONFIG_PPC_CELL)		+= cell/
>  obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
> +obj-$(CONFIG_PPC_CELLEB)	+= celleb/

So another platforms directory.  I think we need to sort out the
mess we have currently.

I'd prefer either

  arch/powerpc/platforms/cell		generic cell code (spufs, ..)
  arch/powerpc/platforms/ibmcell	cell blade & co support
  arch/powerpc/platforms/ps3hv		Sony hypervisor support
  arch/powerpc/platforms/celleb		Toshiba

Alternatively we should put all Cell code into
arch/powerpc/platforms/cell with proper prefixes to the filenames, but
Cell is more an more of an architecture extension than a traditional
platform.  And that despite all existing hardware beeing almost the
same (A big thanks to all the brain amputated hypervisor architects here!)

> +			if(size-- <= 0) {
> +				return NULL;
> +			}

No need for the {} braces for single line conditionals.  also
please put a space in front of opening braces.  If you're unsure
please take a look at Documentation/CodingStyle in the kernel tree.

> +	if((str = re_det1(str, &buf[0].cbuf[4], 4)) == NULL) {
> +		return -1;
> +	}

Similarly this should be written as:

	str = re_det1(str, &buf[0].cbuf[4], 4);
	if (!str)
		return -1;

And btw, all these function have very non-descriptive names
and no comments.  That could use some work.  Also I'm not
sure -N returns are very useful - you should at least have
descriptive enums for the error cases.

> +static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
> +					  unsigned long ea,
> +					  int psize)
> +{

All this htab code should go into a separate file, e.g.

arch/powerpc/mm/hash_beat.c
