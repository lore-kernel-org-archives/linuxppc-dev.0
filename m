Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0kjr5yKKzDvXt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 22:59:12 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9LBwXAH106475
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 07:59:10 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 267ethauuf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 07:59:09 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Fri, 21 Oct 2016 12:59:08 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 0/5] cpu_relax: introduce yield, remove lowlatency
Date: Fri, 21 Oct 2016 13:58:53 +0200
Message-Id: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For spinning loops people did often use barrier() or cpu_relax().
For most architectures cpu_relax and barrier are the same, but on
some architectures cpu_relax can add some latency. For example on s390
cpu_relax gives up the time slice to the hypervisor. On power cpu_relax
tries to give some of the CPU to the neighbor threads. To reduce the
latency another variant cpu_relax_lowlatency was introduced. Before this
is used in more and more places, lets revert the logic of provide a new
function cpu_relax_yield that can spend some time and for s390 yields
the guest CPU.

So my proposal boils down to:
- lowest latency: use barrier() or mb() if necessary
- low latency: use cpu_relax (e.g. might give up some cpu for the other
  threads)
- really give up CPU: use  cpu_relax_yield

The alternative is to keep cpu_relax_lowlatency if there is some need.

Not fully sure about arc/eznps and power, but lets hear first if the
approach is ok.

PS: In the long run I would also try to provide for s390 something like
cpu_relax_yield_to with a cpu number (or just add that to cpu_relax_yield),
since a yield_to is always better than a yield as long as we know the waiter.


Christian Borntraeger (5):
  processor.h: introduce cpu_relax_yield
  stop_machine: yield CPU during stop machine
  s390: make cpu_relax a barrier again
  Remove cpu_relax_lowlatency users
  remove cpu_relax_lowlatency

 arch/alpha/include/asm/processor.h      | 2 +-
 arch/arc/include/asm/processor.h        | 2 ++
 arch/arm/include/asm/processor.h        | 2 +-
 arch/arm64/include/asm/processor.h      | 2 +-
 arch/avr32/include/asm/processor.h      | 2 +-
 arch/blackfin/include/asm/processor.h   | 2 +-
 arch/c6x/include/asm/processor.h        | 2 +-
 arch/cris/include/asm/processor.h       | 2 +-
 arch/frv/include/asm/processor.h        | 2 +-
 arch/h8300/include/asm/processor.h      | 2 +-
 arch/hexagon/include/asm/processor.h    | 2 +-
 arch/ia64/include/asm/processor.h       | 2 +-
 arch/m32r/include/asm/processor.h       | 2 +-
 arch/m68k/include/asm/processor.h       | 2 +-
 arch/metag/include/asm/processor.h      | 2 +-
 arch/microblaze/include/asm/processor.h | 2 +-
 arch/mips/include/asm/processor.h       | 2 +-
 arch/mn10300/include/asm/processor.h    | 2 +-
 arch/nios2/include/asm/processor.h      | 2 +-
 arch/openrisc/include/asm/processor.h   | 2 +-
 arch/parisc/include/asm/processor.h     | 2 +-
 arch/powerpc/include/asm/processor.h    | 2 +-
 arch/s390/include/asm/processor.h       | 4 ++--
 arch/s390/kernel/processor.c            | 4 ++--
 arch/score/include/asm/processor.h      | 2 +-
 arch/sh/include/asm/processor.h         | 2 +-
 arch/sparc/include/asm/processor_32.h   | 2 +-
 arch/sparc/include/asm/processor_64.h   | 2 +-
 arch/tile/include/asm/processor.h       | 2 +-
 arch/unicore32/include/asm/processor.h  | 2 +-
 arch/x86/include/asm/processor.h        | 2 +-
 arch/xtensa/include/asm/processor.h     | 2 +-
 drivers/gpu/drm/i915/i915_gem_request.c | 2 +-
 drivers/vhost/net.c                     | 4 ++--
 kernel/locking/mcs_spinlock.h           | 4 ++--
 kernel/locking/mutex.c                  | 4 ++--
 kernel/locking/osq_lock.c               | 6 +++---
 kernel/locking/qrwlock.c                | 6 +++---
 kernel/locking/rwsem-xadd.c             | 4 ++--
 kernel/stop_machine.c                   | 2 +-
 lib/lockref.c                           | 2 +-
 41 files changed, 52 insertions(+), 50 deletions(-)

-- 
2.5.5
