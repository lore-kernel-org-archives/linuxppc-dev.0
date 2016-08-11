Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9Mgd4FfRzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 08:11:57 +1000 (AEST)
Date: Thu, 11 Aug 2016 17:11:19 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Remove one insn in __bswapdi2
Message-ID: <20160811221119.GA26763@gate.crashing.org>
References: <20160805112803.36D3B1A2399@localhost.localdomain>
 <20160810085605.GB2117@visitor2.iram.es>
 <1b899394-8df6-ac9b-c65e-ce71dbe96b1d@c-s.fr>
 <20160811213437.GA18560@visitor2.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160811213437.GA18560@visitor2.iram.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2016 at 11:34:37PM +0200, Gabriel Paubert wrote:
> On the other hand gcc did at the time a very poor job (quite an
> understatement) at bswapdi when compiling for 64 bit processors 
> (see the example).
> 
> But what do modern compilers generate for bswapdi these days? Do they
> still call the library or not?

Nope.

> After all, bswapdi on 32 bit processors only takes 6 instructions if the
> input and output registers don't overlap.

For this testcase:
===
typedef unsigned long long u64;
u64 bs(u64 x) { return __builtin_bswap64(x); }
===

we get with -m32:
===
bs:
	mr 9,3
	rotlwi 3,4,24
	rlwimi 3,4,8,8,15
	rlwimi 3,4,8,24,31
	rotlwi 4,9,24
	rlwimi 4,9,8,8,15
	rlwimi 4,9,8,24,31
	blr
===

and with -m64:
===
.L.bs:
	srdi 10,3,32
	mr 9,3
	rotlwi 3,3,24
	rotlwi 8,10,24
	rlwimi 3,9,8,8,15
	rlwimi 8,10,8,8,15
	rlwimi 3,9,8,24,31
	rlwimi 8,10,8,24,31
	sldi 3,3,32
	or 3,3,8
	blr
===

Neither as tight as possible, but neither horrible either.


Segher
