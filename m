Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B7F61A0744
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 20:37:36 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 1 Apr 2015 03:37:34 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DE83F19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 03:28:37 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t319bViJ52166680
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 02:37:31 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t319bUmo003415
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 03:37:30 -0600
Message-ID: <551BBC49.707@linux.vnet.ibm.com>
Date: Wed, 01 Apr 2015 15:07:13 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jan Stancek <jstancek@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc: fix memory corruption by
 pnv_alloc_idle_core_states
References: <67174f780b3615749546d5a6d5bfba4c4f26a855.1427818011.git.jstancek@redhat.com>
In-Reply-To: <67174f780b3615749546d5a6d5bfba4c4f26a855.1427818011.git.jstancek@redhat.com>
Content-Type: text/plain; charset=ISO-8859-6
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org, sbest@redhat.com,
 paulus@samba.org, shreyas@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/31/2015 09:41 PM, Jan Stancek wrote:
> Space allocated for paca is based off nr_cpu_ids,
> but pnv_alloc_idle_core_states() iterates paca with
> cpu_nr_cores()*threads_per_core, which is using NR_CPUS.
> 
> This causes pnv_alloc_idle_core_states() to write over memory,
> which is outside of paca array and may later lead to various panics.
> 
> Fixes: 7cba160ad789 (powernv/cpuidle: Redesign idle states management)
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  arch/powerpc/include/asm/cputhreads.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
> index 2bf8e93..4c8ad59 100644
> --- a/arch/powerpc/include/asm/cputhreads.h
> +++ b/arch/powerpc/include/asm/cputhreads.h
> @@ -55,7 +55,7 @@ static inline cpumask_t cpu_thread_mask_to_cores(const struct cpumask *threads)
> 
>  static inline int cpu_nr_cores(void)
>  {
> -	return NR_CPUS >> threads_shift;
> +	return nr_cpu_ids >> threads_shift;
>  }

Thanks for the patch!

Reviewed-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
> 
>  static inline cpumask_t cpu_online_cores_map(void)
> 
