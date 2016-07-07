Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlcbx6gyMzDqyh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 22:38:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/41] drm: Fix broken use of _PAGE_NO_CACHE on powerpc
In-Reply-To: <1467695057-12431-3-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
 <1467695057-12431-3-git-send-email-benh@kernel.crashing.org>
Date: Thu, 07 Jul 2016 22:38:17 +1000
Message-ID: <87inwhoc7a.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> That constant no longer exist. Use the proper accessor instead

I still see it?

  arch/powerpc/include/asm/book3s/32/hash.h:#define _PAGE_NO_CACHE	0x020	/* I: cache inhibit */
  arch/powerpc/include/asm/book3s/64/pgtable.h:#define _PAGE_NO_CACHE		_PAGE_TOLERANT
  arch/powerpc/include/asm/nohash/32/pte-44x.h:#define _PAGE_NO_CACHE	0x00000400		/* H: I bit */
  arch/powerpc/include/asm/nohash/32/pte-8xx.h:#define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
  arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h:#define _PAGE_NO_CACHE	0x00200	/* H: I bit */
  arch/powerpc/include/asm/nohash/pte-book3e.h:#define _PAGE_NO_CACHE	0x400000 /* I: cache inhibit */

Do you mean it doesn't exist in some cases? Or pgprot_noncached_wc() is
just better?

Also this should probably at least get Cc'ed to the DRM folks.

cheers
