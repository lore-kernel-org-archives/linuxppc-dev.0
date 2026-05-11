Return-Path: <linuxppc-dev+bounces-20713-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BC1CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 14:06:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDhN80Pljz2yF1;
	Tue, 12 May 2026 00:06:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778508376;
	cv=none; b=bDNfmAJS7xHHfmHuGGYF0C56Rfp0jexixXZVB9K735bwkPniPpIvy96TEL9c0spQx3xu/QCy0/hZmI4+UqAzj+HkkditgdT4qlgZaE+bWXHliubYxsgeR+chccmhnIEIPJIeTKG0/w8YpmoU1jaGCtAqjuGMmu+fbbf+IN+GixsTu85K4T3UGIhjX8BuFXh07UUpU34sDLhZgfmyMWtQAIMQINN+zCIi00Kxt58mrF3eHk2+jvzX/A1DZnT+LMsvqwY97OSTGsPh2FFA4qsjCc+R1izjVvG3Gf3VQ3jSggdGudKSjhst2kCgb/Rzi/kCoGeBq6dtA1YJu+3xuhQpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778508376; c=relaxed/relaxed;
	bh=3z4GklFCErfTQtmmOR00Q4UhPA9FcZSnCFOQyXtKW7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2VivdQQmChGPbDN2khVUDCRG2CGyLp9LJduekf/Y3LXi+ElSIquvLtc9MNwcp50AcNyn9sxe3yjfUrkQ7K2jaWZ16jY1b5M/oWmmO9yhZIFSosKfrHMdvXSpw0KrGO5IqM1py0bjWLQvfrx/H8QznkHB99A+tdLTlBlvEWhVEVUWskUf3tLN8AXqHpO00K5G4uybc22UF/iQIqKn6pSCuFFVVhzQEztth69yt5XD0Df532YRYFo60ypx7KKmFl8pgURg6mGe1DrAamwuZhS3iGfua2rbH8b2Oqtab/rgdMaQz2iJT6pbxUXSW0zG6fzijKZ0Y8h3KAdgWWus6TaYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MC++Iby5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MC++Iby5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDhN7465Tz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:06:15 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 84CA460172;
	Mon, 11 May 2026 14:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5FFC2BCC9;
	Mon, 11 May 2026 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508373;
	bh=7BplXJKZlQZOSJidAvpNkGSKkzbCMEkCK3cF3mfqU+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MC++Iby5ok7TXQGGc+uvg4Efk5zAMeJWOG3GMzC9znDRLh77sNxq1/rWfakudf+Lf
	 ryEJQVBagPaPXTKqmKiLzgUcFrnhQ8eOCrfmxUdkhB3iXLgVsV1Tvfklz9fKrJOhCN
	 CBaXJF9ug+ycGiW0eTVI5IIFRqbQjitiB9Utta6xmp5xEwQzK+PYR9jG4kLGMLYKbM
	 hB/XM1I/3Cp9r7hbhk/SBnPybVltI0bkF+F52k7f+2LivbjmQfB8GxCq2rfyHJe4xz
	 JsNU1b+6kEJ9qZjaYN5n/MZmWZxyntdGM4p4s3lOh7wJP0Bcyk/9jekF3yTJqi7Wi/
	 1sEPxTCVP5VBg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:35 +0200
Subject: [PATCH 7/8] s390/mm: use free_reserved_page() in vmem_free_pages()
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
Message-Id: <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

We never select CONFIG_HAVE_BOOTMEM_INFO_NODE on s390. Therefore,
free_bootmem_page() nowadays always translates to free_reserved_page().

Let's use free_reserved_page() to replace the free_bootmem_page() loop.
We can stop including bootmem_info.h.

Likely, vmemmap freeing code could be factored out into the core in the
future.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/s390/mm/vmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index eeadff45e0e1..d8b2a60e0c33 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/memory_hotplug.h>
-#include <linux/bootmem_info.h>
 #include <linux/cpufeature.h>
 #include <linux/memblock.h>
 #include <linux/pfn.h>
@@ -51,7 +50,7 @@ static void vmem_free_pages(unsigned long addr, int order, struct vmem_altmap *a
 	if (PageReserved(page)) {
 		/* allocated from memblock */
 		while (nr_pages--)
-			free_bootmem_page(page++);
+			free_reserved_page(page++);
 	} else {
 		free_pages(addr, order);
 	}

-- 
2.43.0


