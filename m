Return-Path: <linuxppc-dev+bounces-27151-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E58C88E5A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 19:39:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhPxK2jthz2yln;
	Sat, 12 Sep 2026 05:39:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789155541;
	cv=none; b=boq503UQ0SsOn/AZbcSmqQkGy9LYCRd6+OdXlsTltZkzgArh9hFTHW3pXgdloFejtYSVJDtQefTk2bj/RMO9ivht+VsDtOCRw4SpYnZHMO4Ta5lwTLc3fkiOZLH2Ipy3Pv/VS8BdLSPRB3Mhanrolw1+PKsmTNcGcRirRY8dBEgOHX1WtBrh0m3ECyT+odXbor/SctpQEHGPlvHA6ebZRt8kIFBtqKh/ZMCeKFqIM4tjwCclx5tD8bGa/7wsmNahkicsDicg0sEBXgC9RJE0NkzfaTnp3U028S/oZuJTRclQOmpOood/L9LJWMUeOrQNeLBKi2KUB0bzwn+VwoMQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789155541; c=relaxed/relaxed;
	bh=dWYqXXcVhqhum5QoL45NNyuXa4EfpjGCy/961eqdzvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G0aKZ77WlaSn8RRx0/tM8W87gA7cBoFRayARqLtWXxi2dxEylpLqd+YCV9/RcaD8HzvfL0B43IhtE86Q1ODhTAyhukDCifhOrvoNTTlqiJK9P6RPa9x2FmWFcwsvG8XKf4dS5uqI8kF3pFlQNfqzT6laEnniy3um1/gCMgCgJcEV/6N7dLMjMEQ/M6MlSnlOebfQBfhv2ylSjl9GW7823PCEJJHuLF2G4a5QVH1xET/do5DV2OUikG9GlSRhKHhs1Rj6Ey8sbJj8XSZIPOK8cdTaJYpgBMepg6sdVgAssI1aTDwSKgElgox44pwUrST+5uH3CpeJq11G8fAy0KS9tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wp7RN6M0; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wp7RN6M0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhPxJ3M8Sz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 05:39:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8237560008;
	Fri, 11 Sep 2026 19:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5FC1F00893;
	Fri, 11 Sep 2026 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155538;
	bh=dWYqXXcVhqhum5QoL45NNyuXa4EfpjGCy/961eqdzvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wp7RN6M0L86FeGpHvZcllj3vCIokf70FAQlmFb0my2TRWM0GhqqE6bZudKHCpCts0
	 5IpQHrKGnnWG+bIkcDmlhu5o/JmejMP+vlO9qxLub0WI2aj33y/PXCJPrlfzzfaxgG
	 wfRru/PZcDX0l+7ekjnU6l1mcPGVvMJ3mpbSQEgXseD9oWYK2HpnfidgjFf2FEnhUo
	 0d8m2F+SGkk1LtOVbi5bZS0uY/wJ9sUmdKZv/QDSEHHuEP8F2v6wnYIaJdzOnH1AwW
	 dXmazlu/e2Xtt/OtHX6TXnZmlwb6uGk3SvGj94GArHUevOjHDzBVbZ5E1AIBL8JCkG
	 O/bo7EuxjGmZQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 11 Sep 2026 20:36:50 +0100
Subject: [PATCH v3 03/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 riscv
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-rcu-pagetable-freeing-v3-3-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, 
 Qi Zheng <qi.zheng@linux.dev>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Ejk+F/Wux5yTvQzPF878nAZnzdraz7QYUlz/y227QJE=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKWRDQKqWW/WBRsHdFlr34u/0fhUyOJ1CeVl/kXd37xF
 rtp8OpURykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACYiKMbw33PDqT2t9smPwr2+
 fZN8x6M9uaJfqklmR1VSWuBq1ukKixj+6Zr+mF/rtsZF4KVQqofE5sKjjVceMvlwNHzdO7fXPke
 EHQA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Currently riscv gates MMU_GATHER_RCU_TABLE_FREE on CONFIG_SMP and
CONFIG_MMU.

Commit 69be3fb111e7 ("riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP &&
MMU") enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE for CONFIG_SMP, CONFIG_MMU
riscv builds.

This is expressly for the safety of GUP-fast walkers (CONFIG_HAVE_GUP_FAST
is enabled if CONFIG_MMU is enabled).

Naturally a single core system does not encounter issues with software page
table walkers being correctly synchronised across cores, as there is only a
single core.

However, CONFIG_PREEMPT_RCU is still available on a riscv UP system, so for
a future RCU-only page table walker, this guarantee is required to prevent
concurrent page table teardown.

All page table freeing is already done via tlb_remove_ptdesc() so the
conditions of CONFIG_MMU_GATHER_RCU_TABLE_FREE are already met.

This forms part of an overall effort to switch every architecture to this
mode.

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 505eed4af932..3529ed1861ce 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -208,7 +208,7 @@ config RISCV
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC if KASAN
 	select LOCK_MM_AND_FIND_VMA
-	select MMU_GATHER_RCU_TABLE_FREE if SMP && MMU
+	select MMU_GATHER_RCU_TABLE_FREE if MMU
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
 	select OF_EARLY_FLATTREE

-- 
2.55.0


