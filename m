Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKrd19FCzDqrR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:50:24 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 07:50:22 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7725D19D804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:38:12 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3LDoLcq29753364
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 06:50:21 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3LDoJSH002110
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 07:50:20 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH 0/9] powerpc/powernv/cpuidle: Add support for POWER ISA v3
 idle states
Date: Thu, 21 Apr 2016 19:19:50 +0530
Message-Id: <1461246599-6098-1-git-send-email-shreyas@linux.vnet.ibm.com>
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

Patches 1-6 are cleanups and code movement.
Patch 7 adds platform specific support for stop and psscr handling.
Patch 8 adds cpuidle driver support.
Patch 9 makes offlined cpu use stop state.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org

Shreyas B. Prabhu (9):
  powerpc/powernv: Move CHECK_HMI_INTERRUPT to exception-64s header
  powerpc/kvm: make hypervisor state restore a function
  powerpc/powernv: Move idle code usable by multiple hardware to common
    location
  powerpc/powernv: Make power7_powersave_common more generic
  powerpc/powernv: Move idle related macros to cpuidle.h
  powerpc/powernv: set power_save func after the idle states are
    initialized
  powerpc/powernv: Add platform support for stop instruction
  cpuidle/powernv: Add support for POWER ISA v3 idle states
  powerpc/powernv: Use deepest stop state when cpu is offlined

 arch/powerpc/include/asm/cpuidle.h        |  29 ++++
 arch/powerpc/include/asm/cputable.h       |   4 +-
 arch/powerpc/include/asm/exception-64s.h  |  18 +++
 arch/powerpc/include/asm/kvm_book3s_asm.h |   2 +-
 arch/powerpc/include/asm/machdep.h        |   1 +
 arch/powerpc/include/asm/opal-api.h       |  11 +-
 arch/powerpc/include/asm/paca.h           |   4 +
 arch/powerpc/include/asm/ppc-opcode.h     |   4 +
 arch/powerpc/include/asm/processor.h      |   1 +
 arch/powerpc/include/asm/reg.h            |  11 ++
 arch/powerpc/kernel/Makefile              |   2 +
 arch/powerpc/kernel/asm-offsets.c         |   4 +
 arch/powerpc/kernel/exceptions-64s.S      |  29 +---
 arch/powerpc/kernel/idle_power7.S         | 212 +++-------------------------
 arch/powerpc/kernel/idle_power_common.S   | 185 +++++++++++++++++++++++++
 arch/powerpc/kernel/idle_power_stop.S     | 221 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig            |   4 +
 arch/powerpc/platforms/powernv/Kconfig    |   1 +
 arch/powerpc/platforms/powernv/idle.c     |  94 +++++++++++--
 arch/powerpc/platforms/powernv/powernv.h  |   1 +
 arch/powerpc/platforms/powernv/setup.c    |   2 +-
 arch/powerpc/platforms/powernv/smp.c      |   4 +-
 drivers/cpuidle/cpuidle-powernv.c         |  57 +++++++-
 23 files changed, 662 insertions(+), 239 deletions(-)
 create mode 100644 arch/powerpc/kernel/idle_power_common.S
 create mode 100644 arch/powerpc/kernel/idle_power_stop.S

-- 
2.1.4
