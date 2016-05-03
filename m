Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzg1x3083zDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 22:08:53 +1000 (AEST)
In-Reply-To: <20160430082927.2111f5ae@kryten>
To: Unknown sender due to SPF <linuxppc-dev@lists.ozlabs.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, felix@linux.vnet.ibm.com,
 Bill Schmidt <wschmidt@us.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: create_zero_mask() has bad inline assembly constraint
Message-Id: <3qzg1x1zDYz9t5P@ozlabs.org>
Date: Tue,  3 May 2016 22:08:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-29-04 at 22:29:27 UTC, Unknown sender due to SPF wrote:
> In create_zero_mask() we have:
> 
> 	addi	%1,%2,-1
> 	andc	%1,%1,%2
> 	popcntd	%0,%1
> 
> using the "r" constraint for %2. r0 is a valid register in the "r" set,
> but addi X,r0,X turns it into an li:
> 
> 	li	r7,-1
> 	andc	r7,r7,r0
> 	popcntd	r4,r7
> 
> Fix this by using the "b" constraint, for which r0 is not a valid
> register.
> 
> This was found with a kernel build using gcc trunk, narrowed down to
> when -frename-registers was enabled at -O2. It is just luck however
> that we aren't seeing this on older toolchains.
> 
> Thanks to Segher for working with me to find this issue.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: <stable@vger.kernel.org>
> Fixes: d0cebfa650a0 ("powerpc: word-at-a-time optimization for 64-bit Little Endian")

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b4c112114aab9aff5ed4568ca5

cheers
