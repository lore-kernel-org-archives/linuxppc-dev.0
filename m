Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31387C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 12:09:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792EA205ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 12:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792EA205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k41M6dN8zDqKs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 22:09:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=de.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=schwidefsky@de.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=de.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k3zF5xxPzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 22:07:52 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3GC7HfB051927
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 08:07:49 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rwe3k1reu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 08:07:46 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Tue, 16 Apr 2019 13:07:04 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 13:07:01 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GC70av52756532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 12:07:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1936EAE055;
 Tue, 16 Apr 2019 12:07:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3789AE053;
 Tue, 16 Apr 2019 12:06:59 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.60])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 12:06:59 +0000 (GMT)
Date: Tue, 16 Apr 2019 14:06:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <20190416110906.6c773aff@mschwideX1>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041612-0008-0000-0000-000002DA661D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041612-0009-0000-0000-000022469E2E
Message-Id: <20190416140658.2cb73a3f@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160083
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
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 16 Apr 2019 11:09:06 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Mon, 15 Apr 2019 09:17:10 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:  
> > >
> > > Can we please have the page refcount overflow fixes out on the list
> > > for review, even if it is after the fact?    
> > 
> > They were actually on a list for review long before the fact, but it
> > was the security mailing list. The issue actually got discussed back
> > in January along with early versions of the patches, but then we
> > dropped the ball because it just wasn't on anybody's radar and it got
> > resurrected late March. Willy wrote a rather bigger patch-series, and
> > review of that is what then resulted in those commits. So they may
> > look recent, but that's just because the original patches got
> > seriously edited down and rewritten.  
> 
> First time I hear about this, thanks for the heads up.
>  
> > That said, powerpc and s390 should at least look at maybe adding a
> > check for the page ref in their gup paths too. Powerpc has the special
> > gup_hugepte() case, and s390 has its own version of gup entirely. I
> > was actually hoping the s390 guys would look at using the generic gup
> > code.  
> 
> We did look at converting the s390 gup code to CONFIG_HAVE_GENERIC_GUP,
> there are some details that need careful consideration. The top one
> is access_ok(), for s390 we always return true. The generic gup code
> relies on the fact that a page table walk with a specific address is
> doable if access_ok() returned true, the s390 specific check is slightly
> different:
> 
>         if ((end <= start) || (end > mm->context.asce_limit))
>                 return 0;
> 
> The obvious approach would be to modify access_ok() to check against
> the asce_limit. I will try and see if anything breaks, e.g. the automatic
> page table upgrade.

I tested the waters in regard to access_ok() and the generic gup code.
The good news is that mm/gup.c with CONFIG_HAVE_GENERIC_GUP=y seems to
work just fine if the access_ok() issue is taken care of. But..

Bloat-o-meter with a non-empty uaccess_ok() that checks against
current->mm->context.asce_limit:

add/remove: 8/2 grow/shrink: 611/11 up/down: 61352/-1914 (59438)

with CONFIG_HAVE_GENERIC_GUP on top of that

add/remove: 10/2 grow/shrink: 612/12 up/down: 63568/-3280 (60288)

This is not nice, would a patch like the following be acceptable?
--
Subject: [PATCH] mm: introduce mm_pgd_walk_ok

Add the architecture overrideable function mm_pgd_walk_ok() to check
if a block of memory is inside the limits of the page table hierarchy
of a given mm struct.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 include/asm-generic/pgtable.h | 4 ++++
 mm/gup.c                      | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index fa782fba51ee..7d2a8a58f1c1 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1186,4 +1186,8 @@ static inline bool arch_has_pfn_modify_check(void)
 #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
 #endif
 
+#ifndef mm_pgd_walk_ok
+#define mm_pgd_walk_ok(mm, addr, size)	access_ok(addr, size)
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
diff --git a/mm/gup.c b/mm/gup.c
index 91819b8ad9cc..b3eb3f45d237 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1990,7 +1990,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
 
-	if (unlikely(!access_ok((void __user *)start, len)))
+	if (unlikely(!mm_pgd_walk_ok(current->mm, (void __user *)start, len)))
 		return 0;
 
 	/*
@@ -2044,7 +2044,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	if (nr_pages <= 0)
 		return 0;
 
-	if (unlikely(!access_ok((void __user *)start, len)))
+	if (unlikely(!mm_pgd_walk_ok(current->mm, (void __user *)start, len)))
 		return -EFAULT;
 
 	if (gup_fast_permitted(start, nr_pages)) {
-- 
2.16.4

With an empty access_ok() but a "real" mm_pgd_walk_ok() the results are
much more reasonable:

add/remove: 2/0 grow/shrink: 2/1 up/down: 2186/-1382 (804)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

