Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 48FE22C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 02:11:58 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 13 Feb 2014 01:11:56 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3B3843578054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 02:11:54 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1CEqP4v5570854
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 01:52:25 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1CFBrKE021477
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 02:11:53 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2] powerpc: thp: Fix crash on mremap
In-Reply-To: <20140212142334.GB7688@kroah.com>
References: <1391781117-19045-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140211173129.GB30336@kroah.com> <87ioslt54d.fsf@linux.vnet.ibm.com>
 <20140212142334.GB7688@kroah.com>
Date: Wed, 12 Feb 2014 20:41:48 +0530
Message-ID: <8761oktlfv.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Feb 12, 2014 at 08:22:02AM +0530, Aneesh Kumar K.V wrote:
>> Greg KH <gregkh@linuxfoundation.org> writes:
>> 
>> > On Fri, Feb 07, 2014 at 07:21:57PM +0530, Aneesh Kumar K.V wrote:
>> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> >> 
>> >> This patch fix the below crash
>> >> 
>> >> NIP [c00000000004cee4] .__hash_page_thp+0x2a4/0x440
>> >> LR [c0000000000439ac] .hash_page+0x18c/0x5e0
>> >> ...
>> >> Call Trace:
>> >> [c000000736103c40] [00001ffffb000000] 0x1ffffb000000(unreliable)
>> >> [437908.479693] [c000000736103d50] [c0000000000439ac] .hash_page+0x18c/0x5e0
>> >> [437908.479699] [c000000736103e30] [c00000000000924c] .do_hash_page+0x4c/0x58
>> >> 
>> >> On ppc64 we use the pgtable for storing the hpte slot information and
>> >> store address to the pgtable at a constant offset (PTRS_PER_PMD) from
>> >> pmd. On mremap, when we switch the pmd, we need to withdraw and deposit
>> >> the pgtable again, so that we find the pgtable at PTRS_PER_PMD offset
>> >> from new pmd.
>> >> 
>> >> We also want to move the withdraw and deposit before the set_pmd so
>> >> that, when page fault find the pmd as trans huge we can be sure that
>> >> pgtable can be located at the offset.
>> >> 
>> >> variant of upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f
>> >> for 3.12 stable series
>> >
>> > This doesn't look like a "variant", it looks totally different.  Why
>> > can't I just take the b3084f4db3aeb991c507ca774337c7e7893ed04f patch
>> > (and follow-on fix) for 3.12?
>> 
>> Because the code in that function changed in 3.13. Kirill added split
>> ptl locks for huge pte, and we decide whether to withdraw and
>> deposit again based on the ptl locks in 3.13. In 3.12 we do that only
>> for ppc64 using #ifdef
>
> I have no idea what that means...
>
> If you want this patch applied, please be specific as to what is going
> on, why the code is _very_ different, and all of that.  Make it
> _obvious_ as to what is happening, and why I would be a fool not to take
> it in the stable tree.
>
> As it is, the code in this patch looks so different that I'm just
> assuming you got something wrong and are trying to really send me
> something else, so I'll just ignore it.

3.13 we added split huge ptl lock which introduced separate lock at pmd
level for hugepage (bf929152e9f6c49b66fad4ebf08cc95b02ce48f5). This
required us 3592806cfa08b7cca968f793c33f8e9460bab395. ie, when we move
huge page, we need to withdraw and deposit PTE page if we are moving
them across different pmd page. We did that by checking spin lock
address in 3.13. ie, we have


 if (new_ptl != old_ptl) {
.....
       pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
       pgtable_trans_huge_deposit(mm, new_pmd,pgtable);
...
}

ppc64 even without using split ptl had PTE page per pmd entry. The
details for that are explained in the commit message above. So when
we move huge page we need to withdraw and deposit PTE page always on
ppc64.

Now on 3.13 we added a new function which did


static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
                                        spinlock_t *old_pmd_ptl)
{
       /*
        * With split pmd lock we also need to move preallocated
        * PTE page table if new_pmd is on different PMD page table.
        */
       return new_pmd_ptl != old_pmd_ptl;
}

for x86

and on ppc64 we did

static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
                                        spinlock_t *old_pmd_ptl)
{
       /*
        * Archs like ppc64 use pgtable to store per pmd
        * specific information. So when we switch the pmd,
        * we should also withdraw and deposit the pgtable
        */
       return true;
}

ie, on ppc64 we always did withdraw and deposit and on x86 we do that
only when spin lock address are different.

For 3.12, since we don't have split huge ptl locks yet, we did the below

+#ifdef CONFIG_ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW
+		/*
+		 * Archs like ppc64 use pgtable to store per pmd
+		 * specific information. So when we switch the pmd,
+		 * we should also withdraw and deposit the pgtable
+		 */
+		pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
+		pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
+#endif

CONFIG_ARCH_THP_MOVE_PMD_ALWAYS_WITHDRAW is only set for PPC64.

-aneesh
