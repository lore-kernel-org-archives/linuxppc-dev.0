Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1637B1A076F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 00:06:16 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 4 Aug 2015 19:36:15 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5CC3F1258018
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 19:39:20 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t74E6BPp48627846
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2015 19:36:11 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t74E64eV016303
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2015 19:36:05 +0530
Message-ID: <55C0C6C8.3030403@linux.vnet.ibm.com>
Date: Tue, 04 Aug 2015 19:36:00 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Subject: Re: powerpc: Add an inline function to update HID0
References: <20150804100858.1F272140306@ozlabs.org>
In-Reply-To: <20150804100858.1F272140306@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 04 August 2015 03:38 PM, Michael Ellerman wrote:
> On Tue, 2015-04-08 at 08:30:58 UTC, "Gautham R. Shenoy" wrote:
>> Section 3.7 of Version 1.2 of the Power8 Processor User's Manual
>> prescribes that updates to HID0 be preceded by a SYNC instruction and
>> followed by an ISYNC instruction (Page 91).
>>
>> Create a function name update_hid0() which follows this recipe and
>> invoke it from the static split core path.
>>
>> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/kvm_ppc.h       | 11 +++++++++++
> Why is it in there? It's not KVM related per se.
>
> Where should it go? I think reg.h would be best, ideally near the definition
> for HID0, though that's probably not possible because of ASSEMBLY requirements.
> So at the bottom of reg.h ?

just to understand, Something like this will not do?

#define update_hid0(x)  __asm__ __volatile__(  
"sync\n"\                      
                                                "mtspr "
__stringify(SPRN_HID0)", %0\n"\
                                                "isync"::"r"(x));

Maddy

>
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index c6ef05b..325f1d6 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -685,4 +685,15 @@ static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
>>  
>>  extern void xics_wake_cpu(int cpu);
>>  
>> +static inline void update_hid0(unsigned long hid0)
>> +{
>> +	/*
>> +	 *  The HID0 update should at the very least be preceded by a
>> +	 *  a SYNC instruction followed by an ISYNC instruction
>> +	 */
>> +	mb();
>> +	mtspr(SPRN_HID0, hid0);
>> +	isync();
> That's going to turn into three separate inline asm blocks, which is maybe a
> bit unfortunate. Have you checked the generated code is what we want, ie. just
> sync, mtspr, isync ?
>
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
