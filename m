Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb9Zf355PzDsfJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 19:53:14 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id oz2so3281936pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 02:53:14 -0700 (PDT)
Date: Fri, 16 Sep 2016 19:53:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/13] powerpc: Use soft_enabled_set api to update
 paca->soft_enabled
Message-ID: <20160916195302.6b2f3320@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-5-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-5-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:31:54 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Force use of soft_enabled_set() wrapper to update paca-soft_enabled
> wherever possisble. Also add a new wrapper function, soft_enabled_set_return(),
> added to force the paca->soft_enabled updates.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h  | 14 ++++++++++++++
>  arch/powerpc/include/asm/kvm_ppc.h |  2 +-
>  arch/powerpc/kernel/irq.c          |  2 +-
>  arch/powerpc/kernel/setup_64.c     |  4 ++--
>  arch/powerpc/kernel/time.c         |  6 +++---
>  5 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index 8fad8c24760b..f828b8f8df02 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -53,6 +53,20 @@ static inline notrace void soft_enabled_set(unsigned long enable)
>  	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
>  }
>  
> +static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
> +{
> +	unsigned long flags;
> +
> +	asm volatile(
> +		"lbz %0,%1(13); stb %2,%1(13)"
> +		: "=r" (flags)
> +		: "i" (offsetof(struct paca_struct, soft_enabled)),\
> +		  "r" (enable)
> +		: "memory");
> +
> +	return flags;
> +}

Why do you have the "memory" clobber here while soft_enabled_set() does not?

Thanks,
Nick
