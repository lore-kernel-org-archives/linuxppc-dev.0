Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qr8Fm3vJ9zDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 16:38:04 +1000 (AEST)
Message-ID: <1461220684.3245.4.camel@ellerman.id.au>
Subject: Re: [PATCH]powerpc/perf: Replace raw event hex values with #def
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 21 Apr 2016 16:38:04 +1000
In-Reply-To: <1461211214-4705-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1461211214-4705-1-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 2016-04-21 at 09:30 +0530, Madhavan Srinivasan wrote:
> @@ -488,17 +489,17 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
>  
>  /* Table of alternatives, sorted by column 0 */
>  static const unsigned int event_alternatives[][MAX_ALT] = {
> -	{ 0x10134, 0x301e2 },		/* PM_MRK_ST_CMPL */
> -	{ 0x10138, 0x40138 },		/* PM_BR_MRK_2PATH */
> -	{ 0x18082, 0x3e05e },		/* PM_L3_CO_MEPF */
> -	{ 0x1d14e, 0x401e8 },		/* PM_MRK_DATA_FROM_L2MISS */
> -	{ 0x1e054, 0x4000a },		/* PM_CMPLU_STALL */
> -	{ 0x20036, 0x40036 },		/* PM_BR_2PATH */
> -	{ 0x200f2, 0x300f2 },		/* PM_INST_DISP */
> -	{ 0x200f4, 0x600f4 },		/* PM_RUN_CYC */
> -	{ 0x2013c, 0x3012e },		/* PM_MRK_FILT_MATCH */
> -	{ 0x3e054, 0x400f0 },		/* PM_LD_MISS_L1 */
> -	{ 0x400fa, 0x500fa },		/* PM_RUN_INST_CMPL */
> +	{ PM_MRK_ST_CMPL,		_PM_MRK_ST_CMPL },
> +	{ PM_BR_MRK_2PATH,		_PM_BR_MRK_2PATH },
> +	{ PM_L3_CO_MEPF,		_PM_L3_CO_MEPF },
> +	{ PM_MRK_DATA_FROM_L2MISS,	_PM_MRK_DATA_FROM_L2MISS },
> +	{ PM_CMPLU_STALL,		_PM_CMPLU_STALL },
> +	{ PM_BR_2PATH,			_PM_BR_2PATH },
> +	{ PM_INST_DISP,			_PM_INST_DISP },
> +	{ _PM_RUN_CYC,			PM_RUN_CYC },
> +	{ PM_MRK_FILT_MATCH,		_PM_MRK_FILT_MATCH },
> +	{ PM_LD_MISS_L1,		_PM_LD_MISS_L1 },
> +	{ _PM_RUN_INST_CMPL,		PM_RUN_INST_CMPL },

I think I'd prefer it if the alternate events were named more like
PM_MRK_ST_CMPL_ALT, or ALT_PM_MRK_ST_CMPL ?

cheers
