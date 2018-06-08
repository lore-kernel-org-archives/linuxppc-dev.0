Return-Path: <srs0=i0xg=i2=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41254J6BFTzF31v
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 11:51:44 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41254J4mcXz8tNJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 11:51:44 +1000 (AEST)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41254J18m9z9s1b
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2018 11:51:43 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id a14-v6so4997000pgw.10
 for <linuxppc-dev@ozlabs.org>; Thu, 07 Jun 2018 18:51:43 -0700 (PDT)
Date: Fri, 8 Jun 2018 11:51:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [v3 PATCH 5/5] powerpc/pseries: Display machine check error
 details.
Message-ID: <20180608115136.7a6db415@roar.ozlabs.ibm.com>
In-Reply-To: <152839254280.25118.11212831020041096859.stgit@jupiter.in.ibm.com>
References: <152839244928.25118.15100234720683911223.stgit@jupiter.in.ibm.com>
 <152839254280.25118.11212831020041096859.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 07 Jun 2018 22:59:04 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Extract the MCE error details from RTAS extended log and display it to
> console.
> 
> With this patch you should now see mce logs like below:
> 
> [  142.371818] Severe Machine check interrupt [Recovered]
> [  142.371822]   NIP [d00000000ca301b8]: init_module+0x1b8/0x338 [bork_kernel]
> [  142.371822]   Initiator: CPU
> [  142.371823]   Error type: SLB [Multihit]
> [  142.371824]     Effective address: d00000000ca70000
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/rtas.h      |    5 +
>  arch/powerpc/platforms/pseries/ras.c |  128 +++++++++++++++++++++++++++++++++-
>  2 files changed, 131 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index 3f2fba7ef23b..8100a95c133a 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -190,6 +190,11 @@ static inline uint8_t rtas_error_extended(const struct rtas_error_log *elog)
>  	return (elog->byte1 & 0x04) >> 2;
>  }
>  
> +static inline uint8_t rtas_error_initiator(const struct rtas_error_log *elog)
> +{
> +	return (elog->byte2 & 0xf0) >> 4;
> +}
> +
>  #define rtas_error_type(x)	((x)->byte3)
>  
>  static inline
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index e56759d92356..cd9446980092 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -422,7 +422,130 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
>  	return 0; /* need to perform reset */
>  }
>  
> -static int mce_handle_error(struct rtas_error_log *errp)
> +#define VAL_TO_STRING(ar, val)	((val < ARRAY_SIZE(ar)) ? ar[val] : "Unknown")
> +
> +static void pseries_print_mce_info(struct pt_regs *regs,
> +				struct rtas_error_log *errp, int disposition)
> +{
> +	const char *level, *sevstr;
> +	struct pseries_errorlog *pseries_log;
> +	struct pseries_mc_errorlog *mce_log;
> +	uint8_t error_type, err_sub_type;
> +	uint8_t initiator = rtas_error_initiator(errp);
> +	uint64_t addr;
> +
> +	static const char * const initiators[] = {
> +		"Unknown",
> +		"CPU",
> +		"PCI",
> +		"ISA",
> +		"Memory",
> +		"Power Mgmt",
> +	};
> +	static const char * const mc_err_types[] = {
> +		"UE",
> +		"SLB",
> +		"ERAT",
> +		"TLB",
> +		"D-Cache",
> +		"Unknown",
> +		"I-Cache",
> +	};
> +	static const char * const mc_ue_types[] = {
> +		"Indeterminate",
> +		"Instruction fetch",
> +		"Page table walk ifetch",
> +		"Load/Store",
> +		"Page table walk Load/Store",
> +	};
> +
> +	/* SLB sub errors valid values are 0x0, 0x1, 0x2 */
> +	static const char * const mc_slb_types[] = {
> +		"Parity",
> +		"Multihit",
> +		"Indeterminate",
> +	};
> +
> +	/* TLB and ERAT sub errors valid values are 0x1, 0x2, 0x3 */
> +	static const char * const mc_soft_types[] = {
> +		"Unknown",
> +		"Parity",
> +		"Multihit",
> +		"Indeterminate",
> +	};
> +
> +	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
> +	if (pseries_log == NULL)
> +		return;
> +
> +	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
> +
> +	error_type = rtas_mc_error_type(mce_log);
> +	err_sub_type = rtas_mc_error_sub_type(mce_log);
> +
> +	switch (rtas_error_severity(errp)) {
> +	case RTAS_SEVERITY_NO_ERROR:
> +		level = KERN_INFO;
> +		sevstr = "Harmless";
> +		break;
> +	case RTAS_SEVERITY_WARNING:
> +		level = KERN_WARNING;
> +		sevstr = "";
> +		break;
> +	case RTAS_SEVERITY_ERROR:
> +	case RTAS_SEVERITY_ERROR_SYNC:
> +		level = KERN_ERR;
> +		sevstr = "Severe";
> +		break;
> +	case RTAS_SEVERITY_FATAL:
> +	default:
> +		level = KERN_ERR;
> +		sevstr = "Fatal";
> +		break;
> +	}
> +
> +	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
> +		disposition == RTAS_DISP_FULLY_RECOVERED ?
> +		"Recovered" : "Not recovered");
> +	if (user_mode(regs)) {
> +		printk("%s  NIP: [%016lx] PID: %d Comm: %s\n", level,
> +			regs->nip, current->pid, current->comm);
> +	} else {
> +		printk("%s  NIP [%016lx]: %pS\n", level, regs->nip,
> +			(void *)regs->nip);
> +	}

I think it's probably still useful to print pid/comm for kernel mode
faults if !in_interrupt()... I see you're basically taking kernel/mce.c
and doing the same thing.

Is there any reasonable way to share code here?

Thanks,
Nick
