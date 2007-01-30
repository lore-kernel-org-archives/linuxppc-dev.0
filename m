Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F8C7DDF88
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 21:46:44 +1100 (EST)
Date: Tue, 30 Jan 2007 11:46:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: kprobes support for ppc32
Message-ID: <20070130104630.GC14571@lst.de>
References: <Pine.LNX.4.64.0701300010550.32498@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0701300010550.32498@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	prasanna@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 30, 2007 at 12:13:32AM -0600, Kumar Gala wrote:
> +	depends on !BOOKE && KALLSYMS && EXPERIMENTAL && MODULES

Just curious: what's the problem with BOOKE?

> +#ifdef CONFIG_PPC64
>   	regs->nip = (unsigned long)(((func_descr_t *)jp->entry)->entry);
>   	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
> +#else
> +	regs->nip = (unsigned long)jp->entry;
> +#endif

This should probably be split int a macro.



also I think you should not define kprobe_lookup_name for the 32bit
case as the generic version should be fine for ppc32
