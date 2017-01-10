Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyLyh2HCnzDqGq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 17:02:20 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 127so27238616pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jan 2017 22:02:20 -0800 (PST)
Date: Tue, 10 Jan 2017 16:02:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 12/12] powerpc: Rename soft_enabled to
 soft_disabled_mask
Message-ID: <20170110160206.27790628@roar.ozlabs.ibm.com>
In-Reply-To: <1483968978-16035-13-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483968978-16035-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1483968978-16035-13-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon,  9 Jan 2017 19:06:18 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Rename the paca->soft_enabled to paca->soft_disabled_mask as
> it is no more used as a flag for interrupt state.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> -static inline notrace void soft_enabled_set(unsigned long enable)
> +static inline notrace void soft_disabled_mask_set(unsigned long enable)

> -static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
> +static inline notrace unsigned long soft_disabled_mask_set_return(unsigned long enable)

> -static inline notrace unsigned long soft_enabled_or_return(unsigned long enable)
> +static inline notrace unsigned long soft_disabled_mask_or_return(unsigned long enable)

> @@ -228,11 +228,11 @@ notrace void arch_local_irq_restore(unsigned long en)
>  	unsigned int replay;
>  
>  #ifdef CONFIG_IRQ_DEBUG_SUPPORT
> -	WARN_ON(en & local_paca->soft_enabled & ~IRQ_DISABLE_MASK_LINUX);
> +	WARN_ON(en & local_paca->soft_disabled_mask & ~IRQ_DISABLE_MASK_LINUX);
>  #endif
>  
>  	/* Write the new soft-enabled value */
> -	soft_enabled_set(en);
> +	soft_disabled_mask_set(en);
>  

Aside from a few minor instances of variable names and comments, this
looks good to me. Much easier to read.

I have no remaining issues with this series.

Thanks,
Nick
