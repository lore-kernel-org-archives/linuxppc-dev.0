Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkKq752w6zDqk0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 23:29:55 +1000 (AEST)
In-Reply-To: <118f28ccb9be59c72f4c7a2a0ce3c8591dea6582.1503277387.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/4] powerpc/32: add memset16()
Message-Id: <3xkKq71dbNz9t42@ozlabs.org>
Date: Fri,  1 Sep 2017 23:29:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-23 at 14:54:32 UTC, Christophe Leroy wrote:
> Commit 694fc88ce271f ("powerpc/string: Implement optimized
> memset variants") added memset16(), memset32() and memset64()
> for the 64 bits PPC.
> 
> On 32 bits, memset64() is not relevant, and as shown below,
> the generic version of memset32() gives a good code, so only
> memset16() is candidate for an optimised version.
> 
> 000009c0 <memset32>:
>  9c0:   2c 05 00 00     cmpwi   r5,0
>  9c4:   39 23 ff fc     addi    r9,r3,-4
>  9c8:   4d 82 00 20     beqlr
>  9cc:   7c a9 03 a6     mtctr   r5
>  9d0:   94 89 00 04     stwu    r4,4(r9)
>  9d4:   42 00 ff fc     bdnz    9d0 <memset32+0x10>
>  9d8:   4e 80 00 20     blr
> 
> The last part of memset() handling the not 4-bytes multiples
> operates on bytes, making it unsuitable for handling word without
> modification. As it would increase memset() complexity, it is
> better to implement memset16() from scratch. In addition it
> has the advantage of allowing a more optimised memset16() than what
> we would have by using the memset() function.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/da74f659205ea08cb0fd0b3050637b

cheers
