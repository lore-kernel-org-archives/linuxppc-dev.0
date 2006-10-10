Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5D16D679E2
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 01:33:22 +1000 (EST)
Date: Tue, 10 Oct 2006 09:03:02 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 3/4] [PATCH] Replace HAVE_ARCH_PCI_MWI with PCI_DISABLE_MWI
Message-ID: <20061010150302.GD8993@parisc-linux.org>
References: <11604888823362-git-send-email-matthew@wil.cx>
	<1160488882440-git-send-email-matthew@wil.cx>
	<11604888831312-git-send-email-matthew@wil.cx>
	<11604888833435-git-send-email-matthew@wil.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11604888833435-git-send-email-matthew@wil.cx>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


More get-send-email brokenness.  I've fixed that in my local copy and
sent the patch to the git mailing list now, so this shouldn't happen
again.

On Tue, Oct 10, 2006 at 08:01:21AM -0600, Matthew Wilcox wrote:
> From: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
> 
> pSeries is the only architecture left using HAVE_ARCH_PCI_MWI and it's
> really inappropriate for its needs.  It really wants to disable MWI
> altogether.  So here are a pair of stub implementations for pci_set_mwi
> and pci_clear_mwi.
> 
> Also rename pci_generic_prep_mwi to pci_set_cacheline_size since that
> better reflects what it does.
> 
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> ---
>  drivers/pci/pci.c         |   31 ++++++++++++++++++-------------
>  include/asm-powerpc/pci.h |   20 +++++++-------------
>  2 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2b93aaf..fc97b91 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -831,7 +831,17 @@ pci_set_master(struct pci_dev *dev)
>  	pcibios_set_master(dev);
>  }
>  
> -#ifndef HAVE_ARCH_PCI_MWI
> +#ifdef PCI_DISABLE_MWI
> +int pci_set_mwi(struct pci_dev *dev)
> +{
> +	return 0;
> +}
> +
> +void pci_clear_mwi(struct pci_dev *dev)
> +{
> +}
> +
> +#else
>  
>  #ifndef PCI_CACHE_LINE_BYTES
>  #define PCI_CACHE_LINE_BYTES L1_CACHE_BYTES
> @@ -842,17 +852,17 @@ #endif
>  u8 pci_cache_line_size = PCI_CACHE_LINE_BYTES / 4;
>  
>  /**
> - * pci_generic_prep_mwi - helper function for pci_set_mwi
> - * @dev: the PCI device for which MWI is enabled
> + * pci_set_cacheline_size - ensure the CACHE_LINE_SIZE register is programmed
> + * @dev: the PCI device for which MWI is to be enabled
>   *
> - * Helper function for generic implementation of pcibios_prep_mwi
> - * function.  Originally copied from drivers/net/acenic.c.
> + * Helper function for pci_set_mwi.
> + * Originally copied from drivers/net/acenic.c.
>   * Copyright 1998-2001 by Jes Sorensen, <jes@trained-monkey.org>.
>   *
>   * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
>   */
>  static int
> -pci_generic_prep_mwi(struct pci_dev *dev)
> +pci_set_cacheline_size(struct pci_dev *dev)
>  {
>  	u8 cacheline_size;
>  
> @@ -878,7 +888,6 @@ pci_generic_prep_mwi(struct pci_dev *dev
>  
>  	return -EINVAL;
>  }
> -#endif /* !HAVE_ARCH_PCI_MWI */
>  
>  /**
>   * pci_set_mwi - enables memory-write-invalidate PCI transaction
> @@ -896,12 +905,7 @@ pci_set_mwi(struct pci_dev *dev)
>  	int rc;
>  	u16 cmd;
>  
> -#ifdef HAVE_ARCH_PCI_MWI
> -	rc = pcibios_prep_mwi(dev);
> -#else
> -	rc = pci_generic_prep_mwi(dev);
> -#endif
> -
> +	rc = pci_set_cacheline_size(dev);
>  	if (rc)
>  		return rc;
>  
> @@ -932,6 +936,7 @@ pci_clear_mwi(struct pci_dev *dev)
>  		pci_write_config_word(dev, PCI_COMMAND, cmd);
>  	}
>  }
> +#endif /* ! PCI_DISABLE_MWI */
>  
>  /**
>   * pci_intx - enables/disables PCI INTx for device dev
> diff --git a/include/asm-powerpc/pci.h b/include/asm-powerpc/pci.h
> index 46afd29..721c97f 100644
> --- a/include/asm-powerpc/pci.h
> +++ b/include/asm-powerpc/pci.h
> @@ -62,19 +62,13 @@ static inline int pci_get_legacy_ide_irq
>  }
>  
>  #ifdef CONFIG_PPC64
> -#define HAVE_ARCH_PCI_MWI 1
> -static inline int pcibios_prep_mwi(struct pci_dev *dev)
> -{
> -	/*
> -	 * We would like to avoid touching the cacheline size or MWI bit
> -	 * but we cant do that with the current pcibios_prep_mwi 
> -	 * interface. pSeries firmware sets the cacheline size (which is not
> -	 * the cpu cacheline size in all cases) and hardware treats MWI 
> -	 * the same as memory write. So we dont touch the cacheline size
> -	 * here and allow the generic code to set the MWI bit.
> -	 */
> -	return 0;
> -}
> +
> +/*
> + * We want to avoid touching the cacheline size or MWI bit.
> + * pSeries firmware sets the cacheline size (which is not the cpu cacheline
> + * size in all cases) and hardware treats MWI the same as memory write.
> + */
> +#define PCI_DISABLE_MWI
>  
>  extern struct dma_mapping_ops pci_dma_ops;
>  
> -- 
> 1.4.1.1
