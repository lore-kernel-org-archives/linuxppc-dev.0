Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03074606A333
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vmmyrz6u
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXb1G3DQ5z2xjN;
	Mon, 23 Nov 2026 04:00:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795366834;
	cv=none; b=VfUi10OwsFGPZviJvhhTkMKrURKAj+Rca/mseq+eQLJjwK73giiPNQrkKxyD3Z08My59NpMFU1W8XjeRWoTVLZQKORIdu8zhl9Ssz5Ue7w1SU+wSfYfLzimovLr4jkAMUKHCcQD/+8gFJwRUveM/LJ/iNcaEcUNb1xTTJQ+pVeHIhCc96ked6m3ZJIFJnplZ1OrcvaXxsgmiB/3AP4VGK0dSVXAhYpAAq07yr3CW0+LW3CM1uZv+iL4wZLBWvqaOMsP3kF6Pp5PShPDSvxZ8uIXMzx//zDJ5eiViWbV1mM4SXTYX4pNZsaSMEMEoBN2RzYwnVwgd7gRZxWyYwj9C0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795366834; c=relaxed/relaxed;
	bh=uEqI+Hp2ezJcINVPIUjY03p8JSLOYnYNaqnNBkjZ3rE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LHl4tU6xyseGNo9PBxfiaAmMV4BmG478HzULU28JH15vskaS4+JKNKd4PU17Hc8USh/F1Beb/JTHwI9Qy9qprFzrqCy1ItGNd/WTAmv1vsuvgc8kMqmHWbz6e4ghUSsyL9dh1NCuAcSMtUkkPS1lrZ8yY/dbh66wxlLMTIP00swqhBUeb1vk5ZU0UFZa5cCfKj7ycnhommdAkw6ft+u9G+HOTSZTCz0TJ0k+zH/0irOSwHixwLRFbQcIEGNIEVLRr5adZhRZaungwTp5BByUy7cXrYamh/oACaTrzZxkxUxiLxiVpBU+zOqDlHMimTN9umJYPVKuKfXAIYGCaezLJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vmmyrz6u; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vmmyrz6u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXb1F2znMz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 04:00:33 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5ACE361120;
	Sun, 22 Nov 2026 17:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0C71F000C0;
	Sun, 22 Nov 2026 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795366829;
	bh=uEqI+Hp2ezJcINVPIUjY03p8JSLOYnYNaqnNBkjZ3rE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Vmmyrz6uK/hYFVidaN2kK+me23a5dUvyk0Op1qeTqHLVqOB88p979QDWelJLt4iap
	 Q1sC8F5zSKZsnUF8J+6xDtlQUU5jID1AtgIYKPRDH4joDHKoOdZ9Z0UEKeZAtS4hQx
	 yvEnCcbrfkkVFn4UA1Xad0pMG9ZT2em9iF5BDDR36qpKsYiSWqPFlFM2EpWLlPWNni
	 AFqo/CI+7GxHabb1n9Gz8W7wZ8CkJ7YkvELRNntoSdhJ45I8dnGf7IW2mmXqth+sBq
	 QNCUJ+JztoZssg7tPc2aSRqkemJ25EJPdIv0x9dG+NYWgEVGBcV1LmZgxEIEXdKLDK
	 1svDrLaa66c8A==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>, Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
References: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
Subject: Re: (subset) [PATCH v6 0/4] mm/huge_memory: copy PMDs at fork like
 the PTE path does
Message-Id: <179536682240.11318.5673184071692513568.b4-ty@b4>
Date: Sun, 22 Nov 2026 18:00:22 +0100
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
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 14:44:01 +0100, Konstantin Khorenko wrote:
> v6 is rebased onto mm/core for-next, as David asked, and patch 2 was
> finished on the way: it now checks the page cache refcount limit before
> it copies a file folio, as copy_present_ptes() and copy_huge_pud() do
> since the refcount overflow fixes. So patch 2 changed after the
> Reviewed-by tags it carries.
> 
> copy_huge_pmd() decides what to copy at fork by its own rules, apart
> from copy_present_ptes(): a lockless check for special PMDs, and a skip
> of every file THP. Following David's review of v3, this series makes it
> decide the way the PTE path does, under the page table lock, with
> vm_normal_page_pmd(). That fixes the two bugs v1-v3 were about. The
> patches:
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: thp-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/4] mm/rmap: duplicate a PMD mapping as one in folio_dup_file_rmap_pmd()
      https://git.kernel.org/mm/core/c/4d47d354
[2/4] mm/huge_memory: copy file THPs at fork like copy_present_ptes() does
      https://git.kernel.org/mm/core/c/e21c5cf9
[3/4] mm/huge_memory: read a special PMD under the lock in copy_huge_pmd()
      https://git.kernel.org/mm/core/c/39b0669b

-- 
Cheers,

David


