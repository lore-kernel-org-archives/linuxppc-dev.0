Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F17C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 23:05:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8396B2089E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 23:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Opn+78pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8396B2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YvDQ3B5bzF3VK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 10:05:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Opn+78pF";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="Opn+78pF"; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YtW81xymzF37b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 09:33:07 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id r9-v6so10377987pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=69Ih0AxspAb3LOagwndf0nAJ0Gw/4Xn5WVb76GM8Zl4=;
 b=Opn+78pFeiAm38S8tKZCcNEMSo2ZkRyw+dKYWyPLp4MS25Ip1WRenp/4a1CfYh9wfa
 4XPqhqN7ADAJGstLtOdjqCR4tWOgV4GcXi5K9jKNvI33afu9+9M5Q3xS+aYlDUZtEc9z
 8FWqxbD6KpEBe9aT75TdS03IJiQEVDKv111dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=69Ih0AxspAb3LOagwndf0nAJ0Gw/4Xn5WVb76GM8Zl4=;
 b=nmrendi33Y/5v5Pgnp6Byxg/XNT82rqm3/Ph6yr/8ZaCKWD9a6D4o9IsnDXKrvvSzC
 ZH/7csauIO0nLMfDvO3KcrJ7HSYWtygqQZUP8oEiykrkb2W5kYj/0T5r+LZ9sno1kDvE
 qKdw55z+1riTd3WWpES/5XxpKitV9Cfn1+4FXJzB0vAdaPKAotX5EuGPNQgV2BNKmLkb
 +dYlF3EYVHE5WA2gs5p14hwYPZuus9fw14MxO83NVlvGk6rPEr221/TnzCH6FpPRTcN3
 Y5XrSldFEcrwrsagAl2jQWOQlhjWfGn/efe2U6CeM+C0RtQM5jnR70yokrKy226z+cHP
 TE3w==
X-Gm-Message-State: ABuFfoiS+R+NE7dHWJxZHUtimx8kHk+9NZe05587b23GdlwK6LKsSVy9
 GbbMF5Jqc9KZHA66z+iz7T+cXA==
X-Google-Smtp-Source: ACcGV61mavqUGksovXZjObMwGIe/HqpZ9cOw5tT0zAj6BM5KqqYwfLYZFTGqOW0BIRGwp/CBZ9RJeA==
X-Received: by 2002:a63:b4b:: with SMTP id
 a11-v6mr16810826pgl.97.1539642785540; 
 Mon, 15 Oct 2018 15:33:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
 by smtp.gmail.com with ESMTPSA id j14-v6sm15591781pgh.52.2018.10.15.15.33.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 15 Oct 2018 15:33:04 -0700 (PDT)
Date: Mon, 15 Oct 2018 15:33:03 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181015223303.GA164293@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181015094209.GA31999@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015094209.GA31999@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Tue, 16 Oct 2018 10:03:11 +1100
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
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, elfring@users.sourceforge.net,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 linux-xtensa@linux-xtensa.org, Jeff Dike <jdike@addtoit.com>,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Ley Foon Tan <lftan@altera.com>, kirill@shutemov.name,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, pantin@google.com, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Richard Weinberger <richard@nod.at>,
 anton.ivanov@kot-begemot.co.uk, nios2-dev@lists.rocketboards.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 02:42:09AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> > Android needs to mremap large regions of memory during memory management
> > related operations.
> 
> Just curious: why?

In Android we have a requirement of moving a large (up to a GB now, but may
grow bigger in future) memory range from one location to another. This move
operation has to happen when the application threads are paused for this
operation. Therefore, an inefficient move like it is now (for example 250ms
on arm64) will cause response time issues for applications, which is not
acceptable. Huge pages cannot be used in such memory ranges to avoid this
inefficiency as (when the application threads are running) our fault handlers
are designed to process 4KB pages at a time, to keep response times low. So
using huge pages in this context can, again, cause response time issues.

Also, the mremap syscall waiting for quarter of a second for a large mremap
is quite weird and we ought to improve it where possible.

> > +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > +	    || old_end - old_addr < PMD_SIZE)
> 
> The || goes on the first line.

Ok, fixed.

