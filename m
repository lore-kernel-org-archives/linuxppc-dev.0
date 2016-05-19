Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9VsN5TRlzDqN1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 22:35:36 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 19 May 2016 22:35:31 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 21D122BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 22:35:29 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4JCZLfS4129178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 22:35:29 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4JCYuHc015455
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 22:34:56 +1000
Date: Thu, 19 May 2016 22:34:32 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: abdhalee <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel
Subject: Re: WARNING at kernel/sched/core.c:1166 while booting 4.6.0 mainline
 on ppc64le bare metal
Message-ID: <20160519123432.GA10547@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <573D9C2D.4020609@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <573D9C2D.4020609@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2016 at 04:27:49PM +0530, abdhalee wrote:
>Hi
>
>Today's mainline stable 4.6 on ppc64le bare metal booted with the following
>warning.
>
>[    0.080615] EEH: PowerNV platform initialized
>[    0.080709] POWER8 performance monitor hardware support registered
>[    0.080791] power8-pmu: PMAO restore workaround active.
>[    0.100780] ------------[ cut here ]------------
>[    0.100869] WARNING: CPU: 40 PID: 248 at kernel/sched/core.c:1166
>__set_cpus_allowed_ptr+0x21c/0x290

I ran into same issue on yesterday's linux-next. Also, I added some logs
and it seems the CPU isn't marked as active in time. The stack trace is
poped up under the circumstance: CPU#80 is online, but not active yet.

======> cpuhp_thread_fun: CPU=80
cpuhp_thread_fun: state=10 target=45
cpuhp_ap_online: CPU=80, state=10 target=45
smpboot_unpark_threads: CPU=80
notify_online: CPU=80                        <<<< CPU#80 isn't active yet.
------------[ cut here ]------------
WARNING: CPU: 80 PID: 408 at kernel/sched/core.c:1166 __set_cpus_allowed_ptr+0x22c/0x290
Modules linked in:
CPU: 80 PID: 408 Comm: cpuhp/80 Not tainted 4.6.0-next-20160517-gavin-00020-g176bf86-dirty #35
task: c000001e5243de00 ti: c000001ffc10c000 task.ti: c000001ffc10c000
NIP: c0000000000d923c LR: c0000000000d9224 CTR: 0000000000000000
REGS: c000001ffc10f730 TRAP: 0700   Not tainted  (4.6.0-next-20160517-gavin-00020-g176bf86-dirty)
MSR: 9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 28002044  XER: 20000000
CFAR: c00000000047135c SOFTE: 0 
GPR00: c0000000000d9138 c000001ffc10f9b0 c000000001321300 0000000000000000 
GPR04: c00000000135aa18 0000000000000400 0000000000000010 0000000000000000 
GPR08: 0000000000000000 0000000000000050 c00000000135aa90 0000000000000000 
GPR12: 0000000000002200 c00000000ff14000 c000000ffa60c5d0 c000000001292800 
GPR16: 0000000000000001 c0000000012780a8 c00000000139b678 0000000000010000 
GPR20: c000001e523b0000 c000000001278048 0000000000000008 c0000000012cfa8e 
GPR24: c0000000012780c8 c000001ffc10fa40 c000000001278048 c00000000135a898 
GPR28: c000000ff133ff08 c000000ff9c0c780 c000001e52400000 0000000000000000 
NIP [c0000000000d923c] __set_cpus_allowed_ptr+0x22c/0x290
LR [c0000000000d9224] __set_cpus_allowed_ptr+0x214/0x290
Call Trace:
[c000001ffc10f9b0] [c0000000000d9138] __set_cpus_allowed_ptr+0x128/0x290 (unreliable)
[c000001ffc10fa20] [c0000000000c65e0] workqueue_cpu_up_callback+0x460/0x5d0
[c000001ffc10faf0] [c0000000000cee6c] notifier_call_chain+0xac/0x110
[c000001ffc10fb40] [c00000000009fc64] __cpu_notify+0x54/0xa0
[c000001ffc10fb60] [c00000000009fd9c] notify_online+0x4c/0x70
[c000001ffc10fbd0] [c00000000009f5b4] cpuhp_up_callbacks+0x74/0x1a0
[c000001ffc10fc20] [c0000000000a0100] cpuhp_thread_fun+0x1e0/0x2a0
[c000001ffc10fcc0] [c0000000000d2ac0] smpboot_thread_fn+0x290/0x2a0
[c000001ffc10fd20] [c0000000000cd578] kthread+0x108/0x130
[c000001ffc10fe30] [c000000000009578] ret_from_kernel_thread+0x5c/0x64
Instruction dump:
419eff38 3c820004 38849718 7f83e378 38a00400 483980f1 60000000 2fa30000 
409eff18 813e0254 2f890001 419eff0c <0fe00000> 4bffff04 80810038 387d0018 
---[ end trace 5cf6676167cdd41c ]---
sched_cpu_activate: CPU=80      <<<<< CPU#80 is marked as active

Thanks,
Gavin
