Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhkVL6FXbzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 03:54:18 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2DGrv2w078486
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 12:54:09 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 294c8xf5bb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 12:54:09 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 13 Mar 2017 22:24:02 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2DGs1m816384028
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 22:24:01 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2DGs0K5025839
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 22:24:01 +0530
Subject: Re: [BUG] [PowerPC] Kernel Oops when booting Linux mainline
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: sachinp@linux.vnet.ibm.com, Stephen Rothwell <sfr@canb.auug.org.au>, ego
 <ego@linux.vnet.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 "aneesh.kumar" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 13 Mar 2017 22:23:55 +0530
In-Reply-To: <1489396715.19698.24.camel@abdul>
References: <1489396715.19698.24.camel@abdul>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1489424035.19698.29.camel@abdul>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-13 at 14:48 +0530, Abdul Haleem wrote:
> Hi,
> 
> Mainline boot is broken on PowerPC bare metal with below traces:
> Machine Type : Power 8 Bare metal
> 
> [  OK  ] Mounted Debug File System.
> [  OK  ] Started Nameserver information manager.
> [  OK  ] Started LVM2 metadata daemon.
> Unable to handle kernel paging request for data at address 0x300000079
> Faulting instruction address: 0xc000000000811cac
> Oops: Kernel access of bad area, sig: 11 [#1]
> Unable to handle kernel paging request for instruction fetch
> Unable to handle kernel paging request for data at address 0xc000007c77881e28
> Faulting instruction address: 0xc000003c7acd7b80
> Faulting instruction address: 0xc00000000029fd88
> Thread overran stack, or stack corrupted
> SMP NR_CPUS=2048 
> NUMA 
> PowerNV
> Modules linked in: ip_table�KK~<(E) x_tables�\8|<(E) autofs4(E) raid10 raid456 async_raid6_recov 
> async_memcpy async_pq async_xor async_tx xor raid6_pq multipath bnx2x(E) mdio(E) libcrc32�^B�w<(E)
> CPU: 21 PID: 137 Comm: kworker/21:0 Not tainted 4.11.0-rc1-00335-g56b24d1-dirty #1
> Workqueue: events dbs_work_handler
> task: c000003c8e86b380 task.stack: c000003c8eae0000
> NIP: c000000000811cac LR: c000000000813014 CTR: c000000000811c50
> REGS: c000003c8eae3980 TRAP: 0300   Not tainted  (4.11.0-rc1-00335-g56b24d1-dirty)
> MSR: 900000010280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
>   CR: 24002422  XER: 00000000  
> CFAR: c000000000008860 DAR: 0000000300000079 DSISR: 40000000 SOFTE: 1 
> GPR00: c000000000813014 c000003c8eae3c00 c000000001019800 c000003c780d0800 
> GPR04: 0000000000000540 0000000000000000 0000000000000000 c000003c8e86b380 
> GPR08: 0000000000000000 000000000000003c 000000000000003c 0000000000008397 
> GPR12: c000000000811c50 c00000000fe05400 c0000000000f2e08 c000003ffb073d80 
> GPR16: c000003ffc564328 c000003ffc5640f8 c000003ffc5640a0 0000000000000001 
> GPR20: 0000000000000000 0000000000000000 c000000000f50bc0 fffffffffffffef7 
> GPR24: 0000000000000000 c000003ffc564400 0000000000000000 0000000300000001 
> GPR28: c000003c780d0b60 0000000300000001 c000003c780d0800 c000003c780d0b60 
> NIP [c000000000811cac] od_dbs_update+0x5c/0x260
> LR [c000000000813014] dbs_work_handler+0x54/0xa0
> Call Trace:
> [c000003c8eae3c00] [c000003ffc564880] 0xc000003ffc564880 (unreliable)
> [c000003c8eae3c50] [c000000000813014] dbs_work_handler+0x54/0xa0
> [c000003c8eae3c90] [c0000000000ea600] process_one_work+0x2a0/0x590
> [c000003c8eae3d20] [c0000000000ea998] worker_thread+0xa8/0x660
> [c000003c8eae3dc0] [c0000000000f2f4c] kthread+0x14c/0x190
> [c000003c8eae3e30] [c00000000000b4e8] ret_from_kernel_thread+0x5c/0x74
> Instruction dump:
> f821ffb1 ebe30340 813f00ac 895f00ac ebbf0078 71280001 5549003c 993f00ac 
> 40820164 eb9e0340 7fc3f378 eb7c0078 <eb5b0078> 48001539 60000000 39200000 
> ---[ end trace 587e7f5a13c0f2ad ]---
> 
> 
> Detailed logs and config is attached.
> 
> FYI, Good commit of last successful boot is : 
> 
> commit ea6200e84182989a3cce9687cf79a23ac44ec4db
> Merge: b4fb8f6 fc69910
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Mar 8 14:45:31 2017 -0800
> 
>     Merge branch 'core-urgent-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> 
> 

With this patch, ppc boots fine. Thanks for the fix

http://lkml.kernel.org/r/20170313052213.11411-1-kirill.shutemov@linux.intel.com

Tested-by : Abdul Haleem <abdhalee@linux.vnet.ibm.com>

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
