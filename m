Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1C8F6B7043
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 23:23:14 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8ODFabj019916
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 23:15:36 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8ODNCuR537060
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 23:23:12 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8ODNCOO014787
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 23:23:12 +1000
Message-ID: <4ABB72BD.9050905@in.ibm.com>
Date: Thu, 24 Sep 2009 18:53:09 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: 2.6.31-git5 kernel boot hangs on powerpc
References: <4AB0D947.8010301@in.ibm.com> <4AB214C3.4040109@in.ibm.com>
	<1253185994.8375.352.camel@pasglop>	<4AB25B61.9020609@kernel.org>
	<4AB266AF.9080705@in.ibm.com> <4AB49C37.6020003@in.ibm.com>
	<4AB9DAEC.3060309@in.ibm.com> <4AB9DD8F.1040305@kernel.org>
	<4ABA2DE2.6000601@kernel.org> <4ABB269F.6020309@in.ibm.com>
	<4ABB6D33.6060706@kernel.org>
In-Reply-To: <4ABB6D33.6060706@kernel.org>
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

Tejun Heo wrote:
> Sachin Sant wrote:
>   
>> Tejun Heo wrote:
>>     
>>> Can you please apply the attached patch and see whether anything
>>> interesting shows up in the kernel log?
>>>   
>>>       
>> Thanks Tejun for the debug patch. Attached here are the relevant logs.
>> The only messages related to percpu in the logs are
>>
>> <6>PERCPU: Embedded 2 pages/cpu @c000000001200000 s100232 r0 d30840 u524288
>> <7>pcpu-alloc: s100232 r0 d30840 u524288 alloc=1*1048576
>> <7>pcpu-alloc: [0] 0 1
>> The captured logs are with latest git.
>>     
>
> Hmm... that means it wasn't caused by rogue percpu pointer access.
> Pleast wait a bit.  I'll try to reproduce it.
>   
I was able to reproduce the hang in a different way. (I still had
IPV6 disabled in my config). I executed the network namespace container
tests from LTP and could reproduce a similar hang. The top three
function calls were the same as with IPV6. Here are the traces
using xmon debugger.


Oops: System Reset, sig: 6 [#4]
SMP NR_CPUS=1024 DEBUG_PAGEALLOC NUMA pSeries
Modules linked in: quota_v2 quota_tree fuse loop dm_mod sg sd_mod crc_t10dif ibmvscsic scsi_transport_srp scsi_tgt scsi_mod
NIP: c00000000003c310 LR: c0000000000055d0 CTR: 0000000000000040
REGS: c0000000fc90f340 TRAP: 0100   Tainted: G      D     (2.6.31-git13-autotest)
MSR: 8000000000081032 <ME,IR,DR>  CR: 28004420  XER: 20000001
TASK = c00000002c408890[8753] 'check_netns_ena' THREAD: c0000000fc90c000 CPU: 2
GPR00: 00000fffffffffff c0000000fc90f5c0 c000000000b8c2a8 d00007fffff00000
GPR04: 0000000000000201 0000000000000300 d00007fffff00000 d00007fffff00000
GPR08: 0000000000000000 000007fffff00000 0000000000000000 0000000000000000
GPR12: 8000000000009032 c000000000c82a00 0000000000000001 c0000000fc90f924
GPR16: 0000000000000300 0000000000000001 c0000000fa8e2380 0000000000000000
GPR20: 0000000000010000 0000000000000001 0000000000000000 0000000000000000
GPR24: c0000000fa9c09c8 0000000000000001 0000000000000001 c0000000faef6f60
GPR28: c000000000c6b620 0000000000000000 c000000000af2aa0 c000000000c6d1b0
NIP [c00000000003c310] .hash_page+0x24/0x4bc
LR [c0000000000055d0] .do_hash_page+0x50/0x6c
Call Trace:
[c0000000fc90f5c0] [c0000000000055d0] .do_hash_page+0x50/0x6c (unreliable)
--- Exception: 301 at .memset+0x60/0xfc
    LR = .pcpu_alloc+0x718/0x8fc
[c0000000fc90f8b0] [c0000000001700dc] .pcpu_alloc+0x6a8/0x8fc (unreliable)
[c0000000fc90f9d0] [c000000000614648] .snmp_mib_init+0x54/0x9c
[c0000000fc90fa60] [c000000000614764] .ipv4_mib_init_net+0xd4/0x1e0
[c0000000fc90fb10] [c0000000005a839c] .setup_net+0x68/0x124
[c0000000fc90fbb0] [c0000000005a8ad0] .copy_net_ns+0x88/0x130
[c0000000fc90fc40] [c0000000000bd5ac] .create_new_namespaces+0x110/0x1d0
[c0000000fc90fce0] [c0000000000bd874] .unshare_nsproxy_namespaces+0x6c/0xe8
[c0000000fc90fd80] [c000000000091ee8] .SyS_unshare+0x13c/0x318
[c0000000fc90fe30] [c0000000000085b4] syscall_exit+0x0/0x40
Instruction dump:
7c0803a6 ebe1fff8 4e800020 78690100 7c0802a6 f8010010 3800ffff fa01ff80
7cb02b78 78000500 fa21ff88 fb61ffd8 <7c912378> fa41ff90 7c7b1b78 fa61ff98

As you can see the call trace is same as far as top three function calls
are concerned [snmp_mib_init(), pcpu_alloc() and memset()].

The snmp_mib_init() function is :

int snmp_mib_init(void *ptr[2], size_t mibsize)
{
        BUG_ON(ptr == NULL);
        ptr[0] = __alloc_percpu(mibsize, __alignof__(unsigned long long));
        if (!ptr[0])
                goto err0;
        ptr[1] = __alloc_percpu(mibsize, __alignof__(unsigned long long));
        if (!ptr[1])
                goto err1;
        return 0;
.....

May be this might help..

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
