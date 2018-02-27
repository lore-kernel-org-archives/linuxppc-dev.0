Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqzzH3rrVzDqSX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 11:27:07 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id z10so2896697pfh.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 16:27:07 -0800 (PST)
Message-ID: <1519691217.24879.1.camel@gmail.com>
Subject: Re: [PATCH] xmon: Setup xmon debugger hooks when first break-point
 is set
From: Balbir Singh <bsingharora@gmail.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,  Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>, Douglas Miller
 <dougmill@linux.vnet.ibm.com>, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 11:26:57 +1100
In-Reply-To: <20180226113607.20321-1-vaibhav@linux.vnet.ibm.com>
References: <20180226113607.20321-1-vaibhav@linux.vnet.ibm.com>
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

On Mon, 2018-02-26 at 17:06 +0530, Vaibhav Jain wrote:
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
> instruction or data break-point is set via xmon console. It also clears
> all breakpoints when xmon is disabled via debugfs.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  arch/powerpc/xmon/xmon.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
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

Can we get this three liner into an inline function?

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
>  		break;
>  	}
>  }
> @@ -3651,9 +3670,22 @@ device_initcall(setup_xmon_sysrq);
>  #ifdef CONFIG_DEBUG_FS
>  static int xmon_dbgfs_set(void *data, u64 val)
>  {
> +	int i;
> +
>  	xmon_on = !!val;
>  	xmon_init(xmon_on);
>  
> +	/* make sure all breakpoints removed when disabling */
> +	if (!xmon_on) {
> +		for (i = 0; i < NBPTS; ++i)
> +			bpts[i].enabled = 0;
> +		/* if anything set inform user that breakpoints are cleared */
> +		if (iabr || dabr.enabled)
> +			pr_info("xmon: All breakpoints cleared\n");
> +
> +		iabr = NULL;
> +		dabr.enabled = 0;

Is this sufficient or do we need remove_bpts()

Balbir Singh
