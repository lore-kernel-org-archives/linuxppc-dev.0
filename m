Return-Path: <paulus@ozlabs.org>
Date: Tue, 10 Sep 2013 20:20:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/6] powerpc: Unify FP/VMX/VSX state handling between KVM and
 main kernel
Message-ID: <20130910102000.GA28145@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently on powerpc we store and access floating-point and vector
state in various ad-hoc arrays in places such as the thread_struct and
the kvm_vcpu_arch struct.  This leads to code duplication for the code
that transfers this state between CPU registers and memory, and leads
to double-copying in the case of PR KVM, where we copy state from the
kvm_vcpu_arch struct to the thread_struct, and then load it up into
CPU registers from the thread_struct.

To simplify all this, this patch series defines a struct for storing
FP/VSX state including FPSCR, and a struct for storing vector state
(VMX/Altivec) including VSCR.  These structs then get used in both the
thread_struct and the kvm_vcpu_arch struct, enabling us to use common
functions for loading and storing the CPU register state, and avoid
double copying.  The benefit can be seen in that the series deletes
330 more lines than it adds.

This series will also help greatly in implementing the support in KVM
for saving and restoring transactional register state on POWER8.

This series is against the "queue" branch of the kvm.git tree.  I used
that as a base because it has pulled in Linus' tree recently and thus
has the most recent powerpc code from Ben H's next branch as well as
the latest KVM code.

Paul.

 arch/powerpc/include/asm/kvm_book3s.h    |   3 -
 arch/powerpc/include/asm/kvm_host.h      |  12 +--
 arch/powerpc/include/asm/ppc_asm.h       |  95 ++---------------
 arch/powerpc/include/asm/processor.h     |  47 +++++----
 arch/powerpc/include/asm/sfp-machine.h   |   2 +-
 arch/powerpc/include/asm/switch_to.h     |   2 -
 arch/powerpc/kernel/align.c              |   6 +-
 arch/powerpc/kernel/asm-offsets.c        |  36 +++----
 arch/powerpc/kernel/fpu.S                |  84 +++++++--------
 arch/powerpc/kernel/ppc_ksyms.c          |   4 +
 arch/powerpc/kernel/process.c            |  15 ++-
 arch/powerpc/kernel/ptrace.c             |  49 ++++-----
 arch/powerpc/kernel/ptrace32.c           |  11 +-
 arch/powerpc/kernel/signal_32.c          |  72 ++++++-------
 arch/powerpc/kernel/signal_64.c          |  29 +++---
 arch/powerpc/kernel/tm.S                 |  41 ++++----
 arch/powerpc/kernel/traps.c              |  10 +-
 arch/powerpc/kernel/vecemu.c             |   6 +-
 arch/powerpc/kernel/vector.S             |  77 +++++++-------
 arch/powerpc/kvm/book3s.c                |  38 +++++--
 arch/powerpc/kvm/book3s_exports.c        |   4 -
 arch/powerpc/kvm/book3s_hv.c             |  42 --------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  82 ++++-----------
 arch/powerpc/kvm/book3s_paired_singles.c | 169 +++++++++++++++----------------
 arch/powerpc/kvm/book3s_pr.c             | 145 +++++---------------------
 arch/powerpc/kvm/book3s_rmhandlers.S     |  47 ---------
 arch/powerpc/kvm/booke.c                 |  21 ----
 arch/powerpc/kvm/booke.h                 |   5 +-
 arch/powerpc/kvm/powerpc.c               |   4 +-
 29 files changed, 414 insertions(+), 744 deletions(-)
