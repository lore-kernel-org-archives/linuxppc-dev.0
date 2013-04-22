Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2AC12C010D
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 17:03:52 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 12:30:20 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 371213940053
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 12:33:47 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3M73gx264225506
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 12:33:43 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3M73kp2021043
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 07:03:46 GMT
Message-ID: <5174E0C3.505@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 12:33:31 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH V3 1/5] powerpc, perf: Add new BHRB related instructions
 for POWER8
References: <1366287976-3900-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1366287976-3900-2-git-send-email-khandual@linux.vnet.ibm.com>
 <20130421234109.GC22246@concordia> <14010.1366593223@ale.ozlabs.ibm.com>
 <20130422024546.GA24739@concordia> <14063.1366599003@ale.ozlabs.ibm.com>
In-Reply-To: <14063.1366599003@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/22/2013 08:20 AM, Michael Neuling wrote:
> Michael Ellerman <michael@ellerman.id.au> wrote:
> 
>> On Mon, Apr 22, 2013 at 11:13:43AM +1000, Michael Neuling wrote:
>>> Michael Ellerman <michael@ellerman.id.au> wrote:
>>>
>>>> On Thu, Apr 18, 2013 at 05:56:12PM +0530, Anshuman Khandual wrote:
>>>>> This patch adds new POWER8 instruction encoding for reading
>>>>> the BHRB buffer entries and also clearing it. Encoding for
>>>>> "clrbhrb" instruction is straight forward.
>>>>
>>>> Which is "clear branch history rolling buffer" ?
>>>>
>>>>> But "mfbhrbe"
>>>>> encoding involves reading a certain index of BHRB buffer
>>>>> into a particular GPR register.
>>>>
>>>> And "Move from branch history rolling buffer entry" ?
>>>>
>>>>> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
>>>>> index 8752bc8..93ae5a1 100644
>>>>> --- a/arch/powerpc/include/asm/ppc-opcode.h
>>>>> +++ b/arch/powerpc/include/asm/ppc-opcode.h
>>>>> @@ -82,6 +82,7 @@
>>>>>  #define	__REGA0_R31	31
>>>>>  
>>>>>  /* sorted alphabetically */
>>>>> +#define PPC_INST_BHRBE			0x7c00025c
>>>>
>>>> I don't think you really need this, just use the literal value below.
>>>
>>> The rest of the defines in this file do this, so Anshuman's right. 
>>
>> I don't see the point, but sure let's be consistent. Though in that case
>> he should do the same for PPC_CLRBHRB below.
> 
> Agreed.
> 

Sure, would define a new macro (PPC_INST_CLRBHRB) to encode 0x7c00035c
before using it for PPC_CLRBHRB.

> Mikey
> 
>>
>>>>> @@ -297,6 +298,12 @@
>>>>>  #define PPC_NAP			stringify_in_c(.long PPC_INST_NAP)
>>>>>  #define PPC_SLEEP		stringify_in_c(.long PPC_INST_SLEEP)
>>>>>  
>>>>> +/* BHRB instructions */
>>>>> +#define PPC_CLRBHRB		stringify_in_c(.long 0x7c00035c)
>>>>> +#define PPC_MFBHRBE(r, n)	stringify_in_c(.long PPC_INST_BHRBE | \
>>>>> +						__PPC_RS(r) | \
>>>>> +							(((n) & 0x1f) << 11))
>>>>
>>>> Why are you not using ___PPC_RB(n) here ?
>>>
>>> Actually, this is wrong.  The number field should be 10 bits (0x3ff),
>>> not 5 (0x1f)  Anshuman please fix.
>>
>> ACK.

I got it wrong, thought this as 32 instead of 1024. Would fix it.

Regards
Anshuman
