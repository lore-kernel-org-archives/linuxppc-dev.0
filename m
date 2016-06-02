Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL6H36RVqzDqcV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 22:39:11 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 08:39:09 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: paulus@ozlabs.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: [PATCH v5 00/11] powerpc/powernv/cpuidle: Add support for POWER ISA
 v3 idle states
Date: Thu,  2 Jun 2016 07:38:50 -0500
Message-Id: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER ISA v3 defines a new idle processor core mechanism. In summary,
 a) new instruction named stop is added. This instruction replaces
	instructions like nap, sleep, rvwinkle.
 b) new per thread SPR named PSSCR is added which controls the behavior
	of stop instruction. 
		
PSSCR has following key fields
	Bits 0:3  - Power-Saving Level Status. This field indicates the
	lowest power-saving state the thread entered since stop
	instruction was last executed.
		
	Bit 42 - Enable State Loss                          
	0 - No state is lost irrespective of other fields  
	1 - Allows state loss
		
	Bits 44:47 - Power-Saving Level Limit      
	This limits the power-saving level that can be entered into.
		
	Bits 60:63 - Requested Level              
	Used to specify which power-saving level must be entered on
	executing stop instruction
		
Stop idle states and their properties like name, latency, target
residency, psscr value are exposed via device tree.

This patch series adds support for this new mechanism.

Patches 1-7 are cleanups and code movement.
Patch 8 adds platform specific support for stop and psscr handling.
Patch 9 is a minor cleanup in cpuidle driver.
Patch 10 adds cpuidle driver support.
Patch 11 makes offlined cpu use deepest stop state.

Note: Documentation for the device tree bindings is posted here-
http://patchwork.ozlabs.org/patch/629125/


Changes in v5
=============
 - Use generic cpuidle constant CPUIDLE_NAME_LEN
 - Fix return code handling for of_property_read_string_array
 - Use DT flags to determine if are using stop instruction, instead of
   cpu_has_feature
 - Removed uncessary cast with names
 - &stop_loop -> stop_loop
 - Added POWERNV_THRESHOLD_LATENCY_NS to filter out idle states with high latency

Changes in v4
=============
 - Added a patch to use PNV_THREAD_WINKLE macro while requesting for winkle
 - Moved power7_powersave_common rename to more appropriate patch
 - renaming power7_enter_nap_mode to pnv_enter_arch207_idle_mode
 - Added PSSCR layout to Patch 7's commit message
 - Improved / Fixed comments
 - Fixed whitespace error in paca.h
 - Using MAX_POSSIBLE_STOP_STATE macro instead of hardcoding 0xF has
   max possible stop state

Changes in v3
=============
 - Rebased on powerpc-next
 - Dropping patch 1 since we are not adding a new file for P9 idle support
 - Improved comments in multiple places
 - Moved GET_PACA from power7_restore_hyp_resource to System Reset
 - Instead of moving few functions from idle_power7 to idle_power_common,
   renaming idle_power7.S to idle_power_common.S
 - Moved HSTATE_HWTHREAD_STATE updation to power_powersave_common
 - Dropped earlier patch 5 which moved few macros from idle_power_common to
   asm/cpuidle.h. 
 - Added a patch to rename reusable power7_* idle functions to pnv_*
 - Added new patch that creates abstraction for saving SPRs before
   entering deep idle states
 - Instead of introducing new file idle_power_stop.S, P9 idle support
   is added to idle_power_common.S using CPU_FTR sections.
 - Fixed r4 reg clobbering in power_stop0

Changes in v2
=============
 - Rebased on v4.6-rc6
 - Using CPU_FTR_ARCH_300 bit instead of CPU_FTR_STOP_INST

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>


Shreyas B. Prabhu (11):
  powerpc/powernv: Use PNV_THREAD_WINKLE macro while requesting for
    winkle
  powerpc/kvm: make hypervisor state restore a function
  powerpc/powernv: Rename idle_power7.S to idle_power_common.S
  powerpc/powernv: Rename reusable idle functions to hardware agnostic
    names
  powerpc/powernv: Make pnv_powersave_common more generic
  powerpc/powernv: abstraction for saving SPRs before entering deep idle
    states
  powerpc/powernv: set power_save func after the idle states are
    initialized
  powerpc/powernv: Add platform support for stop instruction
  cpuidle/powernv: Use CPUIDLE_STATE_MAX instead of
    MAX_POWERNV_IDLE_STATES
  cpuidle/powernv: Add support for POWER ISA v3 idle states
  powerpc/powernv: Use deepest stop state when cpu is offlined

 arch/powerpc/include/asm/cpuidle.h        |   2 +
 arch/powerpc/include/asm/kvm_book3s_asm.h |   2 +-
 arch/powerpc/include/asm/machdep.h        |   1 +
 arch/powerpc/include/asm/opal-api.h       |  11 +-
 arch/powerpc/include/asm/paca.h           |   2 +
 arch/powerpc/include/asm/ppc-opcode.h     |   4 +
 arch/powerpc/include/asm/processor.h      |   1 +
 arch/powerpc/include/asm/reg.h            |  11 +
 arch/powerpc/kernel/Makefile              |   2 +-
 arch/powerpc/kernel/asm-offsets.c         |   2 +
 arch/powerpc/kernel/exceptions-64s.S      |  30 +-
 arch/powerpc/kernel/idle_power7.S         | 515 -----------------------
 arch/powerpc/kernel/idle_power_common.S   | 662 ++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |   4 +-
 arch/powerpc/platforms/powernv/idle.c     |  98 ++++-
 arch/powerpc/platforms/powernv/powernv.h  |   1 +
 arch/powerpc/platforms/powernv/setup.c    |   2 +-
 arch/powerpc/platforms/powernv/smp.c      |   4 +-
 drivers/cpuidle/cpuidle-powernv.c         |  66 ++-
 19 files changed, 857 insertions(+), 563 deletions(-)
 delete mode 100644 arch/powerpc/kernel/idle_power7.S
 create mode 100644 arch/powerpc/kernel/idle_power_common.S

-- 
2.1.4
