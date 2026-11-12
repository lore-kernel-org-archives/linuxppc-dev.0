Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56350606A8BA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PLhRjYTp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQZLK4hStz3bcf;
	Fri, 13 Nov 2026 09:09:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794521369;
	cv=none; b=TTaoiZ00WZPjly2DIk/lziBtLLOmIGVttfK7ckZTYl++AFyacRAw/QgjmKwVXRD9dxdaDBN16Up4KkRtfZCCZLGTPTFXfufrLOMjFtyZj3BqF1Gz8b3+bNgjQEU/i+l69xqJxE1WvfW9z8OOezpn0EPJ0FFRNwvJzas1jc2CLJ8w0OdB+kHnsi+BkBr6UgjhmDg9Xvjk0C8Eb2309+RvIlmjt1NEbYX+sEyPX2nQ6rRdduC2aH/VZ4/5SDnh+wpJBZJutG6r0QUnXKJmpy4qvV+2RxwCKjpoPlaIn/ykpqHPGLQi054PiXIoUJz8T/Fc9vnkFP1opsBogf7Jh7NtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794521369; c=relaxed/relaxed;
	bh=930N6QEOjUHirsduFLhsvXWNKJmMCsCwncwdA/i9tec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZD1hgDbRGiLE3Y24z039GMUN304sGn4O+KvM8nU1j68r3mwyWisSRnGMvrZ2zTnpVxfWSZjgcB7RSIr03PFV5epIL0NGPiOheuAl3Kro1syao006Q4LzHjyqXKK+PJfYFwvpCYbfGAeqLvYG2+hWd0FwdouRXZBwUamBYpyk6JyXtPXEMOn6OGmmSGWj87WdDEtlsg9bE6DfBBwq9NTvYwM7cK7/568UxKxSh83kPqb6tcSDnJNBNCG5Wlui/bshrpkbzCrdyu/bd7xvuX6CacSGTKudR4XbWU1QbDh+7BRIZDZFtwkpj2EqqjglgvJ9rjVb8risdowPgo2zx08vnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PLhRjYTp; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PLhRjYTp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQZLJ62G7z2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 09:09:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EEA8043AAA;
	Thu, 12 Nov 2026 22:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BE11F000C4;
	Thu, 12 Nov 2026 22:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521366;
	bh=930N6QEOjUHirsduFLhsvXWNKJmMCsCwncwdA/i9tec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PLhRjYTpuVCEwDtQeQbEtcsKdTDD4Sr++WJShgqRPkO8U08CqZ+HAAAC1BKtceEex
	 +ShABf3NSFxi4EA6/i9nO14MOuL3QYZK4jNWj4pB4ivxpkNeAIEdvLVkUSiVC22SRS
	 HAPkNG60I9FMyz6ojt1gqm35PE5pYqb8siXMDA0df7NnSUIA4ZusDSdoAwhqNcyatw
	 KOakc8sMlWUc40XT7CnNd4OzM8pVL7XSfTE6f+BgfiH7WZ9S195dJ35iHDfRiD5oiM
	 MztehWcbZk5EMfmofYeuH1mGMoGM1KD+V45D9dNOEXxNIqLZyVKGmwpaahIp+Lf2x8
	 7/EMJQgtaFlNA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:08:58 +0100
Subject: [PATCH 2/5] drm/i915: consider vm_pgoff in vm_access()
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
Message-Id: <20261112-access_shite-v1-2-988a5c470db2@kernel.org>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
In-Reply-To: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430; i=david@kernel.org;
 h=from:subject:message-id; bh=732UbEwrVg9H6cBI5IEtEOpt8rsKtwsfjrtc/ksVv/s=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+WfwzFui7teDAdzGvmXXhs2YtOLerfuOEw82X/n+3K
 FgXz3xZv6OUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJTDRl+MO/pni27aQmQ5eM
 pjlcVpMMTh34tWiC9fsE8y17/pglmGQxMtzhnMYyW1mtOJO778z5SumEjPXhzB949iW6cz/dLxn
 zggMA
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
2.43.0


