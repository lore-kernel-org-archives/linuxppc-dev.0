Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C36B606A32A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vh8JImBl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQZLC1FLgz3bSw;
	Fri, 13 Nov 2026 09:09:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794521363;
	cv=none; b=hV8hX6WGRA0kGBH4WzOoPXznWF/8TGlRD0tB9nkxkCLxPJrW5yxBzIK7nJz1XnhQwMcjdAZ2L1HL2Kmid4xiVZm4CxWVAU1FrzVJOBJINypzwRddPkE2tx2jKboU3TczPLvLCnmwnd221cmheR1Rdn5Ogrh6bvmFUSxA2CRRzIeWobpavQ5A7dqmjhlu069SW2wMp2kwyMKEuSbI6DWElarYC1jaO0+THIrFrugYxxI4wqcDIjvJrDGj1x7gIusfgE33/kJeS90QDO/RpdrNL1NaDMOKA6Zop5AzyHMC2a57wwwT4iI55pavBNPtcyfDReWx8yufpfQrBMC5armsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794521363; c=relaxed/relaxed;
	bh=mz5C+hrA4fTk82DSD6cW8Q3erNJ0g6GuLKJqSpAAgFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JnVv7RHbJIe8S1IKTkhDgJGuBa5EmaICdzfNSzpKA2qcr8GtFZ4Kc7qeVCcGQMqHSzXeBcjp9pHiEb+Ax6R1fncZJI1Ma8Xlujl2DKsV36Zz3slpw7aYa7G0KAt4HPzB+e8oJ7MHqjHHSyI8OOMy5W3IhGNLNEwS62yPIbKj+5sXs0yh7LV+L0RWIwahNvJEuq5uspLJ1k2n/X8mm3XlXIl+0Dot+02xWDucWmgETFmCGnAtzhR8aSxU5wCnqMorRfp1+kwtHDeFQEgF4lN3CEeTD391S9CWE/JTpTQfeCqR6L59nqBZBc6Fe16JpUOfJQdGbSion3QCWnTmyqLAoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vh8JImBl; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vh8JImBl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQZLB2YLrz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 09:09:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 844AE62488;
	Thu, 12 Nov 2026 22:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C291F000C4;
	Thu, 12 Nov 2026 22:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521359;
	bh=mz5C+hrA4fTk82DSD6cW8Q3erNJ0g6GuLKJqSpAAgFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vh8JImBlAcjOnz8y7pU8IDWYsh0VqCsMcBMwSe6HbE3/KNMIikgL9fSTP4JOHSZjr
	 71AQirUlRVwjDEcPjEKvKy9nxX5cE2CSgQsjHHZ++J82aM5osTEASy3SwFAVHIi2Al
	 yK6o/209hYacaP0a+i2FCwwTThsYUdQ/iynhfX32OjA7OCxEPQWfl93b5EpcAD7H1T
	 0zOvz0wOrpQ7IFR5/pJeNizPRh9TSkWWwGRcndpgqlf66JpmGI8bbE9R3IRWqoioJL
	 EOsibmII5FAk1frAhSF+hWqu5i5pT6ygxfDHbptiJMSPIkUBz2ZQaHcyldEHV2Njon
	 vuPSfjHEXQyyQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:08:57 +0100
Subject: [PATCH 1/5] mm: do not call vm_ops->access with FOLL_ANON
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
Message-Id: <20261112-access_shite-v1-1-988a5c470db2@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=david@kernel.org;
 h=from:subject:message-id; bh=Gbkm7xA4sog0FLarlHe8xi7ovZnljYEXfiAf17aaLzU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+Wfy7c+rgyoVXNq89/TK8dlY/s/mZo9w5kz1fSCm0e
 jXN1/W51lHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEtpxh+MMrP+llbnSkpuHW
 xxzz3s7a7tR48FFV/F0Ofb40GdtAoxMM/yOtmW7crbi/7Oi3Se18k46HyTZ+UGSacP7+okuzf3k
 JBrICAA==
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 1a0ec09c56fd7..d4370c1b331c9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7398,6 +7398,9 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 				continue;
 			}
 
+			if (gup_flags & FOLL_ANON)
+				break;
+
 			/*
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.

-- 
2.43.0


