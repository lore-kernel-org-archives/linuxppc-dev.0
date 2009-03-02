Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4BC9DDF2A
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 18:58:02 +1100 (EST)
Subject: Re: [PATCH] powerpc/mm: Merge various PTE bits and accessors
	definitions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1235979481.8526.31.camel@localhost>
References: <20090302062351.26F84DDFBE@ozlabs.org>
	<1235979481.8526.31.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Mar 2009 18:57:52 +1100
Message-Id: <1235980672.7248.4.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-02 at 18:38 +1100, Michael Ellerman wrote:
> On Mon, 2009-03-02 at 17:22 +1100, Benjamin Herrenschmidt wrote:
> > Now that they are almost identical, we can merge some of the definitions
> > related to the PTE format into common files.
> 
> <snip>
> 
> > +/* Protection used for kernel text. We want the debuggers to be able to
> > + * set breakpoints anywhere, so don't write protect the kernel text
> > + * on platforms where such control is possible.
> > + */
> > +#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
> > +	defined(CONFIG_KPROBES)
> > +#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
> > +#else
> > +#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
> > +#endif
> 
> What about FTRACE? ∞TRACE etc.

Well, I'm just moving those bits around from pgtable-ppc32.h (ie, only
ppc32 uses PAGE_KERNEL_TEXT for now anyway).

Note also that as it is, with ppc32 hash, we don't honor the read-only
restriction on the BAT mapping anyway.

So yes, there's room for fixing things but that isn't what this patch
does.

Cheers,
Ben.
