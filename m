Return-Path: <srs0=6l0/=dp=suse.de=agraf@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1L623y82zDx5j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 01:35:06 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3z1L622Jm8z8vHQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 01:35:06 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3z1L612n2dz9sPt
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2017 01:35:04 +1100 (AEDT)
Subject: Re: [PATCH v2 2/2] powerpc/book3s: Fix TB corruption in guest exit
 path on HMI interrupt.
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20160515041413.2280.747.stgit@mars>
 <20160515041426.2280.92697.stgit@mars>
Cc: KVM <kvm@vger.kernel.org>, KVM-PPC <kvm-ppc@vger.kernel.org>
From: Alexander Graf <agraf@suse.de>
Message-ID: <8626c984-45aa-540b-dea3-f9f48d76f9d3@suse.de>
Date: Tue, 19 Dec 2017 15:35:00 +0100
MIME-Version: 1.0
In-Reply-To: <20160515041426.2280.92697.stgit@mars>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/15/2016 06:14 AM, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> When a guest is assigned to a core it converts the host Timebase (TB)
> into guest TB by adding guest timebase offset before entering into
> guest. During guest exit it restores the guest TB to host TB. This means
> under certain conditions (Guest migration) host TB and guest TB can differ.
>
> When we get an HMI for TB related issues the opal HMI handler would
> try fixing errors and restore the correct host TB value. With no guest
> running, we don't have any issues. But with guest running on the core
> we run into TB corruption issues.
>
> If we get an HMI while in the guest, the current HMI handler invokes opal
> hmi handler before forcing guest to exit. The guest exit path subtracts
> the guest TB offset from the current TB value which may have already
> been restored with host value by opal hmi handler. This leads to incorrect
> host and guest TB values.
>
> With split-core, things become more complex. With split-core, TB also gets
> split and each subcore gets its own TB register. When a hmi handler fixes
> a TB error and restores the TB value, it affects all the TB values of
> sibling subcores on the same core. On TB errors all the thread in the core
> gets HMI. With existing code, the individual threads call opal hmi handle
> independently which can easily throw TB out of sync if we have guest
> running on subcores. Hence we will need to co-ordinate with all the
> threads before making opal hmi handler call followed by TB resync.
>
> This patch introduces a sibling subcore state structure (shared by all
> threads in the core) in paca which holds information about whether sibling
> subcores are in Guest mode or host mode. An array in_guest[] of size
> MAX_SUBCORE_PER_CORE=4 is used to maintain the state of each subcore.
> The subcore id is used as index into in_guest[] array. Only primary
> thread entering/exiting the guest is responsible to set/unset its
> designated array element.
>
> On TB error, we get HMI interrupt on every thread on the core. Upon HMI,
> this patch will now force guest to vacate the core/subcore. Primary
> thread from each subcore will then turn off its respective bit
> from the above bitmap during the guest exit path just after the
> guest->host partition switch is complete.
>
> All other threads that have just exited the guest OR were already in host
> will wait until all other subcores clears their respective bit.
> Once all the subcores turn off their respective bit, all threads will
> will make call to opal hmi handler.
>
> It is not necessary that opal hmi handler would resync the TB value for
> every HMI interrupts. It would do so only for the HMI caused due to
> TB errors. For rest, it would not touch TB value. Hence to make things
> simpler, primary thread would call TB resync explicitly once for each
> core immediately after opal hmi handler instead of subtracting guest
> offset from TB. TB resync call will restore the TB with host value.
> Thus we can be sure about the TB state.
>
> One of the primary threads exiting the guest will take up the
> responsibility of calling TB resync. It will use one of the top bits
> (bit 63) from subcore state flags bitmap to make the decision. The first
> primary thread (among the subcores) that is able to set the bit will
> have to call the TB resync. Rest all other threads will wait until TB
> resync is complete.  Once TB resync is complete all threads will then
> proceed.
>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/hmi.h          |   45 ++++++++
>   arch/powerpc/include/asm/paca.h         |    6 +
>   arch/powerpc/kernel/Makefile            |    2
>   arch/powerpc/kernel/exceptions-64s.S    |    4 +
>   arch/powerpc/kernel/hmi.c               |   56 ++++++++++
>   arch/powerpc/kernel/idle_power7.S       |    5 +
>   arch/powerpc/kernel/traps.c             |    5 +
>   arch/powerpc/kvm/book3s_hv.c            |   37 +++++++
>   arch/powerpc/kvm/book3s_hv_ras.c        |  176 +++++++++++++++++++++++++++++++
>   arch/powerpc/kvm/book3s_hv_rmhandlers.S |   65 +++++++++++
>   10 files changed, 396 insertions(+), 5 deletions(-)
>   create mode 100644 arch/powerpc/include/asm/hmi.h
>   create mode 100644 arch/powerpc/kernel/hmi.c
>

