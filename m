Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D7D962C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 14:16:22 +1100 (EST)
Message-ID: <1390878783.3872.63.camel@pasglop>
Subject: Re: [PATCH RFC 00/73] tree-wide: clean up some no longer required
 #include <linux/init.h>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 28 Jan 2014 14:13:03 +1100
In-Reply-To: <20140123003838.GA10182@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <20140122180023.dd90d34cba38d9f9ac516349@canb.auug.org.au>
 <20140123003838.GA10182@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-m68k@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org,
 kvm@vger.kernel.org, linux-mips@linux-mips.org, linux-s390@vger.kernel.org,
 rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-22 at 19:38 -0500, Paul Gortmaker wrote:

> Thanks, it was a great help as it uncovered a few issues in fringe arch
> that I didn't have toolchains for, and I've fixed all of those up.
> 
> I've noticed that powerpc has been un-buildable for a while now; I have
> used this hack patch locally so I could run the ppc defconfigs to check
> that I didn't break anything.  Maybe useful for linux-next in the
> interim?  It is a hack patch -- Not-Signed-off-by: Paul Gortmaker.  :)

Can you and/or Aneesh submit that as a proper patch (with S-O-B
etc...) ?

Thanks !

Cheers,
Ben.

> Paul.
> --
> 
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index d27960c89a71..d0f070a2b395 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -560,9 +560,9 @@ extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  			    pmd_t *pmdp);
>  
>  #define pmd_move_must_withdraw pmd_move_must_withdraw
> -typedef struct spinlock spinlock_t;
> -static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
> -					 spinlock_t *old_pmd_ptl)
> +struct spinlock;
> +static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
> +					 struct spinlock *old_pmd_ptl)
>  {
>  	/*
>  	 * Archs like ppc64 use pgtable to store per pmd
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
