Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F65CDDF00
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 11:31:52 +1000 (EST)
Message-Id: <C2D1C19D-0D86-4B72-9D17-34246ED0B0AD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1209602915.18023.277.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
Date: Wed, 30 Apr 2008 20:31:40 -0500
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
	<18455.37613.709102.30668@cargo.ozlabs.ibm.com>
	<73CD5806-5CE4-40A7-957B-8F164E26FAFB@kernel.crashing.org>
	<1209537128.18023.225.camel@pasglop>
	<EDF2E889-4B04-42A8-8D93-E04B35162661@kernel.crashing.org>
	<1209592794.18023.248.camel@pasglop>
	<2A2997EA-F3AF-4C90-8952-42CA48AA07BC@kernel.crashing.org>
	<20080430184502.4f0c66e2@zod.rchland.ibm.com>
	<1209599602.18023.273.camel@pasglop>
	<20080430191153.49fce28e@zod.rchland.ibm.com>
	<1209602915.18023.277.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 7:48 PM, Benjamin Herrenschmidt wrote:
>
> On Wed, 2008-04-30 at 19:11 -0500, Josh Boyer wrote:
>>
>>> Nah, he meant using the slot for MAS0 in the exception frame
>> structure
>>> as to not have to define two different structures I suppose...
>>
>> Ah, ok.  Sorry, still playing catch up on email.  I thought we were
>> talking about a #define.
>
> Heh, now that I think about it ... maybe :-) That would be bad indeed.
> Kumar ?

I'll alias the slot.  Similiar to how we use _ESR -> for dsisr

Something like this will be added in asm-offset.c:

DEFINE(MMUCR, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs,  
mas0));
