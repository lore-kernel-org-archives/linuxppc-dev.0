Return-Path: <paubert@iram.es>
Received: from rudy.puc.rediris.es (rudy.puc.rediris.es [130.206.18.140])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9Ls52crqzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 07:35:05 +1000 (AEST)
Date: Thu, 11 Aug 2016 23:34:37 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Remove one insn in __bswapdi2
Message-ID: <20160811213437.GA18560@visitor2.iram.es>
References: <20160805112803.36D3B1A2399@localhost.localdomain>
 <20160810085605.GB2117@visitor2.iram.es>
 <1b899394-8df6-ac9b-c65e-ce71dbe96b1d@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1b899394-8df6-ac9b-c65e-ce71dbe96b1d@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 10, 2016 at 12:18:15PM +0200, Christophe Leroy wrote:
> 
> 
> Le 10/08/2016 à 10:56, Gabriel Paubert a écrit :
> >On Fri, Aug 05, 2016 at 01:28:02PM +0200, Christophe Leroy wrote:
> >>Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>---
> >> arch/powerpc/kernel/misc_32.S | 3 +--
> >> 1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >>diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
> >>index e025230..e18055c 100644
> >>--- a/arch/powerpc/kernel/misc_32.S
> >>+++ b/arch/powerpc/kernel/misc_32.S
> >>@@ -578,9 +578,8 @@ _GLOBAL(__bswapdi2)
> >> 	rlwimi  r9,r4,24,0,7
> >> 	rlwimi  r10,r3,24,0,7
> >> 	rlwimi  r9,r4,24,16,23
> >>-	rlwimi  r10,r3,24,16,23
> >>+	rlwimi  r4,r3,24,16,23
> >> 	mr      r3,r9
> >>-	mr      r4,r10
> >> 	blr
> >>
> >
> >Hmmm, are you sure that it works? rlwimi is a bit special since the
> >first operand is both an input and an output of the instruction.
> >
> >
> 
> Oops, you are right ...

I just found this: 

http://hardwarebug.org/2010/01/14/beware-the-builtins/

the bswapdi2 suggested sequence only needs a single mr instruction, the 
other one is absorbed in a rotlwi.

The scheduling looks poor, but it seems impossible to interleave the
operations between the two halves without adding another instructions,
and the routine is 8 instructions long, which happens to be exactly a
cache line on most 32 bit processors.

On the other hand gcc did at the time a very poor job (quite an
understatement) at bswapdi when compiling for 64 bit processors 
(see the example).

But what do modern compilers generate for bswapdi these days? Do they
still call the library or not?

After all, bswapdi on 32 bit processors only takes 6 instructions if the
input and output registers don't overlap.

    Gabriel
