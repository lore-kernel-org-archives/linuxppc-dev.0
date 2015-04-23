Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0146.outbound.protection.outlook.com [65.55.169.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC7531A0BE7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 11:46:44 +1000 (AEST)
Message-ID: <1429753587.16357.9.camel@freescale.com>
Subject: Re: [PATCH 3/3] powerpc/8xx: Implementation of PAGE_EXEC
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Wed, 22 Apr 2015 20:46:27 -0500
In-Reply-To: <77ae326f3637ae008e33875b7be792d64b24461f.1429696335.git.christophe.leroy@c-s.fr>
References: <cover.1429696335.git.christophe.leroy@c-s.fr>
 <77ae326f3637ae008e33875b7be792d64b24461f.1429696335.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-22 at 12:06 +0200, Christophe Leroy wrote:
> diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
> index d41200c..1407034 100644
> --- a/arch/powerpc/include/asm/mmu-8xx.h
> +++ b/arch/powerpc/include/asm/mmu-8xx.h
> @@ -27,6 +27,19 @@
>  #define MI_Ks		0x80000000	/* Should not be set */
>  #define MI_Kp		0x40000000	/* Should always be set */
>  
> +/*
> + * All pages PP exec bits are set to 000, which means Execute for Supervisor
> + * and no Execute for User.
> + * Then we use the APG to say whether accesses are according to Page rules,
> + * "all Supervisor" rules (Exec for all) and "all User" rules (Exec for noone)
> + * Therefore, we define 4 APG groups. msb is _PAGE_EXEC, lsb is _PAGE_USER
> + * 0 (00) => Not User, no exec => 11 (all accesses performed as user)
> + * 1 (01) => User but no exec => 11 (all accesses performed as user)
> + * 2 (10) => Not User, exec => 01 (rights according to page definition)
> + * 3 (11) => User, exec => 00 (all accesses performed as supervisor)
> + */
> +#define MI_APG_INIT	0xf4ffffff
> +
>  /* The effective page number register.  When read, contains the information
>   * about the last instruction TLB miss.  When MI_RPN is written, bits in
>   * this register are used to create the TLB entry.
> @@ -87,6 +100,19 @@
>  #define MD_Ks		0x80000000	/* Should not be set */
>  #define MD_Kp		0x40000000	/* Should always be set */
>  
> +/*
> + * All pages PP exec bits are set to either 000 or 011, which means respectively
> + * RW for Supervisor and no access for User, or RO for Supervisor and no access
> + * for user.
> + * Then we use the APG to say whether accesses are according to Page rules or
> + * "all Supervisor" rules (Access to all)
> + * Therefore, we define 2 APG groups. lsb is _PAGE_USER
> + * 0 => No user => 01 (all accesses performed according to page definition)
> + * 1 => User => 00 (all accesses performed as supervisor
> + *                                 according to page definition)
> + */
> +#define MD_APG_INIT	0x4fffffff

"exec" bits or data?

-Scott
