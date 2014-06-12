Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E170A1A0329
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 18:21:26 +1000 (EST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9CA611400B6
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2014 18:21:25 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 12 Jun 2014 13:51:21 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id EC0FA3940048
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2014 13:51:16 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5C8LUHM11338020
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2014 13:51:30 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5C8LFEP024653
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2014 13:51:16 +0530
Message-ID: <53996288.6000407@linux.vnet.ibm.com>
Date: Thu, 12 Jun 2014 13:49:20 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc, xmon: Enable hardware instruction breakpoint
 support on POWER8
References: <1401451823-25547-1-git-send-email-khandual@linux.vnet.ibm.com>
 <8761knl6x5.fsf@linux.vnet.ibm.com> <538D654E.8040205@linux.vnet.ibm.com>
 <538EDD61.60801@linux.vnet.ibm.com>
In-Reply-To: <538EDD61.60801@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 mikey@neuling.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/04/2014 02:18 PM, Anshuman Khandual wrote:
> On 06/03/2014 11:33 AM, Anshuman Khandual wrote:
>> On 05/30/2014 07:12 PM, Aneesh Kumar K.V wrote:
>>>> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
>>>>
>>>>>> This patch enables support for hardware instruction breakpoints on POWER8 with
>>>>>> the help of a new register called CIABR (Completed Instruction Address Breakpoint
>>>>>> Register). With this patch, single hardware instruction breakpoint can be added
>>>>>> and cleared during any active xmon debug session. This hardware based instruction
>>>>>> breakpoint mechanism works correctly along with the existing TRAP based instruction
>>>>>> breakpoints available on xmon. Example usage as follows.
>>>>>>
>>>>>> (A) Start xmon:
>>>>>> $echo x > /proc/sysrq-trigger
>>>>>> SysRq : Entering xmon
>>>>>> cpu 0x0: Vector: 0  at [c000001f6c67f960]
>>>>>>     pc: c000000000072078: .sysrq_handle_xmon+0x58/0x60
>>>>>>     lr: c000000000072078: .sysrq_handle_xmon+0x58/0x60
>>>>>>     sp: c000001f6c67fac0
>>>>>>    msr: 9000000000009032
>>>>>>   current = 0xc000001f6e709ac0
>>>>>>   paca    = 0xc00000000fffa000   softe: 0        irq_happened: 0x00
>>>>>>     pid   = 3250, comm = bash
>>>>>> enter ? for help
>>>>>> 0:mon> b
>>>>>>    type            address
>>>>>>
>>>>>> (B) Set the breakpoint:
>>>>>> 0:mon> ls .power_pmu_add
>>>>>> .power_pmu_add: c000000000078f50
>>>>>> 0:mon> bi c000000000078f50
>>>>>> 0:mon> b
>>>>>>    type            address
>>>>>>  1 inst   c000000000078f50  .power_pmu_add+0x0/0x2e0
>>>>>> 0:mon> ls .perf_event_interrupt
>>>>>> .perf_event_interrupt: c00000000007aee0
>>>>>> 0:mon> bi c00000000007aee0
>>>>>> One instruction breakpoint possible with CIABR
>>>>>> 0:mon> x
>>>>>>
>>>>>> (C) Run the workload (with the breakpoint):
>>>>>> $./perf record ls
>>>>>> cpu 0x2: Vector: d00 (Single Step) at [c000001f718133a0]
>>>>>>     pc: c000000000078f54: .power_pmu_add+0x4/0x2e0
>>>>>>     lr: c000000000155be0: .event_sched_in+0x90/0x1d0
>>>>>>     sp: c000001f71813620
>>>>>>    msr: 9000000040109032
>>>>>>   current = 0xc000001f6ce30000
>>>>>>   paca    = 0xc00000000fffa600   softe: 0        irq_happened: 0x01
>>>>>>     pid   = 3270, comm = ls
>>>>>>         std     r22,-80(r1)
>>>>>> enter ? for help
>>>>>>
>>>>>> (D) Clear the breakpoint:
>>>>>> 2:mon> bc
>>>>>> All breakpoints cleared
>>>>>> 2:mon> x
>>>>>> [ perf record: Woken up 1 times to write data ]
>>>>>> [ perf record: Captured and wrote 0.002 MB perf.data (~66 samples) ]
>>>>>>
>>>>>> (E) Run the workload again (without any breakpoints):
>>>>>> $./perf record ls
>>>>>> [ perf record: Woken up 1 times to write data ]
>>>>>> [ perf record: Captured and wrote 0.001 MB perf.data (~61 samples) ]
>>>>>>
>>>>>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>  arch/powerpc/xmon/xmon.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
>>>>>>  1 file changed, 58 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>>>>>> index 3fd1d9a..f74ec83 100644
>>>>>> --- a/arch/powerpc/xmon/xmon.c
>>>>>> +++ b/arch/powerpc/xmon/xmon.c
>>>>>> @@ -48,6 +48,7 @@
>>>>>>  #ifdef CONFIG_PPC64
>>>>>>  #include <asm/hvcall.h>
>>>>>>  #include <asm/paca.h>
>>>>>> +#include <asm/plpar_wrappers.h>
>>>>>>  #endif
>>>>>>  
>>>>>>  #include "nonstdio.h"
>>>>>> @@ -89,6 +90,7 @@ struct bpt {
>>>>>>  /* Bits in bpt.enabled */
>>>>>>  #define BP_IABR_TE	1		/* IABR translation enabled */
>>>>>>  #define BP_IABR		2
>>>>>> +#define BP_CIABR	4
>>>>>>  #define BP_TRAP		8
>>>>>>  #define BP_DABR		0x10
>>>>>>  
>>>>>> @@ -97,6 +99,7 @@ static struct bpt bpts[NBPTS];
>>>>>>  static struct bpt dabr;
>>>>>>  static struct bpt *iabr;
>>>>>>  static unsigned bpinstr = 0x7fe00008;	/* trap */
>>>>>> +static bool ciabr_used = false;		/* CIABR instruction breakpoint */
>>>>>>  
>>>>>>  #define BP_NUM(bp)	((bp) - bpts + 1)
>>>>>>  
>>>>>> @@ -269,6 +272,34 @@ static inline void cinval(void *p)
>>>>>>  	asm volatile ("dcbi 0,%0; icbi 0,%0" : : "r" (p));
>>>>>>  }
>>>>>>  
>>>>>> +static void write_ciabr(unsigned long ciabr)
>>>>>> +{
>>>>>> +	if (cpu_has_feature(CPU_FTR_HVMODE)) {
>>>>>> +		mtspr(SPRN_CIABR, ciabr);
>>>>>> +		return;
>>>>>> +	}
>>>>>> +
>>>>>> +#ifdef CONFIG_PPC64
>>>>>> +	plapr_set_ciabr(ciabr);
>>>>>> +#endif
>>>>>> +}
>>>>>> +
>>>>>> +static void set_ciabr(unsigned long addr)
>>>>>> +{
>>>>>> +	addr &= ~CIABR_PRIV;
>>>>>> +	if (cpu_has_feature(CPU_FTR_HVMODE))
>>>>>> +		addr |= CIABR_PRIV_HYPER;
>>>>>> +	else
>>>>>> +		addr |= CIABR_PRIV_SUPER;
>>>>>> +	write_ciabr(addr);
>>>>>> +}
>>>>>> +
>>>>>> +static void clear_ciabr(void)
>>>>>> +{
>>>>>> +	if (cpu_has_feature(CPU_FTR_ARCH_207S))
>>>>>> +		write_ciabr(0);
>>>>>> +}
>>>>>> +
>>>>>>  /*
>>>>>>   * Disable surveillance (the service processor watchdog function)
>>>>>>   * while we are in xmon.
>>>>>> @@ -764,6 +795,9 @@ static void insert_cpu_bpts(void)
>>>>>>  	if (iabr && cpu_has_feature(CPU_FTR_IABR))
>>>>>>  		mtspr(SPRN_IABR, iabr->address
>>>>>>  			 | (iabr->enabled & (BP_IABR|BP_IABR_TE)));
>>>>>> +
>>>>>> +	if (iabr && cpu_has_feature(CPU_FTR_ARCH_207S))
>>>>>> +		set_ciabr(iabr->address);
>>>>>>  }
>>>>>>  
>>>>>>  static void remove_bpts(void)
>>>>>> @@ -791,6 +825,7 @@ static void remove_cpu_bpts(void)
>>>>>>  	hw_breakpoint_disable();
>>>>>>  	if (cpu_has_feature(CPU_FTR_IABR))
>>>>>>  		mtspr(SPRN_IABR, 0);
>>>>>> +	clear_ciabr();
>>>>>>  }
>>>>>>  
>>>>>>  /* Command interpreting routine */
>>>>>> @@ -1124,7 +1159,7 @@ static char *breakpoint_help_string =
>>>>>>      "b <addr> [cnt]   set breakpoint at given instr addr\n"
>>>>>>      "bc               clear all breakpoints\n"
>>>>>>      "bc <n/addr>      clear breakpoint number n or at addr\n"
>>>>>> -    "bi <addr> [cnt]  set hardware instr breakpoint (POWER3/RS64 only)\n"
>>>>>> +    "bi <addr> [cnt]  set hardware instr breakpoint (POWER3/RS64/POWER8 only)\n"
>>>>>>      "bd <addr> [cnt]  set hardware data breakpoint\n"
>>>>>>      "";
>>>>>>  
>>>>>> @@ -1163,11 +1198,20 @@ bpt_cmds(void)
>>>>>>  		break;
>>>>>>  
>>>>>>  	case 'i':	/* bi - hardware instr breakpoint */
>>>>>> -		if (!cpu_has_feature(CPU_FTR_IABR)) {
>>>>>> +		if (!cpu_has_feature(CPU_FTR_IABR) && !cpu_has_feature(CPU_FTR_ARCH_207S)) {
>>>>>>  			printf("Hardware instruction breakpoint "
>>>>>>  			       "not supported on this cpu\n");
>>>>>>  			break;
>>>>>>  		}
>>>>>> +
>>>>>> +		if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
>>>>>> +			if (ciabr_used) {
>>>>>> +				printf("One instruction breakpoint "
>>>>>> +					"possible with CIABR\n");
>>>>>> +				break;
>>>>>> +			}
>>>>
>>>> We don't seem to do that with iabr ? Why keep ciabr different 
> 
>> Right now with the IABR implementation if we try to set hardware instruction
>> breakpoint while one is already there, it just get overridden with the new
>> address without complaining. I thought with this at least for CIABR cases,
>> it will complain about it and require the user to clear the breakpoint
>> explicitly before allowing a new breakpoint. Okay will remove this.
>>  
> 
> I tried removing the "ciabr_used" variable and all related checks/assignments on it.
> Then I was able to add all these three address as hardware instruction breakpoint
> and xmon never complained that it might override the existing actual checkpoint
> implemented with CIABR. It accepted all the three addresses which can later be
> listed as below.
> 
> 0:mon> b
>    type            address
>  1 inst   c0000000000830d0  .power_pmu_add+0x0/0x2e0                                                
>  2 inst   c000000000084690  .power_pmu_del+0x0/0x3a0                                   
>  3 inst   c000000000085060  .perf_event_interrupt+0x0/0x480
> 
> But in reality, only perf_event_interrupt function's address got written into CIABR
> register and got triggered with the workload. I dont have a system which has IABR
> support to test it's behaviour for this situation. But this does not sound okay,
> we should explicitly inform the user that the hardware instruction breakpoint has
> been overridden with the latest command or reject the attempt. Looking for some
> suggestions in this regard. Thank you.

Hey Ben/MPE,

Any suggestions on this ^^^^^^^^^^^^ ?
