Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSWgD2tJVzDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 21:04:55 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id f27so1354627pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 04:04:55 -0700 (PDT)
Message-ID: <1495019087.30802.12.camel@gmail.com>
Subject: Re: [PATCH 1/3] powerpc: Add __hard_irqs_disabled()
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, Frederic
 Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 May 2017 21:04:47 +1000
In-Reply-To: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-16 at 14:56 +0530, Aneesh Kumar K.V wrote:
> Add __hard_irqs_disabled() similar to arch_irqs_disabled to check whether irqs
> are hard disabled.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index eba60416536e..541bd42f902f 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -88,6 +88,12 @@ static inline bool arch_irqs_disabled(void)
>  	return arch_irqs_disabled_flags(arch_local_save_flags());
>  }
>  
> +static inline bool __hard_irqs_disabled(void)
> +{
> +	unsigned long flags = mfmsr();
> +	return (flags & MSR_EE) == 0;

I have some patches that ensure MSR_EE is never 0, what are we protecting
against - external interrupts, IPI's or something else? I suspect its IPI's

Balbir SIngh.
