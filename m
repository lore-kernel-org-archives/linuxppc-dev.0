Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28D606A327
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzgtvDcA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvG50c1Kz3bkq;
	Thu, 26 Nov 2026 22:19:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691981;
	cv=none; b=m455MOD2Mxs8z3pJC64gt7fadUfyzE/8wdWRDvDCgJqVUmKo0/epLZK5sDdcWd+TTvxJeB1fEO3Zlv4DnHHgo+bnPACz1+zfGvySBwpxGUjB087qI/rpS5+xop/dM30YG+SIimzeXsjK6F8l6fWzhdc9YZ6NY52nDQkKypD0fmKj10SgVim8yapI7punL3PalUv/1BEyApagxfKDrn/tZf3N22PJxvHTpur+YkXe2g/cEUZWHM35KxD/AOSDPh6HpiXFtbwh/F/Xa1OIQC7q/wnMobRw/IU5e0rkt3vIjz1nQ0+aWaXlpRT7+iQHpj1Ijv3VHZwP34UPQPtluvkm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691981; c=relaxed/relaxed;
	bh=6IUAESVFtsidcpD6OicOHeScwyTIg4rQEjzbtezfzqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmtTxz7jFLEO/NBAqVzp/TylMaTvkXRc+Hirhs1p/wmKmGIfkA7rq9dBixgU4nJSQZrF3LyqXF0XSpx2OWoji8yymilFoh0Dg3JXaUvkiU/vSWmCaZlj9K0mkrI+IIEYw4oZ+q9RmjLUkhDP5gfaWBlQSCcYTbTRhV/oKUROWjsu74lvCDCS5rQVuHvljs9de9xg1kGAzQWPywJtfOkVBKaSo3o2CSwgIk1rTFZNf+Vsv2TdiruNBrO3nyVruKwZeaJzFKizv7HyWfPbFK0xDVgTKC2iRewMQXJ2EcYUJ/TEyM05rm9qMtHMK+N8N/HbIUcdL0WVLmiHb6A21zebVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzgtvDcA; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzgtvDcA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvG41Smyz2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:19:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 51F8C62D47;
	Thu, 26 Nov 2026 11:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D211F00A03;
	Thu, 26 Nov 2026 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691977;
	bh=6IUAESVFtsidcpD6OicOHeScwyTIg4rQEjzbtezfzqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PzgtvDcA4yy/D2Uepj3A4ekmgkoMVvK8vCHb6UdANFhGAR3OBnrXkvAS3r9CqvP2I
	 eDmwCIrTD3P98wMkVnY3W85BeGo+ZeBhcoHLlCd12HdFjujk8Zaf5uhR8BV51AOM9P
	 oW6Xtzx0AUymGG49kFi+8vJRbIFAGKIoVzVQwMCXSTZexmCClqXB7irUaJOvnH7AT5
	 H8yglHbC98pbN4quyuAGcNaw3RNs1KOwrdkUjWO3r1r/5ZIYpv9vJVR16CKt6bfdWC
	 KH8ca4HCAeD7eXntGrPQqRIQieHY1E0JUb0HMs7NmNLeElY0r6qD2n6VSHz7fdgu6N
	 3KyI5zsbNkYeQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:45 +0200
Subject: [PATCH RFC v2 32/54] asm-generic: add an empty pageattr.h
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-32-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

linux/pageattr.h includes asm/pageattr.h for the overrides of the CPA
hooks. An architecture that is fine with all the defaults has nothing to
put there.

Add an empty asm-generic/pageattr.h and make it mandatory, so that such an
architecture does not need an empty header of its own.

LoongArch, ARM and powerpc will pick up the asm-generic/pageattr.h when
they switch to the CPA core.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/asm-generic/Kbuild     | 1 +
 include/asm-generic/pageattr.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index b7a388bef6ea..fd9fb2c3260b 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -42,6 +42,7 @@ mandatory-y += mmu_context.h
 mandatory-y += module.h
 mandatory-y += module.lds.h
 mandatory-y += msi.h
+mandatory-y += pageattr.h
 mandatory-y += pci.h
 mandatory-y += percpu.h
 mandatory-y += percpu_types.h
diff --git a/include/asm-generic/pageattr.h b/include/asm-generic/pageattr.h
new file mode 100644
index 000000000000..07bf3b0e84a0
--- /dev/null
+++ b/include/asm-generic/pageattr.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_PAGEATTR_H
+#define __ASM_GENERIC_PAGEATTR_H
+
+#endif /* __ASM_GENERIC_PAGEATTR_H */

-- 
2.53.0


