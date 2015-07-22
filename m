Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 506A31A1A3B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 19:32:23 +1000 (AEST)
Message-ID: <1437557537.27712.6.camel@ellerman.id.au>
Subject: Re: [RFC 3/8] powerpc/slb: Define macros for the bolted slots
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
Date: Wed, 22 Jul 2015 19:32:17 +1000
In-Reply-To: <1437461926-8908-3-git-send-email-khandual@linux.vnet.ibm.com>
References: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1437461926-8908-3-git-send-email-khandual@linux.vnet.ibm.com>
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

On Tue, 2015-07-21 at 12:28 +0530, Anshuman Khandual wrote:
> From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
> 
> This patch defines macros for all the three bolted SLB slots. This also
> renames the 'create_shadowed_slb' function as 'new_shadowed_slb'.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/slb.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 3842a54..cbeaaa2 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -25,6 +25,9 @@
>  #include <asm/udbg.h>
>  #include <asm/code-patching.h>
>  
> +#define SLOT_KLINR  0	/* kernel linear map  (0xc00000000) */

Call it LINEAR_SLOT ?

> +#define SLOT_KVIRT  1	/* kernel virtual map (0xd00000000) */

VMALLOC_SLOT

> +#define SLOT_KSTACK 2	/* kernel stack map   (0xf00000000) */

KSTACK_SLOT

And the comment is wrong, it's not 0xf00.., that's the vmemmap.


I know we're inconsistent about FOO_SLOT vs SLOT_FOO at times, but I think in
this case it reads better as FOO_SLOT.

Actually even better, make it an enum?

cheers
