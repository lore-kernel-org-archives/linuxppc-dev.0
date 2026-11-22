Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F8606A330
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlPMPBSq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXcFD3LcBz2yYs;
	Mon, 23 Nov 2026 04:56:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795370160;
	cv=none; b=lNH6Jat2mgJWPYLLP8U5tVZR8wZ00mC/X1prOz9VnGmjpvwyzkvICgjRnk2DgpqXPsn6WxQksjitSXad0GLJij4vV8Js0zio193sOTcsi6SRzAJjAVKXoCrXol/ia4jJkvfCqtrsAzBaXokBXP2E96scA1IAGVA4x3Tha4s1vTiLHDRkV/dKTJVG1gEWHXkv964pL8AH5z3tVsGdsE0NKjzFdYwUZ65ZzF/xg47xnNTVp5VLLLuR1/lf2kcvYI2cQWeKGET78QFN0hW/7rNmDnQdJ5p3dMxWhoVYwU2t8Cl2FzllwSf45Hu0Xh2qwLDAUeHhEnc/VGvMjwXRZf8kBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795370160; c=relaxed/relaxed;
	bh=YJuynXecCuAMRPu1fuAj/g8WUJ63sUPX3+ZQ3T0k/jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K33oTY/UXVN79uszw/+Kuppxqryj8dtjjAh1M+93lvTvVBNG2MokCbYCfPmmHqeZUs/LCpCWsOGy46cmqvphfeeXSQGZ3VNnifgKzDNM3jJZVwclXBbMA3cGaIpHNmp24VrzgcJX33C0Zgr3p8BwLrApI7GKFoManeXJVWp1qMCc+o7b6dbhic4WQEj7wWuRz6FtT9GkV/G6+uhKvU+k4jxPnBX6JLpC2VXdAC7cYkY5S4vVZEP9+GEJcXkyKApTP9v+CKBpFPbPbEEKRkaXrw7zlL+3+cQYThhqkazHdirQbcfcs1C3ty8MbpIhWTGgf8aCWg9P/QAFAwx4U6rGxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlPMPBSq; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlPMPBSq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXcFC44j0z2yQl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 04:55:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6502C61B2E;
	Sun, 22 Nov 2026 17:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873161F000C0;
	Sun, 22 Nov 2026 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370157;
	bh=YJuynXecCuAMRPu1fuAj/g8WUJ63sUPX3+ZQ3T0k/jQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZlPMPBSqzDmHZOGkU4054fbMNFlF1IGQXsCUJvAri5JYusQq6Fld+r5likMn8ztyc
	 7Mu9eLJLytazLi5qvR4SRWz2zDpkE7rhOdNUxABvNd9cXZh3w9NVbFT/1fK3G2mQjm
	 T/G50bkDLqZAhz5fG4Qa2/PAI4f5SbSBnyUGRdECOvoORfmjY7nKMarfffarIrcue0
	 4p/dISPdQ38AEu/2E5zXoiDU+qVjyi+aRyDPyIeuectPnv6lWYxDSXN57PcX4bQnT8
	 6paLk+KUayEaB0GxbLKlmu55IsoNjLstoFUqG/1K2dQan7NU+By0RS4eluYAbhRKR8
	 sNWFJkwwLQ9lA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 22 Nov 2026 18:55:20 +0100
Subject: [PATCH v2 3/4] powerpc/spufs: consider vm_pgoff in
 spufs_mem_mmap_access()
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
Message-Id: <20261122-access_shite-v2-3-808d8d2aa700@kernel.org>
References: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
In-Reply-To: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Willy Tarreau <w@1wt.eu>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=david@kernel.org;
 h=from:subject:message-id; bh=f8MyOmAIcEjLMC9uMSbKvRisK/L7ggF5sRJ95bTUbag=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKZdTpFH06P76o89+bMQV6RhB1rfNnzZyntmJ6i9n3Zg
 XtzTZ5GdJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjARtlCGv4LXtR5FTwyfuPvV
 mktGH1783zK3bR53UvaTOT9EhOMXVL9g+F9ToTll5fSfRpcOb85ieqIRcuLBUudv8zlK2kTnubP
 HfGAAAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

spufs_mem_mmap_access() calculates the local store offset relative to the
start of the VMA and ignores vm_pgoff. After VMA splits, debugger reads and
writes access the wrong part of the local store. Mappings created with a
nonzero file offset have the same problem.

Properly take the vm_pgoff into account, just like spufs_mem_mmap_fault()
already does.

Fixes: a352894d0705 ("spufs: use new vm_ops->access to allow local state access from gdb")
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 98c47bafaf678..0a46d6f7178ab 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -248,7 +248,8 @@ static int spufs_mem_mmap_access(struct vm_area_struct *vma,
 				void *buf, int len, int write)
 {
 	struct spu_context *ctx = vma->vm_file->private_data;
-	unsigned long offset = address - vma->vm_start;
+	unsigned long offset = address - vma->vm_start +
+			       (vma->vm_pgoff << PAGE_SHIFT);
 	char *local_store;
 
 	if (write && !(vma->vm_flags & VM_WRITE))

-- 
2.56.1


