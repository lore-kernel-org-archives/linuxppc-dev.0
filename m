Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A1606A31F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 31 Oct 2026 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LX0RjJQJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGvyQ3c4qz2xpt;
	Sat, 31 Oct 2026 21:55:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793444142;
	cv=none; b=LgMo4Z5wd/VEC/S2wbRVGEG0Jb857aQgaxFO0kpc+ljV66mc2l9knxvvshPVdoPEmc7Dp0LrNaTKuOKqfHs38bbWkbGCwXTzkehqFX+U76rgtTaqOCm8KaziK1qAwNrSl+qqmoNaLaf+GA9QYXEGi7xt6HbDdu+BwIEB8PYhCbplOPP15CK9uX3SVm398ZwaovD8BnqhrMJAyqF/tk24qEzcscblkayeJ5+hA6xFmwXUacYDqIkFZiM7ajG819VvOkIPIa5yobwRwqWMLO3TrnTuQX4hkiNys9QyOfNjtArYC3Rz/aTfZUfMG2fWMdVWL2FErdlX0ZMa7OtL5ExT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793444142; c=relaxed/relaxed;
	bh=7b46y4s0/zi9X4zHo11yWW6Vbp88X1A148hn2dA9HOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=acwvB+VjCc0qwtO5E8xPCanAHOlfNN53q3msOEWtEd50p2qWHbkETz8NIJM50FsboyH/Wr7R0szLAn56CV8WCwa0TkL/OvJknA7knSfIKMh3mdXzdG/SyfNvSiPdkOz4p4vdsaRhf9GBj3YkUjPYAzMPhZQJtrTJ+lEYgrocTckA1BuUsg86nvig/Q1OcLARCZfKd9EvFrfYjilGOcBVBeBhunHoHYJo29cg4O7Ph1WEzP/f0w3OYbcsOjxQhktAj7+WqiMj7Ahw1PnbkoUNzIxA8GK3E6YCHSA9L+upxiKp7ZMMTmqfhpN/xP2RQkcJjVpItBVlTSa60Pt6blU0iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LX0RjJQJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LX0RjJQJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGvyN3ftVz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 21:55:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 766CB600C8;
	Sat, 31 Oct 2026 10:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210BC1F00919;
	Sat, 31 Oct 2026 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793444137;
	bh=7b46y4s0/zi9X4zHo11yWW6Vbp88X1A148hn2dA9HOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LX0RjJQJpWdppLt42SNRn7EQV2Ff5N7jMe3itfLCjplO/MRkUZIp3jFNWvcrwA1mQ
	 UcCj6Mk2yZ8lLHHTQDlrfQDnCXDNASSI3GyG08p720TBjS7E7BDx/hdhXgrHg1QsO3
	 LbeRvsMZBc5KtLwSi7wWODzYoqe6aeCx8rzl2jQQSBqaCz+nLmFTtRvNi8zQ4mcSLK
	 IWFp1W844QfHer5jTZdGQvH25z2biHGD6EeJx++6y7oK/Hf2tF4RjSoEn4R3z8Xtnk
	 8m+5hfjRvvOela8b76hyVYCr8+w5vrvKSzquGangM6VzaPOpzRyecLva2TLMDrvoyV
	 b8B8LK0WZHFHg==
From: David Hildenbrand <david@kernel.org>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, David Hildenbrand <david@kernel.org>, 
 Muchun Song <muchun.song@linux.dev>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <8b853e5f9f16145859407b28af654b0f79e12642.1793318297.git.ritesh.list@gmail.com>
References: <8b853e5f9f16145859407b28af654b0f79e12642.1793318297.git.ritesh.list@gmail.com>
Subject: Re: [PATCHv2] mm/huge_memory: set the mmu_gather page size in
 zap_huge_pud()
Message-Id: <179344413383.15514.17004105179365165951.b4-ty@b4>
Date: Sat, 31 Oct 2026 11:55:33 +0100
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 05:37:36 +0530, Ritesh Harjani (IBM) wrote:
> Unmapping a device-dax mapping with 1G alignment on powerpc radix kernel
> built with CONFIG_DEBUG_VM triggers this warning on every munmap:
> 
>     WARNING: mm/mmu_gather.c:176 at __tlb_remove_folio_pages_size+0x38/0x230
>     NIP [c00000000063d508] __tlb_remove_folio_pages_size+0x38/0x230
>     LR [c0000000006fb688] zap_huge_pud+0x1b8/0x2d0
>     Call Trace:
>      zap_huge_pud+0x170/0x2d0 (unreliable)
>      __zap_vma_range+0x1604/0x1e20
>      unmap_vmas+0xa0/0x1f0
>      unmap_region+0xb0/0x130
>      vms_complete_munmap_vmas+0x120/0x310
>      do_vmi_align_munmap+0x1ec/0x240
>      __vm_munmap+0x148/0x220
>      sys_munmap+0x28/0x40
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: for-next-fixes

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/huge_memory: set the mmu_gather page size in zap_huge_pud()
      https://git.kernel.org/mm/core/c/0ba86a16

-- 
Cheers,

David


