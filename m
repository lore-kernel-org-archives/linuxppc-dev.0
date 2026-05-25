Return-Path: <linuxppc-dev+bounces-21485-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A7BCD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 17:12:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPMr34BVKz2xfB;
	Tue, 26 May 2026 03:12:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779729123;
	cv=none; b=Y4f1yMT58BZqePchofnw+u3/tYr42HL85cQ/wL/nWlhOHP2n7KAcoMd0CXKLKMpEhhdJTl/I9dLAAR0pKXxQbSTavAP+GYfq1hPWu085MRRGokjrpB8eR7JPIK+L5IKFFsyyWbR96wXJUAlnAswoAU9plIlktHrRW5WaLfS5YK4gEvaaksenbTHlP9wkraxFsuUJYQZGbAOm3MgzyMS3CGtCDZ+BxjEMy26SfFZIzGDAXSqvl3jFNofR56kAvYZkAVEweS+jzzM2HY3iUghehvOM3QC+xWhvg1lnn981VWgCVVmGNOxHPALjMvLwXv5ymoPKsRxUcdg+2SCQnZlw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779729123; c=relaxed/relaxed;
	bh=lppuGztfV3VAd9Pwvb8KD32Y3Ykhpo6lzmvPRGEXMHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSoorY7926KNtoEN38svfB8h+neXlYX0AU4bMlS3ZzVO5pIXjXuZN3nLBdEbmj9mtZwtlQhn+iW07BJMF1clKvSH7Fk53zudhK7QOJhW3n9yISdSb5iUq7vwiFzsjDLFD43KHbE1c2nfqMqUkgw+UsDeP8nb5RYJytATeiUGZm32mjyYLJ8ZWkEvk9401ZGk/DJ7Ft6v2jVQyaAOFIKBuzQizviYH+EUElf0uvpLjdHGlgKL46ivRDDz5skMsKAAOOUG10AZSO+bnAGG8kRRBeHCMh8w/PcM5JwhPIe+QcoeR8AphG5YrYG81Zd2C2C/jQ7mQ166GbMRC30gAqQP6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0GkC8JB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0GkC8JB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPMr26vynz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 03:12:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 123296008A;
	Mon, 25 May 2026 17:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1941F000E9;
	Mon, 25 May 2026 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779729120;
	bh=lppuGztfV3VAd9Pwvb8KD32Y3Ykhpo6lzmvPRGEXMHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c0GkC8JBi6s+kPHIrR7x5eWxzlrBWPbVN7JRD3kvVG0gzNUV7Ut9TkT0Vs51PyYTK
	 wOXSbJ8Rs2W1si5bDo37166aK3LgCK2zLuyOB48h2NzF4pPSfV0L6++kYqQTiGDfMi
	 9iU/inQrR+aoScNEW/B8QYe5oyPB8FdJtp1abpsDjMe3Sug4cUQRHJpKWIGFrZHOZQ
	 bNNctxCvB049dg4NCUGmds1f23o4Q5gdmQl2EAmTeeOsGpMEYcZammGoDUSdKQzZZL
	 hiE7o3quPtwsL8DwdU0NekrjkJTKao3aEhAtCQvNiye0I3BdsrP665kw7Aw8t2ZsHW
	 seF0mOUytk/QQ==
Date: Mon, 25 May 2026 19:11:52 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
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
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/69] mm/sparse: Move sparse_vmemmap_init_nid_late()
 into sparse_init_nid()
Message-ID: <ahSC2M1VZOtjDVvW@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-12-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-12-songmuchun@bytedance.com>

On Wed, May 13, 2026 at 09:04:39PM +0800, Muchun Song wrote:
> sparse_vmemmap_init_nid_late() is still called separately from
> mm_core_init_early(), away from the rest of the sparse initialization
> path.
> 
> Now that sparse_init() runs after zone initialization, call
> sparse_vmemmap_init_nid_late() from sparse_init_nid() instead. This
> keeps both sparse_vmemmap_init_nid_early() and
> sparse_vmemmap_init_nid_late() in the sparse setup path.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs

