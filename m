Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D04B31A019F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 11:04:21 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9135F1401E7
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2015 11:04:21 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Thu, 9 Jul 2015 11:04:20 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C630B2CE8040
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2015 11:04:17 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t69149bC60817632
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Jul 2015 11:04:17 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6913jHH022129
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Jul 2015 11:03:45 +1000
Reply-To: sam.mj@au1.ibm.com
Subject: Re: [PATCH V2 2/2] powerpc/kexec: Reset HILE before kexec_sequence
References: <1436330233-28489-1-git-send-email-sam.mj@au1.ibm.com>
 <1436330233-28489-2-git-send-email-sam.mj@au1.ibm.com>
 <1436333865.17490.4.camel@ellerman.id.au>
 <m3fv4z16sj.fsf@oc8180480414.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Message-ID: <559DC86E.201@au1.ibm.com>
Date: Thu, 9 Jul 2015 11:03:42 +1000
MIME-Version: 1.0
In-Reply-To: <m3fv4z16sj.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/15 16:51, Stewart Smith wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> On Wed, 2015-07-08 at 14:37 +1000, Samuel Mendoza-Jonas wrote:
>>> On powernv secondary cpus are returned to OPAL, and will then enter the
>>> target kernel in big-endian. However if it is set the HILE bit will persist,
>>> causing the first exception in the target kernel to be delivered in
>>> litte-endian regardless of the kernel endianess.
>>> Make sure that the HILE bit is switched off before entering
>>> kexec_sequence.
>>>
>>> Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
>>> ---
>>>  arch/powerpc/kernel/machine_kexec_64.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
>>> index 1a74446..2266135c 100644
>>> --- a/arch/powerpc/kernel/machine_kexec_64.c
>>> +++ b/arch/powerpc/kernel/machine_kexec_64.c
>>> @@ -22,8 +22,10 @@
>>>  #include <asm/page.h>
>>>  #include <asm/current.h>
>>>  #include <asm/machdep.h>
>>> +#include <asm/opal.h>
>>>  #include <asm/cacheflush.h>
>>>  #include <asm/paca.h>
>>> +#include <asm/firmware.h>
>>>  #include <asm/mmu.h>
>>>  #include <asm/sections.h>	/* _end */
>>>  #include <asm/prom.h>
>>> @@ -356,6 +358,10 @@ void default_machine_kexec(struct kimage *image)
>>>  	 * switched to a static version!
>>>  	 */
>>>  
>>> +	/* Reset HILE in case we kexec into an older BE kernel */
>>> +	if (firmware_has_feature(FW_FEATURE_OPALv3))
>>> +		opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_BE);
>>
>> It's not safe to do this here.
>>
>> We are still in virtual mode and have external interrupts enabled, so you could
>> easily take an exception of some kind and then you'd blow up. Mashing the
>> keyboard during kexec might even be enough.
> 
> Hrm... interrupts are disabled in kexec_sequence, should we be doing
> this there instead I wonder? At this point we're pretty much at the
> point of no return, so maybe we just need to disable interrupts first?
> 
>> I think a better API would be that opal_return_cpu() deals with this under the
>> covers. I think we talked about that, so maybe there was some reason that
>> wasn't possible.
> 
> opal_return_cpu() acts on current CPU which if we started flipping HILE
> there we'd hit PowerISA 2.07 Section 2.11:
> "The contents of the HILE bit must be the same for all
> threads under the control of a given instance of the
> hypervisor; otherwise all results are undefined."
> 
> so we'd have to do something kind of funny in opal_return_cpu() to work
> out what's going on. Keeping in mind that opal_return_cpu() is also used
> in the fsp code update path (which I haven't gone and really looked at
> in this context though).
> 
> I'm not convinced that opal_return_cpu() doing the HILE switch is
> safe when we'd be relying on the kernel to pretty much do this all at
> the same time (when we really have opal_reinit_cpus to do that)

Having discovered opal_call_realmode, it looks like we can probably do this
safely in real mode just before moving the kernel around and releasing
the secondaries into the next kernel. I'll test this and send a V2 if it
looks good.

> 
> Although PowerISA also says:
> "The HILE bit is set, by an implementa-
> tion-dependent method, during system initialization,
> and cannot be modified after system initialization."
> 
> Which... umm... we are clearly doing and have been since we started
> supporting LE powernv, so there's something somewhere in some document
> describing it all... I just have to find it (or poke Ben to find out
> where he worked it out from).
> 


-- 
-----------
LTC Ozlabs
IBM
