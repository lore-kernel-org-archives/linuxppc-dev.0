Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsHH44G9JzF1l8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 14:00:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] xmon: Setup xmon debugger hooks when first break-point is
 set
In-Reply-To: <20180226113607.20321-1-vaibhav@linux.vnet.ibm.com>
References: <20180226113607.20321-1-vaibhav@linux.vnet.ibm.com>
Date: Thu, 01 Mar 2018 14:00:15 +1100
Message-ID: <87tvu08pq8.fsf@concordia.ellerman.id.au>
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

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:

> Presently sysrq key for xmon('x') is registered during kernel init
> irrespective of the value of kernel param 'xmon'. Thus xmon is enabled
> even if 'xmon=off' is passed on the kernel command line. However this
> doesn't enable the kernel debugger hooks needed for instruction or data
> breakpoints. Thus when a break-point is hit with xmon=off a kernel oops
> of the form below is reported:
>
> Oops: Exception in kernel mode, sig: 5 [#1]
> < snip >
> Trace/breakpoint trap
>
> To fix this the patch checks and enables debugger hooks when an
> instruction or data break-point is set via xmon console.

> It also clears
     ^^^^
> all breakpoints when xmon is disabled via debugfs.

Can you split that into a separate patch please.

> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 82e1a3ee6e0f..3679f5417a7e 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -1295,6 +1295,7 @@ bpt_cmds(void)
>  	switch (cmd) {
>  #ifndef CONFIG_PPC_8xx
>  	static const char badaddr[] = "Only kernel addresses are permitted for breakpoints\n";
> +	static const char warnxmon[] = "xmon: Enabling debugger hooks\n";
>  	int mode;
>  	case 'd':	/* bd - hardware data breakpoint */
>  		mode = 7;
> @@ -1315,6 +1316,11 @@ bpt_cmds(void)
>  			dabr.address &= ~HW_BRK_TYPE_DABR;
>  			dabr.enabled = mode | BP_DABR;
>  		}
> +		/* Enable xmon hooks if needed */
> +		if (!xmon_on) {
> +			printf(warnxmon);
> +			xmon_on = 1;
> +		}
>  		break;
>  
>  	case 'i':	/* bi - hardware instr breakpoint */
> @@ -1335,6 +1341,12 @@ bpt_cmds(void)
>  		if (bp != NULL) {
>  			bp->enabled |= BP_CIABR;
>  			iabr = bp;
> +
> +			/* Enable xmon hooks if needed */
> +			if (!xmon_on) {
> +				printf(warnxmon);
> +				xmon_on = 1;
> +			}
>  		}
>  		break;
>  #endif
> @@ -1399,8 +1411,15 @@ bpt_cmds(void)
>  		if (!check_bp_loc(a))
>  			break;
>  		bp = new_breakpoint(a);
> -		if (bp != NULL)
> +		if (bp != NULL) {
>  			bp->enabled |= BP_TRAP;
> +
> +			/* Enable xmon hooks if needed */
> +			if (!xmon_on) {
> +				printf(warnxmon);
> +				xmon_on = 1;
> +			}
> +		}

Yeah Balbir is right, repeating that three times is ugly. A static
function would do, and also avoids you feeling like you need to make
warnxmon a static char[].

cheers
