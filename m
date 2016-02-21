Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAFE81A08F4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 18:31:04 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 21 Feb 2016 00:31:02 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 543273E40030
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 00:30:59 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1L7Ux5x30277698
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 00:30:59 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1L7UwRu026995
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 00:30:58 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 7/9] powerpc/mm/book3s-64: Shuffle read, write,
 execute and user bits in PTE
In-Reply-To: <1455948760-24710-8-git-send-email-paulus@samba.org>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
 <1455948760-24710-8-git-send-email-paulus@samba.org>
Date: Sun, 21 Feb 2016 13:00:54 +0530
Message-ID: <87si0m7c5t.fsf@linux.vnet.ibm.com>
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

Paul Mackerras <paulus@samba.org> writes:

> This moves the _PAGE_EXEC, _PAGE_RW and _PAGE_USER bits around in
> the Linux PTE on 64-bit Book 3S systems to correspond with the bit
> positions used in radix mode by PowerISA v3.0 CPUs.  This also adds
> a _PAGE_READ bit corresponding to the read permission bit in the
> radix PTE.  _PAGE_READ is currently unused but could possibly be used
> in future to improve pte_protnone().
>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
>  arch/powerpc/include/asm/book3s/64/hash.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index c8eba0e..0fc750c 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -13,9 +13,12 @@
>   * We could create separate kernel read-only if we used the 3 PP bits
>   * combinations that newer processors provide but we currently don't.
>   */
> -#define _PAGE_BIT_SWAP_TYPE	2
> -#define _PAGE_USER		0x00004 /* page may be accessed by userspace */
> -#define _PAGE_EXEC		0x00008 /* execute permission */
> +#define _PAGE_BIT_SWAP_TYPE	0
> +
> +#define _PAGE_EXEC		0x00001 /* execute permission */
> +#define _PAGE_RW		0x00002 /* read & write access allowed */
> +#define _PAGE_READ		0x00004	/* read access allowed */
> +#define _PAGE_USER		0x00008 /* page may be accessed by userspace */
>  #define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
>  /* M (memory coherence) is always set in the HPTE, so we don't need it here */
>  #define _PAGE_COHERENT		0x0
> @@ -23,7 +26,6 @@
>  #define _PAGE_WRITETHRU		0x00040 /* W: cache write-through */
>  #define _PAGE_DIRTY		0x00080 /* C: page changed */
>  #define _PAGE_ACCESSED		0x00100 /* R: page referenced */
> -#define _PAGE_RW		0x00200 /* software: user write access allowed */
>  #define _PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
>  #define _PAGE_SPECIAL		0x10000 /* software: special page */
>


For radix, _PAGE_USER is the inverse of this right ?. Ie, we set that
bit position to 1 to indicate privileged access only.

Also can you use constants like
#define _PAGE_USER PPC_BIT(60)

-aneesh
