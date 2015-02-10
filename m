Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9491D1A0F37
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 14:39:45 +1100 (AEDT)
Message-ID: <1423539572.4924.80.camel@kernel.crashing.org>
Subject: Re: [PATCH 03/18] powerpc/powernv:
 s/OPAL_PCI_SET_PHB_CXL_MODE/OPAL_PCI_SET_PHB_CAPI_MODE/ to match firmware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 14:39:32 +1100
In-Reply-To: <1423535220-6322-4-git-send-email-stewart@linux.vnet.ibm.com>
References: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1423535220-6322-4-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-10 at 13:26 +1100, Stewart Smith wrote:
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1481,9 +1481,9 @@ int pnv_phb_to_cxl(struct pci_dev *dev)
>  
>         pe_info(pe, "Switching PHB to CXL\n");
>  
> -       rc = opal_pci_set_phb_cxl_mode(phb->opal_id, 1, pe->pe_number);
> +       rc = opal_pci_set_phb_capi_mode(phb->opal_id, 1, pe->pe_number);
>         if (rc)
> -               dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
> +               dev_err(&dev->dev, "opal_pci_set_phb_capi_mode failed: %i\n", rc);
>  
>         return rc;
>  }

Add a comment above the call: /* CAPI is the IBM/Firmware name for "CXL" */

Cheers,
Ben.
