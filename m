Message-Id: <396A5E4C.94DBE439@si.com>
Date: Mon, 10 Jul 2000 19:37:49 -0400
From: Jon Diekemea <diekema_jon@si.com>
MIME-Version: 1.0
To: Julia Elbert <jelbert@enerdyne.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem compiling arch/ppc/kernel/ppc_ksyms.c with Linux
 2.4.0-test1-ac18
References: <67505026E29DD311A9AA00508B7315F3195628@EXCHANGE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Julia Elbert wrote:

> Did you ever get help on this question? I am having the sam problem?
> If you could share....
> Thanks,
> Julia
>
>                 -----Original Message-----
>                 From:   diekema@bucks.si.com [mailto:diekema@bucks.si.com]
>                 Sent:   Friday, June 16, 2000 7:52 AM
>                 To:     linuxppc-embedded@lists.linuxppc.org;
> dan_malek@mvista.com
>                 Cc:     all@cideas.com
>                 Subject:        Problem compiling
> arch/ppc/kernel/ppc_ksyms.c with Linux 2.4.0-test1-ac18
>
>                 To:
> linuxppc-embedded@lists.linuxppc.org,dan_malek@mvista.com
>
>                 Problem compiling arch/ppc/kernel/ppc_ksyms.c:
>
>                 Linux: 2.4.0-test1-ac18
>
>                 gmake -C  arch/ppc/kernel
>                 gmake[1]: Entering directory
> `/usr/people/diekema/bk/linux-2.3/arch/ppc/kernel'
>                 multiple -mstring -S mk_defs.c
>                 cp ppc_defs.head ppc_defs.h
>                 chmod u+w ppc_defs.h
>                 grep '^#define' mk_defs.s >> ppc_defs.h
>                 rm mk_defs.s
>                 multiple -mstring -D__ASSEMBLY__ -c head.S -o head.o
>                 multiple -mstring   -DEXPORT_SYMTAB -c ppc_ksyms.c
>                 ppc_ksyms.c:86: `isa_io_base' undeclared here (not in a
> function)
>                 ppc_ksyms.c:86: initializer element is not constant
>                 ppc_ksyms.c:86: (near initialization for
> `__ksymtab_isa_io_base.value')
>                 ppc_ksyms.c:87: `isa_mem_base' undeclared here (not in a
> function)
>                 ppc_ksyms.c:87: initializer element is not constant
>                 ppc_ksyms.c:87: (near initialization for
> `__ksymtab_isa_mem_base.value')
>                 ppc_ksyms.c:88: `pci_dram_offset' undeclared here (not in a
> function)
>                 ppc_ksyms.c:88: initializer element is not constant
>                 ppc_ksyms.c:88: (near initialization for
> `__ksymtab_pci_dram_offset.value')
>                 gmake[1]: *** [ppc_ksyms.o] Error 1
>                 gmake[1]: Leaving directory
> `/usr/people/diekema/bk/linux-2.3/arch/ppc/kernel'
>                 gmake: *** [_dir_arch/ppc/kernel] Error 2
>

Here is a patch that avoids the problem:

===== ppc_ksyms.c 1.36 vs 1.37 =====
--- 1.36/arch/ppc/kernel/ppc_ksyms.c    Fri Jun 16 10:23:38 2000
+++ 1.37/arch/ppc/kernel/ppc_ksyms.c    Fri Jun 16 10:54:43 2000
@@ -82,7 +82,7 @@
 EXPORT_SYMBOL(kernel_flag);
 #endif /* CONFIG_SMP */

-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
+#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx) && !defined(CONFIG_8260)
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(isa_mem_base);
 EXPORT_SYMBOL(pci_dram_offset);


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
