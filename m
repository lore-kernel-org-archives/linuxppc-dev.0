Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 35B162C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 04:29:01 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 22:59:00 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 569C7394005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:58:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SHSq7A49348678
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:58:53 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SHSusD025179
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:58:56 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: don't re-issue spinlock typedef that breaks
 older gcc
In-Reply-To: <1390925817-27374-1-git-send-email-paul.gortmaker@windriver.com>
References: <1390925817-27374-1-git-send-email-paul.gortmaker@windriver.com>
Date: Tue, 28 Jan 2014 22:58:54 +0530
Message-ID: <87sis810dl.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> Commit b3084f4db3aeb991c507ca774337c7e7893ed04f ("powerpc/thp: Fix
> crash on mremap") added a "typedef struct spinlock spinlock_t;"
> which on gcc 4.5.2 (and possibly other versions) causes many of:
>
> include/linux/spinlock_types.h:76:3: error: redefinition of typedef 'spinlock_t'
> arch/powerpc/include/asm/pgtable-ppc64.h:563:25: note: previous declaration of 'spinlock_t' was here
> In file included from include/linux/mutex.h:15:0,
>                  from include/linux/notifier.h:13,
>                  from include/linux/pm_qos.h:8,
>                  from include/linux/netdevice.h:28,
>                  from drivers/net/wireless/ath/wil6210/wil6210.h:20,
>                  from drivers/net/wireless/ath/wil6210/debug.c:17:
>
> It appears that somewhere between gcc 4.5.2 and 4.6.3 this
> redefinition restriction was lifted.  Using the proper header
> from within !ASSEMBLY seems to fix it up in an acceptable way.
>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>


http://mid.gmane.org/1389939036.3000.7.camel@ThinkPad-T5421.cn.ibm.com

This was posted earlier.



> [ Note that b3084f4db3 isn't mainline yet, it is currently in
>   benh/powerpc.git #merge -- but is headed there soon via:
>              https://lkml.org/lkml/2014/1/27/599           ]
>
>  arch/powerpc/include/asm/pgtable-ppc64.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index d27960c89a71..3b638411646a 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -111,6 +111,8 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <linux/spinlock_types.h>
> +
>  /*
>   * This is the default implementation of various PTE accessors, it's
>   * used in all cases except Book3S with 64K pages where we have a
> @@ -560,7 +562,6 @@ extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>  			    pmd_t *pmdp);
>
>  #define pmd_move_must_withdraw pmd_move_must_withdraw
> -typedef struct spinlock spinlock_t;
>  static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
>  					 spinlock_t *old_pmd_ptl)
>  {
> -- 
> 1.8.5.2
