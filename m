Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ3DV5Jj0zDt1M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 21:15:22 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAFADf2v074968
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 05:15:20 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26qrbuck5k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 05:15:20 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 15 Nov 2016 10:15:18 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 58B8F219004D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 10:14:29 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAFAFFhO27983986
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 10:15:15 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAFAFE3Z005559
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 03:15:15 -0700
Subject: Re: [GIT PULL v2 0/5] cpu_relax: drop lowlatency, introduce yield
To: Peter Zijlstra <peterz@infradead.org>
References: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Noam Camus <noamc@ezchip.com>, sparclinux@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 15 Nov 2016 11:15:13 +0100
MIME-Version: 1.0
In-Reply-To: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <75f6869e-a2a2-6394-aeda-a30d59b3baa1@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/25/2016 11:03 AM, Christian Borntraeger wrote:
> Peter,
> 
> here is v2 with some improved patch descriptions and some fixes. The
> previous version has survived one day of linux-next and I only changed
> small parts.
> So unless there is some other issue, feel free to pull (or to apply
> the patches) to tip/locking.
> 
> The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:
> 
>   Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/borntraeger/linux.git  tags/cpurelax
> 
> for you to fetch changes up to dcc37f9044436438360402714b7544a8e8779b07:
> 
>   processor.h: remove cpu_relax_lowlatency (2016-10-25 09:49:57 +0200)

Ping.

Peter, you had these patches in your
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git/
repository, but now the patches are gone. 
Any feedback?



> 
> ----------------------------------------------------------------
> cpu_relax: drop lowlatency, introduce yield
> 
> For spinning loops people do often use barrier() or cpu_relax().
> For most architectures cpu_relax and barrier are the same, but on
> some architectures cpu_relax can add some latency.
> For example on power,sparc64 and arc, cpu_relax can shift the CPU
> towards other hardware threads in an SMT environment.
> On s390 cpu_relax does even more, it uses an hypercall to the
> hypervisor to give up the timeslice.
> In contrast to the SMT yielding this can result in larger latencies.
> In some places this latency is unwanted, so another variant
> "cpu_relax_lowlatency" was introduced. Before this is used in more
> and more places, lets revert the logic and provide a cpu_relax_yield
> that can be called in places where yielding is more important than
> latency. By default this is the same as cpu_relax on all architectures.
> 
> So my proposal boils down to:
> - lowest latency: use barrier() or mb() if necessary
> - low latency: use cpu_relax (e.g. might give up some cpu for the other
>   _hardware_ threads)
> - really give up CPU: use  cpu_relax_yield
> 
> PS: In the long run I would also try to provide for s390 something
> like cpu_relax_yield_to with a cpu number (or just add that to
> cpu_relax_yield), since a yield_to is always better than a yield as
> long as we know the waiter.
> 
> ----------------------------------------------------------------
> Christian Borntraeger (5):
>       processor.h: introduce cpu_relax_yield
>       stop_machine: yield CPU during stop machine
>       s390: make cpu_relax a barrier again
>       processor.h: Remove cpu_relax_lowlatency users
>       processor.h: remove cpu_relax_lowlatency
> 
>  arch/alpha/include/asm/processor.h      | 2 +-
>  arch/arc/include/asm/processor.h        | 4 ++--
>  arch/arm/include/asm/processor.h        | 2 +-
>  arch/arm64/include/asm/processor.h      | 2 +-
>  arch/avr32/include/asm/processor.h      | 2 +-
>  arch/blackfin/include/asm/processor.h   | 2 +-
>  arch/c6x/include/asm/processor.h        | 2 +-
>  arch/cris/include/asm/processor.h       | 2 +-
>  arch/frv/include/asm/processor.h        | 2 +-
>  arch/h8300/include/asm/processor.h      | 2 +-
>  arch/hexagon/include/asm/processor.h    | 2 +-
>  arch/ia64/include/asm/processor.h       | 2 +-
>  arch/m32r/include/asm/processor.h       | 2 +-
>  arch/m68k/include/asm/processor.h       | 2 +-
>  arch/metag/include/asm/processor.h      | 2 +-
>  arch/microblaze/include/asm/processor.h | 2 +-
>  arch/mips/include/asm/processor.h       | 2 +-
>  arch/mn10300/include/asm/processor.h    | 2 +-
>  arch/nios2/include/asm/processor.h      | 2 +-
>  arch/openrisc/include/asm/processor.h   | 2 +-
>  arch/parisc/include/asm/processor.h     | 2 +-
>  arch/powerpc/include/asm/processor.h    | 2 +-
>  arch/s390/include/asm/processor.h       | 4 ++--
>  arch/s390/kernel/processor.c            | 4 ++--
>  arch/score/include/asm/processor.h      | 2 +-
>  arch/sh/include/asm/processor.h         | 2 +-
>  arch/sparc/include/asm/processor_32.h   | 2 +-
>  arch/sparc/include/asm/processor_64.h   | 2 +-
>  arch/tile/include/asm/processor.h       | 2 +-
>  arch/unicore32/include/asm/processor.h  | 2 +-
>  arch/x86/include/asm/processor.h        | 2 +-
>  arch/x86/um/asm/processor.h             | 2 +-
>  arch/xtensa/include/asm/processor.h     | 2 +-
>  drivers/gpu/drm/i915/i915_gem_request.c | 2 +-
>  drivers/vhost/net.c                     | 4 ++--
>  kernel/locking/mcs_spinlock.h           | 4 ++--
>  kernel/locking/mutex.c                  | 4 ++--
>  kernel/locking/osq_lock.c               | 6 +++---
>  kernel/locking/qrwlock.c                | 6 +++---
>  kernel/locking/rwsem-xadd.c             | 4 ++--
>  kernel/stop_machine.c                   | 2 +-
>  lib/lockref.c                           | 2 +-
>  42 files changed, 53 insertions(+), 53 deletions(-)
> 
