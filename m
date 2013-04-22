Return-Path: <aarcange@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 9A3592C0158
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 01:46:58 +1000 (EST)
Date: Mon, 22 Apr 2013 17:46:50 +0200
From: Andrea Arcangeli <aarcange@redhat.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V6 17/27] mm/THP: Add pmd args to pgtable deposit and
 withdraw APIs
Message-ID: <20130422154650.GB13442@redhat.com>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1366624861-24948-18-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366624861-24948-18-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 22, 2013 at 03:30:51PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This will be later used by powerpc THP support. In powerpc we want to use
> pgtable for storing the hash index values. So instead of adding them to
> mm_context list, we would like to store them in the second half of pmd
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>

*snip*

>  #ifndef __HAVE_ARCH_PGTABLE_DEPOSIT
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -void pgtable_trans_huge_deposit(struct mm_struct *mm, pgtable_t pgtable)
> +void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
> +				pgtable_t pgtable)
>  {
>  	assert_spin_locked(&mm->page_table_lock);
>  
> @@ -141,7 +142,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pgtable_t pgtable)
>  #ifndef __HAVE_ARCH_PGTABLE_WITHDRAW
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  /* no "address" argument so destroys page coloring of some arch */
> -pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm)
> +pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
>  {
>  	pgtable_t pgtable;

This will add micro overhead with more variables put in certain regs
or stack. The micro overhead could be optimized away by wrapping the
call with a generic and per-arch header and by adding a __ prefix to
the above one in the generic .c file. I'm neutral but I pointed out so
others are free to comment on it.

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
