Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 087012C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 13:41:20 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 9 Feb 2014 21:41:18 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C683DC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Feb 2014 21:41:10 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1A2fDoK5243218
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 02:41:13 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1A2fCee021666
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Feb 2014 21:41:12 -0500
Subject: [RESEND PATCH 0/3] powerpc: Free up an IPI message slot for tick
 broadcast IPIs
To: benh@kernel.crashing.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Mon, 10 Feb 2014 08:07:36 +0530
Message-ID: <20140210023503.19345.30567.stgit@preeti>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: deepthi@linux.vnet.ibm.com, arnd@arndb.de, geoff@infradead.org,
 paul.gortmaker@windriver.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
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
The support in the tick broadcast framework to handle wakeup of CPUs from
deep idle states on such implementations is currently in the tip tree.
https://lkml.org/lkml/2014/2/7/906
https://lkml.org/lkml/2014/2/7/876
https://lkml.org/lkml/2014/2/7/608

With the above support in place, this patchset is next in line to enable deep
idle states on powerpc.

The patchset has been appended by a RESEND tag since nothing has changed from
the previous post except for an added config condition around
tick_broadcast() which handles sending broadcast IPIs, and the update in the cover
letter.
---

Preeti U Murthy (1):
      cpuidle/ppc: Split timer_interrupt() into timer handling and interrupt handling routines

Srivatsa S. Bhat (2):
      powerpc: Free up the slot of PPC_MSG_CALL_FUNC_SINGLE IPI message
      powerpc: Implement tick broadcast IPI as a fixed IPI message


 arch/powerpc/include/asm/smp.h          |    2 -
 arch/powerpc/include/asm/time.h         |    1 
 arch/powerpc/kernel/smp.c               |   25 ++++++---
 arch/powerpc/kernel/time.c              |   86 ++++++++++++++++++-------------
 arch/powerpc/platforms/cell/interrupt.c |    2 -
 arch/powerpc/platforms/ps3/smp.c        |    2 -
 6 files changed, 73 insertions(+), 45 deletions(-)

-- 
