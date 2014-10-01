Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 12A141A1882
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:46:28 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 03:46:25 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 649B16E8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 03:35:07 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s917kMvq6947320
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 07:46:22 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s917kLJI027662
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 03:46:22 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] powernv/cpuidle: Fastsleep workaround and fixes
Date: Wed,  1 Oct 2014 13:15:57 +0530
Message-Id: <1412149560-2953-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: "Srivatsa S. Bhat" <srivatsa@mit.edu>, linux-pm@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Mackerras <paulus@samba.org>,
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

This series overcomes above problem in kernel.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Srivatsa S. Bhat <srivatsa@mit.edu>
Cc: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

v2:
Rebased on 3.17-rc7
Split from 'powerpc/powernv: Support for fastsleep and winkle'

v1:
https://lkml.org/lkml/2014/8/25/446

Preeti U Murthy (1):
  powerpc/powernv/cpuidle: Add workaround to enable fastsleep

Shreyas B. Prabhu (1):
  powerpc/kvm/book3s_hv: Enable CPUs to run guest after waking up from
    fast-sleep

Srivatsa S. Bhat (1):
  powerpc/powernv: Enable Offline CPUs to enter deep idle states

 arch/powerpc/include/asm/machdep.h             |   3 +
 arch/powerpc/include/asm/opal.h                |   7 ++
 arch/powerpc/include/asm/processor.h           |   4 +-
 arch/powerpc/kernel/exceptions-64s.S           |  35 ++++----
 arch/powerpc/kernel/idle.c                     |  19 ++++
 arch/powerpc/kernel/idle_power7.S              |   2 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/powernv.h       |   7 ++
 arch/powerpc/platforms/powernv/setup.c         | 118 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/smp.c           |  11 ++-
 drivers/cpuidle/cpuidle-powernv.c              |  13 ++-
 11 files changed, 194 insertions(+), 26 deletions(-)

-- 
1.9.3
