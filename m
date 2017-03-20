Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn1rQ0CsjzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 03:39:49 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id r137so14240818pfr.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 09:39:49 -0700 (PDT)
Date: Tue, 21 Mar 2017 02:39:34 +1000
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
Subject: Re: [v2 PATCH 3/4] powernv:idle: Don't override default/deepest
 directly in kernel
Message-ID: <20170321023934.1a9b84f6@roar.ozlabs.ibm.com>
In-Reply-To: <84bfbacbd0ab98dd82241292a29e4d5d1bb456c6.1490024477.git.ego@linux.vnet.ibm.com>
References: <cover.1490024477.git.ego@linux.vnet.ibm.com>
 <84bfbacbd0ab98dd82241292a29e4d5d1bb456c6.1490024477.git.ego@linux.vnet.ibm.com>
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

On Mon, 20 Mar 2017 21:24:17 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently during idle-init on power9, if we don't find suitable stop
> states in the device tree that can be used as the
> default_stop/deepest_stop, we set stop0 (ESL=1,EC=1) as the default
> stop state psscr to be used by power9_idle and deepest stop state
> which is used by CPU-Hotplug.
> 
> However, if the platform firmware has not configured or enabled a stop
> state, the kernel should not make any assumptions and fallback to a
> default choice.
> 
> If the kernel uses a stop state that is not configured by the platform
> firmware, it may lead to further failures which should be avoided.
> 
> In this patch, we modify the init code to ensure that the kernel uses
> only the stop states exposed by the firmware through the device
> tree. When a suitable default stop state isn't found, we disable
> ppc_md.power_save for power9. Similarly, when a suitable
> deepest_stop_state is not found in the device tree exported by the
> firmware, fall back to the default busy-wait loop in the CPU-Hotplug
> code.
> 
> [Changelog written with inputs from svaidy@linux.vnet.ibm.com]
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index f335e0f..63ade78 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -147,7 +147,6 @@ u32 pnv_get_supported_cpuidle_states(void)
>  }
>  EXPORT_SYMBOL_GPL(pnv_get_supported_cpuidle_states);
>  
> -
>  static void pnv_fastsleep_workaround_apply(void *info)
>  
>  {
> @@ -241,8 +240,9 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
>   * The default stop state that will be used by ppc_md.power_save
>   * function on platforms that support stop instruction.
>   */
> -u64 pnv_default_stop_val;
> -u64 pnv_default_stop_mask;
> +static u64 pnv_default_stop_val;
> +static u64 pnv_default_stop_mask;
> +static bool default_stop_found;
>  
>  /*
>   * Used for ppc_md.power_save which needs a function with no parameters
> @@ -262,8 +262,9 @@ static void power9_idle(void)
>   * psscr value and mask of the deepest stop idle state.
>   * Used when a cpu is offlined.
>   */
> -u64 pnv_deepest_stop_psscr_val;
> -u64 pnv_deepest_stop_psscr_mask;
> +static u64 pnv_deepest_stop_psscr_val;
> +static u64 pnv_deepest_stop_psscr_mask;
> +static bool deepest_stop_found;

Aha you have made them static. Nitpick withdrawn :)

The log messages look good now.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
