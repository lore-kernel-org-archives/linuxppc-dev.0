Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHrwR4gkjzDvYM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 13:30:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [powerpc v4 1/3] Setup AMOR in HV mode
In-Reply-To: <1479101112-21120-2-git-send-email-bsingharora@gmail.com>
References: <1479101112-21120-1-git-send-email-bsingharora@gmail.com>
 <1479101112-21120-2-git-send-email-bsingharora@gmail.com>
Date: Tue, 15 Nov 2016 13:30:42 +1100
Message-ID: <871sydiiel.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index ed7bddc..7343573 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -320,6 +320,25 @@ static void update_hid_for_radix(void)
>  		cpu_relax();
>  }
>  
> +/*
> + * In HV mode, we init AMOR so that the hypervisor
> + * and guest can setup IMAR, enable key 0 and set
> + * it to 1
> + * AMOR = 1100....00 (Mask for key 0 is 11)
> + */
> +static void __init radix_init_amor(void)

This can't be __init because you call it from the secondary version,
which can run after init due to CPU hotplug.

> +{
> +	unsigned long amor_mask = 0xc000000000000000;
> +	unsigned long amor = mfspr(SPRN_AMOR);

You don't use the amor value.

> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
> +		return;

This needs a comment explaining why we're not doing it on DD1.

> +
> +	amor = amor_mask;
> +
> +	mtspr(SPRN_AMOR, amor);

Just move the constant directly.



cheers
