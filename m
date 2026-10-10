Return-Path: <linuxppc-dev+bounces-29173-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA56CA9EC0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 09:58:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1zh25Zr5z30gC;
	Sat, 10 Oct 2026 20:58:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791626306;
	cv=none; b=A+l3sI1Mjj6ECHW0ITZ5PZh1xcpVPqpYxj/7w/jAfbYYZ8v2xzwD5NbJZMs7oN5xiT8NVvcOJZz6ontOpYRj8mX1z3XSjemIQCUGzUlmug7lurMWoWeHk3Oe2gJItLqsZ7Z427GAMjrYDSwGL4+tnaClE+nwuOtAY7Ek6tenmsZnNLVUYaEYqcJCJ8hOMYbSaSisTP8ozj2RZPC26Z3cFhnxudKd1bdYWrF7+h7cM9dW6Q4AnLQCsrkTvF3uhhu4ItYByp4zUMWbLRhd69xiXJfsU6gCSGYIAQUhrDYsuIKF+3QlGczBMGXuMKMtET2ZaqFxKInKa/kuIAO4HQRmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791626306; c=relaxed/relaxed;
	bh=QvnkvLtda/rMoARtnwYn7sNzYphFVMCDdG5HrVdsEsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZvWH8YliubhQba14tVj9C9Ls+Mws1aZLG9XfLuwLdEIhusTmG2ow0GhDmj1LmtBW/o0I6C/2TM0XfSvnXIeqY8bAfr6SV0m8F+9QV1ASxcMDIvNOilJGxbmVcFBAoEBacLwMr7Ofce8Wxh0k88Av9vuL8d1f7jQzBIA7vvXvKfo6v7za8ti++GeQlBINCkdF9wE7FO0/W83/XwQ8Zmo80sCXN7mIQ+jXX9rZgrOBnJTj7o+sR+Sbg3Phh5Pl90Nmpryzy+KeWEGcdCFc8RivzQNFKRdCyAa123OkeBebsaqHI/1RvuFVIhxosZON3BHHlDHrTHIcx4nhXTGs/DNGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoWXNSPm; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoWXNSPm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1zh146rwz30V1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 20:58:25 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 24314437AC;
	Sat, 10 Oct 2026 09:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC8E1F000FF;
	Sat, 10 Oct 2026 09:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791626303;
	bh=QvnkvLtda/rMoARtnwYn7sNzYphFVMCDdG5HrVdsEsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OoWXNSPmC7aomO/qL5FrCOYGUk0MjGnEvvS67qACxOjUNH3ibjhLX9Nq8BunMAM6c
	 IpWgnn8nCsJZgc1iisSfTDUBg+w2Er0od02JE3A3L0EAIEX54dJ8fuA5zs8T6HZ4eP
	 5dDZGQ2UUR//Gvmrw/NEj+hNEqrz8bZF9GcWzdi1RTYvMCKvfcIfs+FqsVfpvQOCNL
	 NtHwWMNR/aZ5rvbXyDlyzO11KP1B4lLEJjdzgGk0AULtyAL3vCw/DNt8WqIifzhadY
	 jkBh+EOgJKQnOp6G2LdCynMkuT/rfkdntoC8zzVFbIIz3hLEWCfz/BLBfnPsPNmytU
	 uo+NxkfMgn4FQ==
Date: Sat, 10 Oct 2026 11:58:15 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Qi Zheng <qi.zheng@linux.dev>,
	Lance Yang <lance.yang@linux.dev>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 6/6] mm/mm_init: add zone mismatch warning during page
 init
Message-ID: <asoMN5F-3qvaW5w0@kernel.org>
References: <20261010075755.83339-1-songmuchun@bytedance.com>
 <20261010075755.83339-7-songmuchun@bytedance.com>
 <434B0573-BF18-4413-9BDF-C5873CC13206@linux.dev>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434B0573-BF18-4413-9BDF-C5873CC13206@linux.dev>

On Sat, Oct 10, 2026 at 05:32:59PM +0800, Muchun Song wrote:
> 
> 
> > On Oct 10, 2026, at 15:57, Muchun Song <songmuchun@bytedance.com> wrote:
> > 
> > For vmemmap-optimized sections, tail struct pages may be backed by
> > shared vmemmap pages. Those shared pages must carry the same page zone
> > ID as the struct pages initialized for the section.
> > 
> > Warn in __init_single_page() if the shared tail page has a different
> > page_zone_id(), which would indicate inconsistent initialization.
> 
> Please ignore Sashiko's report [1], both are false positive. It didn't
> realize that shared vmemmap pages are initialized early before __init_single_page().

I didn't realize it too when I read this first :)
 
How about a short comment above vmemmap_optimization_verify_zone()?

> [1] https://sashiko.dev/#/patchset/20261010075755.83339-1-songmuchun%40bytedance.com?part=6
> 
> Thanks.

-- 
Sincerely yours,
Mike.

