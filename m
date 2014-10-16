Return-Path: <kernelfans@gmail.com>
Received: from mail-pd0-x232.google.com (mail-pd0-x232.google.com
 [IPv6:2607:f8b0:400e:c02::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD7B61A0373
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:25:37 +1100 (AEDT)
Received: by mail-pd0-f178.google.com with SMTP id y10so2781770pdj.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:25:35 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 00/11]: powerKVM,
 release the compute power of secondary hwthread on host
Date: Thu, 16 Oct 2014 15:29:49 -0400
Message-Id: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nowadays, when running powerKVM(book3s, hv mode), we should make the secondary hwthread
offline. Which means that if we run misc tsks other than dedicated KVM (e.g mix java and KVM),
we will lose the compute power of the secondary hwthread on host env.


This series aim to make the powerpc adaptive to the misc tsks on host.
( This series is just a sketch, with some broken patch. Sorry to bring up it in a hurry,
  I am afraid that I am on the wrong direction too far. So I hope I can get some advice and feedback
  in advance. I will go on the work on the "place holder" patch if my idea is reasonable.

  Please consider the code as the explaining of my idea.
)


The internal:
  -1.To enter guest, the primary hwthread schedule stopper func on the secondary to bring them into NAP mode.
        The proto will be:
             cpu1                              cpuX
          stop_cpus_async()
                                          bring cpuX to a special state
                                          signal flag and trapped
          check for flag
          set up guest env and ipi cpuX        
  -2.When exit to host, the secondary hardcode to jmp back to the stopper func, i.e back to host.


Drawbacks that I can think so far:
  -1. increase the sched interval on secondary but the schduler do NOT know it.(can it cause problem?)
  -2. lose some presice of hrtime on secondary hwthread for host.(To avoid the primary
       has too small time slice, we need to impose a threshold，so we may lose the presice)

Any suggestion? Thanks!

Liu Ping Fan (11):
  sched: introduce sys_cpumask in tsk to adapt asymmetric system
  powerpc: kvm: ensure vcpu-thread run only on primary hwthread
  powerpc: kvm: add interface to control kvm function on a core
  powerpc: kvm: introduce a kthread on primary thread to anti tickless
  sched: introduce stop_cpus_async() to schedule special tsk on cpu
  powerpc: kvm: introduce online in paca to indicate whether cpu is
    needed by host
  powerpc: kvm: the stopper func to cease secondary hwthread
  powerpc: kvm: add a flag in vcore to sync primary with secondry
    hwthread
  powerpc: kvm: handle time base on secondary hwthread
  powerpc: kvm: on_primary_thread() force the secondary threads into NAP
        mode
  powerpc: kvm: Kconfig add an option for enabling secondary hwthread

 arch/powerpc/include/asm/kvm_host.h     |  6 ++++
 arch/powerpc/include/asm/paca.h         |  3 ++
 arch/powerpc/kernel/asm-offsets.c       |  6 ++++
 arch/powerpc/kernel/smp.c               |  3 ++
 arch/powerpc/kernel/sysfs.c             | 41 ++++++++++++++++++++++
 arch/powerpc/kvm/Kconfig                |  4 +++
 arch/powerpc/kvm/book3s_hv.c            | 39 +++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 61 +++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/xics/xics-common.c  | 12 +++++++
 include/linux/init_task.h               |  1 +
 include/linux/sched.h                   |  6 ++++
 include/linux/stop_machine.h            |  2 ++
 kernel/sched/core.c                     | 10 ++++--
 kernel/stop_machine.c                   | 25 +++++++++++---
 14 files changed, 212 insertions(+), 7 deletions(-)

-- 
1.8.3.1
