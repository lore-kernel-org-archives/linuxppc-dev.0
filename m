Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D756AC04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 10:16:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E13520652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 10:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E13520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YZ993QsZzF3NY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 21:16:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=de.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=de.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=schwidefsky@de.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=de.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YWYG53kbzF2X0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:18:39 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9F8E7dm060225
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 04:18:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n4p4u3094-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 04:18:36 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Mon, 15 Oct 2018 09:18:31 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 15 Oct 2018 09:18:17 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9F8IGEr5439792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Oct 2018 08:18:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D49D44C059;
 Mon, 15 Oct 2018 11:17:50 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62EA74C040;
 Mon, 15 Oct 2018 11:17:49 +0100 (BST)
Received: from mschwideX1 (unknown [9.152.212.164])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 15 Oct 2018 11:17:49 +0100 (BST)
Date: Mon, 15 Oct 2018 10:18:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
In-Reply-To: <6580a62b-69c6-f2e3-767c-bd36b977bea2@de.ibm.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <6580a62b-69c6-f2e3-767c-bd36b977bea2@de.ibm.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18101508-4275-0000-0000-000002CC25A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101508-4276-0000-0000-000037D72734
Message-Id: <20181015101814.306d257c@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-15_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150078
X-Mailman-Approved-At: Mon, 15 Oct 2018 21:14:38 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com,
 "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
 linux-riscv@lists.infradead.org, elfring@users.sourceforge.net,
 Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, nios2-dev@lists.rocketboards.org,
 kirill@shutemov.name, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 Richard Weinberger <richard@nod.at>, linux-parisc@vger.kernel.org,
 pantin@google.com, Max Filippov <jcmvbkbc@gmail.com>,
 linux-kernel@vger.kernel.org, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 Ley Foon Tan <lftan@altera.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Oct 2018 09:10:53 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 10/12/2018 03:37 AM, Joel Fernandes (Google) wrote:
> > Android needs to mremap large regions of memory during memory management
> > related operations. The mremap system call can be really slow if THP is
> > not enabled. The bottleneck is move_page_tables, which is copying each
> > pte at a time, and can be really slow across a large map. Turning on THP
> > may not be a viable option, and is not for us. This patch speeds up the
> > performance for non-THP system by copying at the PMD level when possible.
> > 
> > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > 
> > Before:
> > Total mremap time for 1GB data: 242321014 nanoseconds.
> > Total mremap time for 1GB data: 196842467 nanoseconds.
> > Total mremap time for 1GB data: 167051162 nanoseconds.
> > 
> > After:
> > Total mremap time for 1GB data: 385781 nanoseconds.
> > Total mremap time for 1GB data: 388959 nanoseconds.
> > Total mremap time for 1GB data: 402813 nanoseconds.
> > 
> > Incase THP is enabled, the optimization is skipped. I also flush the
> > tlb every time we do this optimization since I couldn't find a way to
> > determine if the low-level PTEs are dirty. It is seen that the cost of
> > doing so is not much compared the improvement, on both x86-64 and arm64.
> > 
> > Cc: minchan@kernel.org
> > Cc: pantin@google.com
> > Cc: hughd@google.com
> > Cc: lokeshgidra@google.com
> > Cc: dancol@google.com
> > Cc: mhocko@kernel.org
> > Cc: kirill@shutemov.name
> > Cc: akpm@linux-foundation.org
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  mm/mremap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> > 
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 9e68a02a52b1..d82c485822ef 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> >  		drop_rmap_locks(vma);
> >  }
> >  
> > +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> > +		  unsigned long new_addr, unsigned long old_end,
> > +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> > +{
> > +	spinlock_t *old_ptl, *new_ptl;
> > +	struct mm_struct *mm = vma->vm_mm;
> > +
> > +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > +	    || old_end - old_addr < PMD_SIZE)
> > +		return false;
> > +
> > +	/*
> > +	 * The destination pmd shouldn't be established, free_pgtables()
> > +	 * should have release it.
> > +	 */
> > +	if (WARN_ON(!pmd_none(*new_pmd)))
> > +		return false;
> > +
> > +	/*
> > +	 * We don't have to worry about the ordering of src and dst
> > +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> > +	 */
> > +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> > +	if (old_ptl) {
> > +		pmd_t pmd;
> > +
> > +		new_ptl = pmd_lockptr(mm, new_pmd);
> > +		if (new_ptl != old_ptl)
> > +			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> > +
> > +		/* Clear the pmd */
> > +		pmd = *old_pmd;
> > +		pmd_clear(old_pmd);  
> 
> Adding Martin Schwidefsky.
> Is this mapping maybe still in use on other CPUs? If yes, I think for
> s390 we need to flush here as well (in other word we might need to introduce
> pmd_clear_flush). On s390 you have to use instructions like CRDTE,IPTE or IDTE
> to modify page table entries that are still in use. Otherwise you can get a 
> delayed access exception which is - in contrast to page faults - not recoverable.

Just clearing an active pmd would be broken for s390. We need the equivalent
of the ptep_get_and_clear() function for pmds. For s390 this function would
look like this:

static inline pte_t pmdp_get_and_clear(struct mm_struct *mm,
                                       unsigned long addr, pmd_t *pmdp)
{
        return pmdp_xchg_lazy(mm, addr, pmdp, __pmd(_SEGMENT_ENTRY_INVALID));
}

Just like pmdp_huge_get_and_clear() in fact.

> 
> 
> 
> > +
> > +		VM_BUG_ON(!pmd_none(*new_pmd));
> > +
> > +		/* Set the new pmd */
> > +		set_pmd_at(mm, new_addr, new_pmd, pmd);
> > +		if (new_ptl != old_ptl)
> > +			spin_unlock(new_ptl);
> > +		spin_unlock(old_ptl);
> > +
> > +		*need_flush = true;
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +

So the idea is to move the pmd entry to the new location, dragging
the whole pte table to a new location with a different address.
I wonder if that is safe in regard to get_user_pages_fast().

> >  unsigned long move_page_tables(struct vm_area_struct *vma,
> >  		unsigned long old_addr, struct vm_area_struct *new_vma,
> >  		unsigned long new_addr, unsigned long len,
> > @@ -239,7 +287,21 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >  			split_huge_pmd(vma, old_pmd, old_addr);
> >  			if (pmd_trans_unstable(old_pmd))
> >  				continue;
> > +		} else if (extent == PMD_SIZE) {
> > +			bool moved;
> > +
> > +			/* See comment in move_ptes() */
> > +			if (need_rmap_locks)
> > +				take_rmap_locks(vma);
> > +			moved = move_normal_pmd(vma, old_addr, new_addr,
> > +					old_end, old_pmd, new_pmd,
> > +					&need_flush);
> > +			if (need_rmap_locks)
> > +				drop_rmap_locks(vma);
> > +			if (moved)
> > +				continue;
> >  		}
> > +
> >  		if (pte_alloc(new_vma->vm_mm, new_pmd))
> >  			break;
> >  		next = (new_addr + PMD_SIZE) & PMD_MASK;
> >   

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

