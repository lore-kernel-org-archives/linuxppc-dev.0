Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9B6ED67CE9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 May 2006 18:23:50 +1000 (EST)
Date: Fri, 26 May 2006 12:22:48 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 2/5] Updates for WRS SBC82xx boards
Message-ID: <20060526122248.14c6728c@localhost.localdomain>
In-Reply-To: <20060525182533.GD679@windriver.com>
References: <20060525182533.GD679@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: p_gortmaker@yahoo.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 25 May 2006 14:25:33 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> 
> patch2: sbc82xx-PCI-diff1
> 	- allow m82xx_pci.c to be used by other platforms that have
> 	  their own map_irq
> 
> I'm open to doing this another way if desired -- I just went for the
> minimal impact on the existing code with this.

> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> 
> diff -ur orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c
> linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c ---
> orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c	2006-02-09
> 16:20:35.000000000 -0500 +++
> linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.c	2006-02-09
> 16:01:40.000000000 -0500 @@ -198,7 +198,7 @@ } }
>  
> -static int sbc82xx_pci_map_irq(struct pci_dev *dev, unsigned char
> idsel, +int pq2pci_map_irq(struct pci_dev *dev, unsigned char idsel,
>  			       unsigned char pin)
>  {
>  	static char pci_irq_table[][4] = {
> @@ -247,7 +247,7 @@
>  	callback_init_IRQ	= ppc_md.init_IRQ;
>  
>  	ppc_md.init_IRQ		= sbc82xx_init_IRQ;
> -	ppc_md.pci_map_irq	= sbc82xx_pci_map_irq;
> +	ppc_md.pci_map_irq	= pq2pci_map_irq;
>  #ifdef CONFIG_GEN_RTC
>  	ppc_md.time_init        = NULL;
>  	ppc_md.get_rtc_time     = NULL;
> diff -ur orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h
> linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h ---
> orig/linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h	2006-02-09
> 16:20:35.000000000 -0500 +++
> linux-2.6.16rc2/arch/ppc/platforms/sbc82xx.h	2006-02-09
> 16:35:05.000000000 -0500 @@ -24,6 +24,7 @@ #define
> BOOTROM_RESTART_ADDR      ((uint)0x40000104) 
> +#define HAVE_OWN_PQ2PCI_IRQ
>  #define SBC82xx_PC_IRQA		(NR_CPM_INTS+0)
>  #define SBC82xx_PC_IRQB		(NR_CPM_INTS+1)
>  #define SBC82xx_MPC185_IRQ	(NR_CPM_INTS+2)
> diff -ur orig/linux-2.6.16rc2/arch/ppc/syslib/m82xx_pci.c
> linux-2.6.16rc2/arch/ppc/syslib/m82xx_pci.c ---
> orig/linux-2.6.16rc2/arch/ppc/syslib/m82xx_pci.c	2006-01-02
> 22:21:10.000000000 -0500 +++
> linux-2.6.16rc2/arch/ppc/syslib/m82xx_pci.c	2006-02-09
> 14:35:10.000000000 -0500 @@ -51,6 +51,10 @@
>   * Interrupt routing
>   */
>  
> +#ifdef HAVE_OWN_PQ2PCI_IRQ
> +extern int
> +pq2pci_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned
> char pin); +#else 
>  static inline int
>  pq2pci_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned
> char pin) {
> @@ -172,6 +176,7 @@
>  	setup_irq(PCI_INT_TO_SIU, &pq2pci_irqaction);
>  	return;
>  }
> +#endif	/* HAVE_OWN_PQ2PCI_IRQ */
Sorry, but I don't quite follow the reason of that. As I see, 
you are going to call find_bridges stuff but with demux disabled.

I see no reason to add any defines - if you won't call init_irq,
nothing will happen, I mean demux will not be assigned and so on. BTW,
right now it will not be issued in case of sbc82xx. It is not code-size
optimal, but we'll leave optimizations to arch/powerpc time. 

Actually, you'll just have to override map_irq with sbc_ thing after
find_bridges() call.

>  
>  static int
>  pq2pci_exclude_device(u_char bus, u_char devfn)
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
