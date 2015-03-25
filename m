Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0107.outbound.protection.outlook.com [157.56.111.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A19211A0259
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 12:23:11 +1100 (AEDT)
Date: Tue, 24 Mar 2015 20:22:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: powerpc32: rearrange instructions order in ip_fast_csum()
Message-ID: <20150325012248.GA7270@home.buserror.net>
References: <20150203113927.B909E1A5F15@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150203113927.B909E1A5F15@localhost.localdomain>
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
> On PPC_8xx, lwz has a 2 cycles latency, and branching also takes 2 cycles.
> As the size of the header is minimum 5 words, we can unroll the loop for the
> first words to reduce number of branching, and we can re-order the instructions
> to limit loading latency.

Please wrap commit messages at around 70 characters.

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/lib/checksum_32.S | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
> index 6d67e05..5500704 100644
> --- a/arch/powerpc/lib/checksum_32.S
> +++ b/arch/powerpc/lib/checksum_32.S
> @@ -26,13 +26,17 @@
>  _GLOBAL(ip_fast_csum)
>  	lwz	r0,0(r3)
>  	lwzu	r5,4(r3)
> -	addic.	r4,r4,-2
> +	addic.	r4,r4,-4
>  	addc	r0,r0,r5
>  	mtctr	r4
>  	blelr-
> -1:	lwzu	r4,4(r3)
> -	adde	r0,r0,r4
> +	lwzu	r5,4(r3)
> +	lwzu	r4,4(r3)

The blelr is pointless since len is guaranteed to be >= 5 (assuming that
comment is accurate), but now it's both pointless and in the wrong place,
since you haven't yet finished the four words that you subtracted from
r4.

How about keeping the blelr, without the -, moving it after the initial
words, and changing the number of inital words to 5?  Also maybe do all
the loads up front, since many PPC chips have a three cycle load latency
rather than two.

-Scott
