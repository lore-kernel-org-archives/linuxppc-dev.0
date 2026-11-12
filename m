Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C77606A332
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtSf8AS/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQZL24PWzz30C6;
	Fri, 13 Nov 2026 09:09:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794521354;
	cv=none; b=AK8OBgSvzFM5NvTXeZ4AlCNsg0OMyMw/nDAqGPZz+IuwveaT26sBuLiHYQmGt1ATALxYARUnmDtos8v8pzQktXMGr8mJB7AX06yhgJyt/aPCdm3vbxhHk0VyNHU1I6iLMKJ6mYY96n65oN5y92jAkbOGL0DzPmhK4TfFDhhcEyNrhjwjHua4ZiMV+DMl2J4p70ZW06hz4UVuZdBgo5gR/RJDpW9A8dGuFOzVPJ7zVG35bKm7nXHHLqDZoFPCW+gLE3o5jzJ0UT7ChOjq1F7BeiEA7NyqL1fp3Ke2zSFsohNuNbp1LaWj96p8EuEKaFuwxSdCQL++tIMXv30j+n13ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794521354; c=relaxed/relaxed;
	bh=YdaqQU5UQrIE7jz+L18q1ofvhwJPYfk/YgBxfo4uzJ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AF+Lj5D/Hd/QC931KJ4CkTgFKLlxjpJjIfiI9PvfuxNSkP9EfUwMIF7GuuSlmaBARuX+2BeYkv6U3vur+FSYgz+FG6B2dxjYRMkFAYwXCVhYPXXgxkO9cPwoKnHPYBNxSYN5UpsMEqfS0naO7+x5+eOiCl2RXZciUtA6s9p5eZIMz+G2ngHOrMialMzaTS561gveZwjI7/e9+JQ2j0bJs1pOex3KcDjBXj85BNiVaA0vGsp1AESTAGw68y1xNo4F+5h1eiRWbVKlxjyc02HVMmmrG/ii5kWqdaOVx/aVIk00lB7D7PHBYZZJECV18iL0aEZZ+qzST6h5cwXMedtdIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtSf8AS/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtSf8AS/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQZL1520nz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 09:09:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D5F04115B;
	Thu, 12 Nov 2026 22:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94D01F000C4;
	Thu, 12 Nov 2026 22:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521351;
	bh=YdaqQU5UQrIE7jz+L18q1ofvhwJPYfk/YgBxfo4uzJ8=;
	h=From:Subject:Date:To:Cc;
	b=UtSf8AS/2vkBzFQsYMRwuG1chkyE3t6cf92PIU1mH6Zccmm+N7wlrDPMvoqYVIzeg
	 JaLGGZUy2+KPrln/QsrIgnjuKFaGDX8Ul4e5+R6J9wuhUlJxYqeuFzFJkhawftra1r
	 7SRhv9cNjIbSPkFZlJNY1RkXOEYclnV9rxg6sieR55Lx5ecY0vkYsZqBeGZ/uxLJlF
	 Qrc4sbjJPGk5oW5iS/G1qEymWrpXDPeK65SVHwwPX1ALJNiO4mLgB9nfDeBE6PPOAh
	 LYb0r3Ey8u0d2JvuAPbuxNQZd5+VkItHekuWndG07g9VEf+lahJlbpgVYIRfUGeslY
	 O2MPZl+vhSR0w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/5] mm,drm/i915,powerpc/spufs: vm_ops->access related
 fixes
Date: Thu, 12 Nov 2026 23:08:56 +0100
Message-Id: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAPg49moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mj3cTk5NTi4vjijMySVN0Ui0QTc1NTS1Nzo1QloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAywJpcnAAAAA=
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
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463; i=david@kernel.org;
 h=from:subject:message-id; bh=WdwVU4D50DJi588gxgEao7aVctqzLO6VANAj2lIv6bs=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+Wfx957ddpWa78tHiMrVrJ99FeK1a/GtDtFr8v2eVG
 8tPF86K7ShlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiGw8x/JU5HnSJ1W7u5NdB
 n0Tf3ezdkWO74I2I2MJ5z7NfhK+8ermJ4b+bh3bR4pbPQQmrj9+Vd5eZuOcZt0PR6/sme6cfFHx
 xYxU/AA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While working on vm_ops->access related fixes in core code for FOLL_ANON
and VMA access permission + size handling, I stumbled over two driver
issues. Also, I have to update one selftest that specifies PROT_WRITE
but actually wants read-access.

Fixing it all in this series, because it's all intertwined.

In patch #5 we break a debugging use case for older ROCm versions, where
the amdgpu driver hacked around it by exploiting broken access checks in
core-mm.

Tested as good as I can with selftests. I cannot really test the
i915 and powerpc/spufs stuff on real hardware.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Chris Mason (1):
      mm: do not call vm_ops->access with FOLL_ANON

David Hildenbrand (Arm) (4):
      drm/i915: consider vm_pgoff in vm_access()
      drm/i915/selftests: request read access for mmap access tests
      powerpc/spufs: consider vm_pgoff in spufs_mem_mmap_access()
      mm: check permissions and bounds for vm_ops->access

 arch/powerpc/platforms/cell/spufs/file.c           |  3 ++-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |  4 +++-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |  3 ++-
 mm/memory.c                                        | 28 ++++++++++++++++++++--
 4 files changed, 33 insertions(+), 5 deletions(-)

---

base-commit: cc06c90c164a389d51444a7df5056a8460d26d5b

change-id: 20261112-access_shite-d8a47559572e

--

Cheers,

David


