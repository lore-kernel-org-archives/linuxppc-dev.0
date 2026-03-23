Return-Path: <linuxppc-dev+bounces-18602-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5C4EC01A0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:49:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQKz3kkWz2yZN;
	Mon, 23 Mar 2026 18:49:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252167;
	cv=none; b=Kr8HrqWZih2E278dl67JWp9JaFe2OVoZF3iIhECrta2u3X9KJkqxiIPcyCAAqxiH2IIG5caeRnXpTfREXwjpUc6fY8H7yZXeJB48ddzn66j5SYnJxqmc+u3UROf4ZPsu/RICxA/JMF8MGz06nOOX0Ljs8RHUEgBkKllBIjE1TJKHZ1hxHU6pUXcKprf77DhdICvJZ3RosXck64V7vzPiMNdLCc+PVEXyn/Ou5JWcVGXHS+y0uIX9erXPbefg5Iib6UKd3hDDLRBm4LUotA7a6x/vP3YIzSWefvMtWI3ISFLa8MSxQn0ZEC9lkfmyEbeI10OPp/cLIi4atltJEgCGog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252167; c=relaxed/relaxed;
	bh=EJzb2fLH8dZQbmaimNfUiNnzxhnIKEQ1hMjT2Y397N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDQRWMkFFLrWZ31XxmIBPNRpSYlpIgdwpN8CV9t39+e+5u/wRV5szJEga8MqsTy2LXX78DxwfVsHBA5xgF8M7rEum9iXgNmQffsUGP+sFyn54hjOzcD6L6bZ24YAOIxo/fJ/pGqDw5aVaAXHV9wed8MHqB+AhmctYt5fQhZrHmadnI6HMd4Tpk55ZsNLsiuJar1/Hv5f4/oUSE7PUjELGWwyXVSicCg6gNvGs9FRQJlErjfDgkqD44tyae07Q+NV1E5pxTiHTn9El4tv6vINFoPtq42IqwiFeBIAfyurjNe0V7wiqecEwbKMxKZDsBgi8UxlhbNiWfjE/Z5OQpoQXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I5My3+MQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I5My3+MQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQKy0myhz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:49:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F20A34181A;
	Mon, 23 Mar 2026 07:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3804AC4CEF7;
	Mon, 23 Mar 2026 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252163;
	bh=H66xl/BIJkTq28ukNF8WEu/fNAsPeeebsB5A/nwWYaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I5My3+MQvuPzdJ/eqnURHDufO2mFAIraPI31J+w/BDj7mSnOzz+bBSQ1nkIe6BHbp
	 XVpJh7sZx9NFenINTf9GYQ137cP6vq3WlrCC8bnp6YDsHPgO8DCjw+QUFpZuyiQRev
	 4ZiDp6rsouY8nD13d6IOzKlDukyiP/rqJ1UKAgnZiOiYzFhPGMGLMTbUTFoLqAqxjQ
	 tmiRSnujVaLodu+eJjuLWv5yflUsq2SZE3WtD7/jj+hDdLQLtnmbP8EpnzzEK7QIi7
	 D0NRQA1iQ/GFpfYatJJU9GNNL+T6vp+PtI6c81WogxjFBeSkYizd+xg4X95TFNbYpb
	 0iF2JqU+gfR1g==
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
Subject: [PATCH v2 3/9] powerpc: opal-core: pair alloc_pages_exact() with free_pages_exact()
Date: Mon, 23 Mar 2026 09:48:30 +0200
Message-ID: <20260323074836.3653702-4-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323074836.3653702-1-rppt@kernel.org>
References: <20260323074836.3653702-1-rppt@kernel.org>
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
 arch/powerpc/platforms/powernv/opal-core.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index e76e462f55f6..32662d30d70f 100644
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
@@ -328,11 +327,6 @@ static int __init create_opalcore(void)
 		oc_conf->opalcorebuf_sz = 0;
 		return -ENOMEM;
 	}
-	count = oc_conf->opalcorebuf_sz / PAGE_SIZE;
-	page = virt_to_page(oc_conf->opalcorebuf);
-	for (i = 0; i < count; i++)
-		mark_page_reserved(page + i);
-
 	pr_debug("opalcorebuf = 0x%llx\n", (u64)oc_conf->opalcorebuf);
 
 	/* Read OPAL related device-tree entries */
@@ -437,10 +431,7 @@ static void opalcore_cleanup(void)
 
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
2.53.0


