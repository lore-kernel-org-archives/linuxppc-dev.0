Return-Path: <linuxppc-dev+bounces-27451-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA959C982C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 02:01:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl2F01CgLz2xkr;
	Wed, 16 Sep 2026 12:01:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789524100;
	cv=none; b=nqEuBYSI9Dtekjic9ubttfVKqtq3uN95Qm5YGryXMofDJSf4OdkSfZlXG/m3bQuWD/01K8wIzznIECO6eQ950snynknYWZRWDxd3k1V4bD4jARI0gBP3AjH8KnB3K51zK1jO2lQP0Llri2ar3slZe+BdCS8q0DGOBgbgzCpT3ZV0BdXDLIWndK4q2d/+YKV+plqgB2f8LAA1jJNcF8eqIE8a6yyDmoMvFVcr8I16lIDbVWWhCuttKygSsC6mugUimguT/miB/qshwgPOKPx76zj30AIjLsinQ1WclFzdXVTIZmA/PxZl4IRSL+1Eow1qYukzlZselOSw9V6bfmRmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789524100; c=relaxed/relaxed;
	bh=Kq4nX0CZWZvbBl1ewxdrR8njTtxJd2HKKhLZ4yZoin4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d9EDGqMIifmlAW3CtzPF2gJD1oSC1HOyd169kZu9kKnw7CymmMkTDwuFcLYnpAYuQeMYgnjgWHgzh/kYJusEyPV1aleXI5kr5V0Rw9kR/b4NP3hrXO4BCbRifVpCiv+Uwzpkr3t1UPnMZI7MLy0U5fiVncdWzisVSwluR7umXTEygWJ2EtT6N/b06DxuOyfnm3UolQFICwO8HiWeC30bdWPxSGMGHtEIhgYobRa++QJJD10I5qZbCv937InucmL3u3hrN9rZPJta01V5uv7jOPcN8FPN+yjDLKoH/glhxMdMj2gLQsGQDbdB/iRJb2lIFgkXFYVNcMljYqJHPCFyYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=HA4IrxR+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=HA4IrxR+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl2Dy6nCCz2xWV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 12:01:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CDE3560214;
	Wed, 16 Sep 2026 02:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E999D1F00893;
	Wed, 16 Sep 2026 02:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789524094;
	bh=Kq4nX0CZWZvbBl1ewxdrR8njTtxJd2HKKhLZ4yZoin4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HA4IrxR+bH6KFYi5TWsVFFRj5NN/KsmXWn+L2rcKXslNm+h4O1+C0Mz1TX/mnbSd5
	 wNlo1vs7L/RwOu/p4JC+a32HO1/edlho+RmyG7M/c8w2xQw4dUW63KjVSNntMUP6xo
	 zHIhd6HWzSLYzzfxhv0JalmDYIqgVcBuZA1Pa2/U=
Date: Tue, 15 Sep 2026 19:01:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren
 <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster
 <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne
 <shorne@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich
 Felker <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, Vineet Gupta
 <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris Zankel
 <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Will Deacon
 <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick
 Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng
 <qi.zheng@linux.dev>
Subject: Re: [PATCH v3 00/12] mm: make userland page table freeing RCU-safe
Message-Id: <20260915190131.adee185f2ce04a8ec821489c@linux-foundation.org>
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 20:36:47 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> The majority of architectures in the kernel defer page table freeing until
> an RCU grace period has elapsed, this series converts all remaining
> architectures to do so too and eliminates CONFIG_MMU_GATHER_RCU_TABLE_FREE
> altogether.

Thanks, I've updated mm.git's mm-unstable branch to this version.

> v3:
> * Added Kiryl's tag to series (thanks! :)
> * Corrected commit message, comment indentation in 11/12 as per Kiryl.
> * Corrected 12/12 documentation as per Kiryl.

Here's how v3 altered mm.git:


 Documentation/mm/process_addrs.rst |    4 ++--
 include/asm-generic/tlb.h          |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/Documentation/mm/process_addrs.rst~b
+++ a/Documentation/mm/process_addrs.rst
@@ -541,8 +541,8 @@ We establish basic locking rules when in
   after an RCU grace period has elapsed. However, any entry found must be
   revalidated after the page table lock is taken (such as the
   :c:func:`!pmd_same` recheck performed by :c:func:`!pte_offset_map_lock`)
-  before it is acted upon. Changing an entry always requires the page table
-  lock.
+  before it is acted upon. Changing an entry requires the page table
+  lock and one of the locks that excludes teardown (mmap or VMA lock).
 * Reads from and writes to page table entries must be *appropriately*
   atomic. See the section on atomicity below for details.
 * Populating previously empty entries requires that the mmap or VMA locks are
--- a/include/asm-generic/tlb.h~b
+++ a/include/asm-generic/tlb.h
@@ -151,8 +151,8 @@
  *  Page directories (__p*_free_tlb()) are always freed via tlb_remove_table(),
  *  after an RCU grace period (see mm/mmu_gather.c).
  *
- * This serialises against software page-table walkers, including architectures
- * which do not use IPIs for remote TLB invalidates.
+ *  This serialises against software page-table walkers, including architectures
+ *  which do not use IPIs for remote TLB invalidates.
  *
  *  An architecture is expected to provide __tlb_remove_table() (see
  *  HAVE_ARCH_TLB_REMOVE_TABLE) or use the generic __tlb_remove_table(), which
_


