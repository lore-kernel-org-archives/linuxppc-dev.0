Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9806E1A043F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 04:01:43 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 25 Aug 2014 14:01:41 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4C242C90026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 14:01:30 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7PI1cOI52953170
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 18:01:38 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7PI1a5Y008107
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 14:01:38 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] powerpc/powernv: Support for fastsleep and winkle
Date: Mon, 25 Aug 2014 23:31:04 +0530
Message-Id: <1408989673-14137-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: devicetree@vger.kernel.org, "Srivatsa S. Bhat" <srivatsa@MIT.EDU>,
 linux-pm@vger.kernel.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fast sleep is an idle state, where the core and the L1 and L2
caches are brought down to a threshold voltage. This also means that
the communication between L2 and L3 caches have to be fenced. However
the current P8 chips have a bug wherein this fencing between L2 and
L3 caches get delayed by a cpu cycle. This can delay L3 response to
the other cpus if they request for data during this time. Thus they
would fetch the same data from the memory which could lead to data
corruption if L3 cache is not flushed.
Patch 4 adds support to work around this.

'Deep Winkle' is a deeper idle state where core and private L2 are powered
off. While it offers higher power savings, it is at the cost of losing
hypervisor register state and higher latency.
Patch 5-9 adds support for winkle and uses it for offline cpus.

Patch 1 - Moves parameters required discover idle states to a location 
common to both cpuidle driver and powernv core code
Patch 2 - Populates idle state details from device tree
Patch 3 - Enables cpus to run guest after waking up from fastsleep/winkle


Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Srivatsa S. Bhat <srivatsa@MIT.EDU>
Cc: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org

Preeti U Murthy (2):
  cpuidle/powernv: Populate cpuidle state details by querying the
    device-tree
  powerpc/powernv/cpuidle: Add workaround to enable fastsleep

Shreyas B. Prabhu (6):
  powerpc/kvm/book3s_hv: Enable CPUs to run guest after waking up from
    fast-sleep
  powerpc/powernv: Add OPAL call to save and restore
  powerpc: Adding macro for accessing Thread Switch Control Register
  powerpc/powernv: Add winkle infrastructure
  powerpc/powernv: Discover and enable winkle
  powerpc/powernv: Enter deepest supported idle state in offline

Srivatsa S. Bhat (1):
  powerpc/powernv: Enable Offline CPUs to enter deep idle states

 arch/powerpc/include/asm/machdep.h             |   4 +
 arch/powerpc/include/asm/opal.h                |  10 ++
 arch/powerpc/include/asm/paca.h                |   3 +
 arch/powerpc/include/asm/ppc-opcode.h          |   2 +
 arch/powerpc/include/asm/processor.h           |   6 +-
 arch/powerpc/include/asm/reg.h                 |   1 +
 arch/powerpc/kernel/asm-offsets.c              |   1 +
 arch/powerpc/kernel/exceptions-64s.S           |  37 ++---
 arch/powerpc/kernel/idle.c                     |  30 ++++
 arch/powerpc/kernel/idle_power7.S              |  83 +++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +
 arch/powerpc/platforms/powernv/powernv.h       |   8 +
 arch/powerpc/platforms/powernv/setup.c         | 217 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/smp.c           |  13 +-
 arch/powerpc/platforms/powernv/subcore.c       |  15 ++
 drivers/cpuidle/cpuidle-powernv.c              |  40 ++++-
 16 files changed, 439 insertions(+), 33 deletions(-)

-- 
1.9.0
