Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHpZv3xTtzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:45:11 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7M9dLNc009475
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 05:45:07 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24y8r8md8a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 05:45:07 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 10:45:05 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 76D1A17D8067
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 10:46:48 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7M9j3IB25166182
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 09:45:03 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7M9j2Qa030663
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 03:45:03 -0600
Subject: Re: TM Bad Thing exception easily raised from userspace
To: Cyril Bur <cyrilbur@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <fb29f778-75c5-088c-fe40-e03d95b901e0@linux.vnet.ibm.com>
 <1471839520.18408.0.camel@gmail.com>
Cc: Simon Guo <wei.guo.simon@gmail.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 22 Aug 2016 11:45:02 +0200
MIME-Version: 1.0
In-Reply-To: <1471839520.18408.0.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5a840aa4-c336-6dce-286b-4c338d871210@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/08/2016 06:18, Cyril Bur wrote:
> On Fri, 2016-08-19 at 19:21 +0200, Laurent Dufour wrote:
>> Hi,
>>
>> While working on the TM support for CRIU, I faced a TM Bad Thing
>> exception.
>>
>> Digging further, I found that it is *easy* to raised it from the user
>> space. I attached below a simple program which raise it all the time,
>> like this :
>>
>> [12045.221359] Kernel BUG at c000000000050a40 [verbose debug info
>> unavailable]
>> [12045.221470] Unexpected TM Bad Thing exception at c000000000050a40
>> (msr 0x201033)
>> [12045.221540] Oops: Unrecoverable exception, sig: 6 [#1]
>> [12045.221586] SMP NR_CPUS=2048 NUMA PowerNV
>> [12045.221634] Modules linked in: xt_CHECKSUM iptable_mangle
>> ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat
>> nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT
>> nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables
>> ip6table_filter ip6_tables iptable_filter ip_tables x_tables kvm_hv
>> kvm
>> uio_pdrv_genirq ipmi_powernv uio powernv_rng ipmi_msghandler autofs4
>> ses
>> enclosure scsi_transport_sas bnx2x ipr mdio libcrc32c
>> [12045.222167] CPU: 68 PID: 6178 Comm: sigreturnpanic Not tainted
>> 4.7.0 #34
>> [12045.222224] task: c0000000fce38600 ti: c0000000fceb4000 task.ti:
>> c0000000fceb4000
>> [12045.222293] NIP: c000000000050a40 LR: c0000000000163bc CTR:
>> 0000000000000000
>> [12045.222361] REGS: c0000000fceb7ac0 TRAP: 0700   Not
>> tainted  (4.7.0)
>> [12045.222418] MSR: 9000000300201033
>> <SF,HV,ME,IR,DR,RI,LE,TM[SE]>  CR:
>> 28444280  XER: 20000000
>> [12045.222625] CFAR: c0000000000163b8 SOFTE: 0
>> PACATMSCRATCH: 900000014280f033
>> GPR00: 01100000b8000001 c0000000fceb7d40 c00000000139c100
>> c0000000fce390d0
>> GPR04: 900000034280f033 0000000000000000 0000000000000000
>> 0000000000000000
>> GPR08: 0000000000000000 b000000000001033 0000000000000001
>> 0000000000000000
>> GPR12: 0000000000000000 c000000002926400 0000000000000000
>> 0000000000000000
>> GPR16: 0000000000000000 0000000000000000 0000000000000000
>> 0000000000000000
>> GPR20: 0000000000000000 0000000000000000 0000000000000000
>> 0000000000000000
>> GPR24: 0000000000000000 00003ffff98cadd0 00003ffff98cb470
>> 0000000000000000
>> GPR28: 900000034280f033 c0000000fceb7ea0 0000000000000001
>> c0000000fce390d0
>> [12045.223535] NIP [c000000000050a40] tm_restore_sprs+0xc/0x1c
>> [12045.223584] LR [c0000000000163bc] tm_recheckpoint+0x5c/0xa0
>> [12045.223630] Call Trace:
>> [12045.223655] [c0000000fceb7d80] [c000000000026e74]
>> sys_rt_sigreturn+0x494/0x6c0
>> [12045.223738] [c0000000fceb7e30] [c0000000000092e0]
>> system_call+0x38/0x108
>> [12045.223806] Instruction dump:
>> [12045.223841] 7c800164 4e800020 7c0022a6 f80304a8 7c0222a6 f80304b0
>> 7c0122a6 f80304b8
>> [12045.223955] 4e800020 e80304a8 7c0023a6 e80304b0 <7c0223a6>
>> e80304b8
>> 7c0123a6 4e800020
>> [12045.224074] ---[ end trace cb8002ee240bae76 ]---
>>
>> The exception is raised when the kernel is restoring the TM SPRS from
>> the signal stack. But this operation is not allowed while in a
>> transaction.
>>
>> The sampler test is ending the signal handler with a pending
>> transaction
>> while the signal got caught during a transaction itself.
>>
>> I can't see any straight way to get rid of that, except by clearing
>> the
>> transactional state in the path of sigreturn....
>>
> 
> This is correct - I have a patch.
> 
>> Please advise.
>>
> 
> I'm happy to do it if you don't have time (I pretty much already have
> for my testing), do you want to send your test case in as a
> selftest/powerpc? It is good to have these to guard against regressions
> as these kinds of pathes aren't often exercised.

Thanks, just saw your patch which sounds good.

I'll provide the test case in selftest/powerpc case asap.
