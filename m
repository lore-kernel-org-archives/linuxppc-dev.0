Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 05AB72C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 20:38:56 +1100 (EST)
Message-ID: <1384940328.26969.88.camel@pasglop>
Subject: Re: [PATCH] powerpc/eeh: Dump PHB3 diag-data on frozen PE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Wed, 20 Nov 2013 20:38:48 +1100
In-Reply-To: <1384940196-32514-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1384940196-32514-1-git-send-email-shangw@linux.vnet.ibm.com>
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

On Wed, 2013-11-20 at 17:36 +0800, Gavin Shan wrote:
> While we detect frozen PE on PHB3, it's always meaningful to have
> the dumped diag-data for further diagnosis and analysis.

Don't we trip that during PCI probing ? For example if we probe behind
a PCI-X bridge (which can exist on an adapter) we'll trip EEH on every
non-existing device won't we ?

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/eeh-ioda.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
> index 02245ce..481528d 100644
> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
> @@ -994,8 +994,11 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
>  			if (ioda_eeh_get_pe(hose, frozen_pe_no, pe))
>  				break;
>  
> +			/* It would be always indicative to have PHB diag-data */
>  			pr_err("EEH: Frozen PE#%x on PHB#%x detected\n",
>  				(*pe)->addr, (*pe)->phb->global_number);
> +			ioda_eeh_phb_diag(hose);
> +
>  			ret = 1;
>  			goto out;
>  		}
