Subject: Module support for 8260 in 2.4(.1) kernel
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 20 Apr 2001 13:51:00 -0500
Message-ID: <CD5CA14300A9D54A8D13D58CD3C87B422DD731@advcorp-exc01.advent.com>
From: "Oliver Brown" <obrown@adventnetworks.com>
To: "linuxppc-embedded List" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am working on loadable driver modules for the 8260. I had to make the
changes below to the ppc_ksyms.c file to export the symbols in needed.

The problems I am having are
1. The udelay marco is not exportable. Is there a substitute? For now I
am using __delay() which is not a constant delay.
2. The m8260_cpm_hostalloc() and m8260_cpm_dpalloc do not have deallocs.
I can load my module, but I can't unload it.

I've added an init_module and cleanup_module to the fcc_enet.c from
(bitkeeper 2.5 tree). Also, I had to replace all of the udelay()'s with
__delay()'s. And I've diabled the MDIO PHY support.

Any comments or suggestions would be appreciated.

Regards,
Oliver Brown

46a47,51
> /* exporting 8260 symbols for modules - OFB */
> #ifdef CONFIG_8260
> #include <asm/cpm_8260.h>
> #include <asm/mpc8260.h>
> #endif /* CONFIG_8260 - OFB */
90c95,96
< #if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
---
> /* Added CONFIG_8260 to exclude symbols below - OFB */
> #if !defined(CONFIG_4xx) && !defined(CONFIG_8xx) &&
!defined(CONFIG_8260)
94a101
>
104a112,126
> /* exporting CPM symbols for modules - OFB */
> #ifdef CONFIG_8260
> EXPORT_SYMBOL(cpmp);
> EXPORT_SYMBOL(m8260_cpm_hostalloc);
> EXPORT_SYMBOL(m8260_cpm_dpalloc);
> EXPORT_SYMBOL(m8260_cpm_setbrg);
> EXPORT_SYMBOL(m8260_cpm_fastbrg);
> EXPORT_SYMBOL(__res);
> #endif /* CONFIG_8260 */
>
> /* exporting symbols for modules - OFB */
> #if (defined(CONFIG_8260) || defined(CONFIG_8xx))
> EXPORT_SYMBOL(request_8xxirq);
> #endif /* (defined(CONFIG_8260) || defined(CONFIG_8xx)) - OFB */
>
243a266,267
>
> #ifdef CONFIG_ALL_PPC
244a269,270
> #endif /* CONFIG_ALL_PPC */
>
281a308,309
>
> #ifdef CONFIG_VT
282a311,312
> #endif /* CONFIG_VT */
>
349c379,380
< #if !defined(CONFIG_8xx) && !defined(CONFIG_4xx)
---
> /* Added CONFIG_8260 -OFB */
> #if !defined(CONFIG_8xx) && !defined(CONFIG_4xx) &&
!defined(CONFIG_8260)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
