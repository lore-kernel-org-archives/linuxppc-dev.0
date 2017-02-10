Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKLmv6HFGzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 14:59:43 +1100 (AEDT)
Date: Fri, 10 Feb 2017 14:59:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>,
 KVM <kvm@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras
 <paulus@ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: linux-next: manual merge of the kvm tree with the powerpc tree
Message-ID: <20170210145943.5bf98310@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/powerpc/kernel/exceptions-64s.S

between commit:

  1a6822d194c3 ("powerpc/64s: Use (start, size) rather than (start, end) for exception handlers")

from the powerpc tree and commit:

  bc3551257af8 ("powerpc/64: Allow for relocation-on interrupts from guest to host")

from the kvm tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/kernel/exceptions-64s.S
index a6205a4a3574,34a04a5fa468..000000000000
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@@ -720,14 -720,10 +720,10 @@@ hardware_interrupt_hv
  	FTR_SECTION_ELSE
  		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
  					    EXC_STD, SOFTEN_TEST_PR)
- do_kvm_0x500:
- 		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
  	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 -EXC_REAL_END(hardware_interrupt, 0x500, 0x600)
 +EXC_REAL_END(hardware_interrupt, 0x500, 0x100)
  
 -EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x4600)
 +EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x100)
  	.globl hardware_interrupt_relon_hv;
  hardware_interrupt_relon_hv:
  	BEGIN_FTR_SECTION
@@@ -735,8 -731,10 +731,10 @@@
  	FTR_SECTION_ELSE
  		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_STD, SOFTEN_TEST_PR)
  	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 -EXC_VIRT_END(hardware_interrupt, 0x4500, 0x4600)
 +EXC_VIRT_END(hardware_interrupt, 0x4500, 0x100)
  
+ TRAMP_KVM(PACA_EXGEN, 0x500)
+ TRAMP_KVM_HV(PACA_EXGEN, 0x500)
  EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
  
  
@@@ -884,35 -907,15 +907,15 @@@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE
  	b	system_call_common ;
  #endif
  
 -EXC_REAL_BEGIN(system_call, 0xc00, 0xd00)
 +EXC_REAL_BEGIN(system_call, 0xc00, 0x100)
- 	 /*
- 	  * If CONFIG_KVM_BOOK3S_64_HANDLER is set, save the PPR (on systems
- 	  * that support it) before changing to HMT_MEDIUM. That allows the KVM
- 	  * code to save that value into the guest state (it is the guest's PPR
- 	  * value). Otherwise just change to HMT_MEDIUM as userspace has
- 	  * already saved the PPR.
- 	  */
- #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
- 	SET_SCRATCH0(r13)
- 	GET_PACA(r13)
- 	std	r9,PACA_EXGEN+EX_R9(r13)
- 	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);
- 	HMT_MEDIUM;
- 	std	r10,PACA_EXGEN+EX_R10(r13)
- 	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r9, CPU_FTR_HAS_PPR);
- 	mfcr	r9
- 	KVMTEST_PR(0xc00)
- 	GET_SCRATCH0(r13)
- #else
- 	HMT_MEDIUM;
- #endif
+ 	SYSCALL_KVMTEST
  	SYSCALL_PSERIES_1
  	SYSCALL_PSERIES_2_RFID
  	SYSCALL_PSERIES_3
 -EXC_REAL_END(system_call, 0xc00, 0xd00)
 +EXC_REAL_END(system_call, 0xc00, 0x100)
  
 -EXC_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
 +EXC_VIRT_BEGIN(system_call, 0x4c00, 0x100)
- 	HMT_MEDIUM
+ 	SYSCALL_KVMTEST
  	SYSCALL_PSERIES_1
  	SYSCALL_PSERIES_2_DIRECT
  	SYSCALL_PSERIES_3
@@@ -926,8 -929,8 +929,8 @@@ EXC_VIRT(single_step, 0x4d00, 0x100, 0x
  TRAMP_KVM(PACA_EXGEN, 0xd00)
  EXC_COMMON(single_step_common, 0xd00, single_step_exception)
  
 -EXC_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
 -EXC_VIRT_OOL_HV(h_data_storage, 0x4e00, 0x4e20, 0xe00)
 +EXC_REAL_OOL_HV(h_data_storage, 0xe00, 0x20)
- EXC_VIRT_NONE(0x4e00, 0x20)
++EXC_VIRT_OOL_HV(h_data_storage, 0x4e00, 0x20, 0xe00)
  TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
  EXC_COMMON_BEGIN(h_data_storage_common)
  	mfspr   r10,SPRN_HDAR
@@@ -942,8 -945,8 +945,8 @@@
  	b       ret_from_except
  
  
 -EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
 -EXC_VIRT_OOL_HV(h_instr_storage, 0x4e20, 0x4e40, 0xe20)
 +EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0x20)
- EXC_VIRT_NONE(0x4e20, 0x20)
++EXC_VIRT_OOL_HV(h_instr_storage, 0x4e20, 0x20, 0xe20)
  TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
  EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
  
