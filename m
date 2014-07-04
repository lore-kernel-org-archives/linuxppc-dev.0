Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7E561A002E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 17:57:26 +1000 (EST)
Message-ID: <53B65E61.3070107@suse.de>
Date: Fri, 04 Jul 2014 09:57:21 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Joel Stanley <joel@jms.id.au>, paulus@samba.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au
Subject: Re: [PATCH 1/3] powerpc/kvm: Remove redundant save of SIER AND MMCR2
References: <1404367956-19515-1-git-send-email-joel@jms.id.au>
 <1404367956-19515-2-git-send-email-joel@jms.id.au>
In-Reply-To: <1404367956-19515-2-git-send-email-joel@jms.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, KVM <kvm@vger.kernel.org>,
 kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.14 08:12, Joel Stanley wrote:
> These two registers are already saved in the block above. Aside from
> being unnecessary, by the time we get down to the second save location
> r8 no longer contains MMCR2, so we are clobbering the saved value with
> PMC5.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alexander Graf <agraf@suse.de>

Please CC kvm-ppc@vger and kvm@vger when you send kvm related patches :).

Ben, I think this patch makes sense to go via your tree. Want to take it?


Alex

> ---
>   arch/powerpc/kvm/book3s_hv_interrupts.S | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
> index 8c86422..731be74 100644
> --- a/arch/powerpc/kvm/book3s_hv_interrupts.S
> +++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
> @@ -127,11 +127,6 @@ BEGIN_FTR_SECTION
>   	stw	r10, HSTATE_PMC + 24(r13)
>   	stw	r11, HSTATE_PMC + 28(r13)
>   END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
> -BEGIN_FTR_SECTION
> -	mfspr	r9, SPRN_SIER
> -	std	r8, HSTATE_MMCR + 40(r13)
> -	std	r9, HSTATE_MMCR + 48(r13)
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>   31:
>   
>   	/*
