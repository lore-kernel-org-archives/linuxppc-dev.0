Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjFx92774zDsF8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 00:30:53 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 77so24490676pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 06:30:53 -0700 (PDT)
Date: Tue, 14 Mar 2017 23:30:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Balbir
 Singh <bsingharora@gmail.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powernv:smp: Add busy-wait loop as fall back for
 CPU-Hotplug
Message-ID: <20170314233029.478a7294@roar.ozlabs.ibm.com>
In-Reply-To: <8c52750bfcd2a7c65673fc82763df7a7f335c79c.1489383815.git.ego@linux.vnet.ibm.com>
References: <cover.1489383815.git.ego@linux.vnet.ibm.com>
 <8c52750bfcd2a7c65673fc82763df7a7f335c79c.1489383815.git.ego@linux.vnet.ibm.com>
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

On Mon, 13 Mar 2017 11:31:26 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> [Changelog written with inputs from svaidy@linux.vnet.ibm.com]
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/platforms/powernv/smp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index e39e6c4..8d5b99e 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -192,8 +192,16 @@ static void pnv_smp_cpu_kill_self(void)
>  		} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
>  			   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
>  			srr1 = power7_sleep();
> -		} else {
> +		} else if (idle_states & OPAL_PM_NAP_ENABLED) {
>  			srr1 = power7_nap(1);
> +		} else {
> +			/* This is the fallback method. We emulate snooze */
> +			while (!generic_check_cpu_restart(cpu)) {
> +				HMT_low();
> +				HMT_very_low();
> +			}
> +			srr1 = 0;
> +			HMT_medium();
>  		}
>  
>  		ppc64_runlatch_on();
