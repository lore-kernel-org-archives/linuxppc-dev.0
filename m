Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A38CF2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 15:38:45 +1000 (EST)
Message-ID: <1346823512.2257.52.camel@pasglop>
Subject: Re: [PATCH 6/6] powerpc/booke64: restore VDSO information on
 critical exception
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Wed, 05 Sep 2012 15:38:32 +1000
In-Reply-To: <1344259628-31161-7-git-send-email-mihai.caraman@freescale.com>
References: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
 <1344259628-31161-7-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-08-06 at 16:27 +0300, Mihai Caraman wrote:
> Critical exception handler on 64-bit booke uses user-visible SPRG3 as scratch.
> Restore VDSO information in SPRG3 on exception prolog.

Breaks the build on !BOOKE because of :

> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index b67db22..a0b0d08 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -725,6 +725,8 @@ int __cpuinit vdso_getcpu_init(void)
>  	mtspr(SPRN_SPRG3, val);
>  #ifdef CONFIG_KVM_BOOK3S_HANDLER
>  	get_paca()->kvm_hstate.sprg3 = val;
> +#elif CONFIG_PPC_BOOK3E
    ^^^^

You can't "#elif" a CONFIG option.

> +	get_paca()->sprg3 = val;
>  #endif
>  
>  	put_cpu();

Now, my suggestion is to actually move the bloody thing out of
kvm_hstate on server as well, just make it a common "sprg3" field
accross the board.

I'm dropping this one patch (the other ones seem fine so far and will
land in next soon unless I find another problem).

Cheers,
Ben.
