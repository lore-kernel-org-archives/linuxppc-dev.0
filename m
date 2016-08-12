Return-Path: <paubert@iram.es>
Received: from navarro.puc.rediris.es (navarro.puc.rediris.es [130.206.18.139])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sB0Tq5WlYzDr2W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 08:50:39 +1000 (AEST)
Date: Sat, 13 Aug 2016 00:49:50 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Remove one insn in __bswapdi2
Message-ID: <20160812224950.GA21040@visitor2.iram.es>
References: <20160805112803.36D3B1A2399@localhost.localdomain>
 <20160810085605.GB2117@visitor2.iram.es>
 <1b899394-8df6-ac9b-c65e-ce71dbe96b1d@c-s.fr>
 <20160811213437.GA18560@visitor2.iram.es>
 <20160811221119.GA26763@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160811221119.GA26763@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2016 at 05:11:19PM -0500, Segher Boessenkool wrote:
> On Thu, Aug 11, 2016 at 11:34:37PM +0200, Gabriel Paubert wrote:
> > On the other hand gcc did at the time a very poor job (quite an
> > understatement) at bswapdi when compiling for 64 bit processors 
> > (see the example).
> > 
> > But what do modern compilers generate for bswapdi these days? Do they
> > still call the library or not?
> 
> Nope.

Great, could then these functions be removed from misc_32.S, or are
compilers that use libcalls still supported for kernel builds?

> 
> > After all, bswapdi on 32 bit processors only takes 6 instructions if the
> > input and output registers don't overlap.
> 
> For this testcase:
> ===
> typedef unsigned long long u64;
> u64 bs(u64 x) { return __builtin_bswap64(x); }
> ===
> 
> we get with -m32:
> ===
> bs:
> 	mr 9,3
> 	rotlwi 3,4,24
> 	rlwimi 3,4,8,8,15
> 	rlwimi 3,4,8,24,31
> 	rotlwi 4,9,24
> 	rlwimi 4,9,8,8,15
> 	rlwimi 4,9,8,24,31
> 	blr

In this case the compiler is constrained by the fact that the input and
ouput registers are the same. When inlined with other things it can
probably perform better scheduling and interleaving of operations.


> ===
> 
> and with -m64:
> ===
> .L.bs:
> 	srdi 10,3,32
> 	mr 9,3
> 	rotlwi 3,3,24
> 	rotlwi 8,10,24
> 	rlwimi 3,9,8,8,15
> 	rlwimi 8,10,8,8,15
> 	rlwimi 3,9,8,24,31
> 	rlwimi 8,10,8,24,31
> 	sldi 3,3,32
> 	or 3,3,8
> 	blr
> ===
> 

As demonstrated here where the two halves of the 64 bit quantity
are byte swapped in an interleaved fashion. Not perfect (I think
that with proper ordering the last 2 instructions could be replaced
by a rldimi), but reasonable.

> Neither as tight as possible, but neither horrible either.
> 

Indeed.

    Gabriel
