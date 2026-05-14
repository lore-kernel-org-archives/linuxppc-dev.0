Return-Path: <linuxppc-dev+bounces-20947-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5C5CD4F39
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 08:15:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGNSX4SLKz2xy8;
	Thu, 14 May 2026 18:15:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778746556;
	cv=none; b=Hxsg3UaFwUHlhoWaLhprK5dHgwq1PPxVegHU8UD/Ll1HSNETrV25fT1MHQZUn6YVEOOYRiltbX4hElg8Hbs1w/1Pnr/2lohGFI9tHL/ScBvLiXnvEz5kIorM0hNTS50ZIa1iBDTWEWcp7PVCmkw3BXUq7YFN5F/BNgK0AGxAlJbzzzWhwxPkA8Vg7QVNUCtaJcDb0VCnLWu/1je8MKL1CRPxbJ7gEhlfChKFlpYSMMLDELbmfyEr2GL9S1DjiU6LX55Oi/OO85dNCvbsXo8+4sZ32nMFQuTf5GLInx3Mu/tvDDriJr8Zvbz2GeXp4yL9F79VilDyVptAhwU3HR+mNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778746556; c=relaxed/relaxed;
	bh=GYHvhQh+aU5YKMg1lnuWAy6/GMx5Fj4JhjQmk8/RJkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tle/15m3FMD0bFmNJ4UdRebAba8mW6nBM3f18+w3kWl33UkmLiFaDFvvum5QPcWnYQeKMRhnzmcRg3RcDLycD5vA41jsnp+jL6hbwfmZuSLbL/TYiNsfs1AtAtyIq3vjTcU9zRw+c46PI97hbHcn5iXWLAxhTWgVyVStydFkyvSO9at/JAe9TT4MyVGsm7qhxzAYD3HFamgR/81zeHBK8HFtW/6r0JQ2Kp+MvKkEJKsEiporDlaYgDfs7Uxx1+rp38g31PnT/rjLcOxXclQOozW3FJZiZ2h356a4NJt3zqEMlQbe++SidgEhhCm5W5Ks1xUOxJOoIMNeMO1uBhk6pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Yn7op8mE; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=33hUj/VH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Yn7op8mE; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=33hUj/VH; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Yn7op8mE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=33hUj/VH;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Yn7op8mE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=33hUj/VH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGNSS2whNz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 18:15:52 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DD535E0E9;
	Thu, 14 May 2026 08:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778746549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYHvhQh+aU5YKMg1lnuWAy6/GMx5Fj4JhjQmk8/RJkk=;
	b=Yn7op8mE2TAPVKVIpe9TijF6q8yc2mzF0AWBa8NOZ9bVRX7EtTlVdWm0s2eYsQUChIXqYV
	xzv3stRGxlkbwAYEIfM1n4YnEGu8gr6z3JBuxQsOekiRw6iNOqmDUttRnfg3fXEMeYx2Tg
	Cn0wdfZR//P1bZ4TxBjtiQ1PZzz6iN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778746549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYHvhQh+aU5YKMg1lnuWAy6/GMx5Fj4JhjQmk8/RJkk=;
	b=33hUj/VHkqcsJmfiuh7Ram0jOGYgvYjUOcsSaqakySsXvlWo9WD6kZCVsUEE5FS2z+AJrG
	1aw6x8T4G5/L9qAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778746549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYHvhQh+aU5YKMg1lnuWAy6/GMx5Fj4JhjQmk8/RJkk=;
	b=Yn7op8mE2TAPVKVIpe9TijF6q8yc2mzF0AWBa8NOZ9bVRX7EtTlVdWm0s2eYsQUChIXqYV
	xzv3stRGxlkbwAYEIfM1n4YnEGu8gr6z3JBuxQsOekiRw6iNOqmDUttRnfg3fXEMeYx2Tg
	Cn0wdfZR//P1bZ4TxBjtiQ1PZzz6iN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778746549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYHvhQh+aU5YKMg1lnuWAy6/GMx5Fj4JhjQmk8/RJkk=;
	b=33hUj/VHkqcsJmfiuh7Ram0jOGYgvYjUOcsSaqakySsXvlWo9WD6kZCVsUEE5FS2z+AJrG
	1aw6x8T4G5/L9qAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8338D593A9;
	Thu, 14 May 2026 08:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +oCGHbSEBWoGHgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 14 May 2026 08:15:48 +0000
Date: Thu, 14 May 2026 10:15:47 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
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
Subject: Re: [PATCH v2 06/69] mm/sparse: Panic on memmap and usemap
 allocation failure
Message-ID: <agWEs93xurZIRQRK@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-7-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-7-songmuchun@bytedance.com>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,ellerman.id.au,linux.ibm.com,oracle.com,google.com,suse.com,gmail.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,bytedance.com:email,localhost.localdomain:mid,suse.de:email]

On Wed, May 13, 2026 at 09:04:34PM +0800, Muchun Song wrote:
> When vmemmap or usemap allocation fails, sparse_init_nid() currently
> marks the section non-present and continues. Later boot-time code can
> still walk PFNs in that section without checking for this partial setup,
> which leads to invalid accesses. subsection_map_init() can also touch an
> unallocated usemap.
> 
> Auditing and fixing all early PFN walkers for this case is not worth the
> complexity. These allocation failures are expected to be fatal anyway,
> and other memory models already treat them that way.
> 
> Make memmap and usemap allocation failures panic immediately instead of
> trying to recover and crashing later in less obvious ways. This is also
> consistent with how other memory model configurations handle memmap
> allocation failures.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Yes, one could argue that if we fail to allocate memory at that early
stage we are already screwed.

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

