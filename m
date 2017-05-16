Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRll510gNzDqNs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 15:05:36 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G53lma090759
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 01:05:26 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2affx7ukg9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 01:05:26 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 May 2017 15:05:23 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4G55EuG49086700
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 15:05:22 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4G54geQ010985
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 15:04:43 +1000
Subject: Re: kernel BUG at mm/usercopy.c:72!
To: Balbir Singh <bsingharora@gmail.com>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20170515191949.GA13641@gmail.com>
 <53dcd142-47d6-f6c0-32b1-a5d611810873@linux.vnet.ibm.com>
 <1494909896.30802.1.camel@gmail.com>
Cc: gromero@br.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 16 May 2017 10:34:30 +0530
MIME-Version: 1.0
In-Reply-To: <1494909896.30802.1.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <20721bd8-82c3-df1b-fddc-7a6c70a9b88c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2017 10:14 AM, Balbir Singh wrote:
> On Tue, 2017-05-16 at 09:30 +0530, Anshuman Khandual wrote:
>> On 05/16/2017 12:49 AM, Breno Leitao wrote:
>>> Hello,
>>>
>>> Kernel 4.12-rc1 is showing a bug when I try it on a POWER8 virtual
>>> machine. Justing SSHing into the machine causes this issue.
>>>
>>> 	[23.138124] usercopy: kernel memory overwrite attempt detected to d000000003d80030 (mm_struct) (560 bytes)
>>> 	[23.138195] ------------[ cut here ]------------
>>> 	[23.138229] kernel BUG at mm/usercopy.c:72!
>>> 	[23.138252] Oops: Exception in kernel mode, sig: 5 [#3]
>>> 	[23.138280] SMP NR_CPUS=2048 
>>> 	[23.138280] NUMA 
>>> 	[23.138302] pSeries
>>> 	[23.138330] Modules linked in:
>>> 	[23.138354] CPU: 4 PID: 2215 Comm: sshd Tainted: G      D         4.12.0-rc1+ #9
>>> 	[23.138395] task: c0000001e272dc00 task.stack: c0000001e27b0000
>>> 	[23.138430] NIP: c000000000342358 LR: c000000000342354 CTR: c0000000006eb060
>>> 	[23.138472] REGS: c0000001e27b3a00 TRAP: 0700   Tainted: G      D          (4.12.0-rc1+)
>>> 	[23.138513] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
>>> 	[23.138517]   CR: 28004222  XER: 20000000
>>> 	[23.138565] CFAR: c000000000b34500 SOFTE: 1 
>>> 	[23.138565] GPR00: c000000000342354 c0000001e27b3c80 c00000000142a000 000000000000005e 
>>> 	[23.138565] GPR04: c0000001ffe0ade8 c0000001ffe21bf8 2920283536302062 79746573290d0a74 
>>> 	[23.138565] GPR08: 0000000000000007 c000000000f61864 00000001feeb0000 3064206f74206465 
>>> 	[23.138565] GPR12: 0000000000004400 c00000000fb42600 0000000000000015 00000000545bdc40 
>>> 	[23.138565] GPR16: 00000000545c49c8 000001000b4b8890 00007ffff78c26f0 00000000545cf000 
>>> 	[23.138565] GPR20: 00000000546109c8 000000000000c7e8 0000000054610010 00007ffff78c22e8 
>>> 	[23.138565] GPR24: 00000000545c8c40 c0000000ff6bcef0 c0000000001e5220 0000000000000230 
>>> 	[23.138565] GPR28: d000000003d80260 0000000000000000 0000000000000230 d000000003d80030 
>>> 	[23.138920] NIP [c000000000342358] __check_object_size+0x88/0x2d0
>>> 	[23.138956] LR [c000000000342354] __check_object_size+0x84/0x2d0
>>> 	[23.138990] Call Trace:
>>> 	[23.139006] [c0000001e27b3c80] [c000000000342354] __check_object_size+0x84/0x2d0 (unreliable)
>>> 	[23.139056] [c0000001e27b3d00] [c0000000009f5ba8] bpf_prog_create_from_user+0xa8/0x1a0
>>> 	[23.139099] [c0000001e27b3d60] [c0000000001e5d30] do_seccomp+0x120/0x720
>>> 	[23.139136] [c0000001e27b3dd0] [c0000000000fd53c] SyS_prctl+0x2ac/0x6b0
>>> 	[23.139172] [c0000001e27b3e30] [c00000000000af84] system_call+0x38/0xe0
>>> 	[23.139218] Instruction dump:
>>> 	[23.139240] 60000000 60420000 3c82ff94 3ca2ff9d 38841788 38a5e868 3c62ff95 7fc8f378 
>>> 	[23.139283] 7fe6fb78 386310c0 487f2169 60000000 <0fe00000> 60420000 2ba30010 409d018c 
>>> 	[23.139328] ---[ end trace 1a1dc952a4b7c4af ]---
>>> 	
>>> I found that kernel 4.11 does not have this issue. I also found that, if
>>> I revert 517e1fbeb65f5eade8d14f46ac365db6c75aea9b, I do not see the
>>> problem.
>>
>> commit 517e1fbeb65f5eade8d14f46ac365db6c75aea9b
>> Author: Laura Abbott <labbott@redhat.com>
>> Date:   Tue Apr 4 14:09:00 2017 -0700
>>
>>     mm/usercopy: Drop extra is_vmalloc_or_module() check
>>     
>>     Previously virt_addr_valid() was insufficient to validate if virt_to_page()
>>     could be called on an address on arm64. This has since been fixed up so
>>     there is no need for the extra check. Drop it.
>>     
>>     Signed-off-by: Laura Abbott <labbott@redhat.com>
>>     Acked-by: Mark Rutland <mark.rutland@arm.com>
>>     Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> diff --git a/mm/usercopy.c b/mm/usercopy.c
>> index 1eba99b..a9852b2 100644
>> --- a/mm/usercopy.c
>> +++ b/mm/usercopy.c
>> @@ -200,17 +200,6 @@ static inline const char *check_heap_object(const void *ptr, unsigned long n,
>>  {
>>  	struct page *page;
>>  
>> -	/*
>> -	 * Some architectures (arm64) return true for virt_addr_valid() on
>> -	 * vmalloced addresses. Work around this by checking for vmalloc
>> -	 * first.
>> -	 *
>> -	 * We also need to check for module addresses explicitly since we
>> -	 * may copy static data from modules to userspace
>> -	 */
>> -	if (is_vmalloc_or_module_addr(ptr))
>> -		return NULL;
>> -
>>  	if (!virt_addr_valid(ptr))
>>  		return NULL;
>>  
>>
>>
>> On POWER8 (CONFIG_PPC64),
>>
>> #define virt_addr_valid(kaddr)	pfn_valid(virt_to_pfn(kaddr))
>> #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
>> #define __pa(x) ((unsigned long)(x) & 0x0fffffffffffffffUL)
>>
>> Hence some vmalloc (0xd range) addresses can still pass the virt_addr_valid()
>> test, hence the removed exclusive check for vmalloc and module addresses in
>> the commit is still required for powerpc. If that is the case, we should
>> revert the commit.
>>
> 
> I guess it we should evaluate the meaning of virt_addr_valid() and what
> it should return for 0xd.. and 0xf.. ranges for example?

Hmm, I get your point. But 0xd, 0xf are *actually* virtual addresses,
I wonder how can we return anything else for them. Hence the extra
check above is required for vmalloc addresses if thats not something
we want.
