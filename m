Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C662D1A0170
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 20:25:07 +1000 (AEST)
Message-ID: <1440930307.907.5.camel@ellerman.id.au>
Subject: talitos doesn't build with GCC 4.4.4 (was Re: [PATCH v3 07/17]
 crypto: talitos - enhanced talitos_desc struct for SEC1)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Scott Wood
 <scottwood@freescale.com>
Cc: Kim Phillips <kim.phillips@freescale.com>, linuxppc-dev@lists.ozlabs.org
Date: Sun, 30 Aug 2015 20:25:07 +1000
In-Reply-To: <20150417143201.7C8B41A242C@localhost.localdomain>
References: <20150417143201.7C8B41A242C@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi guys,

Due to the recent config changes for 85xx, CRYPTO_DEV_TALITOS is now enabled
for corenet64/32_smp_defconfig:

  https://git.kernel.org/cgit/linux/kernel/git/scottwood/linux.git/commit/?h=next&id=7e2ad2ef851545c9bd0b5aadc8026c6901a87c50

And so I've started seeing a build failure caused by the patch below (merged as
commit 90490752eb03 ("crypto: talitos - enhanced talitos_desc struct for
SEC1")) but only with GCC 4.4.4.

I assume you're not interested in building with such an old compiler?

The error is:

  In file included from drivers/crypto/talitos.c:56:
  drivers/crypto/talitos.h:56: error: unknown field 'len' specified in initializer
  drivers/crypto/talitos.h:56: warning: missing braces around initializer
  drivers/crypto/talitos.h:56: warning: (near initialization for 'zero_entry.<anonymous>')
  drivers/crypto/talitos.h:57: error: unknown field 'j_extent' specified in initializer
  drivers/crypto/talitos.h:58: error: unknown field 'eptr' specified in initializer
  drivers/crypto/talitos.h:58: warning: excess elements in struct initializer
  drivers/crypto/talitos.h:58: warning: (near initialization for 'zero_entry')
  make[3]: *** [drivers/crypto/talitos.o] Error 1


cheers

On Fri, 2015-04-17 at 16:32 +0200, Christophe Leroy wrote:
> This patch enhances the talitos_desc struct with fields for SEC1.
> SEC1 has only one header field, and has a 'next_desc' field in
> addition.
> This mixed descriptor will continue to fit SEC2, and for SEC1
> we will recopy hdr value into hdr1 value in talitos_submit()
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/crypto/talitos.h | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
> index 61a1405..f078da1 100644
> --- a/drivers/crypto/talitos.h
> +++ b/drivers/crypto/talitos.h
> @@ -37,9 +37,17 @@
>  
>  /* descriptor pointer entry */
>  struct talitos_ptr {
> -	__be16 len;     /* length */
> -	u8 j_extent;    /* jump to sg link table and/or extent */
> -	u8 eptr;        /* extended address */
> +	union {
> +		struct {		/* SEC2 format */
> +			__be16 len;     /* length */
> +			u8 j_extent;    /* jump to sg link table and/or extent*/
> +			u8 eptr;        /* extended address */
> +		};
> +		struct {			/* SEC1 format */
> +			__be16 res;
> +			__be16 len1;	/* length */
> +		};
> +	};
>  	__be32 ptr;     /* address */
>  };
>  
> @@ -53,8 +61,12 @@ static const struct talitos_ptr zero_entry = {
>  /* descriptor */
>  struct talitos_desc {
>  	__be32 hdr;                     /* header high bits */
> -	__be32 hdr_lo;                  /* header low bits */
> +	union {
> +		__be32 hdr_lo;		/* header low bits */
> +		__be32 hdr1;		/* header for SEC1 */
> +	};
>  	struct talitos_ptr ptr[7];      /* ptr/len pair array */
> +	__be32 next_desc;		/* next descriptor (SEC1) */
>  };
>  
>  /**
