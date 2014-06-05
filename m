Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 052BC1A00D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 22:21:14 +1000 (EST)
Message-ID: <539060B5.9040808@suse.de>
Date: Thu, 05 Jun 2014 14:21:09 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH 2/4] KVM: PPC: BOOK3S: PR: Doorbell support
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1401970085-14493-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1401970085-14493-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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


On 05.06.14 14:08, Aneesh Kumar K.V wrote:
> We don't have SMT support yet, hence we should not find a doorbell
> message generated
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kvm/book3s_emulate.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
> index 1bb16a59dcbc..d6c87d085182 100644
> --- a/arch/powerpc/kvm/book3s_emulate.c
> +++ b/arch/powerpc/kvm/book3s_emulate.c
> @@ -28,7 +28,9 @@
>   #define OP_19_XOP_RFI		50
>   
>   #define OP_31_XOP_MFMSR		83
> +#define OP_31_XOP_MSGSNDP	142
>   #define OP_31_XOP_MTMSR		146
> +#define OP_31_XOP_MSGCLRP	174
>   #define OP_31_XOP_MTMSRD	178
>   #define OP_31_XOP_MTSR		210
>   #define OP_31_XOP_MTSRIN	242
> @@ -303,6 +305,22 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   
>   			break;
>   		}
> +		case OP_31_XOP_MSGSNDP:
> +		{
> +			/*
> +			 * PR KVM still don't support SMT mode. So we should

still?

> +			 * not see a MSGSNDP/MSGCLRP used with PR KVM
> +			 */
> +			pr_info("KVM: MSGSNDP used in non SMT case\n");
> +			emulated = EMULATE_FAIL;

What would happen on an HV guest with only 1 thread that MSGSNDs to 
thread 0? Would the guest get an illegal instruction trap, a 
self-interrupt or would this be a simple nop?


Alex

> +			break;
> +		}
> +		case OP_31_XOP_MSGCLRP:
> +		{
> +			pr_info("KVM: MSGCLRP used in non SMT case\n");
> +			emulated = EMULATE_FAIL;
> +			break;
> +		}
>   		default:
>   			emulated = EMULATE_FAIL;
>   		}
