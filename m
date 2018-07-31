Return-Path: <srs0=hess=kp=linux.vnet.ibm.com=gromero@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fcsd1xJ8zF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 10:35:17 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41fcsd1TDXz8t83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 10:35:17 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41fcsc4tn4z9s3q
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2018 10:35:16 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6V0Y7DS146907
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2018 20:35:14 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kj7pkutuk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2018 20:35:14 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Mon, 30 Jul 2018 18:35:13 -0600
Subject: Re: [PATCH 2/3] selftests/powerpc: Only run some tests on ppc64le
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20180726122459.9293-1-mpe@ellerman.id.au>
 <20180726122459.9293-2-mpe@ellerman.id.au>
 <6f71e169-7d73-9128-5cff-72efcf734e7d@linux.vnet.ibm.com>
 <87pnz9z0n8.fsf@concordia.ellerman.id.au>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Date: Mon, 30 Jul 2018 21:35:06 -0300
MIME-Version: 1.0
In-Reply-To: <87pnz9z0n8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3285e3b0-e908-4261-45fb-af5a89730756@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 07/27/2018 02:51 AM, Michael Ellerman wrote:
> Gustavo Romero <gromero@linux.vnet.ibm.com> writes:
> 
>> Hi Michael,
>>
>> On 07/26/2018 09:24 AM, Michael Ellerman wrote:
>>> These tests are currently failing on (some) big endian systems. Until
>>> we can fix that, skip them unless we're on ppc64le.
>>
>> I can take a look at this.
> 
> Thanks!
> 
>> Is that the same issue related to the gcc version we discussed a month ago?
> 
> Maybe, I've forgotten :)
> 
>> If not, could you provide the crash logs as a starting point?
> 
> There's not much:
> 
>    test: tm_tar
>    tags: git_version:9794259
>    failure: tm_tar
>    run-parts: ./tm-tar exited with return code 1
>    
>    test: tm_vmxcopy
>    tags: git_version:9794259
>    !! child died by signal 11
>    failure: tm_vmxcopy
>    run-parts: ./tm-vmxcopy exited with return code 1
> 
> And now I can't get the sigreturn one to fail :/

OK. I _think_ there is a chance it's the same issue we've discussed.

Hence, just for the record (in case somebody else wants to take a look at it as
well), on the occasion we had the following log about tm-sigreturn, that
although is not listed above (only tm-tar and tm-vmxcopy are ), it's marked to
run only on LE as per this patch, just like tm-tar and tm-vmxcopy:

