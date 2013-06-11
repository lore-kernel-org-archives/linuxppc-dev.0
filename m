Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 228C72C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 17:38:08 +1000 (EST)
Message-ID: <1370936279.8250.94.camel@pasglop>
Subject: Re: [PATCH 17/27] powerpc/eeh: I/O chip PE log and bridge setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 11 Jun 2013 17:37:59 +1000
In-Reply-To: <1370417668-16832-18-git-send-email-shangw@linux.vnet.ibm.com>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1370417668-16832-18-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-05 at 15:34 +0800, Gavin Shan wrote:
> The patch adds backends to retrieve error log and configure p2p
> bridges for the indicated PE.
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---

> +/**
> + * ioda_eeh_configure_bridge - Configure the PCI bridges for the indicated PE
> + * @pe: EEH PE
> + *
> + * For particular PE, it might have included PCI bridges. In order
> + * to make the PE work properly, those PCI bridges should be configured
> + * correctly. However, we need do nothing on P7IOC since the reset
> + * function will do everything that should be covered by the function.
> + */
> +static int ioda_eeh_configure_bridge(struct eeh_pe *pe)
> +{
> +	return 0;

Does it now ?

IE. Who reconfigures the windows and other config space bits of P2P
bridges ? Or is this handled elsewhere in Linux or in the upper levels
of EEH ? Or is that only needed for the PHB ?

Cheers,
Ben.
