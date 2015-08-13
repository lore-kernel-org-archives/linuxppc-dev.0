Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09AEA1A1D5A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 17:01:08 +1000 (AEST)
Date: Thu, 13 Aug 2015 02:00:43 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/20] powerpc/8xx: Map linear kernel RAM with 8M pages
Message-ID: <20150813070043.GA29938@gate.crashing.org>
References: <cover.1439382631.git.christophe.leroy@c-s.fr>
 <f4a53e003d35f37d7825b88d7f07ae88a918ed3c.1439382634.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f4a53e003d35f37d7825b88d7f07ae88a918ed3c.1439382634.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2015 at 03:40:56PM +0200, Christophe Leroy wrote:
>  	/* Insert level 1 index */
>  	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
>  	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
> +	mtcr	r11

Maybe mtcrf is faster?  You only want one field, anyhow.

> +	bgt-	cr7,5f		/* CR7.GT = bit 29 = Large page (8M or 512K) */

You can write this as   bt- 29,5f   which should be easier to read.

>  	/* Insert level 1 index */
>  3:	rlwimi	r11, r10, 32 - ((PAGE_SHIFT - 2) << 1), (PAGE_SHIFT - 2) << 1, 29
>  	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
> +	mtcr	r11
> +	bgt	cr7,200f

Same here...  Probably good to comment it, too.


Segher
