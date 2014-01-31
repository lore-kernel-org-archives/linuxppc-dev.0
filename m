Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 442572C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 15:13:34 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 30 Jan 2014 21:13:31 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 02CC63E40026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 21:13:29 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0V4DS3v4456736
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 05:13:28 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0V4DRgZ027229
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 21:13:28 -0700
Subject: [PATCH 0/3] powerpc: Free up an IPI message slot for tick broadcast
 IPIs
To: deepthi@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, toshi.kani@hp.com,
 arnd@arndb.de, geoff@infradead.org, mpe@ellerman.id.au,
 rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 paul.gortmaker@windriver.com, afleming@freescale.com, anton@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, benh@kernel.crashing.org,
 paulus@samba.org, ady8radu@gmail.com, linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Fri, 31 Jan 2014 09:39:53 +0530
Message-ID: <20140131040631.13071.19603.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset is a precursor for enabling deep idle states on powerpc,
when the local CPU timers stop. The tick broadcast framework in
the Linux Kernel today handles wakeup of such CPUs at their next timer event
by using an external clock device. At the expiry of this clock device, IPIs
are sent to the CPUs in deep idle states  so that they wakeup to handle their
respective timers. This patchset frees up one of the IPI slots on powerpc
so as to be used to handle the tick broadcast IPI.

On certain implementations of powerpc, such an external clock device is absent.
Adding support to the tick broadcast framework to handle wakeup of CPUs from
deep idle states on such implementations is currently under discussion.
https://lkml.org/lkml/2014/1/15/86
https://lkml.org/lkml/2014/1/24/28

Either way this patchset is essential to enable handling the tick broadcast IPIs.
---

Preeti U Murthy (1):
      cpuidle/ppc: Split timer_interrupt() into timer handling and interrupt handling routines

Srivatsa S. Bhat (2):
      powerpc: Free up the slot of PPC_MSG_CALL_FUNC_SINGLE IPI message
      powerpc: Implement tick broadcast IPI as a fixed IPI message


 arch/powerpc/include/asm/smp.h          |    2 -
 arch/powerpc/include/asm/time.h         |    1 
 arch/powerpc/kernel/smp.c               |   23 ++++++--
 arch/powerpc/kernel/time.c              |   86 ++++++++++++++++++-------------
 arch/powerpc/platforms/cell/interrupt.c |    2 -
 arch/powerpc/platforms/ps3/smp.c        |    2 -
 6 files changed, 71 insertions(+), 45 deletions(-)

-- 
