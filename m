Return-Path: <linuxppc-dev+bounces-21911-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B28CD6E60
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:42:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVFSP39b2z3brr;
	Wed, 03 Jun 2026 01:41:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780414917;
	cv=none; b=WKF0Tw5eDjJTrNdO5QsVcYmy9zfR165hFg7IBx73Ri9K+6XHLS18IvPM3qrVi2yzM7A+/Qjd6pRVm6PNfVAeOD6OKgzF4eeSJawbbVa95691Fm9YAYcTE13JLNKSpppLCLkhETaOUsL4X9cg3R59ElEEkSc183GZEoiDKYARSCz1snJUvnm2rTgt2SkU2YdfdE7RJHrRb7gV/FkSGxQzeKs5puK7w1J6wceWvMvKjZ+0relnWfzI1FJsWfdVXHOfMXLDnAwVcdf5VUpBbAb6Lwr5/q/9MukPy0dgWqIAHN1UWVmgY90j5r+Ac8/niAmxRCOE8LpePaowRlUGTWIPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780414917; c=relaxed/relaxed;
	bh=AULNQb+g6fJUZlryqt0xEDBzan/vuWgTF6qm0cBWlWE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UCZHc3bcX/btchFSDwdl/cticHIf5jixWDhtMh1hkPzl/X8oqs5VPFRZEWbXezmzTPjrbhiew1pLyLuwVbzulsiwaXDtjWgrORCtn6L/SGF2UFB5JbEOl9LVnK8O+vqdxY7iIrarayG2vEpXV6XJfDKsmxvR4pLE8sKN0Dyhas7LQTvQIxhv1q8j+Q4pd+eTl0sTjgnnniEX1Nlz3gTbAkKx94SnSbeL0UyTmMagE6yoNgsoFsaBynIUF6q8H875boBMA66IXwObxySrEzfk/heDQcbNTX/euwXrHb8c+B8eKV8p3htAgWCSvSOoH4YTytf0P1AWswkW71Td2+dUQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5txiQYE; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5txiQYE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVFSP09cbz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 01:41:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A17A40835;
	Tue,  2 Jun 2026 15:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1CE1F00893;
	Tue,  2 Jun 2026 15:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414915;
	bh=AULNQb+g6fJUZlryqt0xEDBzan/vuWgTF6qm0cBWlWE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=O5txiQYECnW1/ur43TGykfWS5RozIhiiGfdSugDtUNxMzeMj9Lrksy5+uYLs2fH+T
	 e5lVdzdOj3Hw+T+eC7ddXMv11vt6D9tRpINxttmEDIPop49RtVUtnikkZsMPFY08yw
	 B4sljFfEVp+oza+voiJ/gobsdi2y0Pn/Mi2qJhvLXnRbQg2Zqet7SpigjYmQ+jnVkF
	 v9ngBk4Mc3Y8tiLU9T/s67JKK18X/tEh/i3yBYUswnR7O2K+3VAP/1fDlTmSLoRmSI
	 gzW73wzV27MvItWFLJNmniqyZvEK6sa7U/0bE+JV7rOneIb76u/nn91Kgqt2ve5C7K
	 Jhyvvbs+k7EMA==
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 17/19] mm/sparse-vmemmap: Remove
 sparse_vmemmap_init_nid_late()
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20260602101039.1867613-18-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-18-songmuchun@bytedance.com>
Date: Tue, 02 Jun 2026 18:41:33 +0300
Message-Id: <178041489399.457517.7388921848895940892.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 02 Jun 2026 18:10:37 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> hugetlb_vmemmap_init_late() no longer has any users, so the remaining
> late-init path in sparse_vmemmap_init_nid_late() is dead code.
> 
> Remove sparse_vmemmap_init_nid_late() and its declarations.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


