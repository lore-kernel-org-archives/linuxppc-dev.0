Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z18W20tFhzDsSj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 18:22:37 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBJ7JUr6072799
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 02:22:35 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2exwp4shce-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 02:22:34 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 19 Dec 2017 07:22:33 -0000
Subject: Re: [PATCH] powerpc/perf: Dereference bhrb entries safely
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kan.liang@intel.com,
 Thomas Gleixner <tglx@linutronix.de>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20171212122915.20338-1-ravi.bangoria@linux.vnet.ibm.com>
 <CAKTCnzmuwkBLxaFpROo7TTcky970w7s14ETacHseL6Vu1JPTQA@mail.gmail.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 19 Dec 2017 12:53:17 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnzmuwkBLxaFpROo7TTcky970w7s14ETacHseL6Vu1JPTQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <4a72c32d-d9fb-3eea-417d-775e25a8f054@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

Sorry was away for few days.

On 12/14/2017 05:54 PM, Balbir Singh wrote:
> On Tue, Dec 12, 2017 at 11:29 PM, Ravi Bangoria
> <ravi.bangoria@linux.vnet.ibm.com> wrote:
>> It may very well happen that branch instructions recorded by
>> bhrb entries already get unmapped before they get processed by
>> the kernel. Hence, trying to dereference such memory location
>> will endup in a crash. Ex,
>>
>>     Unable to handle kernel paging request for data at address 0xc008000019c41764
>>     Faulting instruction address: 0xc000000000084a14
>>     NIP [c000000000084a14] branch_target+0x4/0x70
>>     LR [c0000000000eb828] record_and_restart+0x568/0x5c0
>>     Call Trace:
>>     [c0000000000eb3b4] record_and_restart+0xf4/0x5c0 (unreliable)
>>     [c0000000000ec378] perf_event_interrupt+0x298/0x460
>>     [c000000000027964] performance_monitor_exception+0x54/0x70
>>     [c000000000009ba4] performance_monitor_common+0x114/0x120
>>
>> Fix this by deferefencing them safely.
>>
>> Suggested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/perf/core-book3s.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
>> index 9e3da168d54c..5a68d2effdf9 100644
>> --- a/arch/powerpc/perf/core-book3s.c
>> +++ b/arch/powerpc/perf/core-book3s.c
>> @@ -410,8 +410,11 @@ static __u64 power_pmu_bhrb_to(u64 addr)
>>         int ret;
>>         __u64 target;
>>
>> -       if (is_kernel_addr(addr))
>> -               return branch_target((unsigned int *)addr);
>> +       if (is_kernel_addr(addr)) {
> I think __kernel_text_address() is more accurate right? In which case
> you need to check for is_kernel_addr(addr) and if its not kernel_text_address()
> then we have an interesting case of a branch from something not text.
> It would be nice to catch such cases.

Something like this?

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 1538129..627af56 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -410,8 +410,13 @@ static __u64 power_pmu_bhrb_to(u64 addr)
     int ret;
     __u64 target;
 
-    if (is_kernel_addr(addr))
-        return branch_target((unsigned int *)addr);
+    if (is_kernel_addr(addr)) {
+        if (probe_kernel_address((void *)addr, instr)) {
+            WARN_ON(!__kernel_text_address(addr));
+            return 0;
+        }
+        return branch_target(&instr);
+    }
 
     /* Userspace: need copy instruction here then translate it */
     pagefault_disable();


I think this will throw warnings when you try to read recently unmapped
vmalloced address. Is that fine?

Thanks for the review.
Ravi

>> +               if (probe_kernel_address((void *)addr, instr))
>> +                       return 0;
>> +               return branch_target(&instr);
>> +       }
>>
>>         /* Userspace: need copy instruction here then translate it */
>>         pagefault_disable();
> Otherwise,
>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
>
