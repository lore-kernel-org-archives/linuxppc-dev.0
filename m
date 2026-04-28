Return-Path: <linuxppc-dev+bounces-20214-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A61EFF8870
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 07:19:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4WyG2FX0z2xld;
	Tue, 28 Apr 2026 17:19:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777360742;
	cv=none; b=jbWeEGucpdoTriqLZ934M0IR/q5P50t0QuRRMn+4b8JqUDe67fgmYk2mlLlEvOZllTojlmZs3Mmol6shUV1UXerF7/d8AxUYcKWSaT3vG4IACjq+AKUqTRiiwXrdKmLf39+K0dy7CDQZRS+iNwpd1zzYs7bVwFLSv8bMkRPn5WBC5voyPkyoWyQ3wHNcQ7a85Eu8PQjKQ4EAg49X9/30+e/RdGfWHyeKaGD+EpFe1jnYHEpXQ9IDhElboAbdVXU/weL3sRWgehad23uurq1+h8zfrWwy5LctHw15EBcCq/P6YtI3UmiK2/J+/RsAw+YB5iLah9NjHftADPxD4P4OIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777360742; c=relaxed/relaxed;
	bh=QaAEDE4karRiLhj6T5smg7SeDy6M3hgvKR6dHn0tccg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ndp8tDSH0wdxZLJ2qBZDMxIAsX/GUlThhlSMfy/NXGZKpXXso1jmzuC8Mvn/1lDi5uhyoDhpj7FeRZIw8cCiLV/wMMSMbja/H86ZYqWnMjtOs7seYplqn4cUHsZigHEwRHDyPKg55hZhFIFiuv40gykiyW9J3/RWkOnG6i/CYAqDkpuA+CwLqjrAoYmebOe41vEs+wsCrYNKdcEQfXweSHKezJXbztDhql/fU0Pw2dAwVr7HlPEEjX9uCdQfmchyLciYcT5oRXw7C0b9vJlg2YEc60sAvPr5U2QF2Q9pO0sgUpnomqU9YCdBVoW/dR+6YobtM/DWBUlQH2YHRDFY6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YFtMVKnP; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YFtMVKnP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4WyF5DY3z2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 17:19:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C389460142;
	Tue, 28 Apr 2026 07:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFBBC2BCAF;
	Tue, 28 Apr 2026 07:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360739;
	bh=JWWk+ejNBKAE57oeYaLCSn1Yap7+NFRPWRTEBQ3yAmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFtMVKnPM3cs5jFOwUhJVQjUEfE2Z5FFuhoJNast+eFJkUriDYYuGiXmCPH5ogowG
	 1yU8ZKpdRXZm+/pQWowDXe/g/UhXlGCOILIufrF5JDmqaUFguksSabcnP8/QdtV2x9
	 3NMESfK/Uhy23GkKjTts0AmQZQ9aPYgf5kiQ4l+8ZgZ+w9N9uzsa47w/E5mwvPb1wm
	 xJ8AZMTYHMkDSoP+jA+vGFFjkLVO3h5zJP0nKEFHkue8v2/TX1zZRrIFsZTijggN/2
	 07A1OfhxAMhFgv6+mp28+fNb1iWsaqXw5rOiFYAprfiMNhaEoHaXuuyisUMKPjCK/j
	 hqOKFlXAE9auA==
Date: Tue, 28 Apr 2026 09:18:49 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/49] mm: integrate sparse_vmemmap_init_nid_late() into
 sparse_init_nid()
Message-ID: <afBfWfwWs7hDU9qS@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-14-songmuchun@bytedance.com>
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
In-Reply-To: <20260405125240.2558577-14-songmuchun@bytedance.com>

On Sun, Apr 05, 2026 at 08:52:04PM +0800, Muchun Song wrote:
> Move the call to sparse_vmemmap_init_nid_late() from mm_core_init_early()
> into sparse_init_nid().
> 
> Since sparse_init() has been deferred until after zone initialization,
> the zone data structures are now available during sparse_init(). This
> satisfies the requirements of sparse_vmemmap_init_nid_late(), allowing
> it to be moved safely.
> 
> This change unifies the vmemmap initialization steps by placing both
> sparse_vmemmap_init_nid_early() and sparse_vmemmap_init_nid_late()
> within the sparse memory initialization logic, making the code structure
> clearer.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 4 ----
>  mm/sparse.c  | 2 ++
>  2 files changed, 2 insertions(+), 4 deletions(-)

-- 
Sincerely yours,
Mike.

