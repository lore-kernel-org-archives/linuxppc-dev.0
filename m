Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sG8sF23tMzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Aug 2016 03:21:53 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7JHIMdF110968
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 13:21:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24wuva4f3k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 13:21:50 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 18:21:48 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 235F017D8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 18:23:30 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7JHLkMs32964750
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 17:21:46 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7JHLjYm026217
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 11:21:46 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: TM Bad Thing exception easily raised from userspace
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Simon Guo <wei.guo.simon@gmail.com>
Date: Fri, 19 Aug 2016 19:21:44 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------66A97C81F37D203F63E60D35"
Message-Id: <fb29f778-75c5-088c-fe40-e03d95b901e0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------66A97C81F37D203F63E60D35
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

While working on the TM support for CRIU, I faced a TM Bad Thing exception.

Digging further, I found that it is *easy* to raised it from the user
space. I attached below a simple program which raise it all the time,
like this :

[12045.221359] Kernel BUG at c000000000050a40 [verbose debug info
unavailable]
[12045.221470] Unexpected TM Bad Thing exception at c000000000050a40
(msr 0x201033)
[12045.221540] Oops: Unrecoverable exception, sig: 6 [#1]
[12045.221586] SMP NR_CPUS=2048 NUMA PowerNV
[12045.221634] Modules linked in: xt_CHECKSUM iptable_mangle
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat
nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT
nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter ip_tables x_tables kvm_hv kvm
uio_pdrv_genirq ipmi_powernv uio powernv_rng ipmi_msghandler autofs4 ses
enclosure scsi_transport_sas bnx2x ipr mdio libcrc32c
[12045.222167] CPU: 68 PID: 6178 Comm: sigreturnpanic Not tainted 4.7.0 #34
[12045.222224] task: c0000000fce38600 ti: c0000000fceb4000 task.ti:
c0000000fceb4000
[12045.222293] NIP: c000000000050a40 LR: c0000000000163bc CTR:
0000000000000000
[12045.222361] REGS: c0000000fceb7ac0 TRAP: 0700   Not tainted  (4.7.0)
[12045.222418] MSR: 9000000300201033 <SF,HV,ME,IR,DR,RI,LE,TM[SE]>  CR:
28444280  XER: 20000000
[12045.222625] CFAR: c0000000000163b8 SOFTE: 0
PACATMSCRATCH: 900000014280f033
GPR00: 01100000b8000001 c0000000fceb7d40 c00000000139c100 c0000000fce390d0
GPR04: 900000034280f033 0000000000000000 0000000000000000 0000000000000000
GPR08: 0000000000000000 b000000000001033 0000000000000001 0000000000000000
GPR12: 0000000000000000 c000000002926400 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR24: 0000000000000000 00003ffff98cadd0 00003ffff98cb470 0000000000000000
GPR28: 900000034280f033 c0000000fceb7ea0 0000000000000001 c0000000fce390d0
[12045.223535] NIP [c000000000050a40] tm_restore_sprs+0xc/0x1c
[12045.223584] LR [c0000000000163bc] tm_recheckpoint+0x5c/0xa0
[12045.223630] Call Trace:
[12045.223655] [c0000000fceb7d80] [c000000000026e74]
sys_rt_sigreturn+0x494/0x6c0
[12045.223738] [c0000000fceb7e30] [c0000000000092e0] system_call+0x38/0x108
[12045.223806] Instruction dump:
[12045.223841] 7c800164 4e800020 7c0022a6 f80304a8 7c0222a6 f80304b0
7c0122a6 f80304b8
[12045.223955] 4e800020 e80304a8 7c0023a6 e80304b0 <7c0223a6> e80304b8
7c0123a6 4e800020
[12045.224074] ---[ end trace cb8002ee240bae76 ]---

The exception is raised when the kernel is restoring the TM SPRS from
the signal stack. But this operation is not allowed while in a transaction.

The sampler test is ending the signal handler with a pending transaction
while the signal got caught during a transaction itself.

I can't see any straight way to get rid of that, except by clearing the
transactional state in the path of sigreturn....

Please advise.

Cheers,
Laurent.

--------------66A97C81F37D203F63E60D35
Content-Type: text/x-csrc;
 name="sigreturnpanic.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sigreturnpanic.c"

/*
 * !!! WARNING THIS TEST MAY PANIC YOUR PPC64 SYSTEM !!!! 
 *
 * This sampler raises a kernel BUG in the sigreturn path when called with 
 * TM suspended state:

[12045.221359] Kernel BUG at c000000000050a40 [verbose debug info unavailable]
[12045.221470] Unexpected TM Bad Thing exception at c000000000050a40 (msr 0x201033)
[12045.221540] Oops: Unrecoverable exception, sig: 6 [#1]
[12045.221586] SMP NR_CPUS=2048 NUMA PowerNV
[12045.221634] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables kvm_hv kvm uio_pdrv_genirq ipmi_powernv uio powernv_rng ipmi_msghandler autofs4 ses enclosure scsi_transport_sas bnx2x ipr mdio libcrc32c
[12045.222167] CPU: 68 PID: 6178 Comm: sigreturnpanic Not tainted 4.7.0 #34
[12045.222224] task: c0000000fce38600 ti: c0000000fceb4000 task.ti: c0000000fceb4000
[12045.222293] NIP: c000000000050a40 LR: c0000000000163bc CTR: 0000000000000000
[12045.222361] REGS: c0000000fceb7ac0 TRAP: 0700   Not tainted  (4.7.0)
[12045.222418] MSR: 9000000300201033 <SF,HV,ME,IR,DR,RI,LE,TM[SE]>  CR: 28444280  XER: 20000000
[12045.222625] CFAR: c0000000000163b8 SOFTE: 0 
PACATMSCRATCH: 900000014280f033 
GPR00: 01100000b8000001 c0000000fceb7d40 c00000000139c100 c0000000fce390d0 
GPR04: 900000034280f033 0000000000000000 0000000000000000 0000000000000000 
GPR08: 0000000000000000 b000000000001033 0000000000000001 0000000000000000 
GPR12: 0000000000000000 c000000002926400 0000000000000000 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR24: 0000000000000000 00003ffff98cadd0 00003ffff98cb470 0000000000000000 
GPR28: 900000034280f033 c0000000fceb7ea0 0000000000000001 c0000000fce390d0 
[12045.223535] NIP [c000000000050a40] tm_restore_sprs+0xc/0x1c
[12045.223584] LR [c0000000000163bc] tm_recheckpoint+0x5c/0xa0
[12045.223630] Call Trace:
[12045.223655] [c0000000fceb7d80] [c000000000026e74] sys_rt_sigreturn+0x494/0x6c0
[12045.223738] [c0000000fceb7e30] [c0000000000092e0] system_call+0x38/0x108
[12045.223806] Instruction dump:
[12045.223841] 7c800164 4e800020 7c0022a6 f80304a8 7c0222a6 f80304b0 7c0122a6 f80304b8 
[12045.223955] 4e800020 e80304a8 7c0023a6 e80304b0 <7c0223a6> e80304b8 7c0123a6 4e800020 
[12045.224074] ---[ end trace cb8002ee240bae76 ]---

 *
 */

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <signal.h>


void handler(int sig)
{
    uint64_t ret;
    
    printf("Entering the signal handler\n");
    
    asm __volatile__(
	"li		3,1		;"
	"tbegin.			;"
	"beq		1f		;"
	"li		3,0		;"
	"tsuspend.			;"
	"1:				;"
	"std		3, %[ret]	;"
	: [ret]"=m"(ret)
	:
	: "memory", "3");

    if (ret) {
	printf("ERROR tbegin failed\n");
	exit(1);
    }
    
    /* 
     * We return from the signal handle while in a suspended transaction
     */
}

int main(void)
{
    struct sigaction sa;
    int ret;

    setbuf(stdout, NULL);
    
    memset(&sa, 0, sizeof(sa));

    sa.sa_handler = handler;
    sigemptyset(&sa.sa_mask);

    if (sigaction(SIGSEGV, &sa, NULL)) {
	perror("sigaction");
	exit(1);
    }

    /* 
     * Raising the signal while in a TM transaction.
     * Note that we can't call a system call otherwise the transaction is 
     * aborted.
     */
    asm __volatile__(
	"tbegin.			;"
	"beq		1f		;"
	"li		3,0		;"
	"std		3,0(3)		;" /* Oups ! */
	"1:				;"
	"tend.				;"
	);

    printf("We should not get there !\n");
    exit(1);
}

--------------66A97C81F37D203F63E60D35--
