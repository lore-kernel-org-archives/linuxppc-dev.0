Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E5C8367B1B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 May 2006 18:23:43 +1000 (EST)
Date: Fri, 26 May 2006 12:09:18 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 4/5] Updates for WRS SBC82xx boards
Message-ID: <20060526120918.35341e48@localhost.localdomain>
In-Reply-To: <20060525183036.GF679@windriver.com>
References: <20060525183036.GF679@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 25 May 2006 14:30:38 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> patch4: sbc82xx-mchk-pci9.diff1
> 	- restore machine check disable for PCI9 that was in earlier
> 	  m8260_pci.c
> 
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> 
> 
> --- linux-2.6.16_rc5/arch/ppc/syslib/m82xx_pci.c.orig
> 2006-02-27 15:02:01.000000000 -0500 +++
> linux-2.6.16_rc5/arch/ppc/syslib/m82xx_pci.c	2006-02-27
> 16:05:20.000000000 -0500 @@ -227,6 +227,11 @@
> immap->im_memctl.memc_pcibr1  = M82xx_PCI_SEC_WND_BASE |
> PCIBR_ENABLE; #endif 
> +#ifdef CONFIG_8260_PCI9 
> +	/* Disable machine check on no response or target abort */
> +        immap->im_pci.pci_emr = cpu_to_le32(0x1fe7);
> +#endif
> +

No need in such a level of splitness - this is going to be hard to
understand in common... 


>  #if defined CONFIG_ADS8272
>  	immap->im_siu_conf.siu_82xx.sc_siumcr =
>  		(immap->im_siu_conf.siu_82xx.sc_siumcr &
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
