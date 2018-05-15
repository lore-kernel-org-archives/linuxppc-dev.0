Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lS3n3nBjzF2sf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 16:15:33 +1000 (AEST)
Date: Tue, 15 May 2018 16:15:26 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 29/30] KVM: PPC: add KVM_SET_ONE_REG/KVM_GET_ONE_REG
 to async ioctl
Message-ID: <20180515061526.GE28451@fergus.ozlabs.ibm.com>
References: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
 <1519753958-11756-19-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519753958-11756-19-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 28, 2018 at 01:52:37AM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> In both HV/PR KVM, the KVM_SET_ONE_REG/KVM_GET_ONE_REG ioctl should
> be able to perform without load vcpu. This patch adds
> KVM_SET_ONE_REG/KVM_GET_ONE_REG implementation to async ioctl
> function.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> ---
>  arch/powerpc/kvm/powerpc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 7987fa3..6afd004 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -1619,6 +1619,19 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
>  			return -EFAULT;
>  		return kvm_vcpu_ioctl_interrupt(vcpu, &irq);
>  	}
> +
> +	if ((ioctl == KVM_SET_ONE_REG) || (ioctl == KVM_GET_ONE_REG)) {
> +		struct kvm_one_reg reg;
> +
> +		if (copy_from_user(&reg, argp, sizeof(reg)))
> +			return -EFAULT;
> +
> +		if (ioctl == KVM_SET_ONE_REG)
> +			return kvm_vcpu_ioctl_set_one_reg(vcpu, &reg);
> +		else
> +			return kvm_vcpu_ioctl_get_one_reg(vcpu, &reg);
> +	}
> +
>  	return -ENOIOCTLCMD;
>  }

This seems dangerous to me, since now we can have set/get one_reg
running in parallel with vcpu execution.  Is there a really compelling
reason to do this?  If not I'd rather not make this change.

Paul.
