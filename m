Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rShYF1p83zDqZB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 15:44:17 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5D5hcB6010342
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 01:44:15 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gbhee986-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 01:44:15 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Sun, 12 Jun 2016 23:44:14 -0600
Date: Mon, 13 Jun 2016 11:14:04 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <htejun@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix CPU Online handling for unbounded worker threads
Reply-To: ego@linux.vnet.ibm.com
References: <5756BE20.3040208@linux.vnet.ibm.com>
 <cover.1465311052.git.ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1465311052.git.ego@linux.vnet.ibm.com>
Message-Id: <20160613054404.GA18423@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter, Thomas,
On Tue, Jun 07, 2016 at 08:44:01PM +0530, Gautham R. Shenoy wrote:
> Hi,
> 
> This patchset fixes a couple of issues in the CPU_ONLINE notification
> handling for the workqueues with respect to unbounded worker
threads.

Any thoughts on these patches ? They fix a race which
was causing WARN_ON() to be consistently reproduced on POWER machines
since 4.6.

Could you please review these patches ?

--
Thanks and Regard
gautham.

> 
> Patch 1 ensures that the affinity of a unbound worker thread
> associated with a node whose very first CPU has come online is set
> correctly. In the existing code path we will never call
> set_cpus_allowed_ptr() for unbound worker threads that have been
> created on a CPU Online operation after boot.
> 
> Patch 2 fixes the following WARN_ON() reported by Abdul when
> set_cpus_allowed_ptr() for an unbound worker thread is invoked when
> only one of the CPUs in its cpumask is online but not yet active.
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 40 PID: 248 at kernel/sched/core.c:1166 __set_cpus_allowed_ptr+0x21c/0x290
>  Modules linked in:
> CPU: 40 PID: 248 Comm: cpuhp/40 Not tainted 4.6.0-autotest #1
> task: c000000f27284200 ti: c000000f273fc000 task.ti: c000000f273fc000
> NIP: c00000000010488c LR: c000000000104874 CTR: 0000000000000000
> REGS: c000000f273ff7d0 TRAP: 0700   Not tainted  (4.6.0-autotest)
> MSR: 9000000100029033 <SF,HV,EE,ME,IR,DR,RI,LE,TM[E]>  CR: 28002804  XER: 20000000
> CFAR: c0000000005b0888 SOFTE: 0
> GPR00: c00000000010478c c000000f273ffa50 c0000000013ce400 0000000000000000
> GPR04: c00000000140ed98 0000000000000800 c0000007f64d9408 0000000000000000
> GPR08: 0000000000000000 0000000000000028 c00000000140ee90 0000000000000020
> GPR12: 0000000000002200 c00000000fb96800 c0000000000f44a8 c0000007fa158480
> GPR16: c0000007fc621a70 c000000f2721f800 0000000000000000 0000000000000001
> GPR20: c000000001571ef0 0000000000000000 c00000000134879f c0000000012bc510
> GPR24: 0000010000000000 0000000000000000 c00000000140ea98 c0000007f64d9408
> GPR28: c0000007fbc21c00 ffffffffffffffea 0000000000000000 c000000f27280000
> NIP [c00000000010488c] __set_cpus_allowed_ptr+0x21c/0x290
> LR [c000000000104874] __set_cpus_allowed_ptr+0x204/0x290
> Call Trace:
> [c000000f273ffa50] [c00000000010478c] __set_cpus_allowed_ptr+0x11c/0x290 (unreliable)
> [c000000f273ffac0] [c0000000000ed4b0] workqueue_cpu_up_callback+0x2c0/0x470
> [c000000f273ffb70] [c0000000000f5c58] notifier_call_chain+0x98/0x100
> [c000000f273ffbc0] [c0000000000c5ed0] __cpu_notify+0x70/0xe0
> [c000000f273ffc00] [c0000000000c6028] notify_online+0x38/0x50
> [c000000f273ffc30] [c0000000000c5214] cpuhp_invoke_callback+0x84/0x250
> [c000000f273ffc90] [c0000000000c562c] cpuhp_up_callbacks+0x5c/0x120
> [c000000f273ffce0] [c0000000000c64d4] cpuhp_thread_fun+0x184/0x1c0
> [c000000f273ffd20] [c0000000000fa050] smpboot_thread_fn+0x290/0x2a0
> [c000000f273ffd80] [c0000000000f45b0] kthread+0x110/0x130
> [c000000f273ffe30] [c000000000009570] ret_from_kernel_thread+0x5c/0x6c
> Instruction dump:
> 419eff3c 3d420004 38a00800 388a0998 7f63db78 484abfa1 60000000 2fa30000
> 409eff1c 813f0378 2f890001 419eff10 <0fe00000> 4bffff08 60000000 60000000
>  ---[ end trace cbc1c5cfbc9591d0 ]---
> 
> The patches are based on 4.7-rc2. I have tested the patches on a
> multi-node x86_64 and a ppc64
> 
> Gautham R. Shenoy (2):
>   workqueue: Move wq_update_unbound_numa() to the beginning of
>     CPU_ONLINE
>   workqueue:Fix affinity of an unbound worker of a node with 1 online
>     CPU
> 
>  kernel/workqueue.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> -- 
> 1.9.3
> 
