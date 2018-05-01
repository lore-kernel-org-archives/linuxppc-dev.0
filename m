Return-Path: <npiggin@gmail.com>
Date: Tue, 1 May 2018 13:47:23 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: skiboot@lists.ozlabs.org, stewart@linux.vnet.ibm.com
Subject: Re: [Skiboot] [PATCH 1/2] SLW: Remove stop1_lite and stop0 stop states
Message-ID: <20180501134723.5d00ddf0@roar.ozlabs.ibm.com>
In-Reply-To: <1525079529-2284-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1525079529-2284-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
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

On Mon, 30 Apr 2018 14:42:08 +0530
Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:

> Powersaving for stop0_lite and stop1_lite is observed to be quite similar
> and both states resume without state loss. Using context_switch test [1]
> we observe that stop0_lite has slightly lower latency, hence removing
> stop1_lite.
> 
> [1] linux/tools/testing/selftests/powerpc/benchmarks/context_switch.c
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

I'm okay for removing stop1_lite and stop2_lite -- SMT switching
is very latency critical. If we decide to actually start saving
real power then SMT should already have been switched.

So I would put stop1_lite and stop2_lite removal in the same patch.

Then what do we have? stop0_lite, stop0, stop1 for our fast idle
states.

I would be against removing stop0 if that is our fastest way to
release SMT resources, even if there is only a small advantage. Why
not remove stop1 instead?

We also need to better evaluate stop0_lite. How much advantage does
that have over snooze?

Thanks,
Nick


> ---
>  hw/slw.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
> 
> diff --git a/hw/slw.c b/hw/slw.c
> index 3f9abaa..edfc783 100644
> --- a/hw/slw.c
> +++ b/hw/slw.c
> @@ -521,36 +521,6 @@ static struct cpu_idle_states power9_cpu_idle_states[] = {
>  				 | OPAL_PM_PSSCR_TR(3),
>  		.pm_ctrl_reg_mask = OPAL_PM_PSSCR_MASK },
>  	{
> -		.name = "stop0",
> -		.latency_ns = 2000,
> -		.residency_ns = 20000,
> -		.flags = 0*OPAL_PM_DEC_STOP \
> -		       | 0*OPAL_PM_TIMEBASE_STOP  \
> -		       | 1*OPAL_PM_LOSE_USER_CONTEXT \
> -		       | 0*OPAL_PM_LOSE_HYP_CONTEXT \
> -		       | 0*OPAL_PM_LOSE_FULL_CONTEXT \
> -		       | 1*OPAL_PM_STOP_INST_FAST,
> -		.pm_ctrl_reg_val = OPAL_PM_PSSCR_RL(0) \
> -				 | OPAL_PM_PSSCR_MTL(3) \
> -				 | OPAL_PM_PSSCR_TR(3) \
> -				 | OPAL_PM_PSSCR_ESL \
> -				 | OPAL_PM_PSSCR_EC,
> -		.pm_ctrl_reg_mask = OPAL_PM_PSSCR_MASK },
> -	{
> -		.name = "stop1_lite", /* Enter stop1 with no state loss */
> -		.latency_ns = 4900,
> -		.residency_ns = 49000,
> -		.flags = 0*OPAL_PM_DEC_STOP \
> -		       | 0*OPAL_PM_TIMEBASE_STOP  \
> -		       | 0*OPAL_PM_LOSE_USER_CONTEXT \
> -		       | 0*OPAL_PM_LOSE_HYP_CONTEXT \
> -		       | 0*OPAL_PM_LOSE_FULL_CONTEXT \
> -		       | 1*OPAL_PM_STOP_INST_FAST,
> -		.pm_ctrl_reg_val = OPAL_PM_PSSCR_RL(1) \
> -				 | OPAL_PM_PSSCR_MTL(3) \
> -				 | OPAL_PM_PSSCR_TR(3),
> -		.pm_ctrl_reg_mask = OPAL_PM_PSSCR_MASK },
> -	{
>  		.name = "stop1",
>  		.latency_ns = 5000,
>  		.residency_ns = 50000,
