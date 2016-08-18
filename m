Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFPHh1zp5zDr5M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 21:38:40 +1000 (AEST)
Subject: Re: [PATCH] powerpc/8xx: fix single_step debug
To: Gabriel Paubert <paubert@iram.es>
References: <20160818094420.8E0991A2459@localhost.localdomain>
 <20160818095807.GA14832@visitor2.iram.es>
 <d371d987-aa4b-20bb-e751-6ced387d5575@c-s.fr>
 <20160818101647.GA16503@visitor2.iram.es>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e31fc3ba-1b4a-f99f-c0a0-663c6bf56abc@c-s.fr>
Date: Thu, 18 Aug 2016 13:38:36 +0200
MIME-Version: 1.0
In-Reply-To: <20160818101647.GA16503@visitor2.iram.es>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 18/08/2016 à 12:16, Gabriel Paubert a écrit :
> On Thu, Aug 18, 2016 at 12:13:21PM +0200, Christophe Leroy wrote:
>>
>>
>> Le 18/08/2016 à 11:58, Gabriel Paubert a écrit :
>>> On Thu, Aug 18, 2016 at 11:44:20AM +0200, Christophe Leroy wrote:
>>>> SPRN_ICR must be read for clearing the internal freeze signal which
>>>> is asserted by the single step exception, otherwise the timebase and
>>>> decrementer remain freezed
>>>
>>> Minor nit: s/freezed/frozen/
>>>
>>> If the timebase and decrementer are frozen even for a few cycles, this
>>> probably upsets timekeeping. I consider this a completely stupid design
>>> decision, and maybe I'm not alone.
>>>
>>>    Gabriel
>>
>> We could also unset TBF bit (TimeBase Freeze enable) in TBSCR
>> register (today it is set in
>> arch/powerpc/platforms/8xx/m8xx_setup.c) but then it would impact
>> debug done with an external BDM system which expects the decrementer
>> and TB frozen when it freezes the execution.
>
> Ok, I believe that systematically setting it is a mistake, but then I'm
> always a bit nervous about screwing up timekeeping (it certainly is
> always a very bad idea when you are driving telescopes).
>

Indeed you are right, this should not happen. The issue is due to the 
fact that the bootloader set the TRE bit in the DER register.
So the fix is to be done in the boot loader.

Christophe
