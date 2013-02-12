Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Scott Wood <scottwood@freescale.com>
Subject: BOOKE KVM calling load_up_fpu from C?
Date: Tue, 12 Feb 2013 14:29:20 +1100
Message-ID: <14306.1360639760@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

I was looking at changing how load_up_fpu works and I found this in
arch/powerpc/kvm/booke.h:

static inline void kvmppc_load_guest_fp(struct kvm_vcpu *vcpu)
{
#ifdef CONFIG_PPC_FPU
	if (vcpu->fpu_active && !(current->thread.regs->msr & MSR_FP)) {
		load_up_fpu();
		current->thread.regs->msr |= MSR_FP;
	}
#endif
}

I'm wondering how this is suppose to work since load_up_fpu is suppose
to have MSR in R12?

Mikey
