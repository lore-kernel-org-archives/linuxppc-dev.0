Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D6606A321
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWMKq2ci
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNPQq6nJsz2xKx;
	Mon, 09 Nov 2026 20:20:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794216051;
	cv=none; b=f1CF4q029h9rMYjOdUwOFnKSO/9DkBwO86pShyD+nMGw9X8tT4s8rqWQ9nKj6IQYbWcmFt45141QEhemt59JEGo1gNeeDcsQgvAPuXmz6aaKSbZTA4QMsn/Sg1GQQwsQzgugDsLL1lKQ5qQcLeRlEm2WIGDdCIvxxEPxD9spblgv6/9e6hkPCMTa+MvQ6FI0OrUGvVP4BTpw9xBxhdhcdWWrfNs7yn8Eyc0yQNS1Hr8QnW4kpZXRLEvmt/0x3NHUPAWu87y50l9XqCg4uLvcGIkRG7eXutBh86frU/GwQzGot0vZfXWI9+s/hb222UbEPadKTx+Ap/QXKC8wZCp6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794216051; c=relaxed/relaxed;
	bh=8h0PI3x5L84bxHJWgvhwyPcSqbxezc6i6wUfYwT0/gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i083CyOpE2wGgdMwK+nrENwJcgGTmDHWCjqZLRQndFl8ZmH2KeLNVycqj/6J5mm2XstLxciGyWIQ1658NUOq1fDtrN6LXydg3MS89eN5yEyxsotpfzh+hzF8kdb8LYAl/bNXBIdQMXuTbzQ8mPMVw16JLsa+oprqmftBe95FSa0Stl9i4MM56IanD9+ed6xpFQVwXwSId85vEoferyNSH7RZk3lEWqFRfFYPaXp7VK4+63ydOfLzUbhSwm7p2dbeq2lKIm/Uat0fsjaZAvPZB7B0ze+dORlteT8ZyVwnLjt0rs7TBCiWbIkQqfFYf+dm97eIKG6qGfaH1pYU2f/vHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWMKq2ci; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PWMKq2ci;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNPQq2Rybz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 20:20:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8AEBB43D06;
	Mon,  9 Nov 2026 09:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8531F008A2;
	Mon,  9 Nov 2026 09:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216049;
	bh=8h0PI3x5L84bxHJWgvhwyPcSqbxezc6i6wUfYwT0/gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PWMKq2cik7On9nLBWZZo+q2yFr8sWXi/dqsHfAOWf5G8lTU47xEhSOhDJMI8XikaX
	 5m07d7IVQvL4OmfmjXbpZC1xKhl0bnPIHFCc1+GnK9lePH1J9OXffOSC3rolXJf+DP
	 k4ocKY24KRkrPS6q7WNJrkW/H6guwGWdd1Qlf00BWCHthyiEskC+lVYU1caVCSxDJ4
	 8mr+TmUNdQsWrTcx+JFHlqbf5vM/T8amfu0IckZaVZKSK+i+YeSGHR/TccZjqYXArb
	 yGxJbGTMk29VHdRtuVjfBsvlx9exyhCVwGps8u3eDDtXsofy9sTxR1LmMTyHZmh202
	 /IyFsFh/XTSVw==
Date: Mon, 9 Nov 2026 10:20:41 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>, Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 4/5] mm/sparse-vmemmap: drop vmemmap_can_optimize()
Message-ID: <avGQadeXQU0ayFYv@localhost.localdomain>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
 <20261107043122.25650-5-songmuchun@bytedance.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107043122.25650-5-songmuchun@bytedance.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 12:31:21PM +0800, Muchun Song wrote:
> section_vmemmap_optimizable() can already decide whether a section uses
> vmemmap optimization based on the section compound order. The DAX-specific
> vmemmap_can_optimize() helper duplicates that policy, so remove it to
> simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs

