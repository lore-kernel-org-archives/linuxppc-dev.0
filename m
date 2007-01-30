Return-Path: <ananth@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A2F1DDEC4
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 22:33:29 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0UBXP8f020030
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 06:33:25 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0UBXO3m273780
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 06:33:24 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0UBXO2C018803
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 06:33:24 -0500
Date: Tue, 30 Jan 2007 17:03:16 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: RFC: kprobes support for ppc32
Message-ID: <20070130113316.GA17288@in.ibm.com>
References: <Pine.LNX.4.64.0701300010550.32498@localhost.localdomain>
	<20070130104630.GC14571@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070130104630.GC14571@lst.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	prasanna@in.ibm.com
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 30, 2007 at 11:46:30AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 30, 2007 at 12:13:32AM -0600, Kumar Gala wrote:
> > +	depends on !BOOKE && KALLSYMS && EXPERIMENTAL && MODULES
> 
> Just curious: what's the problem with BOOKE?
> 
> > +#ifdef CONFIG_PPC64
> >   	regs->nip = (unsigned long)(((func_descr_t *)jp->entry)->entry);
> >   	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
> > +#else
> > +	regs->nip = (unsigned long)jp->entry;
> > +#endif
> 
> This should probably be split int a macro.
> 
> 
> 
> also I think you should not define kprobe_lookup_name for the 32bit
> case as the generic version should be fine for ppc32

Right. 32bit powerpc uses the SVR4 ABI and hence can just use the
generic version. In addition, since 32bit powerpc implementations don't
have a TD/TDI, they can be stubbed out too in the is_trap() check.

Ananth
