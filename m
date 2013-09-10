Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 67BD22C00B3
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Sep 2013 03:12:56 +1000 (EST)
Subject: Re: [PATCH 2/6] powerpc: Provide for giveup_fpu/altivec to save state
 in alternate location
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20130910102110.GC28145@iris.ozlabs.ibm.com>
Date: Tue, 10 Sep 2013 12:12:47 -0500
Message-Id: <675235E3-6991-4DB1-90A4-935E826F6413@suse.de>
References: <20130910102000.GA28145@iris.ozlabs.ibm.com>
 <20130910102110.GC28145@iris.ozlabs.ibm.com>
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


On 10.09.2013, at 05:21, Paul Mackerras wrote:

> This provides a facility which is intended for use by KVM, where the
> contents of the FP/VSX and VMX (Altivec) registers can be saved away
> to somewhere other than the thread_struct when kernel code wants to
> use floating point or VMX instructions.  This is done by providing a
> pointer in the thread_struct to indicate where the state should be
> saved to.  The giveup_fpu() and giveup_altivec() functions test these
> pointers and save state to the indicated location if they are =
non-NULL.
> Note that the MSR_FP/VEC bits in task->thread.regs->msr are still used
> to indicate whether the CPU register state is live, even when an
> alternate save location is being used.
>=20
> This also provides load_fp_state() and load_vr_state() functions, =
which
> load up FP/VSX and VMX state from memory into the CPU registers, and
> corresponding store_fp_state() and store_vr_state() functions, which
> store FP/VSX and VMX state into memory from the CPU registers.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> arch/powerpc/include/asm/processor.h |  7 +++++++
> arch/powerpc/kernel/asm-offsets.c    |  2 ++
> arch/powerpc/kernel/fpu.S            | 25 ++++++++++++++++++++++++-
> arch/powerpc/kernel/ppc_ksyms.c      |  4 ++++
> arch/powerpc/kernel/process.c        |  7 +++++++
> arch/powerpc/kernel/vector.S         | 29 =
+++++++++++++++++++++++++++--
> 6 files changed, 71 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/processor.h =
b/arch/powerpc/include/asm/processor.h
> index 92f709d..8bc9d66 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -212,6 +212,7 @@ struct thread_struct {
> #endif
> #endif
> 	struct thread_fp_state	fp_state;
> +	struct thread_fp_state	*fp_save_area;

Why do you need these pointers? Couldn't you handle everything you need =
through preempt notifiers?


Alex
