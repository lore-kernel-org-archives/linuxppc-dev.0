Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5AB481A005A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 12:14:28 +1100 (AEDT)
Message-ID: <1421284467.11409.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: powernv: winkle: Restore LPCR with LPCR_PECE1
 cleared
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Date: Thu, 15 Jan 2015 12:14:27 +1100
In-Reply-To: <1421234001-24886-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1421234001-24886-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-14 at 16:43 +0530, Shreyas B. Prabhu wrote:
> LPCR_PECE1 bit controls whether decrementer interrupts are allowed to
> cause exit from power-saving mode. While waking up from winkle, restoring
> LPCR with LPCR_PECE1 set (i.e Decrementer interrupts allowed) can cause
> issue in the following scenario:
> 
> - All the threads in a core are offlined. The core enters deep winkle.
> - Spurious interrupt wakes up a thread in the core. Here LPCR is restored
>   with LPCR_PECE1 bit set.
> - Since it was a spurious interrupt on a offline thread, the thread clears
>   the interrupt and goes back to winkle.
> - Here before the thread executes winkle and puts the core into deep winkle,
>   if a decrementer interrupt occurs on any of the sibling threads in the core
>   that thread wakes up. 
> - Since in offline loop we are flushing interrupt only in case of external
>   interrupt, the decrementer interrupt does not get flushed. So at this stage
>   the thread is stuck in this is loop of waking up at 0x100 due to decrementer
>   interrupt, not flushing the interrupt as only external interrupts get flushed,
>   entering winkle, waking up at 0x100 again.
> 
> Fix this by programming PORE to restore LPCR with LPCR_PECE1 bit 
> cleared when waking up from winkle.

That sounds good.

But this makes the third place where we clear LPCR_PECE1, in addition to:

    static int fastsleep_loop(struct cpuidle_device *dev,
    				struct cpuidle_driver *drv,
    				int index)
    {
    	...
    
    	new_lpcr = old_lpcr;
    	/* Do not exit powersave upon decrementer as we've setup the timer
    	 * offload.
    	 */
    	new_lpcr &= ~LPCR_PECE1;
    
    	mtspr(SPRN_LPCR, new_lpcr);

And:

    static void pnv_smp_cpu_kill_self(void)
    {
    	...
    
    	/* We don't want to take decrementer interrupts while we are offline,
    	 * so clear LPCR:PECE1. We keep PECE2 enabled.
    	 */
    	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);


So perhaps we can capture that logic in one place somehow?

cheers
