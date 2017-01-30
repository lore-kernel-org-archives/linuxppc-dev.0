Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC2JP6Bv2zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 08:16:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 03/20] powerpc/64: Enable use of radix MMU under
 hypervisor on POWER9
In-Reply-To: <1485771713-24801-4-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
 <1485771713-24801-4-git-send-email-paulus@ozlabs.org>
Date: Tue, 31 Jan 2017 08:16:36 +1100
Message-ID: <87wpdcuu2z.fsf@concordia.ellerman.id.au>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index cfa53cc..94323c4 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -401,6 +401,8 @@ void __init radix__early_init_mmu(void)
>  		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
>  		radix_init_partition_table();
>  		radix_init_amor();
> +	} else {
> +		radix_init_pseries();
>  	}

That breaks the cell build:

  (.init.text+0x1878): undefined reference to `.radix_init_pseries'

I added a stub in book3s/64/mmu.h.

cheers
