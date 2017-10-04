Return-Path: <clg@kaod.org>
Received: from 10.mo178.mail-out.ovh.net (10.mo178.mail-out.ovh.net
 [46.105.76.150])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6ftD3Y12zDqtT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 02:28:03 +1100 (AEDT)
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 1172C58CCF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 16:48:58 +0200 (CEST)
Subject: Re: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, nikunj@linux.vnet.ibm.com
References: <20170923082656.27219-1-clg@kaod.org>
 <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
 <20171003033615.GA3260@umbus.fritz.box>
 <7f2081f1-415a-85ca-29ed-3ab1467220a7@kaod.org>
 <20171003065858.GL3260@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fa6c0a3f-d350-9ee6-4cb5-3c5996da391a@kaod.org>
Date: Wed, 4 Oct 2017 16:48:51 +0200
MIME-Version: 1.0
In-Reply-To: <20171003065858.GL3260@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/03/2017 08:58 AM, David Gibson wrote:
> On Tue, Oct 03, 2017 at 08:24:07AM +0200, Cédric Le Goater wrote:
>> On 10/03/2017 05:36 AM, David Gibson wrote:
>>> On Mon, Oct 02, 2017 at 06:27:20PM +0200, Cédric Le Goater wrote:
>>>> On 09/23/2017 10:26 AM, Cédric Le Goater wrote:
>>>>> Hi,
>>>>>
>>>>> Here are a couple of small fixes to support CPU hot unplug. There are
>>>>> still some issues to be investigated as, in some occasions, after a
>>>>> couple of plug and unplug, the cpu which was removed receives a 'lost'
>>>>> interrupt. This showed to be the decrementer under QEMU.
>>>>
>>>> So this seems to be a QEMU issue only which can be solved by 
>>>> removing the DEE bit from the LPCR on P9 processor when the CPU 
>>>> is stopped in rtas. PECE3 bit on P8 processors. 
>>>>
>>>> I think these patches are valuable fixes for 4.14. The first 
>>>> is trivial and the second touches the common xive part but it
>>>> is only called on the pseries platform.  
>>>>
>>>> Could you please take a look ?
>>>
>>> Sorry, I think I've missed something here.
>>>
>>> Is there a qemu bug involved in this?  Has there been a patch sent
>>> that I didn't spot?
>>
>>
>> No, not yet, but I will today probably. something like below to stop
>> the decrementer when a CPU is stopped:
>>
>> 	--- qemu.git.orig/hw/ppc/spapr_rtas.c
>> 	+++ qemu.git/hw/ppc/spapr_rtas.c
>> 	@@ -174,6 +174,15 @@ static void rtas_start_cpu(PowerPCCPU *c
>> 	         kvm_cpu_synchronize_state(cs);
>> 	 
>> 	         env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
>> 	+
>> 	+        /* Enable DECR interrupt */
>> 	+        if (env->mmu_model == POWERPC_MMU_3_00) {
>> 	+            env->spr[SPR_LPCR] |= LPCR_DEE;
>> 	+        } else {
>> 	+            /* P7 and P8 both have same bit for DECR */
>> 	+            env->spr[SPR_LPCR] |= LPCR_P8_PECE3;
>> 	+        }
>> 	+
>> 	         env->nip = start;
>> 	         env->gpr[3] = r3;
>> 	         cs->halted = 0;
>> 	@@ -210,6 +219,13 @@ static void rtas_stop_self(PowerPCCPU *c
>> 	      * no need to bother with specific bits, we just clear it.
>> 	      */
>> 	     env->msr = 0;
>> 	+
>> 	+    if (env->mmu_model == POWERPC_MMU_3_00) {
>> 	+        env->spr[SPR_LPCR] &= ~LPCR_DEE;
>> 	+    } else {
>> 	+        /* P7 and P8 both have same bit for DECR */
>> 	+        env->spr[SPR_LPCR] &= ~LPCR_P8_PECE3;
>> 	+    }
>> 	 }
>> 	 
>> 	 static inline int sysparm_st(target_ulong addr, target_ulong len,
>> 	
>> I haven't yet because I fail to understand why the decrementer is not 
>> interrupting the dying CPU under xics as it is the case under XIVE.
> 
> Oh.. ok.  This sounds very similar to the problem Nikunj hit under TCG
> with decrementer interrupts waking up a supposedly dead CPU.  He had a
> couple of proposed fixes, but we got bogged down trying to work out
> why  (with TCG at least) it only seemed to bite after a system_reset,
> and not on initial boot up.

yes. It would be nice to fix the reset under TCG though. May be this is
related. 

>> Also I am not sure this hack is of any use :
>>
>>     /*
>>      * While stopping a CPU, the guest calls H_CPPR which
>>      * effectively disables interrupts on XICS level.
>>      * However decrementer interrupts in TCG can still
>>      * wake the CPU up so here we disable interrupts in MSR
>>      * as well.
>>      * As rtas_start_cpu() resets the whole MSR anyway, there is
>>      * no need to bother with specific bits, we just clear it.
>>      */
>>     env->msr = 0;
> 
> Ok.. why do you think this isn't of use?  I'm pretty sure this is
> necessary for the TCG case, since MSR is checked in cpu_has_work(),
> which could otherwise wake up the "dead" cpu.

well, no, when the CPU is stopped with the 'stop-self' RTAS call, one of 
the CPU states is switched to 1 (cs->halted=1). In cpu_has_work(), this 
is a branch in which we don't check the MSR, only pending hardware 
interrupts are checked with their LPCR enablement bit.

So if the DECR timer fires after 'stop-self' is called (cs->halted=1) and 
before it is really stopped (cs->stop=1), the nearly-dead CPU will have 
some work to do and the guest will crash. This case happens very frequently 
when the P9 XIVE exploitation mode is activated but it does not without, 
when using the XICS mode. In XICS mode, the DECR is occasionally fired but 
after cs->stop=1, so no work is to be done.
 
The patch above fixes the problem but I don't understand why this works 
with XICS. My feeling is that there is a race somewhere and 

	env->msr = 0;

is just a useless workaround, in this case at least. 

C.


> 
>> and the different CPU states are confusing. Nikunj already to a look
>> at this when trying to fix the TCG reboot. Anyway, the QEMU patch 
>> should (re)start a thread. This is not the place to discuss.
>>
>> Thanks,
>>
>> C.  
>>
>>
> 
