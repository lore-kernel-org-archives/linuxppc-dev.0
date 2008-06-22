Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 444C1DDF04
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jun 2008 10:32:15 +1000 (EST)
Subject: Re: [PATCH REPOST #2] IB/ehca: In case of lost interrupts, trigger
	EOI to reenable interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
In-Reply-To: <200806131655.43410.ossrosch@linux.vnet.ibm.com>
References: <200806131655.43410.ossrosch@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Sun, 22 Jun 2008 10:31:22 +1000
Message-Id: <1214094682.8011.200.camel@pasglop>
Mime-Version: 1.0
Cc: Roland Dreier <rdreier@cisco.com>, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	general@lists.openfabrics.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-06-13 at 16:55 +0200, Stefan Roscher wrote:
> During corner case testing, we noticed that some versions of ehca 
> do not properly transition to interrupt done in special load situations.
> This can be resolved by periodically triggering EOI through H_EOI, 
> if eqes are pending.
> 
> Signed-off-by: Stefan Roscher <stefan.roscher@de.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

﻿---

> As firmware team suggested I moved the call of the EOI h_call into 
> the handler function, this ensures that we will call EOI only when we 
> find a valid eqe on the event queue.
> Additionally I changed the calculation of the xirr value as Roland suggested.
> 
>  drivers/infiniband/hw/ehca/ehca_irq.c |    9 +++++++--
>  drivers/infiniband/hw/ehca/hcp_if.c   |   10 ++++++++++
>  drivers/infiniband/hw/ehca/hcp_if.h   |    1 +
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
> index ce1ab05..0792d93 100644
> --- a/drivers/infiniband/hw/ehca/ehca_irq.c
> +++ b/drivers/infiniband/hw/ehca/ehca_irq.c
> @@ -531,7 +531,7 @@ void ehca_process_eq(struct ehca_shca *shca, int is_irq)
>  {
>  	struct ehca_eq *eq = &shca->eq;
>  	struct ehca_eqe_cache_entry *eqe_cache = eq->eqe_cache;
> -	u64 eqe_value;
> +	u64 eqe_value, ret;
>  	unsigned long flags;
>  	int eqe_cnt, i;
>  	int eq_empty = 0;
> @@ -583,8 +583,13 @@ void ehca_process_eq(struct ehca_shca *shca, int is_irq)
>  			ehca_dbg(&shca->ib_device,
>  				 "No eqe found for irq event");
>  		goto unlock_irq_spinlock;
> -	} else if (!is_irq)
> +	} else if (!is_irq) {
> +		ret = hipz_h_eoi(eq->ist);
> +		if (ret != H_SUCCESS)
> +			ehca_err(&shca->ib_device,
> +				 "bad return code EOI -rc = %ld\n", ret);
>  		ehca_dbg(&shca->ib_device, "deadman found %x eqe", eqe_cnt);
> +	}
>  	if (unlikely(eqe_cnt == EHCA_EQE_CACHE_SIZE))
>  		ehca_dbg(&shca->ib_device, "too many eqes for one irq event");
>  	/* enable irq for new packets */
> diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
> index 5245e13..415d3a4 100644
> --- a/drivers/infiniband/hw/ehca/hcp_if.c
> +++ b/drivers/infiniband/hw/ehca/hcp_if.c
> @@ -933,3 +933,13 @@ u64 hipz_h_error_data(const struct ipz_adapter_handle adapter_handle,
>  				       r_cb,
>  				       0, 0, 0, 0);
>  }
> +
> +u64 hipz_h_eoi(int irq)
> +{
> +	unsigned long xirr;
> +
> +	iosync();
> +	xirr = (0xffULL << 24) | irq;
> +
> +	return plpar_hcall_norets(H_EOI, xirr);
> +}
> diff --git a/drivers/infiniband/hw/ehca/hcp_if.h b/drivers/infiniband/hw/ehca/hcp_if.h
> index 60ce02b..2c3c6e0 100644
> --- a/drivers/infiniband/hw/ehca/hcp_if.h
> +++ b/drivers/infiniband/hw/ehca/hcp_if.h
> @@ -260,5 +260,6 @@ u64 hipz_h_error_data(const struct ipz_adapter_handle adapter_handle,
>  		      const u64 ressource_handle,
>  		      void *rblock,
>  		      unsigned long *byte_count);
> +u64 hipz_h_eoi(int irq);
>  
>  #endif /* __HCP_IF_H__ */
