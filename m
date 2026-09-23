Return-Path: <linuxppc-dev+bounces-27984-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B891C982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 08:06:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqV0P5kBMz2ySj;
	Wed, 23 Sep 2026 18:06:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::84"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790150773;
	cv=none; b=Phe2EVbHSaPbtRaxKE+g0t480yS2n0PxNT5cKxxkRIhvlH+g8E6RXWPQtA0WxxUzlG/1Oo2vi1/HoZ27nAUcfqtEeJzeNdqNE9bRBmDzfLlZT9a8gFqXgoCzghYEjrAX5XOrTm9g5ZDIQRU417pzlVLJrrxHuJGOvJB8SKLeEfWr0N4VSFiuywnd2QIlihtDrJz4Xh9YDoBBUiySV6STu8vQdaorKVCcqQHNuXp9cJvXaVOG3a+tD3uPx3JIGo+ZtFRTa7BovGw94JbLMd6trahYJaSRE+NWPuCawXz3oiJ26q9cRm1j3IlPmBcB7bpPAtTP0e8VpMcnm+N8Bu/asQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790150773; c=relaxed/relaxed;
	bh=8PVPdXmv6NnvLVZVQ7aZbUUffkgQCjLv7KTz76oZcF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAUg4YVP6pdLyNp9Lsq+zHbsun6Y6C/P3XIXdwhEQcMdPm9ACPceq66ykuHs4YJ3i+DgCGVC5g8WgBooGX2HXmtALSMMrZ4LmBUoML1NbjL0B7fELcWWmGLURN3E0mzlJ5t6BBIG8tTIfLrnhB7IOfSi1fE4y63b/tJWxAzGj1Wg6hbMiCTSy7tBi0bW4+9JL95SPW1uRH0IjVvhnFxX5/wbBMpfjIH2a2ipJt0WNVHAtxM0oxj63oXNv7pLr0whGIk0mnSk0tmGXf4mJfO6GmUWt/s1HCpa91Myg8jlSFzTGVseXvneKarooqUj4vGnJPLPKs2uVXi8AUDBh1oYTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WWzI1t7T; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::84; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WWzI1t7T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::84; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-132.mta0.migadu.com [IPv6:2001:41d0:1004:224b::84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqV0J5JGvz2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 18:06:05 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=5BGZTHY8kFe6g0IgkeIcnp2oHzMTIKE0zyxoC0cn6HM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790150746; v=1; x=1790755546;
 b=WWzI1t7TTqFw2wr0jDkPbtN7TwQkuQvfOO3Aoft9mKRYRiQ8BJkP6zHsQzDXqVepu6W5cjvb
 tfHsZBOIWQv3UyolWYXTaga2Up9GF8hClSUeIYphsrLfUFaHgusY8nU/X1vFS5NizsI0/JMz8p6
 fN5aMOPIlrRM1utL1VgA1DNQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 0dc515f7c86dd02d;
	Wed, 23 Sep 2026 08:05:34 +0000
X-Mizu-Trace-ID: 0dc515f7c86dd02d
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
Subject: Re: [PATCH v4 04/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU arm
Date: Wed, 23 Sep 2026 16:05:23 +0800
Message-ID: <20260923080523.9480-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-4-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-4-fe1ad1f1e303@kernel.org>
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


On Tue, Sep 22, 2026 at 04:35:35PM +0100, Lorenzo Stoakes (ARM) wrote:
>Commit a0ad5496b2b3 ("arm: mm: enable HAVE_RCU_TABLE_FREE logic") enabled
>CONFIG_MMU_GATHER_RCU_TABLE_FREE (then named HAVE_RCU_TABLE_FREE) for SMP
>arm architectures with LPAE enabled.
>
>Regardless of whether CONFIG_ARM_LPAE is enabled or not, the same page
>table freeing functions __pte_free_tlb() and __pmd_free_tlb() are used.
>
>Non-LPAE PMD page tables are folded into the PGD and freed by
>pgd_free() (PGD freeing is not part of mmu_gather page table freeing in any
>case), so this is a noop in this case.
>
>Since commit 358d1c39c82a ("arm: convert various functions to use ptdescs")
>both LPAE and non-LPAE PTE page table freeing uses tlb_remove_ptdesc().
>
>Thus all page table freeing is performed under RCU with
>CONFIG_MMU_GATHER_RCU_TABLE_FREE enabled for LPAE and non-LPAE and thus it
>need not be gated on LPAE.
>
>A UP arm system can set CONFIG_PREEMPT_RCU, so a future pure RCU page
>table walker requires MMU_GATHER_RCU_TABLE_FREE to be enabled on UP as
>well, even if concurrent GUP fast is not possible there.
>
>Therefore, it is both safe and desirable to set
>CONFIG_MMU_GATHER_RCU_TABLE_FREE for all MMU arm architectures (nommu does
>not perform mmu_gather operations).
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Tested under heavy page-table teardown load on qemu-system-arm,
with and without ARM_LPAE. No issues seen :D

Tested-by: Lance Yang <lance.yang@linux.dev>

Also, feel free to add:

Acked-by: Lance Yang <lance.yang@linux.dev>


> arch/arm/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>index 408aa58a2a5b..72b9afc6ae10 100644
>--- a/arch/arm/Kconfig
>+++ b/arch/arm/Kconfig
>@@ -134,7 +134,7 @@ config ARM
> 	select HAVE_PERF_REGS
> 	select HAVE_PERF_USER_STACK_DUMP
> 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
>-	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
>+	select MMU_GATHER_RCU_TABLE_FREE if MMU
> 	select HAVE_REGS_AND_STACK_ACCESS_API
> 	select HAVE_RSEQ
> 	select HAVE_RUST if CPU_LITTLE_ENDIAN && CPU_32v7 && !KASAN
>
>-- 
>2.55.0
>
>

