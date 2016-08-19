Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFv3V1xvXzDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 16:59:50 +1000 (AEST)
Subject: Re: [PATCH] powerpc/8xx: use SPRN_EIE and SPRN_EID to enable/disable
 interrupts
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <20160818155602.DAD601A2459@localhost.localdomain>
 <20160818163431.GB24467@gate.crashing.org>
 <ab787457-5799-05d2-b063-dec58e6532cd@c-s.fr>
 <20160818175411.GD24467@gate.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <999c7439-d81c-a01a-2e3a-eb4d4ec5c9e2@c-s.fr>
Date: Fri, 19 Aug 2016 08:59:45 +0200
MIME-Version: 1.0
In-Reply-To: <20160818175411.GD24467@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 18/08/2016 à 19:54, Segher Boessenkool a écrit :
> On Thu, Aug 18, 2016 at 06:52:47PM +0200, Christophe Leroy wrote:
>> Le 18/08/2016 à 18:34, Segher Boessenkool a écrit :
>>> On Thu, Aug 18, 2016 at 05:56:02PM +0200, Christophe Leroy wrote:
>>>> The 8xx has two special registers called EID (External Interrupt
>>>> Disable) and EIE (External Interrupt Enable) for clearing/setting
>>>> EE in MSR. It avoids the three instructions set mfmsr/ori/mtmsr or
>>>> mfmsr/rlwinm/mtmsr.
>>>
>>> All 8xx?  What other models?  (5xx for example).
>>
>> At least 823, 860, 866 and 885 have it.
>
> I haven't been able to find a manual for all 8xx.  But there is AN2055,
> which suggests EIE etc. is for all 8xx indeed.
>
>> Looks like the 5xx have it too (at least the 565). Does Linux supports
>> that one at all ?
>
> All 5xx have it, there is a manual for *that* ("RCPU") :-)
>
>>>> +/* Special MSR manipulation registers */
>>>> +#define SPRN_EIE	80	/* External interrupt enable (EE=1, RI=1) */
>>>> +#define SPRN_EID	81	/* External interrupt disable (EE=0, RI=1) */
>>>> +#define SPRN_NRI	81	/* Non Recoverable interrupt (EE=0, RI=0) */
>
> Is it correct to set RI in all places you do now?

MSR_KERNEL contains the RI bit.
MSR_KERNEL less MSR_IR and MSR_DR is loaded into MSR in 
EXCEPTION_PROLOG_2() in head_8xx.S
Then reloaded with MSR_KERNEL in some places in entry_32.S

And MSR_RI is cleared in restore: in entry_32.S a few insns before the RFI.

So in all C functions, MSR_RI is set.

Christophe

>
>>> This is wrong (NRI is 82).  Don't write code you cannot test / don't submit
>>> code you haven't tested?  :-)
>>
>> Oops. You're right, copy/paste failure.
>> Was tested on an 885. Unfortunatly SPRN_NRI is not used (yet) :-(
>
> Well, that was my point!
>
>
> Segher
>
