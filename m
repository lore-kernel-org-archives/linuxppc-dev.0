Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9532E1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 14:03:57 +1000 (EST)
Message-ID: <1410840236.12488.1.camel@concordia>
Subject: Re: [PATCH] powerpc/eeh: Fix kernel crash when passing through VF
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Tue, 16 Sep 2014 14:03:56 +1000
In-Reply-To: <1410768481-27325-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1410406921-8557-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1410768481-27325-1-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-09-15 at 16:08 +0800, Wei Yang wrote:
> This patch introduces a marco to convert eeh_dev to eeh_pe. By doing so, it
> will prevent converting with NULL pointer.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
> V2 -> V3:
>    1. rebased on 3.17-rc4
>    2. introduce a marco
>    3. use this marco in several other places

Macro :)

> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 59a64f8..0f1b637 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -410,7 +410,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
>  	}
>  	dn = eeh_dev_to_of_node(edev);
>  	dev = eeh_dev_to_pci_dev(edev);
> -	pe = edev->pe;
> +	pe = eeh_dev_to_pe(edev);

This looks good, but ..

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fd03e819..9656f92 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1824,6 +1824,11 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>  {
>  	return pdev->dev.archdata.edev;
>  }
> +
> +static inline struct eeh_pe *eeh_dev_to_pe(struct eeh_dev* edev)
> +{
> +	return edev ? edev->pe : NULL;
> +}
>  #endif

Why is it in linux/pci.h ? It's powerpc specific, it should be in arch/powerpc/include/asm/pci.h

cheers
