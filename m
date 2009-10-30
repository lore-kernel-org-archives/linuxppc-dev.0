Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id D455AB7C35
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:36 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 00/27] Add KVM support for Book3s_64 (PPC64) hosts v6
Date: Fri, 30 Oct 2009 16:47:00 +0100
Message-Id: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KVM for PowerPC only supports embedded cores at the moment.

While it makes sense to virtualize on small machines, it's even more fun
to do so on big boxes. So I figured we need KVM for PowerPC64 as well.

This patchset implements KVM support for Book3s_64 hosts and guest support
for Book3s_64 and G3/G4.

To really make use of this, you also need a recent version of qemu.

This time around I have no git tree to pull from. Sorry guys :-).

V1 -> V2:

 - extend sregs with padding
 - new naming scheme (ppc64 -> book3s_64; 74xx -> book3s_32)
 - to_phys -> in-kernel tophys()
 - loadimm -> LOAD_REG_IMMEDIATE
 - call .ko kvm.ko
 - set magic paca bit later
 - run guest code with PACA->soft_enabled=true
 - pt_regs for host state saving (guest too?)
 - only do HV dcbz trick on 970
 - refuse to run on LPAR because of missing SLB pieces

V2 -> V3:

 - fix DAR/DSISR saving
 - allow running on LPAR by modifying the SLB shadow
 - change the SLB implementation to use a mem-backed cache and do
   full world switch on enter/exit. gets rid of "context" magic
 - be more aggressive about DEC injection
 - remove fast ld/st because we're always in host context
 - don't use SPRGs in real->paged transition
 - implement dirty log
 - remove MMIO speedup code
 - SPRG cleanup
   - rename SPRG3 -> SPRN_SPRG_PACA
   - rename SPRG1 -> SPRN_SPRG_SCRATCH0
   - don't use SPRG2

V3 -> V4:

 - use context_id instead of mm_alloc
 - export less

V4 -> V5:

 - use get_tb instead of mftb
 - make ppc32 and ppc64 emulation share more code
 - make pvr 32 bits
 - add patch to use hrtimer for decrememter

V5 -> V6:

 - // -> /* */ style comments
 - make code easier to read
 - not take mmap_sem when it's not needed

Alexander Graf (27):
  Move dirty logging code to sub-arch
  Pass PVR in sregs
  Add Book3s definitions
  Add Book3s fields to vcpu structs
  Add asm/kvm_book3s.h
  Add Book3s_64 intercept helpers
  Add book3s_64 highmem asm code
  Add SLB switching code for entry/exit
  Add interrupt handling code
  Add book3s.c
  Add book3s_64 Host MMU handling
  Add book3s_64 guest MMU
  Add book3s_32 guest MMU
  Add book3s_64 specific opcode emulation
  Add mfdec emulation
  Add desktop PowerPC specific emulation
  Make head_64.S aware of KVM real mode code
  Add Book3s_64 offsets to asm-offsets.c
  Export symbols for KVM module
  Split init_new_context and destroy_context
  Export KVM symbols for module
  Add fields to PACA
  Export new PACA constants in asm-offsets
  Include Book3s_64 target in buildsystem
  Fix trace.h
  Use Little Endian for Dirty Bitmap
  Use hrtimers for the decrementer

 arch/powerpc/include/asm/exception-64s.h     |    2 +
 arch/powerpc/include/asm/kvm.h               |    2 +
 arch/powerpc/include/asm/kvm_asm.h           |   39 ++
 arch/powerpc/include/asm/kvm_book3s.h        |  136 ++++
 arch/powerpc/include/asm/kvm_book3s_64_asm.h |   58 ++
 arch/powerpc/include/asm/kvm_host.h          |   79 +++-
 arch/powerpc/include/asm/kvm_ppc.h           |    1 +
 arch/powerpc/include/asm/mmu_context.h       |    5 +
 arch/powerpc/include/asm/paca.h              |    9 +
 arch/powerpc/kernel/asm-offsets.c            |   18 +
 arch/powerpc/kernel/exceptions-64s.S         |    8 +
 arch/powerpc/kernel/head_64.S                |    7 +
 arch/powerpc/kernel/ppc_ksyms.c              |    3 +-
 arch/powerpc/kernel/time.c                   |    1 +
 arch/powerpc/kvm/Kconfig                     |   17 +
 arch/powerpc/kvm/Makefile                    |   27 +-
 arch/powerpc/kvm/book3s.c                    |  925 ++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_32_mmu.c             |  372 +++++++++++
 arch/powerpc/kvm/book3s_64_emulate.c         |  337 ++++++++++
 arch/powerpc/kvm/book3s_64_exports.c         |   24 +
 arch/powerpc/kvm/book3s_64_interrupts.S      |  392 +++++++++++
 arch/powerpc/kvm/book3s_64_mmu.c             |  476 +++++++++++++
 arch/powerpc/kvm/book3s_64_mmu_host.c        |  408 ++++++++++++
 arch/powerpc/kvm/book3s_64_rmhandlers.S      |  131 ++++
 arch/powerpc/kvm/book3s_64_slb.S             |  277 ++++++++
 arch/powerpc/kvm/booke.c                     |    5 +
 arch/powerpc/kvm/emulate.c                   |   66 ++-
 arch/powerpc/kvm/powerpc.c                   |   25 +-
 arch/powerpc/kvm/trace.h                     |    6 +-
 arch/powerpc/mm/hash_utils_64.c              |    2 +
 arch/powerpc/mm/mmu_context_hash64.c         |   24 +-
 virt/kvm/kvm_main.c                          |    5 +-
 32 files changed, 3853 insertions(+), 34 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kvm_book3s.h
 create mode 100644 arch/powerpc/include/asm/kvm_book3s_64_asm.h
 create mode 100644 arch/powerpc/kvm/book3s.c
 create mode 100644 arch/powerpc/kvm/book3s_32_mmu.c
 create mode 100644 arch/powerpc/kvm/book3s_64_emulate.c
 create mode 100644 arch/powerpc/kvm/book3s_64_exports.c
 create mode 100644 arch/powerpc/kvm/book3s_64_interrupts.S
 create mode 100644 arch/powerpc/kvm/book3s_64_mmu.c
 create mode 100644 arch/powerpc/kvm/book3s_64_mmu_host.c
 create mode 100644 arch/powerpc/kvm/book3s_64_rmhandlers.S
 create mode 100644 arch/powerpc/kvm/book3s_64_slb.S
