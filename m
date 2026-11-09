Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D2606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV6f4qcJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNPW21vQnz2xdb;
	Mon, 09 Nov 2026 20:24:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794216270;
	cv=none; b=Mu89kR0QtdE+FC6SvwnRWpFwaTbb1FKx6sdlSP6SSIBtK3V1+t8vQFTQYpdiC+pXjh3M38jzNoRfV3m6fIKbC3Gnih1r+mnxUi4IegbvHK2F3Q+a0KlYvRyYi6K/Qmd04mJYV3sgPH65Ar8wp3KmaGt4GWW1WP/zmbtQo3C0J3pLZcUc8X8G25NnkE2R4MHnBlrJUx4erOARVx/ltkLDULwvMubPGTjH9aoeuRxgaf6bhhm5YSuMjsgyFURosAA/qOVu7pNTUIaLPOLkKxbtPCby2vQxlE6DxJoB4zX9TL1QEAKgiYPfxRX7AeT+YZIZIYMHK2BIxbQ9GDPJpz7PgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794216270; c=relaxed/relaxed;
	bh=cNFD8zbRoLqcBaLpUrUz65qzQQyXXiRBbh/ZFm+g/0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/fkrKyhRoey6oNe8PYMXddtY8PW1eZCak3n5fWdXM7QLKMBvHaqDX426YK3hHnvLZKTLdx1u3erA2egnJqtspkN56VRSs6qx4paKsdSeGV2mXRbFc59yLxpqXl1lP/1CTbU3j1lF51Xc5aMFKsBPyJJmD2LMjw6YM/yE/KnRrOZmFv7iaD97R+NfrLAwXrQy0UvUtPOteAVOA6ZXczBsUnr4wm3cFmaY+imT/eVqLd1gdy0FVGVIt0w8LmaxGygOkaKwrn3iLnaMSV/p1/JaI+Hp9SMy0s/upMmT8P1AoOaJX/mJMQF/x3FEEKQIv6t52hZugoXyt5R6X/+kGTzAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV6f4qcJ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV6f4qcJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNPW13mnVz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 20:24:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8F02F40710;
	Mon,  9 Nov 2026 09:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E841F00921;
	Mon,  9 Nov 2026 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216267;
	bh=cNFD8zbRoLqcBaLpUrUz65qzQQyXXiRBbh/ZFm+g/0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RV6f4qcJIjlbsx8FxA1gxmtGOYGrqDAqHaEFkjDmVEvh9lKtryFCfIVBh2Syv+Nm5
	 3pWfPBY0jOJrkRMONpLfK9G4EHDraDOfXd+MhXzuTpE2P9tsEthfMKFGmOQLCDYlzs
	 SrJGyjebs3ZRk2dtFEh1jcZAgMmA+UzzkSel7YKXk43VbE4n0QFjoaKPOUMpS0lDnO
	 15H2VQcUneTXTIQ+aMXnT45PaTd+sHwAGhegff5F4dk8O3hpM+u4GKIrR7OGwG4/2J
	 uogUUW4aLsfTJs2ixdi0HB3c3kaLECdnu2Awi3Rgj9GQOwpEjUI4amOtG6CTKVQEMx
	 rIaJ9//B6Yzjg==
Date: Mon, 9 Nov 2026 10:24:19 +0100
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
Subject: Re: [PATCH v3 5/5] mm/sparse-vmemmap: drop @pgmap from vmemmap
 population APIs
Message-ID: <avGRQxsRFT6Ax_zy@localhost.localdomain>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
 <20261107043122.25650-6-songmuchun@bytedance.com>
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
In-Reply-To: <20261107043122.25650-6-songmuchun@bytedance.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 12:31:22PM +0800, Muchun Song wrote:
> The vmemmap population and memory hotplug paths no longer need @pgmap
> to decide whether a mapping can be optimized. That state is now carried
> in mem_section, and the architecture-specific population code can make
> the remaining decisions internally.
> 
> Drop the @pgmap parameter from the vmemmap population helpers and the
> related memory hotplug interfaces, and remove the remaining
> dev_pagemap-specific coupling from those call chains.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs

