Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FCA606A886
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkL+ZB2a
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQZLc07b9z3bQq;
	Fri, 13 Nov 2026 09:09:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794521383;
	cv=none; b=R7SOTC2SJ9vQrYQGd4hck4iadLKC/T0ZT+ZEvTly4DNCX36Fr/9akrALDuIaulK9W3Fmo19rLzdZJL0hJYYRUlpRSSz/MW1mfsZ6xQzI8KjR2Lyz7v1icXX4aDW4BGyblcBkvLO70SyaC5BUiwpRRzEHcJrIRiu5lFV1rp/3HovtH8Yze1jyjqoZkGQuGkQSSnjiMtuv4LaRUP33D9bhfp+xCS1EM8weScWyhRUPLecm6FhnX629iXY6FWhQzeStUlMj6bqn/1rsdaudlAtOM0MCP+H0NKIhm7Cl/rMByQjvwdNcEawqCDmedUpe7XUopBnlmqgKGJaUPfGExapWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794521383; c=relaxed/relaxed;
	bh=eKtXaU18XWDmrm51FUDVoZxTbd+Jzy0nR5+iJLVT/Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/rltqlh5+szaw4dYWxQTXvoX2/c1iYRUTSZ5on/NqYd5CZ0Hn+1hZoL+pTGC/P0t6thon3mlmwJnp1pFu2a2qby5+HXmqC+/yMjp1OLq+P3IWC+FnW6Z/JwDwp1fT9L4USxaQeZ+lkgSVzHhwlC9shwzIYubx4zxfJ5pX48T+/XKu++5qxngh+Eq4BV7bKqqi18AMLAl6Lhm+wbpY+YrcamdAVIYehUbqj7uXMceTcbU+ZigIgfOAht+dW1zXc6How1nqMUJA5Ep+4jTPh/dfa2EMBAcTlRbYWycKCQFSRZm7yPMadt2JtyC/GUdiXQB8R+9Y+ilNBaqtxOmznBkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkL+ZB2a; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkL+ZB2a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQZLb22cXz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 09:09:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BF1774646C;
	Thu, 12 Nov 2026 22:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B891E1F000C4;
	Thu, 12 Nov 2026 22:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521381;
	bh=eKtXaU18XWDmrm51FUDVoZxTbd+Jzy0nR5+iJLVT/Yk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jkL+ZB2a4fUwx27qOVIEV+ckZQ/gSjMPP3h29FpAk4PlOjb9LirgSuhw4zlbzw+TM
	 9Ys06V8UM5KILDGz4kcDcXHt+QdS6IwpIYUNxkrZqklga3AHuZI28CAqsvB6rRKJQy
	 wQcEkO6mrSXip4E8TRbKqS4h6HYP8KFB6IJW4x5SDlh8OyCRis7XriaS13txq3yP1j
	 VjXVrSbG1x1f/e5ytJhhy+FJeef365J72+LX8ayB4cIYe5oD5G+I9hI6Sh9TFxGJH+
	 0jiRerzzmMrSsTaodVJVb8P7sjITxHF4ma/FIxHnXjPAMdZXmioymUii/zY17u1NVp
	 yh2WD0W8m2Nkg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:09:00 +0100
Subject: [PATCH 4/5] powerpc/spufs: consider vm_pgoff in
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
Message-Id: <20261112-access_shite-v1-4-988a5c470db2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; i=david@kernel.org;
 h=from:subject:message-id; bh=PQPxNnQpVVFHjjbqHgG191KRAqKJhGnNL5teRs7niOM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+WfwvmXrNbfL1DTr7E26IRJ7XFjTl6ms4FpmrJVG/6
 pnretUTHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzkURQjQ9dyu4gpkQX8Sr0C
 BvVLG3omPVjE/fyifL1Ezg6x9ZxvgxgZpgskTX6gKFW7IzR7p2TykkUhix0bJs+usdJ6c5drnc1
 CVgA=
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
2.43.0


