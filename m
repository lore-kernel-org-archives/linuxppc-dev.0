Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB39ADE055
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 03:57:01 +1000 (EST)
Message-Id: <606D70D7-6F85-48DF-854F-18DAE01ACA95@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Peter Bergner <bergner@vnet.ibm.com>
In-Reply-To: <1239125792.7557.7.camel@otta>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: Fix tlbilx opcode
Date: Tue, 7 Apr 2009 12:54:53 -0500
References: <1239050219-4477-1-git-send-email-galak@kernel.crashing.org>
	<1239125792.7557.7.camel@otta>
Cc: linuxppc-dev@ozlabs.org, Edmar Wienskoski-RA8797 <edmar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 7, 2009, at 12:36 PM, Peter Bergner wrote:

> On Mon, 2009-04-06 at 15:36 -0500, Kumar Gala wrote:
>> The tlbilx opcode was not matching the Power ISA 2.06 arch spec.
>> The old opcode was an early suggested opcode that changed during the
>> 2.06 architecture process.
> [snip]
>> #define PPC_INST_STSWI			0x7c0005aa
>> #define PPC_INST_STSWX			0x7c00052a
>> -#define PPC_INST_TLBILX			0x7c000626
>> +#define PPC_INST_TLBILX			0x7c000024
>> #define PPC_INST_WAIT			0x7c00007c
>
> How do you want to handle the current binutils code that implements  
> tlbilx
> and its extended mnemonics?  Should they be changed to use secondary  
> opcode
> 18 instead of 787 as per the ISA 2.06 doc?

YES ! :)

>  {"tlbilx",      X(31,787),      X_MASK,      E500MC,     
> PPCNONE,        {T, RA0, RB}},
>  {"tlbilxlpid",  XTO(31,787,0),  XTO_MASK,    E500MC,     
> PPCNONE,        {0}},
>  {"tlbilxpid",   XTO(31,787,1),  XTO_MASK,    E500MC,     
> PPCNONE,        {0}},
>  {"tlbilxva",    XTO(31,787,3),  XTO_MASK,    E500MC,     
> PPCNONE,        {RA0, RB}},
>
> If you want to change the tlbilx entry to use 18 rather than 787,  
> let me
> know whether you want me to make the change or whether you (Edmar?)  
> will
> handle it.
>
> I'll note the extended mnemonics should be moved before tlbilx so  
> that the
> disassembler will use them (if appropriate) instead of the base  
> instruction.

I'll check w/Edmar.

- k
