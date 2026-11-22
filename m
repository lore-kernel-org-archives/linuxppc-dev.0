Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB70606A320
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duxKByMB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXcDk2tBfz2xwN;
	Mon, 23 Nov 2026 04:55:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795370134;
	cv=none; b=U7H81KdSKPO4RHMzaVYK9FUKC/1xYBOYnC5TJp21tR3azYVISfxzTsO02to5vX5dKyzRdL7UpnnxpO90zgZd3ADH3i2UIJ0s8v8k5HkHgng27AiBQQ1qEZkWWg8O/kcC/m4vprI0PZG3jHEvHobBCt66tVjIkqsBiq9BR3ZsWgMCmAVgqrT/j3sifDZE2SMBZSapejvytAWAqODIZSnC2988f/6rF71otoDM3MUw7Md+SjYX1fPVmiR1Dak9/aPQthmSs2JfVWER3+Z/uLutS4V9Bl2/wm7Qzc2GWvTnvyPxK9cd5eBEA8kqji4MJvVRDWWkreQ4TVKXLHxx0x+tYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795370134; c=relaxed/relaxed;
	bh=h/5Vl306LS0GA0rcZKJVnl2ctvPVB3+FArNa0w73Yro=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QXstslsk6RD3qH76DRNtT1ZqmvwI7K4mcC6AiQJCxAA8MCaQNZCEj+VEkHA99+3THYKVMYw0LfZCh6VW3w22+JYLaYCfbIPtw3amkfoVemPmfnh6yENEaEq3xz1TyaM6TkPkcN7pf/iGZDHYF+oKS04WiWmZfJXRfF/hyE1haiUY+E9BE5zpt2VbusbhgQQsEFDU54amaqHOXne0WURlsyeYxFwzGuWtVC6+jC0LW6lJJefAPcCTTu2agqDNxoS/x5h/NU0RSNM2/0G1tbHbKOLCzPohPqKSnNb/vj2g47hQstDOyRuTCQrlIZYLTSQDdQly5kLwi+WJnPbhIIxXDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duxKByMB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duxKByMB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXcDj17lQz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 04:55:33 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A26D4408B7;
	Sun, 22 Nov 2026 17:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB00D1F000C0;
	Sun, 22 Nov 2026 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370130;
	bh=h/5Vl306LS0GA0rcZKJVnl2ctvPVB3+FArNa0w73Yro=;
	h=From:Subject:Date:To:Cc;
	b=duxKByMBP2+mJiLV3lYRrKPgtiowdBAgsPJIOTGZnzS3p58QFIkq1X5nGMYdJsfNM
	 evxhcz1FhYwz1khpDyo/kjMElsksWA2DAYZQuW8yjfOdJAxaqT0kTk/dgJJ3L1YxVs
	 b6bYv0n/0CSza4S099LFxlPG+mjLC99FtaqxP3vqrBOe/KvmCEPggXwrzwtj46PdmL
	 zH6u2jCXro9fXxatJHgHkzEGA/pN1yUrjpGfmhjk4zzw2xpr1FXG85n8DZwRqVtmMo
	 V+B3/ylL49xlmJ3nEPH164nYwknJC3q/uMxMWHQy9Ay2j4bmQ9J6Pw8r1EqMWgOcjr
	 75F1hXUdF5+Pg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v2 0/4] mm,drm/i915,powerpc/spufs: vm_ops->access related
 fixes
Date: Sun, 22 Nov 2026 18:55:17 +0100
Message-Id: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/3XNQQ6CMBCF4as0s6aGNtSWrryHIaaUEUZNMR0kG
 sLdDbh2+ZI/31uAMRMyeLFAxpmYxgRe6EJAHELqUVIHXoAu9VEppWWIEZkvPNCEsnOhssbUxmq
 EQsAz45XeO3dufptf7Q3jtBlbMRBPY/7sf7Pauj/0rGQpa+eCiZUtu1af7pgTPg5j7qFZ1/ULK
 L5wnLsAAAA=
X-Change-ID: 20261112-access_shite-d8a47559572e
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784; i=david@kernel.org;
 h=from:subject:message-id; bh=uurjwnOfWQkMhoYI4DMjJoIthu1xPIvQvDdbePa+8Rc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKZdTqylvaopj9aMl99cWW602yfrivn5ySohf55fPZ2/
 JqtOX7rO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZhIaSvDXynr1g/nX69XZbd6
 ZcFsH2J4UpZD8tdum/4+6S3KwvFF1xkZbodO7b9SyfMl4R/TSwnD7cnx3999jJ+ippmflWjJ++8
 BIwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While working on vm_ops->access related fixes in core code for FOLL_ANON
and VMA access permission + size handling, I stumbled over two driver
issues.

Fixing it all in this series, because it's all intertwined. Only allow
FOLL_FORCE to bypass VMA permissions, similar to what GUP does for other
VMAs.

In patch #4 we break a debugging use case for older ROCm versions, and
forced writes to mappings of read-only files (e.g., DMA-bufs). Current
ROCm no longer relies on it, but old setups (e.g., MI100 with old
userspace) might break when updating the kernel.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v2:
- Drop "drm/i915/selftests: request read access for mmap access tests"
- "mm: check permissions and bounds for vm_ops->access"
 - Allow reads of write-only mappings, as we historically did
 - Combine the permission check comments into one
 - Mention breaking forced writes to read-only files
 - Extend patch description
- Pick up tags
- Link to v1: https://patch.msgid.link/20261112-access_shite-v1-0-988a5c470db2@kernel.org

---
Chris Mason (1):
      mm: do not call vm_ops->access with FOLL_ANON

David Hildenbrand (Arm) (3):
      drm/i915: consider vm_pgoff in vm_access()
      powerpc/spufs: consider vm_pgoff in spufs_mem_mmap_access()
      mm: check permissions and bounds for vm_ops->access

 arch/powerpc/platforms/cell/spufs/file.c |  3 ++-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c |  4 +++-
 mm/memory.c                              | 29 +++++++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 4 deletions(-)
---
base-commit: 76d96c9641d0c1c0d0e92013a30bd887f8d2dbfe
change-id: 20261112-access_shite-d8a47559572e

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>


