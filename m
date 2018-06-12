Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414rmw6d18zF4Wv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 23:48:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v3 PATCH 4/5] powerpc/pseries: Dump and flush SLB contents on
 SLB MCE errors.
In-Reply-To: <152839253238.25118.3114450844744290470.stgit@jupiter.in.ibm.com>
References: <152839244928.25118.15100234720683911223.stgit@jupiter.in.ibm.com>
 <152839253238.25118.3114450844744290470.stgit@jupiter.in.ibm.com>
Date: Tue, 12 Jun 2018 23:47:59 +1000
Message-ID: <87lgbkt8ts.fsf@concordia.ellerman.id.au>
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

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index 2edc673be137..e56759d92356 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -422,6 +422,31 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
>  	return 0; /* need to perform reset */
>  }
>  
> +static int mce_handle_error(struct rtas_error_log *errp)
> +{
> +	struct pseries_errorlog *pseries_log;
> +	struct pseries_mc_errorlog *mce_log;
> +	int disposition = rtas_error_disposition(errp);
> +	uint8_t error_type;
> +
> +	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
> +	if (pseries_log == NULL)
> +		goto out;
> +
> +	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
> +	error_type = rtas_mc_error_type(mce_log);
> +
> +	if ((disposition == RTAS_DISP_NOT_RECOVERED) &&
> +			(error_type == PSERIES_MC_ERROR_TYPE_SLB)) {
> +		slb_dump_contents();
> +		slb_flush_and_rebolt();

Aren't we back in virtual mode here?

Don't we need to do the flush in real mode before turning the MMU back
on. Otherwise we'll just take another multi-hit?

cheers
