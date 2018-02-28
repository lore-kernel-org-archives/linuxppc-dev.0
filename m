Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrmfc5rW4zF1T4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 18:00:24 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id x7so2958348wmc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 23:00:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] KVM: surround kvm_arch_vcpu_async_ioctl() with #ifdef
To: wei.guo.simon@gmail.com, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mips@linux-mips.org
References: <1519785099-13808-1-git-send-email-wei.guo.simon@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19e68ff8-552e-2e64-c2e4-3c718343bf57@redhat.com>
Date: Wed, 28 Feb 2018 07:53:33 +0100
MIME-Version: 1.0
In-Reply-To: <1519785099-13808-1-git-send-email-wei.guo.simon@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/02/2018 03:31, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Although CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL is usually on, logically
> kvm_arch_vcpu_async_ioctl() definition should be wrapped with
> CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL #ifdef.

No, the symbol is defined by Kconfig.  It is a bug if it is not #defined.

Paolo

> This patch adds the #ifdef surround.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> ---
>  arch/mips/kvm/mips.c       | 2 ++
>  arch/powerpc/kvm/powerpc.c | 2 ++
>  arch/s390/kvm/kvm-s390.c   | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 2549fdd..4d593e5 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -903,6 +903,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  	return r;
>  }
>  
> +#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
>  long kvm_arch_vcpu_async_ioctl(struct file *filp, unsigned int ioctl,
>  			       unsigned long arg)
>  {
> @@ -922,6 +923,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp, unsigned int ioctl,
>  
>  	return -ENOIOCTLCMD;
>  }
> +#endif
>  
>  long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
>  			 unsigned long arg)
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 403e642..2adca3c 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -1757,6 +1757,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
>  	return -EINVAL;
>  }
>  
> +#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
>  long kvm_arch_vcpu_async_ioctl(struct file *filp,
>  			       unsigned int ioctl, unsigned long arg)
>  {
> @@ -1771,6 +1772,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
>  	}
>  	return -ENOIOCTLCMD;
>  }
> +#endif
>  
>  long kvm_arch_vcpu_ioctl(struct file *filp,
>                           unsigned int ioctl, unsigned long arg)
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 77d7818..c499396 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3784,6 +3784,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
>  	return r;
>  }
>  
> +#ifdef CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL
>  long kvm_arch_vcpu_async_ioctl(struct file *filp,
>  			       unsigned int ioctl, unsigned long arg)
>  {
> @@ -3811,6 +3812,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
>  	}
>  	return -ENOIOCTLCMD;
>  }
> +#endif
>  
>  long kvm_arch_vcpu_ioctl(struct file *filp,
>  			 unsigned int ioctl, unsigned long arg)
> 
