Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 333C467CAA
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 10:38:17 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH/RFC] Hookable IO operations #3
Date: Mon, 6 Nov 2006 00:38:06 +0100
References: <1162710572.28571.225.camel@localhost.localdomain>
In-Reply-To: <1162710572.28571.225.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611060038.07117.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 05 November 2006 08:09, Benjamin Herrenschmidt wrote:
> [This is version 3 of the patch. It grew bigger as I added new
> base operations in order to fully support the iomap API. It works
> along with the patch from Linus:

Looks really good now, I only have a few unimportant comments about
coding style left:

> +/* The inline wrappers */
> +#define DEF_PCI_AC_RET(name, ret, at, al)			\
> +static inline ret name at					\
> +{								\
> +	if (DEF_PCI_HOOK(ppc_pci_io.name) != NULL)		\
> +		return ppc_pci_io.name al;			\
> +	return __do_##name al;					\
> +}

Why do you write stuff like

if (pointer != NULL) ?

It looks really pointless, since the existence of the object
is already a well-understood conditional.

After all, you don't write

if ((pointer == NULL) == false)

 ;-)

> +static inline void iosync(void)
> +{
> +        __asm__ __volatile__ ("sync" : : : "memory");
> +}

It's way more common to write 'asm volatile' instead of
'__asm__ __volatile__' now. It's also nicer on the eye.

> +	 */
> +	ppc_pci_io.readb = iseries_readb;
> +	ppc_pci_io.readw = iseries_readw;
> +	ppc_pci_io.readl = iseries_readl;
> +	ppc_pci_io.readw_be = iseries_readw_be;
> +	ppc_pci_io.readl_be = iseries_readl_be;
> +	ppc_pci_io.writeb = iseries_writeb;
> +	ppc_pci_io.writew = iseries_writew;
> +	ppc_pci_io.writel = iseries_writel;
> +	ppc_pci_io.writew_be = iseries_writew_be;
> +	ppc_pci_io.writel_be = iseries_writel_be;
> +	ppc_pci_io.readsb = iseries_readsb;
> +	ppc_pci_io.readsw = iseries_readsw;
> +	ppc_pci_io.readsl = iseries_readsl;
> +	ppc_pci_io.writesb = iseries_writesb;
> +	ppc_pci_io.writesw = iseries_writesw;
> +	ppc_pci_io.writesl = iseries_writesl;
> +	ppc_pci_io.memset_io = iseries_memset_io;
> +	ppc_pci_io.memcpy_fromio = iseries_memcpy_fromio;
> +	ppc_pci_io.memcpy_toio = iseries_memcpy_toio;

I guess it would be slightly more readable and more space
efficient to write this as 

static struct ppc_pci_io __initdata iseries_pci_io = {
	.readb = iseries_readb;
	.readw = iseries_readw;
	.readl = iseries_readl;
	.readw_be = iseries_readw_be;
	.readl_be = iseries_readl_be;
	.writeb = iseries_writeb;
	.writew = iseries_writew;
	.writel = iseries_writel;
	.writew_be = iseries_writew_be;
	.writel_be = iseries_writel_be;
	.readsb = iseries_readsb;
	.readsw = iseries_readsw;
	.readsl = iseries_readsl;
	.writesb = iseries_writesb;
	.writesw = iseries_writesw;
	.writesl = iseries_writesl;
	.memset_io = iseries_memset_io;
	.memcpy_fromio = iseries_memcpy_fromio;
	.memcpy_toio = iseries_memcpy_toio;
};
ppc_pci_io = iseries_pci_io;

	Arnd <><
