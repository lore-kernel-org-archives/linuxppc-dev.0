Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0131.outbound.protection.outlook.com [207.46.100.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CC041A0058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 14:14:43 +1100 (AEDT)
Date: Mon, 30 Mar 2015 22:14:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [v2,2/2] powerpc32: add support for csum_add()
Message-ID: <20150331031430.GA7982@home.buserror.net>
References: <20150203113927.8604D1A5F14@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150203113927.8604D1A5F14@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 03, 2015 at 12:39:27PM +0100, LEROY Christophe wrote:
> The C version of csum_add() as defined in include/net/checksum.h gives the
> following assembly:
>        0:       7c 04 1a 14     add     r0,r4,r3
>        4:       7c 64 00 10     subfc   r3,r4,r0
>        8:       7c 63 19 10     subfe   r3,r3,r3
>        c:       7c 63 00 50     subf    r3,r3,r0
> 
> include/net/checksum.h also offers the possibility to define an arch specific
> function.
> This patch provides a ppc32 specific csum_add() inline function.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v2: changed constraints on the __asm__
> 
>  arch/powerpc/include/asm/checksum.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
> index cfe806a..1e48cc7 100644
> --- a/arch/powerpc/include/asm/checksum.h
> +++ b/arch/powerpc/include/asm/checksum.h
> @@ -141,6 +141,18 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
>  {
>  	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
>  }
> +
> +#define HAVE_ARCH_CSUM_ADD
> +static inline __wsum csum_add(__wsum csum, __wsum addend)
> +{
> +    __asm__("\n\

s/__asm__/asm/

Use tabs to indent

> +	addc %0,%0,%1 \n\
> +	addze %0,%0 \n\

Use ; to separate asm statements instead of using \n
Use string concatenation instead of \

-Scott
