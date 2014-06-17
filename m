Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 465EA1A02A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 02:05:50 +1000 (EST)
Message-ID: <53A06759.9050601@suse.de>
Date: Tue, 17 Jun 2014 18:05:45 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, clg@fr.ibm.com
Subject: Re: [PATCH 3/4] KVM: PPC: Book3S HV: Fix ABIv2 indirect branch issue
References: <20140612181420.65b05675@kryten> <20140612181610.3479c3f2@kryten>
In-Reply-To: <20140612181610.3479c3f2@kryten>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12.06.14 10:16, Anton Blanchard wrote:
> To establish addressability quickly, ABIv2 requires the target
> address of the function being called to be in r12.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>

Thanks, applied to kvm-ppc-queue.


Alex

> ---
>
> Index: b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> ===================================================================
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1920,8 +1920,8 @@ hcall_try_real_mode:
>   	lwax	r3,r3,r4
>   	cmpwi	r3,0
>   	beq	guest_exit_cont
> -	add	r3,r3,r4
> -	mtctr	r3
> +	add	r12,r3,r4
> +	mtctr	r12
>   	mr	r3,r9		/* get vcpu pointer */
>   	ld	r4,VCPU_GPR(R4)(r9)
>   	bctrl
