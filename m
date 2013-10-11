Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9B5922C032F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 02:13:21 +1100 (EST)
In-Reply-To: <201310111256.r9BCuepM006243@localhost.localdomain>
References: <201310111256.r9BCuepM006243@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
Subject: Re: [PATCH] powerpc 8xx: Fixing memory init issue with CONFIG_PIN_TLB
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OFF3401910.4A8AA6D0-ONC1257C01.0052FC82-C1257C01.00539C55@transmode.se>
Date: Fri, 11 Oct 2013 17:13:15 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Linuxppc-dev" 
<linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org> 
wrote on 2013/10/11 14:56:40:
> 
> Activating CONFIG_PIN_TLB allows access to the 24 first Mbytes of memory 
at
> bootup instead of 8. It is needed for "big" kernels for instance when 
activating
> CONFIG_LOCKDEP_SUPPORT. This needs to be taken into account in init_32 
too,
> otherwise memory allocation soon fails after startup.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> diff -ur linux-3.11.org/arch/powerpc/kernel/head_8xx.S 
linux-3.11/arch/powerpc/kernel/head_8xx.S
> --- linux-3.11.org/arch/powerpc/mm/init_32.c   2013-09-02 
22:46:10.000000000 +0200
> +++ linux-3.11/arch/powerpc/mm/init_32.c   2013-09-09 11:28:54.000000000 
+0200
> @@ -213,7 +213,12 @@
>      */
>     BUG_ON(first_memblock_base != 0);
> 
> +#ifdef CONFIG_PIN_TLB
> +   /* 8xx can only access 24MB at the moment */
> +   memblock_set_current_limit(min_t(u64, first_memblock_size, 
0x01800000));
> +#else
>     /* 8xx can only access 8MB at the moment */
>     memblock_set_current_limit(min_t(u64, first_memblock_size, 
0x00800000));
> +#endif
>  }
>  #endif /* CONFIG_8xx */

hmm, I think you should always map 24 MB (or less if RAM < 24 MB) and do 
the same
in head_8xx.S.

Or to keep it simple, just always map at least 16 MB here and in 
head_8xx.S, assuming 
that 16 MB is min RAM for any 8xx system running 3.x kernels.

Much of the need for pinning would go away if you adopted my 8MB pages 
from 2.4 to 3.x 

   Jocke
