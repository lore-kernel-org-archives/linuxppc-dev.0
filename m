Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMGhR02LNzDsTb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 23:03:02 +1000 (AEST)
Date: Tue, 1 Aug 2017 07:57:36 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/powernv: Use darn instr for random_seed on p9
Message-ID: <20170801125735.GJ13471@gate.crashing.org>
References: <20170707070249.15773-1-matthew.brown.dev@gmail.com>
 <87lgn555vs.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lgn555vs.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 31, 2017 at 07:10:15PM +1000, Michael Ellerman wrote:
> And ___PPC_RA() is not quite right. The L field is only 2 bits wide, not
> the 5 that ___PPC_RA() allows.
> 
> We don't have a __PPC_L() macro, because L fields vary in size and
> location. So I think you're best of open coding it, eg:
> 
> +#define PPC_DARN(t, l)		stringify_in_c(.long PPC_INST_DARN |  \
> +						__PPC_RT(t)	   |  \
> +						(((l) & 0x3) << 16))

It would be better if you could do a compile-time error if the L value
is out of range.  Hrm, nothing else does such checking either?


Segher
