Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F2191A1A76
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:47:23 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 01:47:21 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 00EE51FF003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 01:36:03 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s915h50B10027466
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 07:43:05 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s917pp2g008008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 01:51:52 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Winkle support for offline cpus
Date: Wed,  1 Oct 2014 13:16:52 +0530
Message-Id: <1412149617-3178-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: "Srivatsa S. Bhat" <srivatsa@MIT.EDU>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
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

Powernv already has support for nap and sleep and these states are used
by cpuidle framework. This patchset adds support for 'deep winkle' a 
deeper idle state. 

In deep winkle, entire chiplet (core/L2/L3) is power off, leading to 
higher power savings. But this results in hypervisor state loss. This
patchset add the necessary infrastructure to recover from hypervisor
state loss and enables offline cpus to use winkle. 

I've successfully tested subcore functionality with these patches. 
Particularly these two scenarios:

Scenario 1:
-> Set subcore-per-core to 4.
-> Offline and online a complete core
Check if core wakes up with 4 subcores

Scenario 2. 
-> Set subcore-per-core to 1.
-> Offline a core. 
-> set subcore-per-core to 4.
-> Online a core 
Check if core wakes up with 4 subcores.

In both these scenarios, the core wakes up with 4 subcores and can run 
guests on individual subcores.

Note, these patches apply on top 'powernv/cpuidle: Fastsleep workaround and
fixes' series.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Srivatsa S. Bhat <srivatsa@MIT.EDU>
Cc: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org

v2:
Rebased on 3.17-rc7
Split from 'powerpc/powernv: Support for fastsleep and winkle'

v1:
https://lkml.org/lkml/2014/8/25/446

Shreyas B. Prabhu (5):
  powerpc/powernv: Add OPAL call to save and restore
  powerpc: Adding macro for accessing Thread Switch Control Register
  powerpc/powernv: Add winkle infrastructure
  powerpc/powernv: Discover and enable winkle
  powerpc/powernv: Enter deepest supported idle state in offline

 arch/powerpc/include/asm/machdep.h             |  1 +
 arch/powerpc/include/asm/opal.h                |  3 +
 arch/powerpc/include/asm/paca.h                |  3 +
 arch/powerpc/include/asm/ppc-opcode.h          |  2 +
 arch/powerpc/include/asm/processor.h           |  2 +
 arch/powerpc/include/asm/reg.h                 |  1 +
 arch/powerpc/kernel/asm-offsets.c              |  1 +
 arch/powerpc/kernel/exceptions-64s.S           |  4 +-
 arch/powerpc/kernel/idle.c                     | 11 +++
 arch/powerpc/kernel/idle_power7.S              | 81 ++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/powernv.h       |  1 +
 arch/powerpc/platforms/powernv/setup.c         | 99 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/smp.c           |  6 +-
 arch/powerpc/platforms/powernv/subcore.c       | 15 ++++
 15 files changed, 226 insertions(+), 5 deletions(-)

-- 
1.9.3
