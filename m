Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17663.20973.922238.823386@cargo.ozlabs.ibm.com>
Date: Thu, 7 Sep 2006 08:55:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Josh Boyer <jdub@us.ibm.com>
Subject: Re: [PATCH] PPC 4xx: Enable XMON on PPC 4xx boards
In-Reply-To: <1157569083.6098.29.camel@zod.rchland.ibm.com>
References: <1157569083.6098.29.camel@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mporter@embeddedalley.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer writes:

> -		excp->msr |= 0x400;
> +		excp->msr |= MSR_SSTEP_ENABLE;
> +#ifdef CONFIG_4xx
> +		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
> +#endif
>  	} else if (at_breakpoint(excp->nip)) {
>  		xmon_trace[smp_processor_id()] = BRSTEP;
> -		excp->msr |= 0x400;
> +		excp->msr |= MSR_SSTEP_ENABLE;
> +#ifdef CONFIG_4xx
> +		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
> +#endif

This would be neater with a little inline xmon_enable_sstep(excp)
function...

Other than that, looks fine.

Paul.
