Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 2DA3A67D35
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jul 2005 02:16:53 +1000 (EST)
In-Reply-To: <1D6EDDB3E43F3B40BC089CCFEE99DB7D14D056@exnanycmbx1.corp.root.ipc.com>
References: <1D6EDDB3E43F3B40BC089CCFEE99DB7D14D056@exnanycmbx1.corp.root.ipc.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AE1B0170-7A23-4C8A-BDD4-C30255DD2A20@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 22 Jul 2005 11:16:45 -0500
To: "Downing, Thomas" <Thomas.Downing@ipc.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 2.6.12.3 Compilation error when CONFIG_PQ2FADS=y
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the patch, I'll send it upstream.  In the future can you  
follow the patch submission details described in Documentation/ 
SubmittingPatches.

- kumar

On Jul 22, 2005, at 8:46 AM, Downing, Thomas wrote:

> Compilation fails for arch/ppc/syslib/m82xx_pci.c in version
> 2.6.12.3 when CONFIG_PQ2FADS=y.  The following patch fixes the
> problems, which are just typographical.
>
> The patch has been tested on PQ2FADS-ZU and -VR boards on 8280
> and 8275 devices.
>
> --- linux-2.6.12.3/arch/ppc/syslib/m82xx_pci.c    2005-07-15  
> 17:18:57.000000000 -0400
> +++ linux-musrum/arch/ppc/syslib/m82xx_pci.c    2005-07-20  
> 08:42:41.000000000 -0400
> @@ -238,9 +238,9 @@ pq2ads_setup_pci(struct pci_controller *
>       * Setting required to enable IRQ1-IRQ7 (SIUMCR [DPPC]),
>       * and local bus for PCI (SIUMCR [LBPC]).
>       */
> -    immap->im_siu_conf.siu_82xx.sc_siumcr = (immap- 
> >im_siu_conf.sc_siumcr &
> -                ~(SIUMCR_L2PC11 | SIUMCR_LBPC11 | SIUMCR_CS10PC11  
> | SIUMCR_APPC11) |
> -                SIUMCR_BBD | SIUMCR_LBPC01 | SIUMCR_DPPC11 |  
> SIUMCR_APPC10;
> +    immap->im_siu_conf.siu_82xx.sc_siumcr = (immap- 
> >im_siu_conf.siu_82xx.sc_siumcr &
> +                ~(SIUMCR_L2CPC11 | SIUMCR_LBPC11 | SIUMCR_CS10PC11  
> | SIUMCR_APPC11) |
> +                SIUMCR_BBD | SIUMCR_LBPC01 | SIUMCR_DPPC11 |  
> SIUMCR_APPC10);
>  #endif
>      /* Enable PCI  */
>      immap->im_pci.pci_gcr = cpu_to_le32(PCIGCR_PCI_BUS_EN);
>
> Thomas Downing
> IPC Information Systems, LLC
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
