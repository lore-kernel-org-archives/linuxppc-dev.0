From: Keith Owens <kaos@melbourne.sgi.com>
To: Thomas Graichen <graichen@innominate.de>, thomas.graichen@innominate.de
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SGI XFS on ppc 
In-reply-to: Your message of "31 Jul 2000 06:12:29 GMT."
             <news2mail-8m35cd$3nu$2@mate.bln.innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 31 Jul 2000 16:34:17 +1000
Message-ID: <15081.965025257@ocs3.ocs-net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 31 Jul 2000 06:12:29 GMT,
Thomas Graichen <news-innominate.list.sgi.xfs@innominate.de> wrote:
>Keith Owens <kaos@ocs.com.au> wrote:
>> More specific please.  kallsyms has no ifdefs.  It should only be
>> included if you select kdb but kdb has not been ported to ppc.  I
>> maintain modutils, kallsyms and kdb.
>
>just have a look at the diff at
>
>  http://innominate.org/~graichen/projects/xfs-ppc/

I can see the problem but need some ppc help in fixing it.  Part of the
kallsyms patch updates arch/xxx/vmlinux.lds on every arch.  I did not
patch arch/ppc/vmlinux.lds because it did not have any entries for
section __ksymtab.  kallsyms is module related and the absence of
__ksymtab in arch/ppc/vmlinux.lds made me think that ppc does not use
modules.

Does ppc support modules?  I know that modutils has an obj-ppc.c file
but I don't think I have ever seen any ppc bug reports for modutils.
If ppc does use modutils then we need lines like this in
arch/ppc/vmlinux.lds.

  __start___ksymtab = .;        /* Kernel symbol table */
  __ksymtab : { *(__ksymtab) }
  __stop___ksymtab = .;

  __start___kallsyms = .;       /* All kernel symbols */
  __kallsyms : { *(__kallsyms) }
  __stop___kallsyms = .;

The first section is standard for any arch that supports modules but is
not in pppc for some reason.  The second section is part of kallsyms.
Most of the kallsyms code needs to be wrapped in #ifdef but
arch/xxx/vmlinux.lds, include/modules.h and kernel/module.c do not,
they are global to provide a standard userspace ABI, independent of
kernel options.

If ppc does not support modules then forget the above update.  However
the code in kernel/module.c that refers to kallsyms entries should not
be compiled when CONFIG_MODULES=n is set, why is it being compiled?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
