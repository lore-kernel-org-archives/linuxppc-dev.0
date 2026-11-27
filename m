Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E3606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wSBlN8+6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbf3c335rz2ySY;
	Sat, 28 Nov 2026 03:28:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::2d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795796892;
	cv=none; b=DmJofaxbrz13uKLJRonaAp4AJubZPPJhT89cf5rVinNjc0X7YLmhiO0MxoCtnUmfUHgRcQ7Iah01vq70YWP+25MALg+UocRKDVTXDcRS++v5DB19KMeP6Fj0kTjJPQo2ykFrIWocTBve4v+ska1z51GvaWY8imK9m0T5V6iDtY4SCnfDpjj6KWq4M7Sv0jNNZjgmNEvRj7KxKqXTWzg2+NBzd/f/LAglwY6yZrFfn/djsMzCSmENR2lEVD8esjFcQij6DLgvGy1Ugk9voAGvMITLDxkeoU1fpElpePzhJURhIBy/sNSmuaR5KMYbOHmqkN4kl52TwsaHsLH3NZI/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795796892; c=relaxed/relaxed;
	bh=VaEAs2JpnZX/wCopgOCtsrHcdnJ8AK5BNMT03LjZSPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ym9AqimFZuUDkpRuPPISz+PC9vwpKgdDIXVj+rdrqTL55iL1D+6bAAbrDiBFGiUS1vxKPOs5/xWMtB0envPv+PZ3tTporK2BCrPZmsbfXHAGkzaOqyJiVd27NQEJGzFEi4DmK2g64iLqoe8XFd4G8uoCo5bQBdLLXzeswkQUOY/SJEo+XMuVnOM7dol9l8dv7RMe4rZfNlv2Lz/SzICTGDEHWyP3i+/Uaft/OGYu+ru239UU6cGfZmK44ATUzfrIrxK6C1gRxNyhNyRca1SUJj7N8Ucg3exBTJr45ZarrlL64aVQMyl+1GcuZbyQYXE2xjTYGroPr6YVar/KvMje7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wSBlN8+6; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::2d; helo=mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wSBlN8+6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::2d; helo=mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-45.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbf3X6tvcz2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 03:28:07 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=Rf/MCpoYMsHhZVqN9YRHgJpiVwU0YEKm9+BlNtnxvdI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795796864; v=1; x=1796401664;
 b=wSBlN8+6CURYpQ1D0VQIh2YyHNh83TwUAONbJyBL5tUf1D7B2KBBvHws1ZV575NwoYlEn3lG
 rcLT/nJTaB55wTpY1F+/Lm8lYPYBZnF12QmL4oYT9wxhUHqB+fVbI8cxF/reUV5nX3xy3OZ0zp0
 G1N6LI8y5fMd4Juj1SJOERsQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 40760d7bb28af9f0;
	Fri, 27 Nov 2026 16:27:44 +0000
X-Mizu-Trace-ID: 40760d7bb28af9f0
X-Migadu-Flow: FLOW_OUT
Message-ID: <63e62346-fabf-4426-88a3-056e1d909fab@linux.dev>
Date: Fri, 27 Nov 2026 16:27:39 +0000
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 7.4-rc2+ 1/7] powerpc/book3s64/mm: don't count
 invalidated PMDs in page table check
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@kernel.org>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Kyle Zeng <kylebot@openai.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Andrew Donnellan <andrew+kernel@donnellan.id.au>,
 Rohan McLure <rmclure@linux.ibm.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20261015-anon_vma_uaf_fix-v1-0-7b977303b42b@nvidia.com>
 <20261015-anon_vma_uaf_fix-v1-1-7b977303b42b@nvidia.com>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20261015-anon_vma_uaf_fix-v1-1-7b977303b42b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 15/10/2026 11:13, Zi Yan wrote:
> pmdp_invalidate() replaces a huge PMD with an invalidated one
> (_PAGE_PRESENT cleared and _PAGE_INVALID set) and calls
> page_table_check_pmd_clear() on the old entry. This decreases the page
> table check map count. When the invalidated entry is later replaced with
> set_pmd_at(), as MADV_COLD, page_mkclean_one() and change_huge_pmd() do,
> page_table_check_pmds_set() in set_pmd_at() clears it a second time and
> decreases the map count because pmd_user_accessible_page() still counts it
> as a live user mapping. The same happens when it is cleared with
> pmdp_huge_get_and_clear(). Then the map count underflows and hits BUG_ON()
> in page_table_check_clear().
> 
> Found by code inspection and confirmed in QEMU (pseries, POWER9, 64K
> pages, CONFIG_PAGE_TABLE_CHECK_ENFORCED=y): MADV_COLD or mprotect() on
> an anonymous THP hits the BUG_ON() with both the radix and the hash MMU.
> 
> Fix it by only counting entries that are hardware valid, so an
> invalidated entry is skipped, as the patch "riscv: mm: exclude invalid
> THP PMDs from page table check" did for riscv.
> 
> Fixes: 641d47d4c963 ("powerpc/mm: support page table check")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> To: Madhavan Srinivasan <maddy@linux.ibm.com>
> To: Andrew Donnellan <andrew+kernel@donnellan.id.au>
> To: Rohan McLure <rmclure@linux.ibm.com>
> To: Pasha Tatashin <pasha.tatashin@soleen.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index dff8790a047db..392474972777c 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1091,7 +1091,8 @@ static inline bool pmd_access_permitted(pmd_t pmd, bool write)
>  #define pmd_user_accessible_page pmd_user_accessible_page
>  static inline bool pmd_user_accessible_page(struct mm_struct *mm, unsigned long addr, pmd_t pmd)
>  {
> -	return pmd_leaf(pmd) && pte_user_accessible_page(mm, addr, pmd_pte(pmd));
> +	return pmd_leaf(pmd) && pte_hw_valid(pmd_pte(pmd)) &&
> +	       pte_user_accessible_page(mm, addr, pmd_pte(pmd));
>  }
>  

LGTM.

It fixes the double decrement in the page-table checker
and preserves how kernel walkers recognize the temporarily
invalid PMD.

Acked-by: Usama Arif <usama.arif@linux.dev>


>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 


