Return-Path: <psomas@ece.ntua.gr>
Received: from ulysses.noc.ntua.gr (ulysses.noc.ntua.gr [147.102.222.230])
	by ozlabs.org (Postfix) with ESMTP id 285EEB71A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 06:32:41 +1000 (EST)
Message-ID: <4DD6CFB9.6090101@ece.ntua.gr>
Date: Fri, 20 May 2011 23:31:53 +0300
From: Stratos Psomadakis <psomas@ece.ntua.gr>
MIME-Version: 1.0
To: Marcus Meissner <meissner@suse.de>
Subject: Re: PATCH: powerpc: remove unused variable assignment
References: <20110520091346.GC29499@suse.de>
In-Reply-To: <20110520091346.GC29499@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: akpm@linux-foundation.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/20/2011 12:13 PM, Marcus Meissner wrote:
> Hi,
>
> gcc 4.6 with -Werror does not like setting but not using variables
> anymore.
>
> So remove it, it does not seem necessary.
>
> Signed-off-by: Marcus Meissner <meissner@suse.de>
>
> Ciao, Marcus
> ---
>  arch/powerpc/include/asm/pgtable-ppc64.h |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index 2b09cd5..c3d39de 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -257,21 +257,17 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  				      pte_t *ptep)
>  {
> -	unsigned long old;
> -
>         	if ((pte_val(*ptep) & _PAGE_RW) == 0)
>         		return;
> -	old = pte_update(mm, addr, ptep, _PAGE_RW, 0);
> +	pte_update(mm, addr, ptep, _PAGE_RW, 0);
>  }
>  
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> -	unsigned long old;
> -
>  	if ((pte_val(*ptep) & _PAGE_RW) == 0)
>  		return;
> -	old = pte_update(mm, addr, ptep, _PAGE_RW, 1);
> +	pte_update(mm, addr, ptep, _PAGE_RW, 1);
>  }
>  
>  /*
It's already in the ppc repo [1]. And going to be merged in 2.6.40 I
think. :)

[1]
http://git.kernel.org/?p=linux/kernel/git/benh/powerpc.git;a=commit;h=2a2c29c1a581319f4485af55e8d628d89e8f2583


-- 
Stratos Psomadakis
<psomas@ece.ntua.gr>
