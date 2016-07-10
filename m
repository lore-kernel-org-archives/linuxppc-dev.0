Return-Path: <dave.hansen@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rnlK41P6bzDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 09:47:51 +1000 (AEST)
Subject: Re: [PATCH] include: mman: Use bool instead of int for the return
 value of arch_validate_prot
To: chengang@emindsoft.com.cn, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org
References: <1468081751-9468-1-git-send-email-chengang@emindsoft.com.cn>
Cc: mpe@ellerman.id.au, tglx@linutronix.de, mingo@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chen Gang <gang.chen.5i5j@gmail.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <5782DEA5.600@linux.intel.com>
Date: Sun, 10 Jul 2016 16:47:49 -0700
MIME-Version: 1.0
In-Reply-To: <1468081751-9468-1-git-send-email-chengang@emindsoft.com.cn>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2016 09:29 AM, chengang@emindsoft.com.cn wrote:
> -static inline int arch_validate_prot(unsigned long prot)
> +static inline bool arch_validate_prot(unsigned long prot)
>  {
>  	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
> -		return 0;
> -	if ((prot & PROT_SAO) && !cpu_has_feature(CPU_FTR_SAO))
> -		return 0;
> -	return 1;
> +		return false;
> +	return (prot & PROT_SAO) == 0 || cpu_has_feature(CPU_FTR_SAO);
>  }
>  #define arch_validate_prot(prot) arch_validate_prot(prot)

Please don't do things like this.  They're not obviously correct and
also have no obvious benefit.  You also don't mention why you bothered
to alter the logical structure of these checks.
