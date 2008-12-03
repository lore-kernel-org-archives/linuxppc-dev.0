Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	by ozlabs.org (Postfix) with ESMTP id 8FCDFDDE11
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 23:37:05 +1100 (EST)
Date: Wed, 3 Dec 2008 20:06:40 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] crypto: talitos - Fix modpost warning
Message-ID: <20081203120640.GB9818@gondor.apana.org.au>
References: <1228278556-1056-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1228278556-1056-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 02, 2008 at 10:29:16PM -0600, Kumar Gala wrote:
> Removed __devexit from talitos_remove() since its also called from
> talitos_probe().
> 
> WARNING: vmlinux.o(.text+0x28a008): Section mismatch in reference from the function talitos_probe() to the function .devexit.text:talitos_remove()
> The function talitos_probe() references a function in an exit section.
> Often the function talitos_remove() has valid usage outside the exit section
> and the fix is to remove the __devexit annotation of talitos_remove.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

OK, but what about the __devexit_p reference on talitos_remove?
We should remove that too.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
