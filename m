Date: Fri, 13 Jun 2003 09:31:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: redwood-5 compile fixes for linuxppc-2.5
Message-ID: <20030613163131.GP828@ip68-0-152-218.tc.ph.cox.net>
References: <20030613121005.GA1839@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030613121005.GA1839@codeblau.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 13, 2003 at 02:10:06PM +0200, Felix von Leitner wrote:

> Here is a small diff that makes the kernel compile for me.  Can't say
> whether it works, but at least it compiles ;-)

That's probably not a good idea.  Loudly broken > Silently broken.

And:
> --- linuxppc-2.5/drivers/net/Kconfig	2003-06-12 15:22:51.000000000 +0200
> +++ linuxppc-2.5-fefe/drivers/net/Kconfig	2003-06-13 10:34:59.000000000 +0200
[snip]
> --- linuxppc-2.5/drivers/net/Makefile	2003-06-12 15:21:54.000000000 +0200
> +++ linuxppc-2.5-fefe/drivers/net/Makefile	2003-06-13 10:35:18.000000000 +0200
[snip]

Looks alright, but I've seen / heard rumblings of a better net driver
for that family of chipsets, I think...

> --- linuxppc-2.5/include/linux/pci.h	2003-06-12 15:22:13.000000000 +0200
> +++ linuxppc-2.5-fefe/include/linux/pci.h	2003-06-13 10:56:42.000000000 +0200
> @@ -806,9 +806,11 @@
>   * configuration space.
>   */
>
> +#ifdef CONFIG_PCI
>  #ifndef CONFIG_PCI_DOMAINS
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  #endif
> +#endif
>
>  #endif /* __KERNEL__ */
>  #endif /* LINUX_PCI_H */

Er, why is this needed?

> --- linuxppc-2.5/arch/ppc/kernel/ppc_ksyms.c	2003-06-12 15:22:53.000000000 +0200
> +++ linuxppc-2.5-fefe/arch/ppc/kernel/ppc_ksyms.c	2003-06-13 11:10:07.000000000 +0200
> @@ -273,8 +273,10 @@
>  #ifdef CONFIG_NVRAM
>  EXPORT_SYMBOL(nvram_read_byte);
>  EXPORT_SYMBOL(nvram_write_byte);
> +#ifdef CONFIG_PMAC
>  EXPORT_SYMBOL(pmac_xpram_read);
>  EXPORT_SYMBOL(pmac_xpram_write);
> +#endif
>  #endif /* CONFIG_NVRAM */
>  EXPORT_SYMBOL(to_tm);

It's CONFIG_PPC_PMAC, and I'll look into this one, thanks.

> --- linuxppc-2.5/arch/ppc/kernel/misc.S	2003-06-12 15:22:54.000000000 +0200
> +++ linuxppc-2.5-fefe/arch/ppc/kernel/misc.S	2003-06-13 11:14:36.000000000 +0200
> @@ -1324,9 +1324,15 @@
>  	.long sys_stat64	/* 195 */
>  	.long sys_lstat64
>  	.long sys_fstat64
> +#ifdef CONFIG_PCI
>  	.long sys_pciconfig_read
>  	.long sys_pciconfig_write
>  	.long sys_pciconfig_iobase 	/* 200 */
> +#else
> +	.long sys_ni_syscall
> +	.long sys_ni_syscall
> +	.long sys_ni_syscall
> +#endif
>  	.long sys_ni_syscall		/* 201 - reserved - MacOnLinux - new */
>  	.long sys_getdents64
>  	.long sys_pivot_root

There should be a conditional_syscall thingy to take care of this..

> --- linuxppc-2.5/arch/ppc/boot/simple/misc-embedded.c	2003-06-12 15:21:49.000000000 +0200
> +++ linuxppc-2.5-fefe/arch/ppc/boot/simple/misc-embedded.c	2003-06-13 11:16:37.000000000 +0200
> @@ -262,7 +262,9 @@
>  		rec = (struct bi_record *)((unsigned long)rec + rec->size);
>  	}
>  	puts("Now booting the kernel\n");
> +#if 0
>  	serial_close(com_port);
> +#endif
>
>  	return (unsigned long)hold_residual;
>  }

This shouldn't be needed either.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
