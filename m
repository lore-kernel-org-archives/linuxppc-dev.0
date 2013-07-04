Return-Path: <R65777@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91FF32C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 17:51:56 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>, <agraf@suse.de>,
 <tiejun.chen@windriver.com>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <mikey@neuling.org>,
 <scottwood@freescale.com>, <sfr@canb.auug.org.au>
Subject: [PATCH 0/4 v6] KVM :PPC: Userspace Debug support
Date: Thu, 4 Jul 2013 12:27:43 +0530
Message-ID: <1372921067-19678-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bharat Bhushan <bharat.bhushan@freescale.com>

Note: These patches depends on https://lkml.org/lkml/2013/7/4/49.

This patchset adds the userspace debug support for booke/bookehv.
this is tested on powerpc e500v2/e500mc devices.

We are now assuming that debug resource will not be used by kernel for
its own debugging. It will be used for only kernel user process debugging.
So the kernel debug load interface during context_to is used to load
debug conext for that selected process.

v5->v6
 - Earlier it was a patchset of six patches. Now this is devided into
   two parts: 1) powerpc spcific changes 2) kvm specific changes.
   This patchset now contains only KVM specific changes.
 - using "ehpriv 1" (earlier using "ehpriv") for software breakpoint
 -

v4->v5
 - Some comments reworded and other cleanup (like change of function name etc)
 - Added a function for setting MSRP rather than inline

v3->v4
 - 4 out of 7 patches of initial patchset were applied.
   This patchset is on and above those 4 patches
 - KVM local "struct kvmppc_booke_debug_reg" is replaced by
   powerpc global "struct debug_reg"
 - use switch_booke_debug_regs() for debug register context switch.
 - Save DBSR before kernel pre-emption is enabled.
 - Some more cleanup

v2->v3
 - We are now assuming that debug resource will not be used by
   kernel for its own debugging.
   It will be used for only kernel user process debugging.
   So the kernel debug load interface during context_to is
   used to load debug conext for that selected process.

v1->v2
 - Debug registers are save/restore in vcpu_put/vcpu_get.
   Earlier the debug registers are saved/restored in guest entry/exit

Bharat Bhushan (4):
  powerpc: export debug registers save function for KVM
  KVM: PPC: exit to user space on "ehpriv 1" instruction
  KVM: PPC: Using "struct debug_reg"
  KVM: PPC: Add userspace debug stub support

 arch/powerpc/include/asm/disassemble.h |    4 +
 arch/powerpc/include/asm/kvm_booke.h   |    7 +-
 arch/powerpc/include/asm/kvm_host.h    |   16 +--
 arch/powerpc/include/asm/switch_to.h   |    1 +
 arch/powerpc/include/uapi/asm/kvm.h    |   22 ++-
 arch/powerpc/kernel/process.c          |    3 +-
 arch/powerpc/kvm/booke.c               |  275 ++++++++++++++++++++++++++++----
 arch/powerpc/kvm/booke.h               |    5 +
 arch/powerpc/kvm/e500_emulate.c        |   26 +++
 9 files changed, 312 insertions(+), 47 deletions(-)
