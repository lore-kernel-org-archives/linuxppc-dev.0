Return-Path: <linuxppc-dev+bounces-28080-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F52C98310
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 03:26:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqzlj6xq5z2y21;
	Thu, 24 Sep 2026 13:26:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.206
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790220417;
	cv=none; b=R6Xet1ohO+I2Yq/+6g8UNZM4UsvwotFtIbEdEizkQjwjYXy/uYaNcnyTrHuOe9WQ9QmCsvmUCdHLm3Bc3LE6QNCNFfi1fmXskyI6WQc627BxqT4Qx1hRYT++tvw+Nd95eQWxWjCeyI1CG2C68sdiAmP+ILg158vmUNqOAfYSOgGvjMZy4/2DVU+SuHj34NtXbQNlXHtomjsdQPYxPnN32+ntiGerBReDL3dOrhDwvKb2HEh044MU6RBAdir+zMe97crm8AT0TKe4gOT+Qr2WqMiGXPQ4QsbqS2M+TVL9EApdogFCVE/F0H41ZY5ZcS9aJDJU+nl6X2VrArqG7QUX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790220417; c=relaxed/relaxed;
	bh=R3BWZhH71CkI6kIjfqREmsVNahheMeRs+lPAGQsvw7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ay3u9kBh5OM/5sN7HfxnGD5drNffuMKOxWZZcU+rLnD5RtjCg4vBSlfHS/zeoNNrdHYYn3bedWl2BDmVVUnF2FVgfihpV5A7s7EqyHZiJ6q4iRSMbxZl4hEmn0MmVzuxQtwcu9vwOnqJeZS9o9/+Hx0ZKx9taJUsK1WTvbOe6wopsay9zwhHpeMHbwWt5QeEyyxFkOzRSJjyyuf50r+7xXw9AY+PtRuU8ZjnspOV/zBecw4lJfFG7S1fjuQCsUGksxKXdX9CIbUSL7r+/ooO+It4DmmoJV7dAqBpYI4Ad5S+2kqcCP+4nTjdUT0pDFLWeJmNKzs4zDHRVmRY3mCGcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qgGOhmf6; dkim-atps=neutral; spf=pass (client-ip=95.215.58.206; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qgGOhmf6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.206; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqzlf3cPRz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 13:26:52 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=2yvE0h+QEBEUSGV14adujKMIHz+x1ZjAZUB9qMU3ScA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790220394; v=1; x=1790825194;
 b=qgGOhmf6IfmpZAuY5nR09PNkJ2CLfBbLQcIzCxoHH6Y8GX2l0Fgp3QZ/pSfpq/4mTGQaJwqT
 /P+paTRwLqcVXLCauERKMk1pA5/VeA8n6fofZ7V6HgkcjnqZ9YU4unflo7G8RcZw/aJXxg1kQ8U
 R/J0LuQXTaitiSzq2lliz6nk=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id ae8cc7886785f523;
	Thu, 24 Sep 2026 03:26:31 +0000
X-Mizu-Trace-ID: ae8cc7886785f523
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	guoren@kernel.org,
	bcain@kernel.org,
	geert@linux-m68k.org,
	dinguyen@kernel.org,
	schuster.simon@siemens-energy.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux@armlinux.org.uk,
	vgupta@kernel.org,
	monstr@monstr.eu,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	ysato@users.sourceforge.jp,
	shakeel.butt@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	hughd@google.com,
	qi.zheng@linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 12/12] mm: change the contract for free_pgtables(), update docs
Date: Thu, 24 Sep 2026 11:26:25 +0800
Message-ID: <20260924032625.28555-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-12-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-12-fe1ad1f1e303@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 22, 2026 at 04:35:43PM +0100, Lorenzo Stoakes (ARM) wrote:
>Now that page tables are freed after an RCU grace period, it is safe for
>read-only page table walkers to walk page table ranges that are being
>concurrently torn down, provided the mm is kept alive via mmgrab().
>
>It is however unsafe for writers to do so, as they must obtain an
>appropriate lock to do so safely.
>
>Update the pte_offset_map_lock()'s comment block to reflect this.
>
>Similarly update the process addresses documentation.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---
> Documentation/mm/process_addrs.rst |  6 ++++++
> mm/pgtable-generic.c               | 15 +++++++++++----
> 2 files changed, 17 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
>index a7296f251799..b1f4f44d75eb 100644
>--- a/Documentation/mm/process_addrs.rst
>+++ b/Documentation/mm/process_addrs.rst
>@@ -537,6 +537,12 @@ We establish basic locking rules when interacting with page tables:
> * When changing a page table entry the page table lock for that page table
>   **must** be held, except if you can safely assume nobody can access the page
>   tables concurrently (such as on invocation of :c:func:`!free_pgtables`).
>+* Page tables may be *walked* under RCU alone, as page tables are freed only
>+  after an RCU grace period has elapsed. However, any entry found must be
>+  revalidated after the page table lock is taken (such as the
>+  :c:func:`!pmd_same` recheck performed by :c:func:`!pte_offset_map_lock`)
>+  before it is acted upon. Changing an entry requires the page table
>+  lock and one of the locks that excludes teardown (mmap or VMA lock).

What about rmap walkers? try_to_unmap() clears PTEs under the rmap lock
and PTL, without an mmap or VMA lock.

Cheers, Lance

> * Reads from and writes to page table entries must be *appropriately*
>   atomic. See the section on atomicity below for details.
> * Populating previously empty entries requires that the mmap or VMA locks are
>diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>index b91b1a98029c..a127e3e8f9b9 100644
>--- a/mm/pgtable-generic.c
>+++ b/mm/pgtable-generic.c
>@@ -385,10 +385,17 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
>  * Note: "RO" / "RW" expresses the intended semantics, not that the *kmap* will
>  * be read-only/read-write protected.
>  *
>- * Note that free_pgtables(), used after unmapping detached vmas, or when
>- * exiting the whole mm, does not take page table lock before freeing a page
>- * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
>- * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
>+ * Note that free_pgtables(), used after unmapping detached vmas or when exiting
>+ * the whole mm, does not take a page table lock before freeing a page table.
>+ *
>+ * As page table freeing itself is RCU-safe, page table readers can safely run
>+ * concurrently with page table teardown.
>+ *
>+ * However, writers CANNOT as, without a lock being held, nothing prevents
>+ * concurrent teardown.
>+ *
>+ * Also note that the PGD itself is freed at mmdrop() time, not under RCU - so
>+ * the walker must keep the mm alive either by pinning the mm or the VMA.
>  */
> pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> 			   unsigned long addr, spinlock_t **ptlp)
>
>-- 
>2.55.0
>
>

