Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40F40h1PsbzF24Y
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2018 17:41:23 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id o16so3617294pfk.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Apr 2018 00:41:23 -0700 (PDT)
Date: Mon, 2 Apr 2018 17:41:03 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2] powerpc: Fix oops due to wrong access of lppaca on
 non virtualized platform
Message-ID: <20180402174103.4d122fb3@roar.ozlabs.ibm.com>
In-Reply-To: <20180402073337.22568-1-aneesh.kumar@linux.ibm.com>
References: <20180402073337.22568-1-aneesh.kumar@linux.ibm.com>
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

On Mon,  2 Apr 2018 13:03:37 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> Commit 8e0b634b1327 ("powerpc/64s: Do not allocate lppaca if we are not
> virtualized") removed allocation of lppaca on non virtualized platform. But with
> CONFIG_PPC_SPLPAR enabled, we do access lppaca non-virtualized platform in some
> code paths.
> 
> Fix this but adding runtime check for virtualized platform.
> 
> Fixes: 8e0b634b1327 ("powerpc/64s: Do not allocate lppaca if we are not virtualized")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Thanks, this looks good to me...

> ---
> Changes from V1:
> * update commit summary
> 
>  arch/powerpc/include/asm/lppaca.h   | 3 +++
>  arch/powerpc/include/asm/spinlock.h | 2 ++
>  arch/powerpc/kernel/time.c          | 3 +++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
> index 65d589689f01..7c23ce8a5a4c 100644
> --- a/arch/powerpc/include/asm/lppaca.h
> +++ b/arch/powerpc/include/asm/lppaca.h
> @@ -34,6 +34,7 @@
>  #include <linux/threads.h>
>  #include <asm/types.h>
>  #include <asm/mmu.h>
> +#include <asm/firmware.h>
>  
>  /*
>   * The lppaca is the "virtual processor area" registered with the hypervisor,
> @@ -114,6 +115,8 @@ struct lppaca {
>  
>  static inline bool lppaca_shared_proc(struct lppaca *l)
>  {
> +	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
> +		return false;
>  	return !!(l->__old_status & LPPACA_OLD_SHARED_PROC);
>  }
>  

We should eventually clean this up. There's no need to pass in an lppaca
here AFAIKS. Is it even per-CPU, does it change dynamically? We could set
it up in a FW_FEATURE parameter at boot, which would could make some of
these tests cheaper.

> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index b9ebc3085fb7..72dc4ddc2972 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -56,6 +56,8 @@
>  #define vcpu_is_preempted vcpu_is_preempted
>  static inline bool vcpu_is_preempted(int cpu)
>  {
> +	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
> +		return false;
>  	return !!(be32_to_cpu(lppaca_of(cpu).yield_count) & 1);
>  }
>  #endif
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index f7d96a68ecaa..360e71d455cc 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -266,6 +266,9 @@ void accumulate_stolen_time(void)
>  
>  static inline u64 calculate_stolen_time(u64 stop_tb)
>  {
> +	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
> +		return 0;
> +
>  	if (get_paca()->dtl_ridx != be64_to_cpu(get_lppaca()->dtl_idx))
>  		return scan_dispatch_log(stop_tb);
>  
