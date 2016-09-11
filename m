Return-Path: <mroos@linux.ee>
Received: from smtp1.it.da.ut.ee (mailhost6-1.ut.ee
 [IPv6:2001:bb8:2002:500::46])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sX2wq3cMSzDsGT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Sep 2016 17:43:04 +1000 (AEST)
Date: Sun, 11 Sep 2016 12:12:22 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: UBSAN: Undefined behaviour in arch/powerpc/kernel/cputable.c
In-Reply-To: <87r38snkv2.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.LRH.2.20.1609111211580.26664@math.ut.ee>
References: <alpine.LRH.2.20.1609091556420.29746@math.ut.ee>
 <87r38snkv2.fsf@concordia.ellerman.id.au>
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

> Does this fix it?

Yes, thank you!

> diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
> index 2ef55f8968a2..b312b152461b 100644
> --- a/arch/powerpc/include/asm/cpu_has_feature.h
> +++ b/arch/powerpc/include/asm/cpu_has_feature.h
> @@ -15,7 +15,7 @@ static inline bool early_cpu_has_feature(unsigned long feature)
>  #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
>  #include <linux/jump_label.h>
>  
> -#define NUM_CPU_FTR_KEYS	64
> +#define NUM_CPU_FTR_KEYS	BITS_PER_LONG
>  
>  extern struct static_key_true cpu_feature_keys[NUM_CPU_FTR_KEYS];
>  
> 

-- 
Meelis Roos (mroos@linux.ee)
