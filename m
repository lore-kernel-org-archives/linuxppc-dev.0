Return-Path: <srs0=g+o6=h6=gondor.apana.org.au=herbert@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jGNj62RjzF2jP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 02:52:37 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40jGNj4y1xz8syK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 02:52:37 +1000 (AEST)
Date: Sat, 12 May 2018 00:19:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, mhcerri@linux.vnet.ibm.com,
 pfsmorigo@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] crypto: vmx - Remove overly verbose printk from AES
 init routines
Message-ID: <20180511161913.nr7woksn2jejipzm@gondor.apana.org.au>
References: <20180503122930.17448-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503122930.17448-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 10:29:29PM +1000, Michael Ellerman wrote:
> In the vmx AES init routines we do a printk(KERN_INFO ...) to report
> the fallback implementation we're using.
> 
> However with a slow console this can significantly affect the speed of
> crypto operations. Using 'cryptsetup benchmark' the removal of the
> printk() leads to a ~5x speedup for aes-cbc decryption.
> 
> So remove them.
> 
> Fixes: 8676590a1593 ("crypto: vmx - Adding AES routines for VMX module")
> Fixes: 8c755ace357c ("crypto: vmx - Adding CBC routines for VMX module")
> Fixes: 4f7f60d312b3 ("crypto: vmx - Adding CTR routines for VMX module")
> Fixes: cc333cd68dfa ("crypto: vmx - Adding GHASH routines for VMX module")
> Cc: stable@vger.kernel.org # v4.1+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/crypto/vmx/aes.c     | 2 --
>  drivers/crypto/vmx/aes_cbc.c | 3 ---
>  drivers/crypto/vmx/aes_ctr.c | 2 --
>  drivers/crypto/vmx/ghash.c   | 2 --
>  4 files changed, 9 deletions(-)

Patch applied.  Thanks.

> If this is the wrong fix please let me know, I'm not a crypto expert.
> 
> What we see is 'cryptsetup benchmark' causing thousands of these printks() to
> happen. The call trace is something like:
> 
> [c000001e47867a60] [c0000000009cf6b4] p8_aes_cbc_init+0x74/0xf0
> [c000001e47867ae0] [c000000000551a80] __crypto_alloc_tfm+0x1d0/0x2c0
> [c000001e47867b20] [c00000000055aea4] crypto_skcipher_init_tfm+0x124/0x280
> [c000001e47867b60] [c00000000055138c] crypto_create_tfm+0x9c/0x1a0
> [c000001e47867ba0] [c000000000552220] crypto_alloc_tfm+0xa0/0x140
> [c000001e47867c00] [c00000000055b168] crypto_alloc_skcipher+0x48/0x70
> [c000001e47867c40] [c00000000057af28] skcipher_bind+0x38/0x50
> [c000001e47867c80] [c00000000057a07c] alg_bind+0xbc/0x220
> [c000001e47867d10] [c000000000a016a0] __sys_bind+0x90/0x100
> [c000001e47867df0] [c000000000a01750] sys_bind+0x40/0x60
> [c000001e47867e30] [c00000000000b320] system_call+0x58/0x6c
> 
> 
> Is it normal for init to be called on every system call?

This is the tfm init function, so yes it is called every time
you allocate a tfm.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
