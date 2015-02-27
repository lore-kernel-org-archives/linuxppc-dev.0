Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.apana.org.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 845691A0079
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 20:51:32 +1100 (AEDT)
Date: Fri, 27 Feb 2015 22:51:21 +1300
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Markus Stockhausen <stockhausen@collogia.de>
Subject: Re: [v2,1/3] crypto: ppc/sha256 - assembler
Message-ID: <20150227095120.GA29140@gondor.apana.org.au>
References: <fc802923-6dbf-4fba-b6fe-5af360ca48c4@EXCHANGE.collogia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fc802923-6dbf-4fba-b6fe-5af360ca48c4@EXCHANGE.collogia.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 30, 2015 at 03:39:23PM +0100, Markus Stockhausen wrote:
> This is the assembler code for SHA256 implementation with
> the SIMD SPE instruction set. Although being only a 32 bit
> architecture GPRs are extended to 64 bit presenting two
> 32 bit values. With the enhanced instruction set we can
> operate on them in parallel. That helps reducing the time
> to calculate W16-W64. For increasing performance even more 
> the assembler function can compute hashes for more than 
> one 64 byte input block. That saves a lot of register
> saving/restoring
> 
> The state of the used SPE registers is preserved via the 
> stack so we can run from interrupt context. There might 
> be the case that we interrupt ourselves and push sensitive 
> data from another context onto our stack. Clear this area
> in the stack afterwards to avoid information leakage.
> 
> The code is endian independant.
> 
> Signed-off-by: Markus Stockhausen <stockhausen@collogia.de>

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
