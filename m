Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A5341A0276
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 18:48:39 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 May 2015 14:18:35 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 73114394005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 14:18:30 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t468mMT036241612
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2015 14:18:23 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t468mJVo014422
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2015 14:18:21 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC PATCH] mm/thp: Use new function to clear pmd before THP
 splitting
In-Reply-To: <20150506001105.GA14559@node.dhcp.inet.fi>
References: <1430760556-28137-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20150506001105.GA14559@node.dhcp.inet.fi>
Date: Wed, 06 May 2015 14:18:17 +0530
Message-ID: <87lhh2ccry.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> On Mon, May 04, 2015 at 10:59:16PM +0530, Aneesh Kumar K.V wrote:
>> Archs like ppc64 require pte_t * to remain stable in some code path.
>> They use local_irq_disable to prevent a parallel split. Generic code
>> clear pmd instead of marking it _PAGE_SPLITTING in code path
>> where we can afford to mark pmd none before splitting. Use a
>> variant of pmdp_splitting_clear_notify that arch can override.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Sorry, I still try wrap my head around this problem.
>
> So, Power has __find_linux_pte_or_hugepte() which does lock-less lookup in
> page tables with local interrupts disabled. For huge pages it casts pmd_t
> to pte_t. Since format of pte_t is different from pmd_t we want to prevent
> transit from pmd pointing to page table to pmd pinging to huge page (and
> back) while interrupts are disabled.
>
> The complication for Power is that it doesn't do implicit IPI on tlb
> flush.
>

s/doesn't do/doesn't need to do/


> Is it correct?

that is correct. I will add more info to the commit message of the patch
I will end up doing.

>
> For THP, split_huge_page() and collapse sides are covered. This patch
> should address two cases of splitting PMD, but not compound page in
> current upstream.
>
> But I think there's still *big* problem for Power -- zap_huge_pmd().
>
> For instance: other CPU can shoot out a THP PMD with MADV_DONTNEED and
> fault in small pages instead. IIUC, for __find_linux_pte_or_hugepte(),
> it's equivalent of splitting.
>
> I don't see how this can be fixed without kick_all_cpus_sync() in all
> pmdp_clear_flush() on Power.
>


Yes we could run into issue with that. Thanks for catching this. Now i
am not sure whether we want to do the kick_all_cpus_sync in
pmdp_get_and_clear. We do use that function while updating huge pte. The
one i am looking at is change_huge_pmd. We don't need a IPI there
and we would really like to avoid the IPI. Any idea why we follow
the sequence of pmd_clear and set_pmd, instead of pmd_update there ?

I looked at code paths we are clearing pmd where we would not
require an IPI. Listing them

move_huge_pmd
do_huge_pmd_wp_page
migrate_misplace_transhuge_page
change_huge_pmd.

Of this IIUC change_huge_pmd may be called more frequently and hence we
may want to avoid doing kick_all_cpus_sync there ?

One way to fix that would be switch change_huge_pmd to pmd_update and
then we could do a kick_all_cpus_sync in pmdp_get_and_clear.

-aneesh
