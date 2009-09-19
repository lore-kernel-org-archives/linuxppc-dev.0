Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2FB82B7B79
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Sep 2009 18:54:21 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8J8peIb006500
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Sep 2009 18:51:40 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8J8sIor1163454
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Sep 2009 18:54:19 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8J8sINb031383
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Sep 2009 18:54:18 +1000
Message-ID: <4AB49C37.6020003@in.ibm.com>
Date: Sat, 19 Sep 2009 14:24:15 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>
	<1253185994.8375.352.camel@pasglop>
	<4AB25B61.9020609@kernel.org> <4AB266AF.9080705@in.ibm.com>
In-Reply-To: <4AB266AF.9080705@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sachin Sant wrote:
> Tejun Heo wrote:
>> Ah... sorry about that.  Sachin, is it possible for you to build the
>> kernel with debug info and ask gdb where the stalling NIP is in the c
>> file?
>>   
> <6>NET: Registered protocol family 10
> <3>BUG: soft lockup - CPU#2 stuck for 61s! [modprobe:1865]
> <4>Modules linked in: ipv6(+) fuse loop dm_mod sg sd_mod crc_t10dif 
> ibmvscsic scsi_transport_srp scsi_tgt scsi_mod
> <4>NIP: c00000000004198c LR: c00000000015dac8 CTR: 0000000000000040
> <4>REGS: c0000000fbdbb6f0 TRAP: 0901   Not tainted  (2.6.31-git5)
> <4>MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 44224420  XER: 20000001
> <4>TASK = c0000000fbd57840[1865] 'modprobe' THREAD: c0000000fbdb8000 
> CPU: 2
> <4>GPR00: 0000000000000040 c0000000fbdbb970 c000000000a96d08 
> d00007fffff00000
> <4>GPR04: 0000000000000000 0000000000000000 d00007fffff00000 
> d00007fffff00000
> <4>GPR08: 0000000000000000 c000000001020180 c000000000b6b4e8 
> 00000000000003c0
> <4>GPR12: 0000000048224428 c000000000b82a00
> <4>NIP [c00000000004198c] .memset+0x60/0xfc
> <4>LR [c00000000015dac8] .pcpu_alloc+0x758/0x960
> <4>Call Trace:
> <4>[c0000000fbdbb970] [c00000000015da58] .pcpu_alloc+0x6e8/0x960 
> (unreliable)
> <4>[c0000000fbdbba90] [c000000000565664] .snmp_mib_init+0x34/0x9c
> <4>[c0000000fbdbbb20] [d00000000212e130] .ipv6_add_dev+0x1cc/0x3dc [ipv6]
> <4>[c0000000fbdbbbc0] [d0000000021598ac] .addrconf_init+0x6c/0x194 [ipv6]
> <4>[c0000000fbdbbc50] [d00000000215967c] .inet6_init+0x1bc/0x34c [ipv6]
> <4>[c0000000fbdbbce0] [c0000000000097a4] .do_one_initcall+0x88/0x1bc
> <4>[c0000000fbdbbd90] [c0000000000c84dc] .SyS_init_module+0x11c/0x29c
> <4>[c0000000fbdbbe30] [c0000000000085b4] syscall_exit+0x0/0x40
> <4>Instruction dump:
> <4>98860000 38c60001 409e000c b0860000 38c60002 409d000c 90860000 
> 38c60004
> <4>78a0d183 78a506a0 7c0903a6 4182002c <f8860000> f8860008 f8860010 
> f8860018
Latest git (2.6.31-git9:78f28b7c555359c67c2a0d23f7436e915329421e)
still has this bug. 

Thanks
-Sachin

> 2:mon> r
> R00 = 0000000000000040   R07 = d00007fffff00000
> R01 = c0000000fbdbb970   R08 = 0000000000000000
> R02 = c000000000a96d08   R09 = c000000001020180
> R03 = d00007fffff00000   R10 = c000000000b6b4e8
> R04 = 0000000000000000   R11 = 00000000000003c0
> R05 = 0000000000000000   R12 = 0000000048224428
> R06 = d00007fffff00000   R13 = c000000000b82a00
> pc  = c00000000004198c .memset+0x60/0xfc
> lr  = c00000000015dac8 .pcpu_alloc+0x758/0x960
> msr = 8000000000009032   cr  = 44224420
> ctr = 0000000000000040   xer = 0000000020000001   trap =  501
> 2:mon>
>
> The corresponding c code is :
>
> pcpu_populate_chunk():
> /home/sachin/work/linux-2.6.31/mm/percpu.c:978
>
>        /* commit new bitmap */
>        bitmap_copy(chunk->populated, populated, pcpu_unit_pages);
> clear:
>        for_each_possible_cpu(cpu)
>                memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, 
> size);
>    1aa0:       e9 3f 00 38     ld      r9,56(r31)
>    1aa4:       7b a0 1f 24     rldicr  r0,r29,3,60
>    1aa8:       e8 7b 00 18     ld      r3,24(r27)
>    1aac:       38 80 00 00     li      r4,0
>    1ab0:       e8 a1 00 88     ld      r5,136(r1)
>    1ab4:       7c 09 00 2a     ldx     r0,r9,r0
>    1ab8:       7c 63 02 14     add     r3,r3,r0
>    1abc:       7c 63 b2 14     add     r3,r3,r22
>    1ac0:       48 00 00 01     bl      1ac0 <.pcpu_alloc+0x754>
>    1ac4:       60 00 00 00     nop
>
> Thanks
> -Sachin
>
>


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
