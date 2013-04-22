Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 904142C00EE
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 16:57:54 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 12:23:26 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 26D92E002D
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 12:29:45 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3M6vdJV6881778
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 12:27:39 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3M6vgok027556
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Apr 2013 16:57:43 +1000
Message-ID: <5174DF58.7020506@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 12:27:28 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH V3 1/5] powerpc, perf: Add new BHRB related instructions
 for POWER8
References: <1366287976-3900-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1366287976-3900-2-git-send-email-khandual@linux.vnet.ibm.com>
 <20130421234109.GC22246@concordia>
In-Reply-To: <20130421234109.GC22246@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/22/2013 05:11 AM, Michael Ellerman wrote:
> On Thu, Apr 18, 2013 at 05:56:12PM +0530, Anshuman Khandual wrote:
>> This patch adds new POWER8 instruction encoding for reading
>> the BHRB buffer entries and also clearing it. Encoding for
>> "clrbhrb" instruction is straight forward.
> 
> Which is "clear branch history rolling buffer" ?
> 
>> But "mfbhrbe"
>> encoding involves reading a certain index of BHRB buffer
>> into a particular GPR register.
> 
> And "Move from branch history rolling buffer entry" ?
> 

Sure, would add these descriptions in the change log.

>> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
>> index 8752bc8..93ae5a1 100644
>> --- a/arch/powerpc/include/asm/ppc-opcode.h
>> +++ b/arch/powerpc/include/asm/ppc-opcode.h
>> @@ -82,6 +82,7 @@
>>  #define	__REGA0_R31	31
>>  
>>  /* sorted alphabetically */
>> +#define PPC_INST_BHRBE			0x7c00025c
> 
> I don't think you really need this, just use the literal value below.
> 
>> @@ -297,6 +298,12 @@
>>  #define PPC_NAP			stringify_in_c(.long PPC_INST_NAP)
>>  #define PPC_SLEEP		stringify_in_c(.long PPC_INST_SLEEP)
>>  
>> +/* BHRB instructions */
>> +#define PPC_CLRBHRB		stringify_in_c(.long 0x7c00035c)
>> +#define PPC_MFBHRBE(r, n)	stringify_in_c(.long PPC_INST_BHRBE | \
>> +						__PPC_RS(r) | \
>> +							(((n) & 0x1f) << 11))
> 
> Why are you not using ___PPC_RB(n) here ?
> 

I would replace __PPC_RS(r) with __PPC_RT(r) which makes more sense from
instruction encoding point of view.

Regards
Anshuman
