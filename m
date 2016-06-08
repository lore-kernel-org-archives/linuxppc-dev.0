Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPgWp4ftbzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 17:47:34 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 01:47:32 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH, RFC] cxl: Add support for CAPP DMA mode
In-Reply-To: <1465362594-10437-1-git-send-email-imunsie@au.ibm.com>
References: <1464025158-23849-1-git-send-email-imunsie@au.ibm.com>
 <1465362594-10437-1-git-send-email-imunsie@au.ibm.com>
Date: Wed, 08 Jun 2016 17:46:27 +1000
Message-ID: <87lh2gi0mk.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian Munsie <imunsie@au1.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 3a5ea82..5a42e98 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2793,7 +2793,9 @@ int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
>  	pe_info(pe, "Switching PHB to CXL\n");
>  
>  	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, mode, pe->pe_number);
> -	if (rc)
> +	if (rc == OPAL_UNSUPPORTED)
> +		dev_err(&dev->dev, "Required cxl mode not supported by firmware - update skiboot\n");
> +	else if (rc)
>  		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed:
> %i\n", rc);

Could mention version required, which would be skiboot 5.3.x or higher.

This could be something we start doing - there's enough random bits of
functionality we could tell the user exactly what they have to upgrade
to to have work.

-- 
Stewart Smith
OPAL Architect, IBM.
