Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmB8G1Zk1zDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 20:49:50 +1000 (AEST)
In-Reply-To: <741e7a7860e055603a311bcc6051bd88fdad1215.1467785081.git.sam.bobroff@au1.ibm.com>
To: Sam bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, agraf@suse.de, kvm-ppc@vger.kernel.org,
 qemu-devel@nongnu.org, paulus@samba.org, david@gibson.dropbear.id.au
Subject: Re: [1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
Message-Id: <3rmB8G0Wkxz9s9Z@ozlabs.org>
Date: Fri,  8 Jul 2016 20:49:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-07 at 06:05:54 UTC, Sam bobroff wrote:
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 02416fe..06d79bc 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -588,6 +588,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		r = 1;
>  		break;
>  #endif
> +	case KVM_CAP_PPC_HTM:
> +		r = cpu_has_feature(CPU_FTR_TM)
> +		    && is_kvmppc_hv_enabled(kvm);

I think it should be using CPU_FTR_TM_COMP.

And AFAICS you don't need to break that line.

cheers
