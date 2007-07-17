Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1DDB8DDE37
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 06:46:14 +1000 (EST)
Subject: Re: [PATCH v2] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
From: Jon Loeliger <jdl@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20070709214853.GA29912@ld0162-tx32.am.freescale.net>
References: <20070709214853.GA29912@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Message-Id: <1184705168.24473.32.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 17 Jul 2007 15:46:08 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-09 at 16:48, Scott Wood wrote:
> In older versions of glibc (through 2.3), the dynamic linker executes a
> small amount of code from the data segment, which is not marked as
> executable.  A recent change (commit 9ba4ace39fdfe22268daca9f28c5df384ae462cf)
> stops this from working; there should be a deprecation period before
> older glibc versions stop working.
> 
> The problem has been observed on glibc 2.2.  While glibc 2.3 has the same
> code, I did not see the problem; it may be that it accesses the page in
> question as data before executing from it, and thus it is already mapped.
> 
> Note that this only applies to the classic 32-bit PowerPC MMU and the
> MPC8xx MMU, not Book E, 64-bit, etc.  These MMUs do not support per-page
> no-exec, and thus this patch isn't taking away any effective protection
> enforcement.  Currently, such accesses will fail only if the page in
> question has not already been faulted on (and thus mapped).
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---

Well now.  I've spent a good chunk of today with Our Friend, git-bisect,
verifying that, in fact, the commit 9ba4ace39fdfe22268daca9f28c5df384ae462cf
breaks the 8641 HPCN port.  init doesn't run off an old NFS'ed root FS
worth a Steven J Hill of beans.

But luckily, this gave me the opportunity to then realize that
we should give a great big...

Amen-brother-by: Jon Loeliger <jdl@freescale.com>

to this patch from Scott.

So, an official plea to Paul to apply this to his tree.

jdl


> v2: Added to the changelog to explain why this change isn't harmful.
> 
>  arch/powerpc/mm/fault.c |   22 +++++++++++++++++++++-
>  1 files changed, 21 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 0ece513..2445512 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -125,6 +125,18 @@ static void do_dabr(struct pt_regs *regs, unsigned long address,
>  }
>  #endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
>  
> +#ifdef CONFIG_PPC32
> +static void warn_exec_from_noexec(void)
> +{
> +	if (printk_ratelimit())
> +		printk(KERN_WARNING "Process %s (%d) attempted to execute from "
> +		                    "a non-executable page.\n"
> +		       KERN_WARNING "This may stop working in future kernels.  "
> +		                    "Please upgrade your libc.\n",
> +		       current->comm, current->pid);
> +}
> +#endif
> +
>  /*
>   * For 600- and 800-family processors, the error_code parameter is DSISR
>   * for a data fault, SRR1 for an instruction fault. For 400-family processors
> @@ -283,8 +295,16 @@ good_area:
>  		/* protection fault */
>  		if (error_code & DSISR_PROTFAULT)
>  			goto bad_area;
> -		if (!(vma->vm_flags & VM_EXEC))
> +		if (!(vma->vm_flags & VM_EXEC)) {
> +#ifdef CONFIG_PPC32
> +			if (vma->vm_flags & VM_READ)
> +				warn_exec_from_noexec();
> +			else
> +				goto bad_area;
> +#else
>  			goto bad_area;
> +#endif
> +		}
>  #else
>  		pte_t *ptep;
>  		pmd_t *pmdp;
