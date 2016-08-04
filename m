Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4bdj0RFmzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 13:53:45 +1000 (AEST)
Message-ID: <1470282813.25630.242.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org, antoine.blangy@c-s.fr, segher@kernel.crashing.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Date: Wed, 03 Aug 2016 22:53:33 -0500
In-Reply-To: <20160802080705.69A9F1A2394@localhost.localdomain>
References: <20160802080705.69A9F1A2394@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2] powerpc/32: fix csum_partial_copy_generic()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-02 at 10:07 +0200, Christophe Leroy wrote:
> commit 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
> based on copy_tofrom_user()") introduced a bug when destination
> address is odd and initial csum is not null
> 
> In that (rare) case the initial csum value has to be rotated one byte
> as well as the resulting value is
> 
> This patch also fixes related comments
> 
> Fixes: 7aef4136566b0 ("powerpc32: rewrite csum_partial_copy_generic()
> based on copy_tofrom_user()")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: updated comments as suggested by Segher
> 
>  arch/powerpc/lib/checksum_32.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Alessio, can you confirm whether this fixes the problem you reported?

-Scott

> 
> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
> index d90870a..0a57fe6 100644
> --- a/arch/powerpc/lib/checksum_32.S
> +++ b/arch/powerpc/lib/checksum_32.S
> @@ -127,8 +127,9 @@ _GLOBAL(csum_partial_copy_generic)
>  	stw	r7,12(r1)
>  	stw	r8,8(r1)
>  
> -	andi.	r0,r4,1			/* is destination
> address even ? */
> -	cmplwi	cr7,r0,0
> +	rlwinm	r0,r4,3,0x8
> +	rlwnm	r6,r6,r0,0,31	/* odd destination address:
> rotate one byte */
> +	cmplwi	cr7,r0,0	/* is destination address even ? */
>  	addic	r12,r6,0
>  	addi	r6,r4,-4
>  	neg	r0,r4
> @@ -237,7 +238,7 @@ _GLOBAL(csum_partial_copy_generic)
>  66:	addze	r3,r12
>  	addi	r1,r1,16
>  	beqlr+	cr7
> -	rlwinm	r3,r3,8,0,31	/* swap bytes for odd destination
> */
> +	rlwinm	r3,r3,8,0,31	/* odd destination address:
> rotate one byte */
>  	blr
>  
>  /* read fault */
