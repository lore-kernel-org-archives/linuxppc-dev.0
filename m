Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC738606A331
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1iRwSzP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSnjw0XD8z30DY;
	Mon, 16 Nov 2026 23:49:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794833348;
	cv=none; b=G8/A0keEoEEEmQVD7G4s00SYKknrN2k0aDlkszcfpgJkKdqyVWZzgWBbFS2s/m5wb0j9YlA1+qFLTTc78FY6YvFF/11G+0NF2KbS5Y/05WtrSUiW7zee56taG05FvvbE48qr2ywv7S+5MkWQBIK5jqYntiFxBE3Ahlmnlg8XRWSg58rgbG/2sT45L4ZCHZ8prjKyJenD9VEVfjwCUgul/QKC1GTT0eyNv4gU8+X9pHtZmGyP6QSoewODS3MNbcrVQptCgDHDG4dKtMJfsepXoziPTDLyG0ZPdMRBT42Ym/sUBbHlkEVvxfINeKkQoxDsIf6lzI7IyDQCliGVIY6DpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794833348; c=relaxed/relaxed;
	bh=T+kkEjnaw2ySVd4lLiujiWW53ZRBsmmAWW3cy3wlJjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQNpQbBj/Md7scpqQA0nCWYYMM2pr3UnPZEpXqAev8x9WQ3HsNicbIdXQbneYbZUGDjCLDY9zXp5uIZ6SKluuTd1SifzZTz2voe0ffXNhqbqFXRIaM+iX7M7JFb9qB+j4rWpXxE9aF+Gezb/L+L9YhALEJRLDQ+IFH/7J0VdXMeV4RJQBRcgzHjO1MrCZRkkmuhiG/sl6R6+jYxknEUNQ2OO66OCDhIs0moCj9RBeCUmmpWw2Y7ky6DhkszdC3VMAG+efe/UhfrjIhGJ8/bZEgc0h0mObR8Frqm88kHps9xoA8P79eq1GpDs6xJySQDJ88BGv5gVPhUaA4pVebtr7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1iRwSzP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1iRwSzP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSnjv2G2yz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 23:49:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C9E7F43421;
	Mon, 16 Nov 2026 12:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FCF1F000C4;
	Mon, 16 Nov 2026 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833345;
	bh=T+kkEjnaw2ySVd4lLiujiWW53ZRBsmmAWW3cy3wlJjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J1iRwSzPkXkJExltWHVg0O8oGOL+tawW+ZmYEGgM1jmGAKgXx8sy7HnmkDQVv80Ss
	 yg4kn+EGjPt1JGKZYyWmr96BKjuswmbOXfgaSRJVySsDYEtOeJ/ovVXA3/PGYaEEQg
	 e3V7fokGmh+Jawesd3SW+NFvr+/7WMp05FEXbQ8wK0id5O9GLzTl/BNPOe8HMP9wyx
	 SXMkzQFD+Nl7UMGApCdcv5Ze+xW2cYq4ISMrZw9YTpwVIzOyl4tI/WGNsQAg4Yn1Op
	 xm4CxP/9WVSS9d5AIaFwkOz7gzndFMorMFu1XaBI6AixyyII7UmWDW9Dxmurqq67j6
	 wYW15Z/uOQhDA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linusw@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH v3 04/10] powerpc: kvm: allow flexible PAGE_OFFSET
Date: Mon, 16 Nov 2026 13:48:26 +0100
Message-ID: <20261116124832.662455-5-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116124832.662455-1-arnd@kernel.org>
References: <20261116124832.662455-1-arnd@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arnd Bergmann <arnd@arndb.de>

As described by the Sashiko bot, the KVM code on powerpc has multiple
hardcoded PAGE_OFFSET values. In order to change the default, make these
compute the correct register values from configuration symbols.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kvm/book3s_32_sr.S     | 4 ++--
 arch/powerpc/kvm/booke_interrupts.S | 4 ++--
 arch/powerpc/kvm/e500_mmu_host.c    | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_32_sr.S b/arch/powerpc/kvm/book3s_32_sr.S
index 6cfcd20d4668..0d8a7857f2bd 100644
--- a/arch/powerpc/kvm/book3s_32_sr.S
+++ b/arch/powerpc/kvm/book3s_32_sr.S
@@ -113,8 +113,8 @@
 
         li      r0, 4
         mtctr   r0
-	LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * 0xc))
-        lis     r4, 0xc000
+	LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * (PAGE_OFFSET >> 28)))
+        lis     r4, (PAGE_OFFSET >> 16)
 3:      mtsrin  r3, r4
         addi    r3, r3, 0x111     /* increment VSID */
         addis   r4, r4, 0x1000    /* address of next segment */
diff --git a/arch/powerpc/kvm/booke_interrupts.S b/arch/powerpc/kvm/booke_interrupts.S
index 205545d820a1..ede394f3f63f 100644
--- a/arch/powerpc/kvm/booke_interrupts.S
+++ b/arch/powerpc/kvm/booke_interrupts.S
@@ -230,8 +230,8 @@ _GLOBAL(kvmppc_resume_host)
 #endif
 
 	/* Restore host IVPR before re-enabling interrupts. We cheat and know
-	 * that Linux IVPR is always 0xc0000000. */
-	lis	r3, 0xc000
+	 * that Linux IVPR is always PAGE_OFFSET. */
+	lis	r3, PAGE_OFFSET >> 16
 	mtspr	SPRN_IVPR, r3
 
 	/* Switch to kernel stack and jump to handler. */
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index fa6128119874..9edad9bed589 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -115,7 +115,8 @@ static u32 get_host_mas0(unsigned long eaddr)
 	mtspr(SPRN_MAS6, 0);
 	mas4 = mfspr(SPRN_MAS4);
 	mtspr(SPRN_MAS4, mas4 & ~MAS4_TLBSEL_MASK);
-	asm volatile("tlbsx 0, %0" : : "b" (eaddr & ~CONFIG_PAGE_OFFSET));
+	asm volatile("tlbsx 0, %0" :
+		: "b" (eaddr & (rounddown_pow_of_two(PAGE_OFFSET)-1)));
 	mas0 = mfspr(SPRN_MAS0);
 	mtspr(SPRN_MAS4, mas4);
 	local_irq_restore(flags);
-- 
2.53.0


