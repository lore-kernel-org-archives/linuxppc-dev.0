Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D952CC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:26:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E852087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E852087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Sh541RH3zDqM4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 04:26:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Sh2s6WNJzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 04:24:30 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Mar 2019 10:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; d="scan'208";a="125738993"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga007.jf.intel.com with ESMTP; 25 Mar 2019 10:24:26 -0700
Date: Mon, 25 Mar 2019 02:23:15 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RESEND 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
Message-ID: <20190325092314.GF16366@iweiny-DESK2.sc.intel.com>
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-5-ira.weiny@intel.com>
 <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
 <20190325084225.GC16366@iweiny-DESK2.sc.intel.com>
 <20190325164713.GC9949@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325164713.GC9949@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: Michal Hocko <mhocko@suse.com>, Linux-sh <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-mm <linux-mm@kvack.org>, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-rdma@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 25, 2019 at 01:47:13PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 25, 2019 at 01:42:26AM -0700, Ira Weiny wrote:
> > On Fri, Mar 22, 2019 at 03:12:55PM -0700, Dan Williams wrote:
> > > On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
> > > >
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > >
> > > > DAX pages were previously unprotected from longterm pins when users
> > > > called get_user_pages_fast().
> > > >
> > > > Use the new FOLL_LONGTERM flag to check for DEVMAP pages and fall
> > > > back to regular GUP processing if a DEVMAP page is encountered.
> > > >
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > >  mm/gup.c | 29 +++++++++++++++++++++++++----
> > > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > index 0684a9536207..173db0c44678 100644
> > > > +++ b/mm/gup.c
> > > > @@ -1600,6 +1600,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> > > >                         goto pte_unmap;
> > > >
> > > >                 if (pte_devmap(pte)) {
> > > > +                       if (unlikely(flags & FOLL_LONGTERM))
> > > > +                               goto pte_unmap;
> > > > +
> > > >                         pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
> > > >                         if (unlikely(!pgmap)) {
> > > >                                 undo_dev_pagemap(nr, nr_start, pages);
> > > > @@ -1739,8 +1742,11 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> > > >         if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
> > > >                 return 0;
> > > >
> > > > -       if (pmd_devmap(orig))
> > > > +       if (pmd_devmap(orig)) {
> > > > +               if (unlikely(flags & FOLL_LONGTERM))
> > > > +                       return 0;
> > > >                 return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
> > > > +       }
> > > >
> > > >         refs = 0;
> > > >         page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> > > > @@ -1777,8 +1783,11 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
> > > >         if (!pud_access_permitted(orig, flags & FOLL_WRITE))
> > > >                 return 0;
> > > >
> > > > -       if (pud_devmap(orig))
> > > > +       if (pud_devmap(orig)) {
> > > > +               if (unlikely(flags & FOLL_LONGTERM))
> > > > +                       return 0;
> > > >                 return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
> > > > +       }
> > > >
> > > >         refs = 0;
> > > >         page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> > > > @@ -2066,8 +2075,20 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
> > > >                 start += nr << PAGE_SHIFT;
> > > >                 pages += nr;
> > > >
> > > > -               ret = get_user_pages_unlocked(start, nr_pages - nr, pages,
> > > > -                                             gup_flags);
> > > > +               if (gup_flags & FOLL_LONGTERM) {
> > > > +                       down_read(&current->mm->mmap_sem);
> > > > +                       ret = __gup_longterm_locked(current, current->mm,
> > > > +                                                   start, nr_pages - nr,
> > > > +                                                   pages, NULL, gup_flags);
> > > > +                       up_read(&current->mm->mmap_sem);
> > > > +               } else {
> > > > +                       /*
> > > > +                        * retain FAULT_FOLL_ALLOW_RETRY optimization if
> > > > +                        * possible
> > > > +                        */
> > > > +                       ret = get_user_pages_unlocked(start, nr_pages - nr,
> > > > +                                                     pages, gup_flags);
> > > 
> > > I couldn't immediately grok why this path needs to branch on
> > > FOLL_LONGTERM? Won't get_user_pages_unlocked(..., FOLL_LONGTERM) do
> > > the right thing?
> > 
> > Unfortunately holding the lock is required to support FOLL_LONGTERM (to check
> > the VMAs) but we don't want to hold the lock to be optimal (specifically allow
> > FAULT_FOLL_ALLOW_RETRY).  So I'm maintaining the optimization for *_fast users
> > who do not specify FOLL_LONGTERM.
> > 
> > Another way to do this would have been to define __gup_longterm_unlocked with
> > the above logic, but that seemed overkill at this point.
> 
> get_user_pages_unlocked() is an exported symbol, shouldn't it work
> with the FOLL_LONGTERM flag?
> 
> I think it should even though we have no user..
> 
> Otherwise the GUP API just gets more confusing.

I agree WRT to the API.  But I think callers of get_user_pages_unlocked() are
not going to get the behavior they want if they specify FOLL_LONGTERM.

What I could do is BUG_ON (or just WARN_ON) if unlocked is called with
FOLL_LONGTERM similar to the code in get_user_pages_locked() which does not
allow locked and vmas to be passed together:

        if (locked) {
                /* if VM_FAULT_RETRY can be returned, vmas become invalid */
                BUG_ON(vmas);
                /* check caller initialized locked */
                BUG_ON(*locked != 1);
        }

Combining Dan's comment and yours; I could do something like below? (not even
compile tested)  Coded with WARN_ON because technically I _think_ the
FOLL_LONGTERM would "work" but not be optimal.  I'm just not 100% sure.  A
BUG_ON would be most protective IMO.


diff --git a/mm/gup.c b/mm/gup.c
index 173db0c44678..8e31411f485f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1014,6 +1014,29 @@ long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(get_user_pages_locked);
 
+long __gup_longterm_unlocked(unsigned long start, unsigned long nr_pages,
+			     struct page **pages, unsigned int gup_flags)
+{
+	struct mm_struct *mm = current->mm;
+	int locked = 1;
+	long ret;
+
+	down_read(&mm->mmap_sem);
+	if (gup_flags & FOLL_LONGTERM) {
+		ret = __gup_longterm_locked(current, mm,
+					    start, nr_pages - nr,
+					    pages, NULL, gup_flags);
+	} else {
+		ret = __get_user_pages_locked(current, mm, start, nr_pages,
+					      pages, NULL, &locked,
+					      gup_flags | FOLL_TOUCH);
+	}
+	if (locked)
+		up_read(&mm->mmap_sem);
+
+	return ret;
+}
+
 /*
  * get_user_pages_unlocked() is suitable to replace the form:
  *
@@ -1032,16 +1055,9 @@ EXPORT_SYMBOL(get_user_pages_locked);
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 			     struct page **pages, unsigned int gup_flags)
 {
-	struct mm_struct *mm = current->mm;
-	int locked = 1;
-	long ret;
+	WARN_ON(gup_flags & FOLL_LONGTERM);
 
-	down_read(&mm->mmap_sem);
-	ret = __get_user_pages_locked(current, mm, start, nr_pages, pages, NULL,
-				      &locked, gup_flags | FOLL_TOUCH);
-	if (locked)
-		up_read(&mm->mmap_sem);
-	return ret;
+	__gup_longterm_unlocked(start, nr_pages, pages, gup_flags);
 }
 EXPORT_SYMBOL(get_user_pages_unlocked);
 
@@ -2075,20 +2091,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 		start += nr << PAGE_SHIFT;
 		pages += nr;
 
-		if (gup_flags & FOLL_LONGTERM) {
-			down_read(&current->mm->mmap_sem);
-			ret = __gup_longterm_locked(current, current->mm,
-						    start, nr_pages - nr,
-						    pages, NULL, gup_flags);
-			up_read(&current->mm->mmap_sem);
-		} else {
-			/*
-			 * retain FAULT_FOLL_ALLOW_RETRY optimization if
-			 * possible
-			 */
-			ret = get_user_pages_unlocked(start, nr_pages - nr,
-						      pages, gup_flags);
-		}
+		__gup_longterm_unlocked();
 
 		/* Have to be a bit careful with return values */
 		if (nr > 0) {
