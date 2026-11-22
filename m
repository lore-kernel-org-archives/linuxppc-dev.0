Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601C606A335
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnQSCvxH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXcDv4DGLz2xwN;
	Mon, 23 Nov 2026 04:55:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795370143;
	cv=none; b=NEvGwjmS8TpdZTZU2PJkDmVxUUOfNAmi0nzpuAHEoapYydbubLD0uvEUrxEud7UJ0HWjTUxAFafKNpphOrIaWk8AhiZkMETR20Me8DsY6LNdDlHLNba3KgqmzGOiM12UGcrbBVoY4GfjK6KEi4Fa+3n9jGus+RnLvOJPyuV3OJh+daSPm7P/yxi3zNM1wUn5G1vDyQS8Ta/xU2TR1VdT3bnnxkHWM0Sdx8LsW/Jr32nBUBOY1EcAEBrc8sHFD4kgKm/0qrwwWIBo5fHodqkNKc6S+8tI60DxhZWZKsUL4NlNJPZ72UqBnTbNBMHBrj8SxiWd9TG+Q7eTcYnesaDH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795370143; c=relaxed/relaxed;
	bh=UAlvlm6XIkjF3CVGuekihGQ4derGbHtU5YfuFOl41qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfwZbdy4kgzobhaHL5uucjWf0Iyv8SbO66Y4Ds5OKoGW//DfNq+IpI3WOuXS3SMJ33mhiw6CwVgETv7VHJM1+ciu36bdIa42bSfdDVRWcoV5E3eLJCT9g0z299brPJd6bTaLyBkNQG0a+r2y7qtFg4ffup+H/Uw3Hk/i98II2OKEOq2oqJuKpYA21/T8AU9sDa1rKxugoHF6F7HB3kVZX+JnP+zGyDz2e7STqzR46QkL72WVqvub46Q5qvxRk/BI2bZU5jhLm3lA5JtJ+gMF8RenCjSYbyML6a59o5nsakrQdRS42qPvc49KzD9ys6yLwAj0HfpDzUZVB5xH3HqWUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnQSCvxH; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnQSCvxH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXcDt5tDzz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 04:55:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5CF80408F8;
	Sun, 22 Nov 2026 17:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0B71F000CA;
	Sun, 22 Nov 2026 17:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370139;
	bh=UAlvlm6XIkjF3CVGuekihGQ4derGbHtU5YfuFOl41qQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fnQSCvxHNo6ERlskR5pyD0RirUHJHoMwYscn8zEwfhOm9qyM/LS5q0it778nXObyH
	 SFAoOYjlOjFY5vXKOdLIVVvhXhoGFLbxI9dKLWclz9Y+vELX6BSItyyKQCjZEhh73b
	 10FztGFeJtlA7TjtRykt5PquRo8ffQfsvW8vgg5YPWh1gTjYgtRk/9zBWoMaOYQyYK
	 +EWwSmhu5H9+l5Ov8IJ+BxLNt/hV2vqgTdn9JMlKNSM85QVslyyH4cAPWwT/+J4LZO
	 8VjJz3ZemsMNeHxwk3c/4OJET3WCmIek09eFjsE5DOZpRMzhb6ZRllFEB3+qtHYI5V
	 pz0ICmqsjK+7A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 22 Nov 2026 18:55:18 +0100
Subject: [PATCH v2 1/4] mm: do not call vm_ops->access with FOLL_ANON
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
Message-Id: <20261122-access_shite-v2-1-808d8d2aa700@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=david@kernel.org;
 h=from:subject:message-id; bh=lBTEaJm0bEVMUkiJfmMuzjRSMI6nwi0rCciXc1cDdUU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKZdToqLJWbiudm15yqnu0Qrr+968s6pakJN3untk3iS
 p1okT6to5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIn4hDP8FTc+nBUYp1uw+alk
 Y2JYAP/y+/9uzzzC9WG/Zv2nxLKg4wz/65dyaF1cE7M41Uy+dOqfLXMCLrAu2vmRMTRvgXD485Z
 0TgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chris Mason <mason@kernel.org>

Reading /proc/<pid>/cmdline or /proc/<pid>/environ can block in a device
driver, or read device memory, if the virtual addresses point at a device
mapping.

Ever since commit 7f7ccc2ccc2e ("proc: do not access cmdline nor environ
from file-backed areas") we use FOLL_ANON to only read from anonymous
memory. While GUP properly handles FOLL_ANON, __access_remote_vm()
will fall back on GUP errors to vma->vm_ops->access() without similarly
considering the flag.

Fix it by not calling vm_ops->access if FOLL_ANON was specified, to
truly limit it to anonymous memory only.

Fixes: 7f7ccc2ccc2e ("proc: do not access cmdline nor environ from file-backed areas")
Signed-off-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org
[ david: simplify description; slightly rework implementation ]
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 6a23198c1c67f..5d0d58aeff3cb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7448,6 +7448,9 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 				continue;
 			}
 
+			if (gup_flags & FOLL_ANON)
+				break;
+
 			/*
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.

-- 
2.56.1


