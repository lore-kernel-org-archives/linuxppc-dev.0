Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Vbvl6xpVzF35v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 09:24:19 +1000 (AEST)
Message-ID: <80bbdf47081e3e302ab5f28b5ddc9e2faabba842.camel@neuling.org>
Subject: Re: [RESEND][PATCH] powerpc/powernv : Save/Restore SPRG3 on
 entry/exit from stop.
From: Michael Neuling <mikey@neuling.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Florian
 Weimer <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>
Date: Wed, 18 Jul 2018 09:24:19 +1000
In-Reply-To: <1531843216-22209-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
 <1531843216-22209-1-git-send-email-ego@linux.vnet.ibm.com>
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


>  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> diff --git a/arch/powerpc/kernel/idle_book3s.S
> b/arch/powerpc/kernel/idle_book3s.S
> index d85d551..5069d42 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -120,6 +120,9 @@ power9_save_additional_sprs:
>  	mfspr	r4, SPRN_MMCR2
>  	std	r3, STOP_MMCR1(r13)
>  	std	r4, STOP_MMCR2(r13)
> +
> +	mfspr	r3, SPRN_SPRG3
> +	std	r3, STOP_SPRG3(r13)

We don't need to save it.  Just restore it from paca->sprg_vdso which shoul=
d
never change.

How can we do better at catching these missing SPRGs?=20

We missed this one and looking at c1b25a17d249 we missed the AMOR a couple =
of
months back. I'd rather we had some systematic way of finding the ones we a=
re
missing, rather than playing wake-a-mole.

Mikey=20

>  	blr
> =20
>  power9_restore_additional_sprs:
> @@ -144,7 +147,9 @@ power9_restore_additional_sprs:
>  	mtspr	SPRN_MMCR1, r4
> =20
>  	ld	r3, STOP_MMCR2(r13)
> +	ld	r4, STOP_SPRG3(r13)
>  	mtspr	SPRN_MMCR2, r3
> +	mtspr	SPRN_SPRG3, r4
>  	blr
> =20
>  /*
