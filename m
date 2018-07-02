Return-Path: <srs0=+knn=js=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KFSt4lldzF1LR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 04:02:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41KFSt2T4hz8tlw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 04:02:06 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41KFSs23m5z9s55
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2018 04:02:02 +1000 (AEST)
Date: Mon, 2 Jul 2018 20:01:58 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v3 PATCH 5/5] powerpc/pseries: Display machine check error
 details.
Message-ID: <20180702200158.7c8c6d4c@kitsune.suse.cz>
In-Reply-To: <20180608115136.7a6db415@roar.ozlabs.ibm.com>
References: <152839244928.25118.15100234720683911223.stgit@jupiter.in.ibm.com>
 <152839254280.25118.11212831020041096859.stgit@jupiter.in.ibm.com>
 <20180608115136.7a6db415@roar.ozlabs.ibm.com>
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

On Fri, 8 Jun 2018 11:51:36 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Thu, 07 Jun 2018 22:59:04 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
> > From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > 
> > Extract the MCE error details from RTAS extended log and display it
> > to console.
> > 
> > With this patch you should now see mce logs like below:
> > 
> > [  142.371818] Severe Machine check interrupt [Recovered]
> > [  142.371822]   NIP [d00000000ca301b8]: init_module+0x1b8/0x338
> > [bork_kernel] [  142.371822]   Initiator: CPU
> > [  142.371823]   Error type: SLB [Multihit]
> > [  142.371824]     Effective address: d00000000ca70000
> > 
> > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/rtas.h      |    5 +
> >  arch/powerpc/platforms/pseries/ras.c |  128
> > +++++++++++++++++++++++++++++++++- 2 files changed, 131
> > insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/rtas.h
> > b/arch/powerpc/include/asm/rtas.h index 3f2fba7ef23b..8100a95c133a
> > 100644 --- a/arch/powerpc/include/asm/rtas.h
> > +++ b/arch/powerpc/include/asm/rtas.h
> > @@ -190,6 +190,11 @@ static inline uint8_t
> > rtas_error_extended(const struct rtas_error_log *elog) return
> > (elog->byte1 & 0x04) >> 2; }
> >  
> > +static inline uint8_t rtas_error_initiator(const struct
> > rtas_error_log *elog) +{
> > +	return (elog->byte2 & 0xf0) >> 4;
> > +}
> > +
> >  #define rtas_error_type(x)	((x)->byte3)
> >  
> >  static inline
> > diff --git a/arch/powerpc/platforms/pseries/ras.c
> > b/arch/powerpc/platforms/pseries/ras.c index
> > e56759d92356..cd9446980092 100644 ---
> > a/arch/powerpc/platforms/pseries/ras.c +++
> > b/arch/powerpc/platforms/pseries/ras.c @@ -422,7 +422,130 @@ int
> > pSeries_system_reset_exception(struct pt_regs *regs) return 0; /*
> > need to perform reset */ }
> >  
> > -static int mce_handle_error(struct rtas_error_log *errp)
> > +#define VAL_TO_STRING(ar, val)	((val < ARRAY_SIZE(ar)) ?
> > ar[val] : "Unknown") +
> > +static void pseries_print_mce_info(struct pt_regs *regs,
> > +				struct rtas_error_log *errp, int
> > disposition) +{
> > +	const char *level, *sevstr;
> > +	struct pseries_errorlog *pseries_log;
> > +	struct pseries_mc_errorlog *mce_log;
> > +	uint8_t error_type, err_sub_type;
> > +	uint8_t initiator = rtas_error_initiator(errp);
> > +	uint64_t addr;
> > +
> > +	static const char * const initiators[] = {
> > +		"Unknown",
> > +		"CPU",
> > +		"PCI",
> > +		"ISA",
> > +		"Memory",
> > +		"Power Mgmt",
> > +	};
> > +	static const char * const mc_err_types[] = {
> > +		"UE",
> > +		"SLB",
> > +		"ERAT",
> > +		"TLB",
> > +		"D-Cache",
> > +		"Unknown",
> > +		"I-Cache",
> > +	};
> > +	static const char * const mc_ue_types[] = {
> > +		"Indeterminate",
> > +		"Instruction fetch",
> > +		"Page table walk ifetch",
> > +		"Load/Store",
> > +		"Page table walk Load/Store",
> > +	};
> > +
> > +	/* SLB sub errors valid values are 0x0, 0x1, 0x2 */
> > +	static const char * const mc_slb_types[] = {
> > +		"Parity",
> > +		"Multihit",
> > +		"Indeterminate",
> > +	};
> > +
> > +	/* TLB and ERAT sub errors valid values are 0x1, 0x2, 0x3
> > */
> > +	static const char * const mc_soft_types[] = {
> > +		"Unknown",
> > +		"Parity",
> > +		"Multihit",
> > +		"Indeterminate",
> > +	};
> > +
> > +	pseries_log = get_pseries_errorlog(errp,
> > PSERIES_ELOG_SECT_ID_MCE);
> > +	if (pseries_log == NULL)
> > +		return;
> > +
> > +	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
> > +
> > +	error_type = rtas_mc_error_type(mce_log);
> > +	err_sub_type = rtas_mc_error_sub_type(mce_log);
> > +
> > +	switch (rtas_error_severity(errp)) {
> > +	case RTAS_SEVERITY_NO_ERROR:
> > +		level = KERN_INFO;
> > +		sevstr = "Harmless";
> > +		break;
> > +	case RTAS_SEVERITY_WARNING:
> > +		level = KERN_WARNING;
> > +		sevstr = "";
> > +		break;
> > +	case RTAS_SEVERITY_ERROR:
> > +	case RTAS_SEVERITY_ERROR_SYNC:
> > +		level = KERN_ERR;
> > +		sevstr = "Severe";
> > +		break;
> > +	case RTAS_SEVERITY_FATAL:
> > +	default:
> > +		level = KERN_ERR;
> > +		sevstr = "Fatal";
> > +		break;
> > +	}
> > +
> > +	printk("%s%s Machine check interrupt [%s]\n", level,
> > sevstr,
> > +		disposition == RTAS_DISP_FULLY_RECOVERED ?
> > +		"Recovered" : "Not recovered");
> > +	if (user_mode(regs)) {
> > +		printk("%s  NIP: [%016lx] PID: %d Comm: %s\n",
> > level,
> > +			regs->nip, current->pid, current->comm);
> > +	} else {
> > +		printk("%s  NIP [%016lx]: %pS\n", level, regs->nip,
> > +			(void *)regs->nip);
> > +	}  
> 
> I think it's probably still useful to print pid/comm for kernel mode
> faults if !in_interrupt()... I see you're basically taking
> kernel/mce.c and doing the same thing.
> 
> Is there any reasonable way to share code here?
> 

I don't think so. In commit 36df96f8acaf ("powerpc/book3s: Decode and
save machine check event.") these enums are added:

enum MCE_ErrorType {
        MCE_ERROR_TYPE_UNKNOWN = 0,
        MCE_ERROR_TYPE_UE = 1,
        MCE_ERROR_TYPE_SLB = 2,
        MCE_ERROR_TYPE_ERAT = 3,
        MCE_ERROR_TYPE_TLB = 4,
};

enum MCE_UeErrorType {
        MCE_UE_ERROR_INDETERMINATE = 0,
        MCE_UE_ERROR_IFETCH = 1,
        MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH = 2,
        MCE_UE_ERROR_LOAD_STORE = 3,
        MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE = 4,
};

enum MCE_SlbErrorType {
        MCE_SLB_ERROR_INDETERMINATE = 0,
        MCE_SLB_ERROR_PARITY = 1,
        MCE_SLB_ERROR_MULTIHIT = 2,
};

enum MCE_EratErrorType {
        MCE_ERAT_ERROR_INDETERMINATE = 0,
        MCE_ERAT_ERROR_PARITY = 1,
        MCE_ERAT_ERROR_MULTIHIT = 2,
};

enum MCE_TlbErrorType {
        MCE_TLB_ERROR_INDETERMINATE = 0,
        MCE_TLB_ERROR_PARITY = 1,
        MCE_TLB_ERROR_MULTIHIT = 2,
};

And the patch in the series adds slightly different definitions:

/* RTAS pseries MCE error types */
#define PSERIES_MC_ERROR_TYPE_UE                0x00
#define PSERIES_MC_ERROR_TYPE_SLB               0x01
#define PSERIES_MC_ERROR_TYPE_ERAT              0x02
#define PSERIES_MC_ERROR_TYPE_TLB               0x04
#define PSERIES_MC_ERROR_TYPE_D_CACHE           0x05
#define PSERIES_MC_ERROR_TYPE_I_CACHE           0x07

/* RTAS pseries MCE error sub types */
#define PSERIES_MC_ERROR_UE_INDETERMINATE               0
#define PSERIES_MC_ERROR_UE_IFETCH                      1
#define PSERIES_MC_ERROR_UE_PAGE_TABLE_WALK_IFETCH      2
#define PSERIES_MC_ERROR_UE_LOAD_STORE                  3
#define PSERIES_MC_ERROR_UE_PAGE_TABLE_WALK_LOAD_STORE  4

#define PSERIES_MC_ERROR_SLB_PARITY             0
#define PSERIES_MC_ERROR_SLB_MULTIHIT           1
#define PSERIES_MC_ERROR_SLB_INDETERMINATE      2

#define PSERIES_MC_ERROR_ERAT_PARITY            1
#define PSERIES_MC_ERROR_ERAT_MULTIHIT          2
#define PSERIES_MC_ERROR_ERAT_INDETERMINATE     3

#define PSERIES_MC_ERROR_TLB_PARITY             1
#define PSERIES_MC_ERROR_TLB_MULTIHIT           2
#define PSERIES_MC_ERROR_TLB_INDETERMINATE      3


If the MCEs are indeed intentionally different between pSeries and
powernv it might be worth mentioning somewhere.

Thanks

Michal
