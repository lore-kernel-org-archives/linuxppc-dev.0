Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0139.outbound.protection.outlook.com [207.46.100.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 728C61A0D17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2015 14:33:44 +1100 (AEDT)
Message-ID: <1445571207.701.152.camel@freescale.com>
Subject: Re: [PATCH 8/9] powerpc: simplify csum_add(a, b) in case a or b is
 constant 0
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <netdev@vger.kernel.org>
Date: Thu, 22 Oct 2015 22:33:27 -0500
In-Reply-To: <5549ecca2c921f34d076c47b5e2a91a3e78b20a7.1442876807.git.christophe.leroy@c-s.fr>
References: <cover.1442876807.git.christophe.leroy@c-s.fr>
 <5549ecca2c921f34d076c47b5e2a91a3e78b20a7.1442876807.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-09-22 at 16:34 +0200, Christophe Leroy wrote:
> Simplify csum_add(a, b) in case a or b is constant 0
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/checksum.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/checksum.h 
> b/arch/powerpc/include/asm/checksum.h
> index 56deea8..f8a9704 100644
> --- a/arch/powerpc/include/asm/checksum.h
> +++ b/arch/powerpc/include/asm/checksum.h
> @@ -119,7 +119,13 @@ static inline __wsum csum_add(__wsum csum, __wsum 
> addend)
>  {
>  #ifdef __powerpc64__
>       u64 res = (__force u64)csum;
> +#endif
> +     if (__builtin_constant_p(csum) && csum == 0)
> +             return addend;
> +     if (__builtin_constant_p(addend) && addend == 0)
> +             return csum;
>  
> +#ifdef __powerpc64__
>       res += (__force u64)addend;
>       return (__force __wsum)((u32)res + (res >> 32));
>  #else

How often does this happen?

-Scott
