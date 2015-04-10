Return-Path: <drjones@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66F1A1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 23:01:01 +1000 (AEST)
Date: Fri, 10 Apr 2015 14:59:58 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 02/10] KVM: define common __KVM_GUESTDBG_USE_SW/HW_BP
 values
Message-ID: <20150410125957.GE3227@hawk.usersys.redhat.com>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-3-git-send-email-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1427814488-28467-3-git-send-email-alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 kvmarm@lists.cs.columbia.edu, Nadav Amit <namit@cs.technion.ac.il>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, agraf@suse.de,
 Gleb Natapov <gleb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 zhichao.huang@linaro.org, jan.kiszka@siemens.com,
 Mihai Caraman <mihai.caraman@freescale.com>, bp@suse.de, marc.zyngier@arm.com,
 r65777@freescale.com, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "open list:ABI/API" <linux-api@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, dahi@linux.vnet.ibm.com,
 pbonzini@redhat.com,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 christoffer.dall@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2015 at 04:08:00PM +0100, Alex Bennée wrote:
> Currently x86, powerpc and soon arm64 use the same two architecture
> specific bits for guest debug support for software and hardware
> breakpoints. This makes the shared values explicit while leaving the
> gate open for another architecture to use some other value if they
> really really want to.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index ab4d473..1731569 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -310,8 +310,8 @@ struct kvm_guest_debug_arch {
>   * and upper 16 bits are architecture specific. Architecture specific defines
>   * that ioctl is for setting hardware breakpoint or software breakpoint.
>   */
> -#define KVM_GUESTDBG_USE_SW_BP		0x00010000
> -#define KVM_GUESTDBG_USE_HW_BP		0x00020000
> +#define KVM_GUESTDBG_USE_SW_BP		__KVM_GUESTDBG_USE_SW_BP
> +#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
>  
>  /* definition of registers in kvm_run */
>  struct kvm_sync_regs {
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index d7dcef5..1438202 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -250,8 +250,8 @@ struct kvm_debug_exit_arch {
>  	__u64 dr7;
>  };
>  
> -#define KVM_GUESTDBG_USE_SW_BP		0x00010000
> -#define KVM_GUESTDBG_USE_HW_BP		0x00020000
> +#define KVM_GUESTDBG_USE_SW_BP		__KVM_GUESTDBG_USE_SW_BP
> +#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
>  #define KVM_GUESTDBG_INJECT_DB		0x00040000
>  #define KVM_GUESTDBG_INJECT_BP		0x00080000
>  
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 5eedf84..ce2db14 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -525,8 +525,16 @@ struct kvm_s390_irq {
>  
>  /* for KVM_SET_GUEST_DEBUG */
>  
> -#define KVM_GUESTDBG_ENABLE		0x00000001
> -#define KVM_GUESTDBG_SINGLESTEP		0x00000002
> +#define KVM_GUESTDBG_ENABLE		(1 << 0)
> +#define KVM_GUESTDBG_SINGLESTEP	(1 << 1)
> +
> +/*
> + * Architecture specific stuff uses the top 16 bits of the field,
> + * however there is some shared commonality for the common cases
> + */
> +#define __KVM_GUESTDBG_USE_SW_BP	(1 << 16)
> +#define __KVM_GUESTDBG_USE_HW_BP	(1 << 17)
> +
>  
>  struct kvm_guest_debug {
>  	__u32 control;
> -- 
> 2.3.4
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
