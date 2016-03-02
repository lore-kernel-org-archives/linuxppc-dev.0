Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA3D51A005D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 12:03:27 +1100 (AEDT)
Message-ID: <1456880600.4528.3.camel@russell.cc>
Subject: Re: [PATCH 3/3] powerpc/eeh: Synchronize recovery in host/guest
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 02 Mar 2016 12:03:20 +1100
In-Reply-To: <1456445092-18337-4-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1456445092-18337-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1456445092-18337-4-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-02-26 at 11:04 +1100, Gavin Shan wrote:
> When passing through SRIOV VFs to guest, we possibly encounter EEH
> error on PF. In this case, the VF PEs are put into frozen state.
> The error could be reported to guest before it's captured by the
> host. That means the guest could attempt to recover errors on VFs
> before host gets chance to recover errors on PFs. The VFs won't be
> recovered successfully.
> 
> This enforces the recovery order for above case: the recovery on
> child PE in guest is hold until the recovery on parent PE in host
> is completed.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/eeh.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index fd9c782..42bd546 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1541,6 +1541,17 @@ int eeh_pe_get_state(struct eeh_pe *pe)
>  	if (!eeh_ops || !eeh_ops->get_state)
>  		return -ENOENT;
>  
> +	/*
> +	 * If the parent PE, which is owned by host kernel, is
> experiencing
> +	 * error recovery. We should return temporarily unavailable PE
> state
> +	 * so that the recovery on guest side is suspended until the
> error
> +	 * recovery is completed on host side.
> +	 */

Hi Gavin,

I think this could be worded a little better.  For example:

/*
 * If the parent PE is owned by the host kernel and is undergoing
 * error recovery, we should return the PE state as temporarily
 * unavailable so that the error recovery on the guest is suspended
 * until the recovery completes on the host.
 */

> +	if (pe->parent &&
> +	    !(pe->state & EEH_PE_REMOVED) &&
> +	    (pe->parent->state & (EEH_PE_ISOLATED | EEH_PE_RECOVERING)))
> +		return EEH_PE_STATE_UNAVAIL;
> +
>  	result = eeh_ops->get_state(pe, NULL);
>  	rst_active = !!(result & EEH_STATE_RESET_ACTIVE);
>  	dma_en = !!(result & EEH_STATE_DMA_ENABLED);
