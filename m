Return-Path: <ego@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDTjk200vzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 18:54:18 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 24 May 2016 04:54:16 -0400
Date: Tue, 24 May 2016 14:24:06 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org, ego@linux.vnet.ibm.com
Subject: Re: [PATCH v3 4/9] powerpc/powernv: Make power7_powersave_common
 more generic
Message-ID: <20160524085406.GC12860@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1464016722-7488-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464016722-7488-5-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464016722-7488-5-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shreyas,

On Mon, May 23, 2016 at 08:48:37PM +0530, Shreyas B. Prabhu wrote:
> power7_powersave_common does common steps needed before entering idle
> state and eventually changes MSR to MSR_IDLE and does rfid to
> power7_enter_nap_mode.
> 
> Move the updation of HSTATE_HWTHREAD_STATE to power7_powersave_common
> from power7_enter_nap_mode and make it more generic by passing the rfid
> address as a function parameter.
> 
> Also make function name more generic.
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
> Changes in v3:
> ==============
>  - Moved HSTATE_HWTHREAD_STATE updation to power_powersave_common
> 
>  arch/powerpc/kernel/idle_power_common.S | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
> index 973c9a1..d100577 100644
> --- a/arch/powerpc/kernel/idle_power_common.S
> +++ b/arch/powerpc/kernel/idle_power_common.S
> @@ -74,8 +74,10 @@ core_idle_lock_held:
>   * To check IRQ_HAPPENED in r4
>   * 	0 - don't check
>   * 	1 - check
> + *
> + * Address to 'rfid' to in r5
>   */
> -_GLOBAL(power7_powersave_common)
> +_GLOBAL(pnv_powersave_common)

You can move this rename to the previous patch where it fits better.

[..snip..]
> 
>  	.globl	power7_enter_nap_mode
>  power7_enter_nap_mode:

Ditto. This should be "pnv_enter_idle_mode" in the previous patch.

[..snip..]
> 
>  _GLOBAL(power7_winkle)
>  	li	r3,3

	li 	r3,PNV_THREAD_WINKLE 

Which should be a separate patch.
