Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 538B2B70B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 08:35:20 +1000 (EST)
Subject: Re: [BUILD FAILURE 01/04] Next June 04:PPC64 randconfig
	[drivers/staging/comedi/drivers.o]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: subrata@linux.vnet.ibm.com
In-Reply-To: <1244572446.5497.32.camel@subratamodak.linux.ibm.com>
References: <20090605182625.24093.7808.sendpatchset@elm3a191.beaverton.ibm.com>
	<1244261806.31984.36.camel@pasglop> <20090606055103.GA9446@kroah.com>
	<200906060936.22322.fmhess@speakeasy.net>
	<1244385405.5265.7.camel@subratamodak.linux.ibm.com>
	<1244519418.5235.2.camel@pasglop>
	<1244572446.5497.32.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Jun 2009 08:34:39 +1000
Message-Id: <1244586879.24481.19.camel@pasglop>
Mime-Version: 1.0
Cc: sachinp@linux.vnet.ibm.com, sfr@canb.auug.org.au,
	fmhess@users.sourceforge.net, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, Linuxppc-dev@ozlabs.org,
	Ian Abbott <abbotti@mev.co.uk>, linux-next@vger.kernel.org,
	paulus@samba.org, Geert.Uytterhoeven@sonycom.com,
	geert@linux-m68k.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > In any case, doing PAGE_KERNEL_NOCACHE for DMA memory is incorrect on
> > many architectures. So at this stage, there's no much option but ifdef I
> > suspect for now until this is fixed properly.
> 
> Ok. But, i am not sure whether Greg will agree to this. If, Ok, is the
> following patch i sent earlier Ok ?
> 
> http://lkml.org/lkml/2009/6/5/462,

Not really.

You probably want to use a constant (call it MY_DMA_MAP_PGPROT), and
in a header, you have a bunch of ifdef's that set it to PAGE_KERNEL,
PAGE_KERNEL_NOCACHE or PAGE_KERNEL_NC depending on what's needed.

Today, you can pretty much assume that

 - x86*, sparc*, ia64*, alpha, ... needs PAGE_KERNEL
 - powerpc needs PAGE_KERNEL if !CONFIG_NOT_COHERENT_CACHE
 - powerpc needs PAGE_KERNEL_NC if CONFIG_NOT_COHERENT_CACHE
 - ARM and MIPS, I think, needs PAGE_KERNEL_NOCACHE
 - ... others I don't know.

Cheers,
Ben.

> Regards--
> Subrata
> 
> > 
> > It does make sense to want to have some memory like that shared between
> > user space and DMA, though I don't know what the right approach that
> > works on all archs is at this stage. Worth asking the Alsa guys, I think
> > they have similar issues :-)
> > 
> > But doing double buffering might do the trick fine for now.
> > 
> > Cheers,
> > Ben.
> > 
> > 
> > 
> > 
