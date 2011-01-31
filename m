Return-Path: <scottwood@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6744DB70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Feb 2011 06:56:23 +1100 (EST)
Date: Mon, 31 Jan 2011 13:40:57 -0600
From: Scott Wood <scottwood@freescale.com>
To: Steve Best <sfbest@us.ibm.com>
Subject: Re: [PATCH] powerpc/mm: add devmem_is_allowed() for STRICT_DEVMEM
	checking
Message-ID: <20110131134057.153d6844@udp111988uds.am.freescale.net>
In-Reply-To: <20110131191109.5727.87742.sendpatchset@squad5-lp1.lab.bos.redhat.com>
References: <20110131191109.5727.87742.sendpatchset@squad5-lp1.lab.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 31 Jan 2011 14:16:00 -0500
Steve Best <sfbest@us.ibm.com> wrote:

>     Provide devmem_is_allowed() routine to restrict access to kernel
>     memory from userspace.
>     Set CONFIG_STRICT_DEVMEM config option to switch on checking.
> 
> Signed-off-by: Steve Best <sfbest@us.ibm.com>
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 2d38a50..6805d5d 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -299,4 +299,16 @@ config PPC_EARLY_DEBUG_CPM_ADDR
>  	  platform probing is done, all platforms selected must
>  	  share the same address.
>  
> +config STRICT_DEVMEM
> +        def_bool y
> +        prompt "Filter access to /dev/mem"
> +        ---help---
> +          This option restricts access to /dev/mem.  If this option is
> +          disabled, you allow userspace access to all memory, including
> +          kernel and userspace memory. Accidental memory access is likely
> +          to be disastrous.
> +          Memory access is required for experts who want to debug the kernel.
> +
> +          If you are unsure, say Y.
> +
>  endmenu
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 53b64be..f225032 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -262,6 +262,11 @@ extern void copy_user_page(void *to, void *from, unsigned long vaddr,
>  		struct page *p);
>  extern int page_is_ram(unsigned long pfn);
>  
> +static inline int devmem_is_allowed(unsigned long pfn)
> +{
> +        return 0;
> +}
> +

I don't see how this is a sane thing to turn on by default (you're not
restricting it, BTW -- you're completely disabling it with that
implementation of devmem_is_allowed).  It will break anything that
uses /dev/mem to access I/O, possibly including desktoppy stuff like X
servers, as well as lots of stuff that goes on in embedded setups.

You need to be root to access /dev/mem, and root has plenty of
other options for causing "disastrous" results.  You don't just stumble
onto /dev/mem by accident.

-Scott
