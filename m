Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQQln1R9CzDqmt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 18:17:08 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9U7EwXx021634
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 03:17:06 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dwx7akjd8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 03:17:05 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 30 Oct 2017 01:17:05 -0600
Subject: [mainline][ppc] sysfs: cannot create duplicate filename
 '/devices/hv_24x7/events/PM_CAPP1_APC_UOP_SEND_PB_CMD'
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mpe <mpe@ellerman.id.au>,
 bauerman@linux.vnet.ibm.com, sachinp <sachinp@linux.vnet.ibm.com>,
 praveen@linux.vnet.ibm.com
Date: Mon, 30 Oct 2017 12:46:59 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1509347819.10521.11.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

A warning is being triggered while booting mainline kernel on ppc
machine.

Machine Type: Power 9
Kernel : 4.14.0-rc6
gcc: 4.8.5
Test : Boot

Boot logs:
----------
hv-24x7: found a duplicate event PM_CAPP1_XPT_MSG_SENT_GT_16_LE_64, ct=1
hv-24x7: found a duplicate event
PM_CAPP1_XPT_MSG_SENT_TSIZE_GT_64_LE_128, ct=1
hv-24x7: read 1463 catalog entries, created 470 event attrs (0
failures), 253 descs
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1509236850.410:1): state=initialized
audit_enabled=0 res=1
Kprobe smoke test: started
Kprobe smoke test: passed successfully
sysfs: cannot create duplicate filename '/devices/hv_24x7/events/PM_CAPP1_APC_UOP_SEND_PB_CMD'
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x80/0xb0
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/1 Not tainted 4.14.0-rc6-autotest-autotest #1
task: c0000000fe9c0000 task.stack: c0000000fea00000
NIP:  c0000000003f89c0 LR: c0000000003f89bc CTR: 000000000073c874
REGS: c0000000fea03610 TRAP: 0700   Not tainted  (4.14.0-rc6-autotest-autotest)
MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 22022022  XER: 0000000f 
CFAR: c0000000001692e8 SOFTE: 1 
GPR00: c0000000003f89bc c0000000fea03890 c0000000010c5900 000000000000005e 
GPR04: 0000000000000000 0000000000000080 000181207e2b5b77 00000000000000a2 
GPR08: 0000000000000000 c00000000103d410 c00000000103d410 0000000000000000 
GPR12: 0000000000002000 c00000000fac0a80 c00000000000d168 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: 0000000000000000 ffffffffffffee4b c0000000f0e0d590 c0000000f0df1c10 
GPR28: c000000000f77090 c0000000f0e0d590 c0000000fe039c80 c0000000fe184000 
NIP [c0000000003f89c0] sysfs_warn_dup+0x80/0xb0
LR [c0000000003f89bc] sysfs_warn_dup+0x7c/0xb0
Call Trace:
[c0000000fea03890] [c0000000003f89bc] sysfs_warn_dup+0x7c/0xb0 (unreliable)
[c0000000fea03910] [c0000000003f85b8] sysfs_add_file_mode_ns+0x1f8/0x210
[c0000000fea03990] [c0000000003f998c] internal_create_group+0x12c/0x3a0
[c0000000fea03a30] [c0000000003f9e10] sysfs_create_groups+0x70/0x120
[c0000000fea03a70] [c0000000005fcaa0] device_add+0x3f0/0x760
[c0000000fea03b30] [c000000000246c48] pmu_dev_alloc+0xb8/0x140
[c0000000fea03bb0] [c000000000c9380c] perf_event_sysfs_init+0x90/0xf4
[c0000000fea03c40] [c00000000000cf00] do_one_initcall+0x60/0x1c0
[c0000000fea03d00] [c000000000c6441c] kernel_init_freeable+0x278/0x358
[c0000000fea03dc0] [c00000000000d184] kernel_init+0x24/0x140
[c0000000fea03e30] [c00000000000b4e8] ret_from_kernel_thread+0x5c/0x74
Instruction dump:
7fa3eb78 38800000 7fe5fb78 38c01000 4bffa529 60000000 3c62ffad 7fe4fb78 
38630e38 7fc5f378 4bd708f1 60000000 <0fe00000> 7fe3fb78 4bf0b1e1 60000000 
---[ end trace 537ba3bf9fbd1b58 ]---
Failed to register pmu: hv_24x7, reason -17
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at kernel/events/core.c:11238 perf_event_sysfs_init+0xa8/0xf4
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/1 Tainted: G        W       4.14.0-rc6-autotest-autotest #1
task: c0000000fe9c0000 task.stack: c0000000fea00000
NIP:  c000000000c93824 LR: c000000000c93820 CTR: 000000000073c874
REGS: c0000000fea03930 TRAP: 0700   Tainted: G        W        (4.14.0-rc6-autotest-autotest)
MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 22000022  XER: 0000000c 
CFAR: c0000000001692e8 SOFTE: 1 
GPR00: c000000000c93820 c0000000fea03bb0 c0000000010c5900 000000000000002b 
GPR04: 0000000000000000 0000000000000080 000181207e2ff5a3 00000000000000a3 
GPR08: 0000000000000000 c00000000103d410 c00000000103d410 0000000000000000 
GPR12: 0000000000000000 c00000000fac0a80 c00000000000d168 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: 0000000000000000 c000000000c637ac c000000000c4d280 c000000000b83e00 
GPR28: 0000000000000000 c000000000f8f8c8 c000000000f8f8e8 c000000000f77108 
NIP [c000000000c93824] perf_event_sysfs_init+0xa8/0xf4
LR [c000000000c93820] perf_event_sysfs_init+0xa4/0xf4
Call Trace:
[c0000000fea03bb0] [c000000000c93820] perf_event_sysfs_init+0xa4/0xf4 (unreliable)
[c0000000fea03c40] [c00000000000cf00] do_one_initcall+0x60/0x1c0
[c0000000fea03d00] [c000000000c6441c] kernel_init_freeable+0x278/0x358
[c0000000fea03dc0] [c00000000000d184] kernel_init+0x24/0x140
[c0000000fea03e30] [c00000000000b4e8] ret_from_kernel_thread+0x5c/0x74
Instruction dump:
2fa90000 419e0030 813f0030 2f890000 419c0024 4b5b3391 7c651b79 41e20018 
e89f0028 7f63db78 4b4d5a8d 60000000 <0fe00000> ebff0000 4bffffb8 39200001 
---[ end trace 537ba3bf9fbd1b59 ]---
Initialise system trusted keyrings 


A similar issue was reported on 4.11.0
https://lkml.org/lkml/2017/3/7/763


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
