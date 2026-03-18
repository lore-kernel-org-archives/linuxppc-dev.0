Return-Path: <linuxppc-dev+bounces-18344-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B453103E160
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 10:59:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbQnF4DtTz2yjV;
	Wed, 18 Mar 2026 21:59:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773831553;
	cv=none; b=AIU3R/psFlyT35MK1TEOXYGwnuTbBdjunwVo0JtRWoXBPqsMSehL/QIQbPKQ40lz5ZLTIGHJ0z3hktdNK3ZeOZ8nYADLAzahXqgvaZZW+in70lS0W9OhFD4+UyzpTnX4LB1SknwYV6yDopP4Mc1FmfsS1KRqUDfaRto5tJRKZ/w7/fwz6W3qO1PSfQjjlmK+xyLw+l0OAiX02hvZAkxKTkrq75QUSWwCXxLF9fsTIJOCBSEERvbzl+3zyFrnTu0x9urUgmWkPvrH7V/6JFZph3YLclTrjArtAtnTwtVUF3kAGL4P2OHY/xHseQH4DPuInnSDsM3KY9OQezf6xWktXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773831553; c=relaxed/relaxed;
	bh=YL7pvZp59Pe1nW2NYzvHDNhH9ud22MdF0vy7DYMTjBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHOteM9mC0wGNvz3v6DljrINuFVlaHCnSO9n1gImYewweZwcytQL1G+MgS931p4EhgpFIv8S374tA6ThPWdcxnPE/AjmtLTzDU7UQ2naH5m6bMGsaWwz6WOKq3fSvtWrAn3rWWQ/0XqENdGkw10sMwctHZKagmftVcTryD0HvziGEriKEpof3W0vMpn2mVDrAF+7z4Y61Ux8RNmLfmq3ZhPKcIqQmWhd9suqCZVIJ7g6Knw5Qi/QGWP8pSpb1bZKOMrdQcu0Egh6rlc6RgFmlD9bMZt4wsy8qfQE1AXh76TL0vYqMV2x2XISco6Xy7XvOuC3hCwxfAGvHfme063v4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F6uE4wnF; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F6uE4wnF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbQnD4g9Vz2yTH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 21:59:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E494444767;
	Wed, 18 Mar 2026 10:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4541BC2BCB9;
	Wed, 18 Mar 2026 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773831543;
	bh=eXHAfMqh6RkD93DEJUVdAwdOv0hR8c1CLNcm1BQYW+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6uE4wnFoYpsxRBiKT/PjPuXliQ4seo8S9062AZ7tk37rf3ZX++agKVae57LX+29I
	 yOZFWkz8+D78t+J+kBeYs9Qs2oAecfpTnD+o1T2HG0HpEjZo810U5evd+qliij5IiW
	 IgYK3nOftqn6sOZlY2YDSpVWlBfQ8TEo4vTV4YniZHRCKn43nBCEaPD8oZfh0eyMZ+
	 QGWYVHomaz+gh+eL5gKQAhKHGEpiUT2Io7PAeJF3RBHLzyCpPPWb8FuXF0KgA94nWR
	 GlEeCRmq1FL9VNkiAAH6yRt6OeunWDVw1taBsLaZn/I5l4CSyZG2rax4i3zH87YD7F
	 F+nbWE7Og683g==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Larsson <andreas@gaisler.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Jackman <jackmanb@google.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rob Herring <robh@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 2/8] powerpc: opal-core: pair alloc_pages_exact() with free_pages_exact()
Date: Wed, 18 Mar 2026 12:58:21 +0200
Message-ID: <20260318105827.1358927-3-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318105827.1358927-1-rppt@kernel.org>
References: <20260318105827.1358927-1-rppt@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

opal-core allocates buffers with alloc_pages_exact(), but then
marks them as reserved and frees using free_reserved_area().

This is completely unnecessary and the pages allocated with
alloc_pages_exact() can be naturally freed with free_pages_exact().

Replace freeing of memory in opalcore_cleanup() with
free_pages_exact() and simplify allocation code so that it won't mark
allocated pages as reserved.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/powerpc/platforms/powernv/opal-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index e76e462f55f6..abd99ddbf21f 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -303,7 +303,6 @@ static int __init create_opalcore(void)
 	struct device_node *dn;
 	struct opalcore *new;
 	loff_t opalcore_off;
-	struct page *page;
 	Elf64_Phdr *phdr;
 	Elf64_Ehdr *elf;
 	int i, ret;
@@ -329,9 +328,6 @@ static int __init create_opalcore(void)
 		return -ENOMEM;
 	}
 	count = oc_conf->opalcorebuf_sz / PAGE_SIZE;
-	page = virt_to_page(oc_conf->opalcorebuf);
-	for (i = 0; i < count; i++)
-		mark_page_reserved(page + i);
 
 	pr_debug("opalcorebuf = 0x%llx\n", (u64)oc_conf->opalcorebuf);
 
@@ -437,10 +433,7 @@ static void opalcore_cleanup(void)
 
 	/* free the buffer used for setting up OPAL core */
 	if (oc_conf->opalcorebuf) {
-		void *end = (void *)((u64)oc_conf->opalcorebuf +
-				     oc_conf->opalcorebuf_sz);
-
-		free_reserved_area(oc_conf->opalcorebuf, end, -1, NULL);
+		free_pages_exact(oc_conf->opalcorebuf, oc_conf->opalcorebuf_sz);
 		oc_conf->opalcorebuf = NULL;
 		oc_conf->opalcorebuf_sz = 0;
 	}
-- 
2.51.0


