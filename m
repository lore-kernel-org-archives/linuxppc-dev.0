Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFCB21A1053
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Dec 2015 19:44:15 +1100 (AEDT)
Date: Sat, 12 Dec 2015 02:43:48 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Cc: herbert@gondor.apana.org.au, ddstreet@ieee.org, davem@davemloft.net,
 mpe@ellerman.id.au, pair@us.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Crypto/nx842: Ignore invalid XER[S0] return error
Message-ID: <20151212084348.GA26552@gate.crashing.org>
References: <1449891029.19568.5.camel@hbabu-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449891029.19568.5.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 11, 2015 at 07:30:29PM -0800, Haren Myneni wrote:
> NX842 coprocessor sets 3rd bit in CR register with XER[S0] which is
> nothing to do with NX request. On powerpc, XER[S0] will be set if
> overflow in FPU and stays until another floating point operation is
> executed. Since this bit can be set with other valuable return status,
> ignore this XER[S0] value.

XER[SO] is the *integer* summary overflow bit.  It is set by OE=1
instructions ("addo" and the like), and can only be cleared explicitly
(using "mtxer").

The floating point overflow bit is FPSCR[OX].

> +	/*
> +	 * NX842 coprocessor sets 3rd bit in CR register with XER[S0].
> +	 * Setting XER[S0] happens if overflow in FPU and stays until
> +	 * other floating operation is executed. XER[S0] value is nothing
> +	 * to NX and no use to user. Since this bit can be set with other
> +	 * return values, ignore this error.
> +	 */
> +	if (ret & ICSWX_XERS0)
> +		ret &= ~ICSWX_XERS0;

You can just always clear it, there is no need to check if it is set first.


Segher
