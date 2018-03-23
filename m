Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4072gf3SZSzF0WV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 23:20:46 +1100 (AEDT)
Subject: Re: [PATCH 15/19] powerpc: Add missing prototype
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-16-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <bd4be06c-b5f5-2516-1c1d-d2b6d7861090@c-s.fr>
Date: Fri, 23 Mar 2018 13:20:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180322202007.23088-16-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/03/2018 à 21:20, Mathieu Malaterre a écrit :
> Add one missing prototype for function rh_dump_blk. Fix warning treated as
> error in W=1:
> 
>    arch/powerpc/lib/rheap.c:740:6: error: no previous prototype for ‘rh_dump_blk’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/include/asm/rheap.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/rheap.h b/arch/powerpc/include/asm/rheap.h
> index 172381769cfc..e75d96de19a0 100644
> --- a/arch/powerpc/include/asm/rheap.h
> +++ b/arch/powerpc/include/asm/rheap.h
> @@ -83,6 +83,9 @@ extern int rh_get_stats(rh_info_t * info, int what, int max_stats,
>   /* Simple dump of remote heap info */
>   extern void rh_dump(rh_info_t * info);
>   
> +/* Simple dump of remote info block */
> +extern void rh_dump_blk(rh_info_t *info, rh_block_t *blk);
> +

Only used in one place, should be static

Christophe

>   /* Set owner of taken block */
>   extern int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner);
>   
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
