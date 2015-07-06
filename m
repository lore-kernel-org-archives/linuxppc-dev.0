Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D00F1A0452
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 14:33:13 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 6 Jul 2015 14:33:12 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4EB9E2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 14:33:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t664Wxun49414384
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 14:33:09 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t664WZ94016846
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 14:32:35 +1000
Message-ID: <559A04CE.5010904@linux.vnet.ibm.com>
Date: Mon, 06 Jul 2015 10:02:14 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
CC: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc/powernv: Fix race in updating core_idle_state
References: <20150706040324.E78D2140DC0@ozlabs.org>
In-Reply-To: <20150706040324.E78D2140DC0@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> 
> What are the symptoms of this bug?
> 
In the cases where we hit this race and the core enters fastsleep, 
code mistakes an idle thread as running. Because of this, the first
thread waking up from fastsleep which is supposed to resync timebase
 skips it. So we can end up having a core with stale timebase value.

We suspect this is causing soft lockups with call stacks similar to this-

[126529.208714] NMI watchdog: BUG: soft lockup - CPU#8 stuck for 22s! [opal_errd:7722]
[126529.208849] CPU: 8 PID: 7722 Comm: opal_errd
[126529.208853] task: c00000bf67803a80 ti: c00000bf6788c000 task.ti: c00000bf6788c000
[126529.208856] NIP: c00000000015a180 LR: c00000000015a0d0 CTR: c00000000001ed70
[126529.208859] REGS: c00000bf6788faa0 TRAP: 0901   Not tainted  (3.18.13-336.el7_1.pkvm3_1_0.2000.1.ppc64le)
[126529.208860] MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24004824  XER: 20000000
[126529.208871] CFAR: c00000000015a194 SOFTE: 1 
GPR00: c0000000002db9e8 c00000bf6788fd20 c0000000012b1800 00003af5b88f569e 
GPR04: 0000000000d3dbb8 00003af5c236ca0b ffffffffffffffff 000000000001ee28 
GPR08: 000000003b9ac9ff 5bfc723fba82c8f9 00000000c06f2b88 c0000000009908c8 
GPR12: c00000000001ed70 c000000007da4c00 
[126529.208896] NIP [c00000000015a180] ktime_get_ts64+0x130/0x1f0
[126529.208899] LR [c00000000015a0d0] ktime_get_ts64+0x80/0x1f0
[126529.208902] Call Trace:
[126529.208909] [c00000bf6788fd20] [c00000000019c0e4] __audit_syscall_exit+0x214/0x2e0 (unreliable)
[126529.208916] [c00000bf6788fda0] [c0000000002db9e8] poll_select_set_timeout+0x98/0xe0
[126529.208919] [c00000bf6788fde0] [c0000000002dcf7c] SyS_poll+0x8c/0x160
[126529.208925] [c00000bf6788fe30] [c000000000009358] syscall_exit+0x0/0x98
[126529.208927] Instruction dump:
[126529.208930] 7d29ea14 6108c9ff 39400000 7fa94040 409d0038 4800001c 60000000 60000000 
[126529.208936] 60000000 60000000 60000000 60420000 <3d29c465> 394a0001 39293600 794a0020 

> I assume they're not good. In which case this should go to stable, shouldn't
> it? If so which versions?
> 
Yes this should go into stable. 3.19+

> And which commit introduced the bug?
> 
77b54e9f213f76a powernv/powerpc: Add winkle support for offline cpus


Thanks,
Shreyas
