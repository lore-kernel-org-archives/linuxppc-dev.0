Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 5A7262C0090
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Sep 2013 04:55:07 +1000 (EST)
Subject: Re: [PATCH 5/6] KVM: PPC: Book3S: Load/save FP/VMX/VSX state directly
 to/from vcpu struct
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20130910102221.GF28145@iris.ozlabs.ibm.com>
Date: Tue, 10 Sep 2013 13:54:59 -0500
Message-Id: <0F09844A-2688-46DC-996F-022818F6E97B@suse.de>
References: <20130910102000.GA28145@iris.ozlabs.ibm.com>
 <20130910102221.GF28145@iris.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.09.2013, at 05:22, Paul Mackerras wrote:

> Now that we have the vcpu floating-point and vector state stored in
> the same type of struct as the main kernel uses, we can load that
> state directly from the vcpu struct instead of having extra copies
> to/from the thread_struct.  Similarly, when the guest state needs to
> be saved, we can have it saved it directly to the vcpu struct by
> setting the current->thread.fp_save_area and =
current->thread.vr_save_area
> pointers.  That also means that we don't need to back up and restore
> userspace's FP/vector state.  This all makes the code simpler and
> faster.
>=20
> Note that it's not necessary to save or modify =
current->thread.fpexc_mode,
> since nothing in KVM uses or is affected by its value.  Nor is it
> necessary to touch used_vr or used_vsr.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> arch/powerpc/kvm/book3s_pr.c | 72 =
++++++++++----------------------------------
> arch/powerpc/kvm/booke.c     | 16 ----------
> arch/powerpc/kvm/booke.h     |  4 ++-
> 3 files changed, 19 insertions(+), 73 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_pr.c =
b/arch/powerpc/kvm/book3s_pr.c
> index 90be91c..5eae919 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -462,16 +462,16 @@ void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, =
ulong msr)
> 		 * both the traditional FP registers and the added VSX
> 		 * registers into thread.fp_state.fpr[].
> 		 */
> -		if (current->thread.regs->msr & MSR_FP)
> +		if (t->regs->msr & MSR_FP)
> 			giveup_fpu(current);

If you make a second version of this call that also gets a state area as =
parameter, you don't need the pointer in the thread struct anymore, no? =
Or do you? Ah, you want to be able to grab the FPU for in-kernel FPU =
using code, so it needs to be seamless.

Fiar enough - pointer it is then :).


Alex
