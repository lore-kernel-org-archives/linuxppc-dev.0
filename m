Return-Path: <paulus@ozlabs.org>
Date: Fri, 8 Nov 2013 22:12:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: Liu Ping Fan <kernelfans@gmail.com>
Subject: Re: [PATCH] powerpc: kvm: optimize "sc 0" as fast return
Message-ID: <20131108111217.GD16470@iris.ozlabs.ibm.com>
References: <1383878656-4196-1-git-send-email-pingfank@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383878656-4196-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 08, 2013 at 10:44:16AM +0800, Liu Ping Fan wrote:
> syscall is a very common behavior inside guest, and this patch
> optimizes the path for the emulation of BOOK3S_INTERRUPT_SYSCALL,
> so hypervisor can return to guest without heavy exit, i.e, no need
> to swap TLB, HTAB,.. etc

Many interrupts that are caused by guest code go directly to the guest
and don't come to the hypervisor at all.  That includes system call
(sc 0), alignment interrupts, program interrupts, SLB miss interrupts,
etc.  See section 6.5 of Book 3S of the Power ISA specification; all
the interrupts with '-' in the 'HV' column of the table there get
delivered directly to the guest when they occur inside a guest.

> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1388,7 +1388,8 @@ kvmppc_hisi:
>  hcall_try_real_mode:
>  	ld	r3,VCPU_GPR(R3)(r9)
>  	andi.	r0,r11,MSR_PR
> -	bne	guest_exit_cont
> +	/* sc 1 from userspace - reflect to guest syscall */
> +	bne	sc_0_fast_return

Discrepancy between comment and code here.  In fact we would only take
the branch for a sc 1 instruction in userspace, which occurs when a PR
KVM guest nested inside a HV KVM guest does a hypercall (i.e., not for
normal system calls).  It is probably worthwhile to speed those up.

> +sc_0_fast_return:
> +	ld	r10,VCPU_PC(r9)
> +	ld	r11,VCPU_MSR(r9)

r11 must already contain this since you just did andi. r0,r11,MSR_PR.
In fact r10 already contains VCPU_PC(r9) at this point also, though
that is not so obvious.

> +	mtspr	SPRN_SRR0,r10
> +	mtspr	SPRN_SRR1,r11
> +	li	r10, BOOK3S_INTERRUPT_SYSCALL
> +	LOAD_REG_IMMEDIATE(r3,0xffffffff87a0ffff)	/* zero 33:36,42:47 */
> +	and	r11,r11,r3

This is not correct, since you don't even clear PR.  In fact what you
need is to load up MSR_SF | MSR_ME, though that value changes with
little-endian support and changes again with transactional memory
support for POWER8.  There is an idiom for loading that MSR value,
which is:

	li	r11, (MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
	rotldi	r11, r11, 63

which you could use for now, but it will need to be changed when
Anton's LE patch gets accepted.

Paul.
