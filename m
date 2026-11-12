Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B02606A323
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HM4HKwBw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQZLT1XS7z30Wg;
	Fri, 13 Nov 2026 09:09:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794521377;
	cv=none; b=LCF1Sr0XAyEZ5wGfngNlNKITAUW934vZyNyVGVJSRr9dJqnJNGTohUBx/noCd5cyPWzKEYCYxrjzEsMBG1PrtPOKfit9yTvvit6dGFhHOMTuNK5Wd2yGRL0/tK4IeC+9PjvR5CnsXPysodyw5/z22ZXMQCxhH2UvJx6VvGOPqpCYwdAGLrF2vU+MEwuWRsBuUVXe8WV1lOAxVm5Nb8bF7y7YvTK3T3cVi4qYiI39GPTeiRs45fihigIb2jxHXyHiBlIUtVIdmUpzLfoKiKFapZ+CafUut0VEW4b59wJXlLLvefi51mk+T/KPCVHSb0sRLVGQIBnydw9OG2Pru77R2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794521377; c=relaxed/relaxed;
	bh=Viwqy3ITQgBszpOy2nxIavh5Mt0ao4kMQc4DSQeToGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMf6CueIcQ3ju5VRXg4AiL2/k4QpjXOQ4B7czcocmBoZF2yti6hxAj/TfoFKR5BqCacpflM6yCVqKUxsGgj/nFW7QhTzxZAbuY1Jz6VQZQut+6nGZPU9rCZHdeNO73TSbc6rG8VynrhxlTo8/gRQQs8bRazipJ+T+2tkWG1z1CfNqZWf3mNPKHaO2zYRRwHJJRGTvzVZ8Pnj1BITXJdPTgwk+zC3xrZoz2Knk6g0CLd4FGQ8QO6wiwnz7dSTe2Ow5TZxJwx6pejNLcp1Q0UaZ5HMVi/5jV6qnw7IkOHgz1GpIi3+r770tklkfUurpJMLu8lkqRepenpkVtGqUCHSgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HM4HKwBw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HM4HKwBw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQZLS2R64z2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 09:09:36 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 751506248D;
	Thu, 12 Nov 2026 22:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555C61F000D4;
	Thu, 12 Nov 2026 22:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521374;
	bh=Viwqy3ITQgBszpOy2nxIavh5Mt0ao4kMQc4DSQeToGo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HM4HKwBwenX5LPu3liCUHEMsEalytKn7ys2DDGNSBAMroq/1dFf/rVUIYBjFEHEpI
	 hE/fY4rJBXGrrTOlj+FZDCzgZ/BtsewXoNR8UtSzaKL3UkvJ1GnU2uIWtxs8CtmBBW
	 0qUUCKuerr+2hwfE4QZ3r9yCnSLDgkteS96rugzAyzmanEYhnXcnUEsXjy0yK3Id9c
	 1d7fVZqky1H5uWLL9Z3pHvNpyENJfo+QwEDcpD3mU4gm8mDkSdZS36INIPyHwx5f4d
	 gwGCNlnn5K6jpoD06i27gE2QSn1Iab7gBi1sgmvAemRpMKmkZuQiuX4NtlNV7WUC/I
	 p0yh9C0dDrLeg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:08:59 +0100
Subject: [PATCH 3/5] drm/i915/selftests: request read access for mmap
 access tests
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
Message-Id: <20261112-access_shite-v1-3-988a5c470db2@kernel.org>
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
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=david@kernel.org;
 h=from:subject:message-id; bh=UNHRKTPPJVrGYq3JL2OOfSiN8BE6XDeP4WdpR0zw48w=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+WfzXfSMdyle0+taS0KYbrY+ZzNvWegtJcp07d9F1o
 8y9imPFHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExkkzEjw1dWKyPrzb+96jf5
 r53V6B4zxaXk36Gv5ozRBdwzOZ5LsDMyfDYz6l6worxt7dyFeduun10lZLpV2HND/cMu4aMaMY/
 7uAE=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__igt_mmap_access() reads the buffer with access_process_vm() without
FOLL_FORCE, but creates the mapping with only PROT_WRITE. Request
PROT_READ as well so the test remains valid when we fix the ->access
fallback to properly check VMA access permissions.

Fixes: 9f909e215fea ("drm/i915: Implement vm_ops->access for gdb access into mmaps")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index 303be698891fd..d9c828032a1aa 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -1460,7 +1460,8 @@ static int __igt_mmap_access(struct drm_i915_private *i915,
 	if (err)
 		return err;
 
-	addr = igt_mmap_offset(i915, offset, obj->base.size, PROT_WRITE, MAP_SHARED);
+	addr = igt_mmap_offset(i915, offset, obj->base.size,
+			       PROT_READ | PROT_WRITE, MAP_SHARED);
 	if (IS_ERR_VALUE(addr))
 		return addr;
 	ptr = (unsigned long __user *)addr;

-- 
2.43.0


