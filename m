Return-Path: <avi@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 6633CDDD04
	for <linuxppc-dev@ozlabs.org>; Sun, 31 May 2009 22:01:06 +1000 (EST)
Message-ID: <4A227158.6050605@redhat.com>
Date: Sun, 31 May 2009 15:00:24 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] KVM: powerpc: beyond ARRAY_SIZE of vcpu->arch.guest_tlb
References: <4A15B129.8070700@gmail.com>
In-Reply-To: <4A15B129.8070700@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulmck@linux.vnet.ibm.com, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roel Kluin wrote:
> Do not go beyond ARRAY_SIZE of vcpu->arch.guest_tlb
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> index 0fce4fb..c2cfd46 100644
> --- a/arch/powerpc/kvm/emulate.c
> +++ b/arch/powerpc/kvm/emulate.c
> @@ -125,7 +125,7 @@ static int kvmppc_emul_tlbwe(struct kvm_vcpu *vcpu, u32 inst)
>  	ws = get_ws(inst);
>  
>  	index = vcpu->arch.gpr[ra];
> -	if (index > PPC44x_TLB_SIZE) {
> +	if (index >= PPC44x_TLB_SIZE) {
>  		printk("%s: index %d\n", __func__, index);
>  		kvmppc_dump_vcpu(vcpu);
>  		return EMULATE_FAIL;
>   

This code no longer exists in kvm.git.

-- 
error compiling committee.c: too many arguments to function
