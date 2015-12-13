Return-Path: <haren@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61D0C1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Dec 2015 11:39:24 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sat, 12 Dec 2015 19:39:22 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9BCE8C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Dec 2015 19:27:29 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBD0dKjq29819128
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Dec 2015 00:39:20 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBD0aJ1j014650
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Dec 2015 19:36:22 -0500
Message-ID: <566CBE2A.1080107@linux.vnet.ibm.com>
Date: Sat, 12 Dec 2015 16:39:06 -0800
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
CC: herbert@gondor.apana.org.au, ddstreet@ieee.org, davem@davemloft.net,
 mpe@ellerman.id.au, pair@us.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Crypto/nx842: Ignore invalid XER[S0] return error
References: <1449891029.19568.5.camel@hbabu-laptop>
 <20151212084348.GA26552@gate.crashing.org>
 <566CA746.1090001@linux.vnet.ibm.com>
 <20151213000550.GA9787@gate.crashing.org>
In-Reply-To: <20151213000550.GA9787@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2015 04:05 PM, Segher Boessenkool wrote:
> On Sat, Dec 12, 2015 at 03:01:26PM -0800, Haren Myneni wrote:
>> On 12/12/2015 12:43 AM, Segher Boessenkool wrote:
>>> On Fri, Dec 11, 2015 at 07:30:29PM -0800, Haren Myneni wrote:
>>>> NX842 coprocessor sets 3rd bit in CR register with XER[S0] which is
>>>> nothing to do with NX request. On powerpc, XER[S0] will be set if
>>>> overflow in FPU and stays until another floating point operation is
>>>> executed. Since this bit can be set with other valuable return status,
>>>> ignore this XER[S0] value.
>>>
>>> XER[SO] is the *integer* summary overflow bit.  It is set by OE=1
>>> instructions ("addo" and the like), and can only be cleared explicitly
>>> (using "mtxer").
>>
>> Thanks for the correct description. I was told XER[S0] is floating overflow from FPU.
> 
> You can use the Power ISA document to make sure for yourself.
> 
>>>> +	if (ret & ICSWX_XERS0)
>>>> +		ret &= ~ICSWX_XERS0;
>>>
>>> You can just always clear it, there is no need to check if it is set first.
>>
>> Do you mean reset this before calling NX?
> 
> I mean write this as simply
> 
> +	ret &= ~ICSWX_XERS0;
> 
> (without any "if").
> 
>> I believe NX coprocessor should not set CR bit as XER[S0] nothing to do with NX request and it is no use.
> 
> Many instructions set the CR bit to XER[SO] -- store conditional, slbfee.,
> and all "normal" dot insns and of course cmp[l][i].  Or, shorter: "everything"
> does this.
> 
>> NX is copying this CR bit with XER. But reset XER[S0] has to be done before NX request.
> 
> Only if you care what the final value of bit 3 in the CR will be.  Even
> in the unusual case where you want to look at all CR field bits at once
> it is cheap to just mask out the bit (as you do).
> 
>> We can not do this in icswx since this instruction can be used by other coprocessors in future. But I am not comfortable clearing as we are not touching this XER in the driver or result of NX operation. So I am proposing this patch to fix this not proper NX behaviour - ignores CR bit. 
> 
> I really wouldn't call it "not proper", that makes it sound like there
> is an implementation bug or design mistake.  Instead, you could say that
> your switch statement looks at the values of bits 0, 1, and 2, so you
> just mask those -- you do not care about the value of bit 3, so you mask
> it out.
> 
> Something like
> 
> +	/* Mask out the bits we do not care about. */
> +	ret &= ~ICSWX_XERS0;

icswx RFC says CR[3] bit can be undefined or set to XER[S0]. So was thinking NX should have ignored since no use to user. I may be wrong.

Thanks for your help. I will repost this patch with your suggestions.

Thanks
Haren
> 
> 
> Segher
> 
