Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKxkr2JDqzDvy9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 23:14:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
 Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH] powerpc/eeh: Refactor EEH PE reset functions
In-Reply-To: <20161117050747.18250-1-ruscur@russell.cc>
References: <20161117050747.18250-1-ruscur@russell.cc>
Date: Fri, 18 Nov 2016 23:14:43 +1100
Message-ID: <877f810yto.fsf@concordia.ellerman.id.au>
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

Russell Currey <ruscur@russell.cc> writes:

> eeh_pe_reset and eeh_reset_pe are two different functions in the same
> file which do mostly the same thing.  Not only is this confusing, but
> potentially causes disrepancies in functionality, notably eeh_reset_pe
> as it does not check return values for failure.
>
> Refactor this into the following:
>
>  - eeh_pe_reset(): stays as is, performs a single operation, exported
>  - eeh_pe_reset_full(): new, full reset process that calls eeh_pe_reset()
>  - eeh_reset_pe(): removed and replaced by eeh_pe_reset_full()
>  - eeh_reset_pe_once(): removed

This seems reasonable.

Though the diff is pretty unreadable.

> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index f257316..ad743d3 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -808,76 +808,67 @@ static void *eeh_set_dev_freset(void *data, void *flag)
...
> +		/* Wait until the PE is in a functioning state */
>  		state = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
> -		if ((state & flags) == flags) {
> -			ret = 0;
> -			goto out;
> -		}
> +		if ((state & active_flags) == active_flags)
> +			break;
>  
>  		if (state < 0) {
> -			pr_warn("%s: Unrecoverable slot failure on PHB#%d-PE#%x",
> +			pr_warn("%s: Unrecoverable slot failure on PHB#%x-PE#%d",
>  				__func__, pe->phb->global_number, pe->addr);

That looks like unrelated %d -> %x stuff.

I dropped it and another below.

cheers
