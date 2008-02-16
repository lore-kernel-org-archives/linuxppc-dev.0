Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 09BD7DDE38
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 17:10:47 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m1G6AgPi025317
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 11:40:42 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1G6AfOn688372
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 11:40:41 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id m1G6Afq0020893
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 06:10:41 GMT
Message-ID: <47B67E5E.4010001@linux.vnet.ibm.com>
Date: Sat, 16 Feb 2008 11:40:38 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] Linux 2.6.25-rc2 - Regression from 2.6.24-rc1-git1 softlockup
	while bootup on powerpc
References: <alpine.LFD.1.00.0802151302210.9496@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.00.0802151302210.9496@woody.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Dhaval Giani <dhaval@linux.vnet.ibm.com>,
	Jens Axboe <jens.axboe@oracle.com>,
	Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The softlockup is seen from 2.6.25-rc1-git{1,3} and is visible in the 2.6.24-rc2 kernel,
While booting up with the 2.6.25-rc1-git{1,3} and 2.6.25-rc2 kernel(s) on the powerbox

Loading st.ko module
BUG: soft lockup - CPU#1 stuck for 61s! [insmod:379]
NIP: c0000000001b0620 LR: c0000000001a5dcc CTR: 0000000000000040
REGS: c00000077caab8a0 TRAP: 0901   Not tainted  (2.6.25-rc2-autotest)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 84004088  XER: 20000000
TASK = c00000077cb450a0[379] 'insmod' THREAD: c00000077caa8000 CPU: 1
GPR00: c00000077c9d4000 c00000077caabb20 c000000000538a40 000000000000000b 
GPR04: ffc0000000000000 c00000077e0c0000 0000000000000036 000000000000000a 
GPR08: 0040000000000000 c00000077c9d4250 c000000000000000 0000000000000000 
GPR12: c00000077c9d4230 c000000000481d00 
NIP [c0000000001b0620] .radix_tree_gang_lookup+0x100/0x1e4
LR [c0000000001a5dcc] .call_for_each_cic+0x50/0x10c
Call Trace:
[c00000077caabb20] [c0000000001a5e2c] .call_for_each_cic+0xb0/0x10c (unreliable)
[c00000077caabc60] [c00000000019dba4] .exit_io_context+0xf0/0x110
[c00000077caabcf0] [c000000000061e38] .do_exit+0x820/0x850
[c00000077caabda0] [c000000000061f34] .do_group_exit+0xcc/0xe8
[c00000077caabe30] [c00000000000872c] syscall_exit+0x0/0x40
Instruction dump:
7d296214 39290018 e8090000 7caa2038 39290008 2fa00000 409e0018 7caa4215 
396b0001 418200cc 424000b8 4bffffdc <79691f24> 7d296214 e9690018 2fab0000 
INFO: task insmod:387 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
insmod        D 000000001000e144 12144   387      1
Call Trace:
[c00000077cb97600] [c0000000008fae80] 0xc0000000008fae80 (unreliable)
[c00000077cb977d0] [c000000000010c7c] .__switch_to+0x11c/0x154
[c00000077cb97860] [c000000000344498] .schedule+0x5d0/0x6b0
[c00000077cb97950] [c0000000003447d8] .schedule_timeout+0x3c/0xe8
[c00000077cb97a20] [c000000000343d34] .wait_for_common+0x150/0x22c
[c00000077cb97ae0] [c00000000008ef00] .__stop_machine_run+0xbc/0xf0
[c00000077cb97bb0] [c00000000008ef70] .stop_machine_run+0x3c/0x80
[c00000077cb97c50] [c0000000000891f0] .sys_init_module+0x14e4/0x1af4
[c00000077cb97e30] [c00000000000872c] syscall_exit+0x0/0x40
-- 0:conmux-control -- time-stamp -- Feb/15/08 16:04:12 --
INFO: task insmod:387 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
insmod        D 000000001000e144 12144   387      1
Call Trace:
[c00000077cb97600] [c0000000008fae80] 0xc0000000008fae80 (unreliable)
[c00000077cb977d0] [c000000000010c7c] .__switch_to+0x11c/0x154
[c00000077cb97860] [c000000000344498] .schedule+0x5d0/0x6b0
[c00000077cb97950] [c0000000003447d8] .schedule_timeout+0x3c/0xe8
[c00000077cb97a20] [c000000000343d34] .wait_for_common+0x150/0x22c
[c00000077cb97ae0] [c00000000008ef00] .__stop_machine_run+0xbc/0xf0
[c00000077cb97bb0] [c00000000008ef70] .stop_machine_run+0x3c/0x80
[c00000077cb97c50] [c0000000000891f0] .sys_init_module+0x14e4/0x1af4
[c00000077cb97e30] [c00000000000872c] syscall_exit+0x0/0x40
-- 0:conmux-control -- time-stamp -- Feb/15/08 16:06:21 --
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