> > +		} else if (extent == PMD_SIZE && IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {
> 
> Overly long line.

Ok, fixed. Preview of updated patch is below.

thanks,

 - Joel

------8<---
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v3)

Android needs to mremap large regions of memory during memory management
related operations. The mremap system call can be really slow if THP is
not enabled. The bottleneck is move_page_tables, which is copying each
pte at a time, and can be really slow across a large map. Turning on THP
may not be a viable option, and is not for us. This patch speeds up the
performance for non-THP system by copying at the PMD level when possible.

The speed up is three orders of magnitude. On a 1GB mremap, the mremap
completion times drops from 160-250 millesconds to 380-400 microseconds.

Before:
Total mremap time for 1GB data: 242321014 nanoseconds.
Total mremap time for 1GB data: 196842467 nanoseconds.
Total mremap time for 1GB data: 167051162 nanoseconds.

After:
Total mremap time for 1GB data: 385781 nanoseconds.
Total mremap time for 1GB data: 388959 nanoseconds.
Total mremap time for 1GB data: 402813 nanoseconds.

Incase THP is enabled, the optimization is mostly skipped except in
certain situations. I also flush the tlb every time we do this
optimization since I couldn't find a way to determine if the low-level
PTEs are dirty. It is seen that the cost of doing so is not much
compared the improvement, on both x86-64 and arm64.

Cc: minchan@kernel.org
Cc: pantin@google.com
Cc: hughd@google.com
Cc: lokeshgidra@google.com
Cc: dancol@google.com
Cc: mhocko@kernel.org
Cc: kirill@shutemov.name
Cc: akpm@linux-foundation.org
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/Kconfig |  5 ++++
 mm/mremap.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6801123932a5..9724fe39884f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -518,6 +518,11 @@ config HAVE_IRQ_TIME_ACCOUNTING
 	  Archs need to ensure they use a high enough resolution clock to
 	  support irq time accounting and then call enable_sched_clock_irqtime().
 
+config HAVE_MOVE_PMD
+	bool
+	help
+	  Archs that select this are able to move page tables at the PMD level.
+
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	bool
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 9e68a02a52b1..a8dd98a59975 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		drop_rmap_locks(vma);
 }
 
+static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
+		  unsigned long new_addr, unsigned long old_end,
+		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
+{
+	spinlock_t *old_ptl, *new_ptl;
+	struct mm_struct *mm = vma->vm_mm;
+
+	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK) ||
+	    old_end - old_addr < PMD_SIZE)
+		return false;
+
+	/*
+	 * The destination pmd shouldn't be established, free_pgtables()
+	 * should have release it.
+	 */
+	if (WARN_ON(!pmd_none(*new_pmd)))
+		return false;
+
+	/*
+	 * We don't have to worry about the ordering of src and dst
+	 * ptlocks because exclusive mmap_sem prevents deadlock.
+	 */
+	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
+	if (old_ptl) {
+		pmd_t pmd;
+
+		new_ptl = pmd_lockptr(mm, new_pmd);
+		if (new_ptl != old_ptl)
+			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+
+		/* Clear the pmd */
+		pmd = *old_pmd;
+		pmd_clear(old_pmd);
+
+		VM_BUG_ON(!pmd_none(*new_pmd));
+
+		/* Set the new pmd */
+		set_pmd_at(mm, new_addr, new_pmd, pmd);
+		if (new_ptl != old_ptl)
+			spin_unlock(new_ptl);
+		spin_unlock(old_ptl);
+
+		*need_flush = true;
+		return true;
+	}
+	return false;
+}
+
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
@@ -239,7 +287,25 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
 				continue;
+		} else if (extent == PMD_SIZE &&
+			   IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {
+			/*
+			 * If the extent is PMD-sized, try to speed the move by
+			 * moving at the PMD level if possible.
+			 */
+			bool moved;
+
+			if (need_rmap_locks)
+				take_rmap_locks(vma);
+			moved = move_normal_pmd(vma, old_addr, new_addr,
+						old_end, old_pmd, new_pmd,
+						&need_flush);
+			if (need_rmap_locks)
+				drop_rmap_locks(vma);
+			if (moved)
+				continue;
 		}
+
 		if (pte_alloc(new_vma->vm_mm, new_pmd))
 			break;
 		next = (new_addr + PMD_SIZE) & PMD_MASK;
-- 
2.19.1.331.ge82ca0e54c-goog

