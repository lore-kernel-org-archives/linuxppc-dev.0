Return-Path: <clg@kaod.org>
Received: from 6.mo2.mail-out.ovh.net (6.mo2.mail-out.ovh.net [87.98.165.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5qFg0CjwzDqhh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 17:41:57 +1100 (AEDT)
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 17C6BB1FB5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 08:24:14 +0200 (CEST)
Subject: Re: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20170923082656.27219-1-clg@kaod.org>
 <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
 <20171003033615.GA3260@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7f2081f1-415a-85ca-29ed-3ab1467220a7@kaod.org>
Date: Tue, 3 Oct 2017 08:24:07 +0200
MIME-Version: 1.0
In-Reply-To: <20171003033615.GA3260@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/03/2017 05:36 AM, David Gibson wrote:
> On Mon, Oct 02, 2017 at 06:27:20PM +0200, Cédric Le Goater wrote:
>> On 09/23/2017 10:26 AM, Cédric Le Goater wrote:
>>> Hi,
>>>
>>> Here are a couple of small fixes to support CPU hot unplug. There are
>>> still some issues to be investigated as, in some occasions, after a
>>> couple of plug and unplug, the cpu which was removed receives a 'lost'
>>> interrupt. This showed to be the decrementer under QEMU.
>>
>> So this seems to be a QEMU issue only which can be solved by 
>> removing the DEE bit from the LPCR on P9 processor when the CPU 
>> is stopped in rtas. PECE3 bit on P8 processors. 
>>
>> I think these patches are valuable fixes for 4.14. The first 
>> is trivial and the second touches the common xive part but it
>> is only called on the pseries platform.  
>>
>> Could you please take a look ?
> 
> Sorry, I think I've missed something here.
> 
> Is there a qemu bug involved in this?  Has there been a patch sent
> that I didn't spot?


No, not yet, but I will today probably. something like below to stop
the decrementer when a CPU is stopped:

	--- qemu.git.orig/hw/ppc/spapr_rtas.c
	+++ qemu.git/hw/ppc/spapr_rtas.c
	@@ -174,6 +174,15 @@ static void rtas_start_cpu(PowerPCCPU *c
	         kvm_cpu_synchronize_state(cs);
	 
	         env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
	+
	+        /* Enable DECR interrupt */
	+        if (env->mmu_model == POWERPC_MMU_3_00) {
	+            env->spr[SPR_LPCR] |= LPCR_DEE;
	+        } else {
	+            /* P7 and P8 both have same bit for DECR */
	+            env->spr[SPR_LPCR] |= LPCR_P8_PECE3;
	+        }
	+
	         env->nip = start;
	         env->gpr[3] = r3;
	         cs->halted = 0;
	@@ -210,6 +219,13 @@ static void rtas_stop_self(PowerPCCPU *c
	      * no need to bother with specific bits, we just clear it.
	      */
	     env->msr = 0;
	+
	+    if (env->mmu_model == POWERPC_MMU_3_00) {
	+        env->spr[SPR_LPCR] &= ~LPCR_DEE;
	+    } else {
	+        /* P7 and P8 both have same bit for DECR */
	+        env->spr[SPR_LPCR] &= ~LPCR_P8_PECE3;
	+    }
	 }
	 
	 static inline int sysparm_st(target_ulong addr, target_ulong len,
	
I haven't yet because I fail to understand why the decrementer is not 
interrupting the dying CPU under xics as it is the case under XIVE.

Also I am not sure this hack is of any use :

    /*
     * While stopping a CPU, the guest calls H_CPPR which
     * effectively disables interrupts on XICS level.
     * However decrementer interrupts in TCG can still
     * wake the CPU up so here we disable interrupts in MSR
     * as well.
     * As rtas_start_cpu() resets the whole MSR anyway, there is
     * no need to bother with specific bits, we just clear it.
     */
    env->msr = 0;

and the different CPU states are confusing. Nikunj already to a look
at this when trying to fix the TCG reboot. Anyway, the QEMU patch 
should (re)start a thread. This is not the place to discuss.

Thanks,

C.  
