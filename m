Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com
 [IPv6:2607:f8b0:4001:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9451E1A0292
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Mar 2015 07:13:29 +1100 (AEDT)
Received: by igdh15 with SMTP id h15so11872001igd.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2015 12:13:27 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1425741651-29152-2-git-send-email-mgorman@suse.de>
References: <1425741651-29152-1-git-send-email-mgorman@suse.de>
 <1425741651-29152-2-git-send-email-mgorman@suse.de>
Date: Sat, 7 Mar 2015 12:13:27 -0800
Message-ID: <CA+55aFwGLOfmBMHsFzuqKbJqR43+SVydv5zxh-KWMPD=fQG1UQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: thp: Return the correct value for change_huge_pmd
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Dave Chinner <david@fromorbit.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looks obviously correct. The old code was just very wrong.

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

                     Linus


On Sat, Mar 7, 2015 at 7:20 AM, Mel Gorman <mgorman@suse.de> wrote:
> The wrong value is being returned by change_huge_pmd since commit
> 10c1045f28e8 ("mm: numa: avoid unnecessary TLB flushes when setting
> NUMA hinting entries") which allows a fallthrough that tries to adjust
> non-existent PTEs. This patch corrects it.
>
> Signed-off-by: Mel Gorman <mgorman@suse.de>
> ---
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fc00c8cb5a82..194c0f019774 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1482,6 +1482,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>
>         if (__pmd_trans_huge_lock(pmd, vma, &ptl) == 1) {
>                 pmd_t entry;
> +               ret = 1;
>
>                 /*
>                  * Avoid trapping faults against the zero page. The read-only
> @@ -1490,11 +1491,10 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>                  */
>                 if (prot_numa && is_huge_zero_pmd(*pmd)) {
>                         spin_unlock(ptl);
> -                       return 0;
> +                       return ret;
>                 }
>
>                 if (!prot_numa || !pmd_protnone(*pmd)) {
> -                       ret = 1;
>                         entry = pmdp_get_and_clear_notify(mm, addr, pmd);
>                         entry = pmd_modify(entry, newprot);
>                         ret = HPAGE_PMD_NR;
> --
> 2.1.2
>
