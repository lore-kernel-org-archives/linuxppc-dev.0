Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858D606A32A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E70M07Wi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXcF5125qz2yCR;
	Mon, 23 Nov 2026 04:55:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795370153;
	cv=none; b=WKi6sOcWfERI91CWUxqvMRTer9G70/Ay7Y6MqRYGYnEOrQL6SUaYI16/dqnj6kjdN9pj75UeQ6dDRdaoTvhBO9eyJ3flYwaQcbHLqf6E1OvuyXnWBXZ5dTXeCiFFVyr7/e+p/nQf6dv8FC8HwvxK0LnO07ilMkRKw756eLrSHyZrcvCPCRf2AZRlcilHUI93/3Two93cZqnfUnpKl/F6nCkqDLtJp7PNVwEIrlaZOH1SNW6c2j+su5x8HSBJV5jUlggYo1sGuTfdapU6uISaNIiFp00WTQXTbtZd2uRhN7wxQigMRqdnmYvrXE+osK6PmheJI8TULbwmp6VedJMiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795370153; c=relaxed/relaxed;
	bh=N3xhcXsSlvYSSdBGEbF5oEiGoX8YAfT6Qkf5pEHEi5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n+reGzLFIS6qN+oKMOlQYVnY6V2M8D0qRx+/J19GXXoyKibRqhI2y0De2oqgRwVpswvm1oeReeLmnPJsV1rMsw+zgGh0HgQ8trZQ7t7xKsGN1+hHXabgZGVtZBoQfmx6uFPo4bz+mepxcHqVZFsdZ7FbOiC4CbwIegkR4WJDNLLvfcADi9K4fygFb5HJvjKco55T7YaU5uJPwtaKY6amslRHW9/WkVPxVVDSuET4ZTapLDJD+bYzB+qXqe2wJJ0BVtJbzXeGRUnVRTNVXLjTJJa01FX1HlQi1PHEtWbIzaBxOPuRLlo3eLNnMFVpodnSV82LarT6CN+dk4hV26APdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E70M07Wi; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E70M07Wi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXcF400jlz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 04:55:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 37F7361B0E;
	Sun, 22 Nov 2026 17:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADEB1F000E0;
	Sun, 22 Nov 2026 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370148;
	bh=N3xhcXsSlvYSSdBGEbF5oEiGoX8YAfT6Qkf5pEHEi5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E70M07WizowpCEjLIq8EGjssWfPz6RUqSLvLQ+xGLzrxDS3gylM+UH5yHjZHVFNmJ
	 VJHhy6enxQtOEZktlriYonxPaLLMky4Erj7SqufwBWKhUmk5XNixHuTx5K2FIsPLID
	 h/J9G5EN+9SKgTEtUoQ7HI2tfGmpwEI6VUvFudX0LFcNOXoS60WTR4nlUad9HPZVDg
	 ON7Uu2mgM9pvW+MfW46A7KTeEHCyqxJGE6beJEhEEladV6jPwuyfUUHeVWAPjXd7Bl
	 pHJNJChJ9nv9ev1pTrlLvXsFFRJZddluCoYLt76x3KZladhKWxmCZbdS9ZtoK23QPJ
	 I/F1jerZy5NMA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 22 Nov 2026 18:55:19 +0100
Subject: [PATCH v2 2/4] drm/i915: consider vm_pgoff in vm_access()
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
Message-Id: <20261122-access_shite-v2-2-808d8d2aa700@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=david@kernel.org;
 h=from:subject:message-id; bh=Z2XxG3ai9Ng99bmlt2CXgZf4H+3uo30xMSG9M6dIcuk=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKZdTritSS8jXWYJzwLms64t+6nzN4Ik9q9a55Wm533O
 825ncW+o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIkE8jAyfPw6Uf5P+zZnV6ng
 +Ah5mzqdqbU9Wru2Hjj5MtBl1fNzyxgZOqeKHfmkpGDtfEt/XexU9o2vfmUXOJ8tYDKv71jiUij
 CBwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vm_access() treats the start of every VMA as the beginning of the GEM
object. After a VMA split, vm_pgoff identifies a later part of the
object. Debugger reads and writes through ptrace or /proc/<pid>/mem then
access the wrong bytes.

Properly consider vm_pgoff just like the fault handlers already do.

Fixes: 9f909e215fea ("drm/i915: Implement vm_ops->access for gdb access into mmaps")
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index 6b337684dbfe8..e3b24dc8e94f5 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -511,13 +511,15 @@ vm_access(struct vm_area_struct *area, unsigned long addr,
 	struct i915_mmap_offset *mmo = area->vm_private_data;
 	struct drm_i915_gem_object *obj = mmo->obj;
 	struct i915_gem_ww_ctx ww;
+	unsigned long obj_offset;
 	void *vaddr;
 	int err = 0;
 
 	if (i915_gem_object_is_readonly(obj) && write)
 		return -EACCES;
 
-	addr -= area->vm_start;
+	obj_offset = area->vm_pgoff - drm_vma_node_start(&mmo->vma_node);
+	addr += (obj_offset << PAGE_SHIFT) - area->vm_start;
 	if (range_overflows_t(u64, addr, len, obj->base.size))
 		return -EINVAL;
 

-- 
2.56.1


