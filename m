Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHpfD2PZZzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:48:04 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7M9dLUS049909
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 05:48:01 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24ybqu8hb4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 05:48:01 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 10:47:59 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id E37A017D805F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 10:49:42 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7M9lv6O21102740
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 09:47:57 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7M8lx6e003891
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 02:47:59 -0600
Subject: Re: [PATCH] powerpc: signals: Discard transaction state from signal
 frames
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org
References: <20160822073206.1342-1-cyrilbur@gmail.com>
Cc: mpe@ellerman.id.au, mikey@neuling.org, Simon Guo <wei.guo.simon@gmail.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 22 Aug 2016 11:47:55 +0200
MIME-Version: 1.0
In-Reply-To: <20160822073206.1342-1-cyrilbur@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <724405b5-b28c-16e8-6187-9ae7396e5f95@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/08/2016 09:32, Cyril Bur wrote:
> Userspace can begin and suspend a transaction within the signal
> handler which means they might enter sys_rt_sigreturn() with the
> processor in suspended state.
> 
> sys_rt_sigreturn() wants to restore process context (which may have
> been in a transaction before signal delivery). To do this it must
> restore TM SPRS. To achieve this, any transaction initiated within the
> signal frame must be discarded in order to be able to restore TM SPRs
> as TM SPRs can only be manipulated non-transactionally..
> From the PowerPC ISA:
>   TM Bad Thing Exception [Category: Transactional Memory]
>    An attempt is made to execute a mtspr targeting a TM register in
>    other than Non-transactional state.
> 
> Not doing so results in a TM Bad Thing:
> [12045.221359] Kernel BUG at c000000000050a40 [verbose debug info unavailable]
> [12045.221470] Unexpected TM Bad Thing exception at c000000000050a40 (msr 0x201033)
> [12045.221540] Oops: Unrecoverable exception, sig: 6 [#1]
> [12045.221586] SMP NR_CPUS=2048 NUMA PowerNV
> [12045.221634] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE
>  nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4
>  xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter
>  ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables kvm_hv kvm
>  uio_pdrv_genirq ipmi_powernv uio powernv_rng ipmi_msghandler autofs4 ses enclosure
>  scsi_transport_sas bnx2x ipr mdio libcrc32c
> [12045.222167] CPU: 68 PID: 6178 Comm: sigreturnpanic Not tainted 4.7.0 #34
> [12045.222224] task: c0000000fce38600 ti: c0000000fceb4000 task.ti: c0000000fceb4000
> [12045.222293] NIP: c000000000050a40 LR: c0000000000163bc CTR: 0000000000000000
> [12045.222361] REGS: c0000000fceb7ac0 TRAP: 0700   Not tainted (4.7.0)
> [12045.222418] MSR: 9000000300201033 <SF,HV,ME,IR,DR,RI,LE,TM[SE]> CR: 28444280  XER: 20000000
> [12045.222625] CFAR: c0000000000163b8 SOFTE: 0 PACATMSCRATCH: 900000014280f033
> GPR00: 01100000b8000001 c0000000fceb7d40 c00000000139c100 c0000000fce390d0
> GPR04: 900000034280f033 0000000000000000 0000000000000000 0000000000000000
> GPR08: 0000000000000000 b000000000001033 0000000000000001 0000000000000000
> GPR12: 0000000000000000 c000000002926400 0000000000000000 0000000000000000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR24: 0000000000000000 00003ffff98cadd0 00003ffff98cb470 0000000000000000
> GPR28: 900000034280f033 c0000000fceb7ea0 0000000000000001 c0000000fce390d0
> [12045.223535] NIP [c000000000050a40] tm_restore_sprs+0xc/0x1c
> [12045.223584] LR [c0000000000163bc] tm_recheckpoint+0x5c/0xa0
> [12045.223630] Call Trace:
> [12045.223655] [c0000000fceb7d80] [c000000000026e74] sys_rt_sigreturn+0x494/0x6c0
> [12045.223738] [c0000000fceb7e30] [c0000000000092e0] system_call+0x38/0x108
> [12045.223806] Instruction dump:
> [12045.223841] 7c800164 4e800020 7c0022a6 f80304a8 7c0222a6 f80304b0 7c0122a6 f80304b8
> [12045.223955] 4e800020 e80304a8 7c0023a6 e80304b0 <7c0223a6> e80304b8 7c0123a6 4e800020
> [12045.224074] ---[ end trace cb8002ee240bae76 ]---
> 
> It isn't clear exactly if there is really a use case for userspace
> returning with a suspended transaction, however, doing so doesn't (on
> its own) constitute a bad frame. As such, this patch simply discards
> the transactional state of the context calling the sigreturn and
> continues.
>
> Reported-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
> V2: Move the code down into the #ifdef CONFIG_PPC_TRANSACTIONAL_MEM (32 and 64 bit)
> 	Add a small amount of text to Documentation
> 	Adjust the commit message for clarity 
> 

FWIW,
Tested-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
