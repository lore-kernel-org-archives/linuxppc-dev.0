Return-Path: <ego@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8kyh5PRfzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 16:37:32 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 18 May 2016 00:37:30 -0600
Date: Wed, 18 May 2016 12:07:09 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [PATCH v2 4/9] powerpc/powernv: Make power7_powersave_common
 more generic
Message-ID: <20160518063708.GD3939@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1462263878-25237-5-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462263878-25237-5-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shreyas,

On Tue, May 03, 2016 at 01:54:33PM +0530, Shreyas B. Prabhu wrote:
> power7_powersave_common does common steps needed before entering idle
> state and eventually changes MSR to MSR_IDLE and does rfid to
> power7_enter_nap_mode.
> 
> Make it more generic by passing the rfid address as a function parameter.
> Also make function name more generic.

[..snip..]

> 
>  _GLOBAL(power7_winkle)
> -	li	r3,3
> +	li	r3,PNV_THREAD_WINKLE

This particular change above can go as an independent patch.

> 
>  _GLOBAL(power7_wakeup_tb_loss)
> diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
> index 05954ae..ff7a541 100644
> --- a/arch/powerpc/kernel/idle_power_common.S
> +++ b/arch/powerpc/kernel/idle_power_common.S
> @@ -21,8 +21,10 @@
>   * To check IRQ_HAPPENED in r4
>   * 	0 - don't check
>   * 	1 - check
> + *
> + * Address to 'rfid' to in r5
>   */
> -_GLOBAL(power7_powersave_common)
> +_GLOBAL(power_powersave_common)
>  	/* Use r3 to pass state nap/sleep/winkle */
>  	/* NAP is a state loss, we create a regs frame on the
>  	 * stack, fill it up with the state we care about and
> @@ -79,13 +81,12 @@ _GLOBAL(power7_powersave_common)
>  	 * because as soon as we do that, another thread can switch
>  	 * the MMU context to the guest.
>  	 */
> -	LOAD_REG_IMMEDIATE(r5, MSR_IDLE)
> +	LOAD_REG_IMMEDIATE(r7, MSR_IDLE)
>  	li	r6, MSR_RI
>  	andc	r6, r9, r6
> -	LOAD_REG_ADDR(r7, power7_enter_nap_mode)
>  	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
> -	mtspr	SPRN_SRR0, r7
> -	mtspr	SPRN_SRR1, r5
> +	mtspr	SPRN_SRR0, r5
> +	mtspr	SPRN_SRR1, r7
>  	rfid
>  	/* No return */

Any particular reason why you swapped the roles of r5 and r7 ?

--
Thanks and Regards
gautham.
