Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 721301A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 21:35:30 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 12 Aug 2014 17:05:24 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C415B125801F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 17:05:29 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7CBZiOO4522382
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 17:05:45 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7CBZKrM018402
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 17:05:21 +0530
Message-ID: <53E9FBF6.5010008@linux.vnet.ibm.com>
Date: Tue, 12 Aug 2014 17:05:18 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/kvm: support to handle sw breakpoint
References: <1406868643-26291-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53E87023.6080200@suse.de> <1407747061.4508.75.camel@pasglop>
 <53E889BA.40108@suse.de> <53E9A383.5060009@linux.vnet.ibm.com>
 <53E9F824.9080906@suse.de>
In-Reply-To: <53E9F824.9080906@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 12 August 2014 04:49 PM, Alexander Graf wrote:
> 
> On 12.08.14 07:17, Madhavan Srinivasan wrote:
>> On Monday 11 August 2014 02:45 PM, Alexander Graf wrote:
>>> On 11.08.14 10:51, Benjamin Herrenschmidt wrote:
>>>> On Mon, 2014-08-11 at 09:26 +0200, Alexander Graf wrote:
>>>>>> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
>>>>>> index da86d9b..d95014e 100644
>>>>>> --- a/arch/powerpc/kvm/emulate.c
>>>>>> +++ b/arch/powerpc/kvm/emulate.c
>>>>> This should be book3s_emulate.c.
>>>> Any reason we can't make that 00dddd00 opcode as breakpoint common to
>>>> all powerpc variants ?
>>> I can't think of a good reason. We use a hypercall on booke (which traps
>>> into an illegal instruction for pr) today, but I don't think it has to
>>> be that way.
>>>
>>> Given that the user space API allows us to change it dynamically, there
>>> should be nothing blocking us from going with 00dddd00 always.
>>>
>> Kindly correct me if i am wrong. So we can still have a common code in
>> emulate.c to set the env for both HV and pr incase of illegal
>> instruction (i will rebase latest src). But suggestion here to use
>> 00dddd00, in that case current path in embed is kvmppc_handle_exit
>> (booke.c) -> BOOKE_INTERRUPT_HV_PRIV -> emulation_exit ->
>> kvmppc_emulate_instruction, will change to kvmppc_handle_exit (booke.c)
>> -> BOOKE_INTERRUPT_PROGRAM -> if debug instr call emulation_exit else
>> send to guest?
> 
> I can't follow your description above.
> 
My bad.

> With the latest git version HV KVM does not include emulate.c anymore.
> 
> Also, it would make a lot of sense of have the same soft breakpoint
> instruction across all ppc targets, so it would make sense to change it
> to 0x00dddd00 for booke as well.
> 
Got it. Was describing the current control flow with respect to booke
and where changes needed (for same software breakpoint inst). This is
for my understanding and wanted verify.

kvmppc_handle_exit(booke.c)
	-> BOOKE_INTERRUPT_HV_PRIV
		-> emulation_exit
			->kvmppc_emulate_instruction

Incase of using the same software breakpoint instruction (0x00dddd00),
then we need to add code in booke something like this

kvmppc_handle_exit (booke.c)
	-> BOOKE_INTERRUPT_PROGRAM
		->	if debug instr
				->emulation_exit
			else
				->send to guest?
				
> Basically you would have handling code in emulate.c and book3s_hv.c at
> the end of the day.
> 
Yes. Will resend the patch with updated code.

> 
> Alex
> 
