Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1DWP4HRTzDx3b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 21:23:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kan.liang@intel.com,
 Thomas Gleixner <tglx@linutronix.de>,
 "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/perf: Dereference bhrb entries safely
In-Reply-To: <4a72c32d-d9fb-3eea-417d-775e25a8f054@linux.vnet.ibm.com>
References: <20171212122915.20338-1-ravi.bangoria@linux.vnet.ibm.com>
 <CAKTCnzmuwkBLxaFpROo7TTcky970w7s14ETacHseL6Vu1JPTQA@mail.gmail.com>
 <4a72c32d-d9fb-3eea-417d-775e25a8f054@linux.vnet.ibm.com>
Date: Tue, 19 Dec 2017 21:23:13 +1100
Message-ID: <87ind39fu6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:

> Hi Balbir,
>
> Sorry was away for few days.
>
> On 12/14/2017 05:54 PM, Balbir Singh wrote:
>> On Tue, Dec 12, 2017 at 11:29 PM, Ravi Bangoria
>> <ravi.bangoria@linux.vnet.ibm.com> wrote:
>>> It may very well happen that branch instructions recorded by
>>> bhrb entries already get unmapped before they get processed by
>>> the kernel. Hence, trying to dereference such memory location
>>> will endup in a crash. Ex,
>>>
>>>     Unable to handle kernel paging request for data at address 0xc00800=
0019c41764
>>>     Faulting instruction address: 0xc000000000084a14
>>>     NIP [c000000000084a14] branch_target+0x4/0x70
>>>     LR [c0000000000eb828] record_and_restart+0x568/0x5c0
>>>     Call Trace:
>>>     [c0000000000eb3b4] record_and_restart+0xf4/0x5c0 (unreliable)
>>>     [c0000000000ec378] perf_event_interrupt+0x298/0x460
>>>     [c000000000027964] performance_monitor_exception+0x54/0x70
>>>     [c000000000009ba4] performance_monitor_common+0x114/0x120
>>>
>>> Fix this by deferefencing them safely.
>>>
>>> Suggested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/perf/core-book3s.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-b=
ook3s.c
>>> index 9e3da168d54c..5a68d2effdf9 100644
>>> --- a/arch/powerpc/perf/core-book3s.c
>>> +++ b/arch/powerpc/perf/core-book3s.c
>>> @@ -410,8 +410,11 @@ static __u64 power_pmu_bhrb_to(u64 addr)
>>>         int ret;
>>>         __u64 target;
>>>
>>> -       if (is_kernel_addr(addr))
>>> -               return branch_target((unsigned int *)addr);
>>> +       if (is_kernel_addr(addr)) {
>> I think __kernel_text_address() is more accurate right? In which case
>> you need to check for is_kernel_addr(addr) and if its not kernel_text_ad=
dress()
>> then we have an interesting case of a branch from something not text.
>> It would be nice to catch such cases.
>
> Something like this?
>
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-boo=
k3s.c
> index 1538129..627af56 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -410,8 +410,13 @@ static __u64 power_pmu_bhrb_to(u64 addr)
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> =C2=A0=C2=A0=C2=A0=C2=A0 __u64 target;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 if (is_kernel_addr(addr))
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return branch_target((unsigned int=
 *)addr);
> +=C2=A0=C2=A0=C2=A0 if (is_kernel_addr(addr)) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (probe_kernel_address((void *)a=
ddr, instr)) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 WARN_ON(!__kern=
el_text_address(addr));
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return branch_target(&instr);
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Userspace: need copy instruction here then tr=
anslate it */
> =C2=A0=C2=A0=C2=A0=C2=A0 pagefault_disable();
>
>
> I think this will throw warnings when you try to read recently unmapped
> vmalloced address. Is that fine?

No.

I've already merged the patch, and am fairly happy with it.

cheers
