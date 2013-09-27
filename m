Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp17.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E76502C034A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 00:45:46 +1000 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 15:45:42 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3563A2190056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 15:45:40 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8REjRTd58982632
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 14:45:27 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8REjdSH018837
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 08:45:39 -0600
Date: Fri, 27 Sep 2013 16:45:35 +0200
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] powerpc/kvm/book3s_hv: propagate
 H_SET_MODE_RESOURCE_LE to the host
Message-ID: <20130927164535.6dbeface@bahia.local>
In-Reply-To: <20130927135930.10288.86526.stgit@nimbus>
References: <20130925223118.GA2844@iris.ozlabs.ibm.com>
 <20130927135930.10288.86526.stgit@nimbus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 27 Sep 2013 15:59:30 +0200
Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> Follow-up to Anton's H_SET_MODE patch, the host should be taken aware
> of guest endianess change.
> 
> The hcall H_SET_MODE/H_SET_MODE_RESOURCE_LE is processed in kvm and
> then propagated to the host.
> 

Even if it seems a bit odd to get H_SET_MODE handled both by kvm and
qemu, it is a simple way to get the job done. Unless we expect tons of
calls to H_SET_MODE_RESOURCE_LE to occur, I do not see a better way for
the host code to know the guest endianess.

FYI, with this patch, Rusty's (Cc'ed) virtio endianess patchset for
qemu works like a charm: my guest kernel calls h_set_mode once at boot
time, qemu gets notified and keeps the information. Do we need more ?

> v2: taking in account the Paul Mackerras's comment, using H_TOO_HARD
> to propagate only H_SET_MODE_RESOURCE_LE to the host.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---

Tested-by: Greg Kurz <gkurz@linux.vnet.ibm.com>

>  arch/powerpc/kvm/book3s_hv.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c
> b/arch/powerpc/kvm/book3s_hv.c index 998cad3..be0af39 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -523,14 +523,14 @@ static int kvmppc_h_set_mode(struct kvm_vcpu
> *vcpu, unsigned long mflags, kvm_for_each_vcpu(n, v, kvm)
>  				v->arch.intr_msr &= ~MSR_LE;
>  			kick_all_cpus_sync();
> -			return H_SUCCESS;
> +			return H_TOO_HARD; /* propagating to the
> host */
> 
>  		case 1:
>  			kvm->arch.lpcr |= LPCR_ILE;
>  			kvm_for_each_vcpu(n, v, kvm)
>  				v->arch.intr_msr |= MSR_LE;
>  			kick_all_cpus_sync();
> -			return H_SUCCESS;
> +			return H_TOO_HARD; /* propagating to the
> host */
> 
>  		default:
>  			return H_UNSUPPORTED_FLAG_START;
> @@ -599,6 +599,8 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  					kvmppc_get_gpr(vcpu, 5),
>  					kvmppc_get_gpr(vcpu, 6),
>  					kvmppc_get_gpr(vcpu, 7));
> +		if (ret == H_TOO_HARD)
> +			return RESUME_HOST;
>  		break;
> 
>  	case H_XIRR:
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 



-- 
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/Meiosys                  http://www.ibm.com
Tel +33 (0)562 165 496

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.