[...]

> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index e571ad2..0d246fc 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -29,6 +29,7 @@
>   #include <asm/kvm_book3s_asm.h>
>   #include <asm/book3s/64/mmu-hash.h>
>   #include <asm/tm.h>
> +#include <asm/opal.h>
>   
>   #define VCPU_GPRS_TM(reg) (((reg) * ULONG_SIZE) + VCPU_GPR_TM)
>   
> @@ -373,6 +374,18 @@ kvm_secondary_got_guest:
>   	lwsync
>   	std	r0, HSTATE_KVM_VCORE(r13)
>   
> +	/*
> +	 * All secondaries exiting guest will fall through this path.
> +	 * Before proceeding, just check for HMI interrupt and
> +	 * invoke opal hmi handler. By now we are sure that the
> +	 * primary thread on this core/subcore has already made partition
> +	 * switch/TB resync and we are good to call opal hmi handler.
> +	 */
> +	cmpwi	r12, BOOK3S_INTERRUPT_HMI
> +	bne	kvm_no_guest
> +
> +	li	r3,0			/* NULL argument */
> +	bl	hmi_exception_realmode
>   /*
>    * At this point we have finished executing in the guest.
>    * We need to wait for hwthread_req to become zero, since
> @@ -428,6 +441,22 @@ kvm_no_guest:
>    */
>   kvm_unsplit_nap:
>   	/*
> +	 * When secondaries are napping in kvm_unsplit_nap() with
> +	 * hwthread_req = 1, HMI goes ignored even though subcores are
> +	 * already exited the guest. Hence HMI keeps waking up secondaries
> +	 * from nap in a loop and secondaries always go back to nap since
> +	 * no vcore is assigned to them. This makes impossible for primary
> +	 * thread to get hold of secondary threads resulting into a soft
> +	 * lockup in KVM path.
> +	 *
> +	 * Let us check if HMI is pending and handle it before we go to nap.
> +	 */
> +	cmpwi	r12, BOOK3S_INTERRUPT_HMI
> +	bne	55f
> +	li	r3, 0			/* NULL argument */
> +	bl	hmi_exception_realmode
> +55:
> +	/*
>   	 * Ensure that secondary doesn't nap when it has
>   	 * its vcore pointer set.
>   	 */
> @@ -601,6 +630,11 @@ BEGIN_FTR_SECTION
>   	mtspr	SPRN_DPDES, r8
>   END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>   
> +	/* Mark the subcore state as inside guest */
> +	bl	kvmppc_subcore_enter_guest
> +	nop
> +	ld	r5, HSTATE_KVM_VCORE(r13)
> +	ld	r4, HSTATE_KVM_VCPU(r13)
>   	li	r0,1
>   	stb	r0,VCORE_IN_GUEST(r5)	/* signal secondaries to continue */
>   
> @@ -1683,6 +1717,23 @@ BEGIN_FTR_SECTION
>   	mtspr	SPRN_DPDES, r8
>   END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>   
> +	/* If HMI, call kvmppc_realmode_hmi_handler() */
> +	cmpwi	r12, BOOK3S_INTERRUPT_HMI
> +	bne	27f
> +	bl	kvmppc_realmode_hmi_handler
> +	nop
> +	li	r12, BOOK3S_INTERRUPT_HMI
> +	/*
> +	 * At this point kvmppc_realmode_hmi_handler would have resync-ed
> +	 * the TB. Hence it is not required to subtract guest timebase
> +	 * offset from timebase. So, skip it.

So when an HMI interrupt comes, we may have a broken time base. But we 
still use the time base to calculate the TB value at which the host is 
supposed to fire DEC on primary as well as secondary threads. Doesn't 
that calculation then break, as it's using a bogus TB value?


Alex
