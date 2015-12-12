Return-Path: <haren@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D48E71A0065
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Dec 2015 10:01:45 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sat, 12 Dec 2015 18:01:41 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 5533DC90043
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Dec 2015 17:49:47 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBCN1cGt25428004
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Dec 2015 23:01:38 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBCN1b1l030303
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Dec 2015 18:01:38 -0500
Message-ID: <566CA746.1090001@linux.vnet.ibm.com>
Date: Sat, 12 Dec 2015 15:01:26 -0800
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
CC: herbert@gondor.apana.org.au, ddstreet@ieee.org, davem@davemloft.net,
 mpe@ellerman.id.au, pair@us.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Crypto/nx842: Ignore invalid XER[S0] return error
References: <1449891029.19568.5.camel@hbabu-laptop>
 <20151212084348.GA26552@gate.crashing.org>
In-Reply-To: <20151212084348.GA26552@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2015 12:43 AM, Segher Boessenkool wrote:
> On Fri, Dec 11, 2015 at 07:30:29PM -0800, Haren Myneni wrote:
>> NX842 coprocessor sets 3rd bit in CR register with XER[S0] which is
>> nothing to do with NX request. On powerpc, XER[S0] will be set if
>> overflow in FPU and stays until another floating point operation is
>> executed. Since this bit can be set with other valuable return status,
>> ignore this XER[S0] value.
> 
> XER[SO] is the *integer* summary overflow bit.  It is set by OE=1
> instructions ("addo" and the like), and can only be cleared explicitly
> (using "mtxer").

Thanks for the correct description. I was told XER[S0] is floating overflow from FPU.

> 
> The floating point overflow bit is FPSCR[OX].
> 
>> +	/*
>> +	 * NX842 coprocessor sets 3rd bit in CR register with XER[S0].
>> +	 * Setting XER[S0] happens if overflow in FPU and stays until
>> +	 * other floating operation is executed. XER[S0] value is nothing
>> +	 * to NX and no use to user. Since this bit can be set with other
>> +	 * return values, ignore this error.
>> +	 */
>> +	if (ret & ICSWX_XERS0)
>> +		ret &= ~ICSWX_XERS0;
> 
> You can just always clear it, there is no need to check if it is set first.

Do you mean reset this before calling NX? I believe NX coprocessor should not set CR bit as XER[S0] nothing to do with NX request and it is no use. NX is copying this CR bit with XER. But reset XER[S0] has to be done before NX request. We can not do this in icswx since this instruction can be used by other coprocessors in future. But I am not comfortable clearing as we are not touching this XER in the driver or result of NX operation. So I am proposing this patch to fix this not proper NX behaviour - ignores CR bit. 

If you are OK, I can repost the patch with proper description.

Thanks
Haren 


  
> 
> 
> Segher
> 
