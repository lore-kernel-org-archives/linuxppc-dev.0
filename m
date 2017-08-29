Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh8S412qGzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 10:20:52 +1000 (AEST)
Date: Tue, 29 Aug 2017 10:14:37 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3 3/4] powerpc/64s: idle POWER9 can execute stop in
 virtual mode
Message-ID: <20170829001437.GF12629@fergus.ozlabs.ibm.com>
References: <20170825043036.18236-1-npiggin@gmail.com>
 <20170825043036.18236-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170825043036.18236-4-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 25, 2017 at 02:30:35PM +1000, Nicholas Piggin wrote:
> The hardware can execute stop in any context, and KVM does not
> require real mode because siblings do not share MMU state. This
> saves a switch to real-mode when going idle.
> 
> Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 14e97f442167..32d65ee323a0 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -195,7 +195,16 @@ pnv_powersave_common:
>  	std	r5,_CCR(r1)
>  	std	r1,PACAR1(r13)
>  
> +BEGIN_FTR_SECTION
> +	/*
> +	 * POWER9 does not require real mode to stop, and presently does not
> +	 * set hwthread_state for KVM (threads don't share MMU context), so
> +	 * we can remain in virtual mode for this.
> +	 */
> +	bctr
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	/*
> +	 * POWER8

... and POWER7 too.

Since that's just a comment,

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
