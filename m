Date: Mon, 31 Jul 2000 08:48:41 +0200 (CEST)
From: Thomas Graichen <graichen@innominate.de>
Reply-To: thomas.graichen@innominate.de
To: Keith Owens <kaos@melbourne.sgi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SGI XFS on ppc 
In-Reply-To: <15081.965025257@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.21.0007310845490.8854-100000@h2o.bln.innominate.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 31 Jul 2000, Keith Owens wrote:

> Does ppc support modules?  I know that modutils has an obj-ppc.c file
> but I don't think I have ever seen any ppc bug reports for modutils.
> If ppc does use modutils then we need lines like this in
> arch/ppc/vmlinux.lds.
>
>   __start___ksymtab = .;        /* Kernel symbol table */
>   __ksymtab : { *(__ksymtab) }
>   __stop___ksymtab = .;
>
>   __start___kallsyms = .;       /* All kernel symbols */
>   __kallsyms : { *(__kallsyms) }
>   __stop___kallsyms = .;
>
> The first section is standard for any arch that supports modules but is
> not in pppc for some reason.  The second section is part of kallsyms.
> Most of the kallsyms code needs to be wrapped in #ifdef but
> arch/xxx/vmlinux.lds, include/modules.h and kernel/module.c do not,
> they are global to provide a standard userspace ABI, independent of
> kernel options.

i think this is something for the ppc guys ...

> If ppc does not support modules then forget the above update.  However
> the code in kernel/module.c that refers to kallsyms entries should not
> be compiled when CONFIG_MODULES=n is set, why is it being compiled?

maybe due to the "||" (kernel/modules.c) ?

#if defined(CONFIG_MODULES) || defined(CONFIG_KALLSYMS)

t

--
thomas.graichen@innominate.de
technical director                                       innominate AG
clustering & security                                networking people
fon: +49.30.308806-13 fax: -77 web: http://innominate.de pgp: /pgp/tgr


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