[  403.458953] Unexpected TM Bad Thing exception at c00000000006da4c (msr 0x201032)
13:59:41 console: [  403.459865] Oops: Unrecoverable exception, sig: 6 [#1]
13:59:41 console: [  403.460286] BE SMP NR_CPUS=32 NUMA pSeries
13:59:41 console: [  403.460611] Modules linked in:
13:59:41 console: [  403.460929] CPU: 2 PID: 25233 Comm: tm-sigreturn Not tainted 4.16.0-gcc6x-g709b973 #1
13:59:41 console: [  403.461530] NIP:  c00000000006da4c LR: c00000000001d6a4 CTR: 0000000000000000
13:59:41 console: [  403.461782] REGS: c00000003ffcbd80 TRAP: 0700   Not tainted  (4.16.0-gcc6x-g709b973)
13:59:41 console: [  403.461943] MSR:  8000000300201032 <SF,ME,IR,DR,RI,TM[SE]>  CR: 48004288  XER: 20000000
13:59:41 console: [  403.462112] CFAR: c00000000001d6a0 SOFTE: 3
13:59:41 console: [  403.462112] PACATMSCRATCH: 000000034280f032
13:59:41 console: [  403.462112] GPR00: d40000018c000001 c0000000f09bfc20 c00000000165bd00 c0000000fbd5c900
13:59:41 console: [  403.462112] GPR04: 8000000300009032 0000000000000000 0000000000000000 0000000000000000
13:59:41 console: [  403.462112] GPR08: 0000000000000000 0000000000000001 0000000000000001 0000000000000000
13:59:41 console: [  403.462112] GPR12: 0000000000000000 c00000003fffdf00 000000000000000f 000000001003a338
13:59:41 console: [  403.462112] GPR16: 0000000010002e5c 0000000010002e44 0000000010002d08 0000000010002e24
13:59:41 console: [  403.462112] GPR20: 0000000010002eac 0000000000000000 c0000000fbd5cdc8 c000000000df6578
13:59:41 console: [  403.462112] GPR24: 0000000000000000 bfffffffffffffff 00000000fffef394 00000000fffeee10
13:59:41 console: [  403.462112] GPR28: c0000000f09bfea0 000000000280d032 0000000000000000 c0000000fbd5c900
13:59:41 console: [  403.463642] NIP [c00000000006da4c] .tm_restore_sprs+0xc/0x1c
13:59:41 console: [  403.463782] LR [c00000000001d6a4] .tm_recheckpoint.part.7+0x54/0x90
13:59:41 console: [  403.463912] Call Trace:
13:59:41 console: [  403.464003] [c0000000f09bfc20] [c000000000312ae0] .__might_fault+0x70/0x90 (unreliable)
13:59:41 console: [  403.464165] [c0000000f09bfca0] [c00000000001b2b8] .restore_tm_user_regs.part.0+0x418/0x6c0
13:59:41 console: [  403.464326] [c0000000f09bfd70] [c00000000001c55c] .compat_sys_sigreturn+0x14c/0x490
13:59:41 console: [  403.464495] [c0000000f09bfe30] [c00000000000c070] system_call+0x58/0x6c
13:59:41 console: [  403.464624] Instruction dump:
13:59:41 console: [  403.464705] 7c800164 4e800020 7c0022a6 f80304b0 7c0222a6 f80304b8 7c0122a6 f80304c0
13:59:41 console: [  403.464868] 4e800020 e80304b0 7c0023a6 e80304b8 <7c0223a6> e80304c0 7c0123a6 4e800020
13:59:41 console: [  403.465030] ---[ end trace 0045efc572a679cf ]---

and some initial debugging by mpe using xmon:

Unexpected TM Bad Thing exception at c000000000069e6c (msr 0x201032)
cpu 0x6: Vector: 700 (Program Check) at [c00000003ff9bd80]
     pc: c000000000069e6c: .tm_restore_sprs+0xc/0x1c
     lr: c00000000001e2a4: .tm_recheckpoint.part.11+0x64/0xf0
     sp: c0000000f2a2bc30
    msr: 8000000300201032
   current = 0xc0000000fa68b000
   paca    = 0xc00000003fff8f00     softe: 3     irq_happened: 0x01
     pid   = 3879, comm = tm-sigreturn
Linux version 4.17.0-rc1-gcc-7.0.1-00005-g56376c5864f8 (michael@ka3.ozlabs.ibm.com) (gcc version 7.0.1 20170213 (experimental) (Custom 8e8a14c238db56c7)) #172 SMP Thu Apr 19 21:48:31 AEST 2018
enter ? for help
[link register   ] c00000000001e2a4 .tm_recheckpoint.part.11+0x64/0xf0
[c0000000f2a2bc30] c0000000f2a2bcb0 (unreliable)
[c0000000f2a2bcb0] c00000000001c30c .restore_tm_user_regs.part.0+0x55c/0x610
[c0000000f2a2bd70] c00000000001d400 .compat_sys_sigreturn+0x130/0x410
[c0000000f2a2be30] c00000000000c268 system_call+0x58/0x6c
--- Exception: 300 (Data Access) at 00000000100009c8
SP (ffd75e90) is in userspace
6:mon> di %pc
c000000000069e6c  7c0223a6    mtspr   130,r0
c000000000069e70  e80304c0    ld      r0,1216(r3)
c000000000069e74  7c0123a6    mtspr   129,r0
c000000000069e78  4e800020    blr
c000000000069e7c  7c03071d    tabort. r3
c000000000069e80  4e800020    blr
c000000000069e84  7ca00026    mfcr    r5
c000000000069e88  7c0802a6    mflr    r0
c000000000069e8c  90a10008    stw     r5,8(r1)
c000000000069e90  f8010010    std     r0,16(r1)
c000000000069e94  f8410028    std     r2,40(r1)
c000000000069e98  f821fe21    stdu    r1,-480(r1)
c000000000069e9c  f8610030    std     r3,48(r1)
c000000000069ea0  f9c100e0    std     r14,224(r1)
c000000000069ea4  f9e100e8    std     r15,232(r1)
c000000000069ea8  fa0100f0    std     r16,240(r1)


Best regards,
Gustavo
