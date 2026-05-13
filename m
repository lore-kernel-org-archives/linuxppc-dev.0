Return-Path: <linuxppc-dev+bounces-20923-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1E0CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 18:27:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gG24C074vz2xn3;
	Thu, 14 May 2026 04:27:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778696826;
	cv=none; b=GoSp28gdgp8GpjB5lKN8djyXPkR/2mNvI6e0iBzom/b067mNqgqJB4tvppNeCBxUDpLo81/fEvLNeTH3e1MSRp7HkLDQNIYroZaSTZDTdDYpR0Ly5T2+hYGA2c/Mk7teSDQcGtPzEfa+72SpLYe0P5lk/04BJ5ZMUxGb0PsU5v8swMPGBOZq12Oqf8TwF32wTQHqN+/sWB7iUrs71iRf1ifmIqScJCWbJ8vkjGg1e9QCjawvD9qP5VdDPOaWAg4nfCBMP2GperfHEGIjVtExHHBXY6kCdYUriWwQ1EsYtK74q/iODlv1F8cA7+K1JIRh9UdWu++r7/JPpDQxkRQIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778696826; c=relaxed/relaxed;
	bh=CMY3vjl7HirudEIlBL9RQXThipPsv2YSmm9hm08krqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctXbNlZ42wVdSK3WcOW/skhbMKjSsufUF35AAz4yYFwaQApcO5/NC7YaPE/gs2xxt58lIeaciiFBZ3FKPegH4hUM1ZG0s+1dAUNFF/6iRcvvGA4bywGuC/ppV7yCUNJYbtHjLLfbmBS/+DA1HoEKjFf+Nx7km+7F/NjRrT6lUUOXtxVnBp6GFOQ+m103Ai8JNPJmaZh0yWz56WTPedmIYC0k9swvP3lAETqjXZDM3L2DMPjE28xSrfb2ZRnLIYI4Funrnh1/HCcuY8jyGwzHJp+8/LReGP0ze4OqHXM4zRvPfdPjjuAVx9KDP1WwGdCW/QS6XjcJrHKiSZOBq393TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FhMJJ1Xk; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UWfRRZTE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FhMJJ1Xk; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UWfRRZTE; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FhMJJ1Xk;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UWfRRZTE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FhMJJ1Xk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UWfRRZTE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gG2460RSrz2xld
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 04:27:01 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A4E1685BE;
	Wed, 13 May 2026 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778696817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMY3vjl7HirudEIlBL9RQXThipPsv2YSmm9hm08krqM=;
	b=FhMJJ1Xk2ZqhzR8+BOHNu26g3TctsKnhgOuylmu2zcMuQ9ewQgmJSWlsfYsCiplTR3qmed
	8HXR8BmdcN2BnUs04wQUFnkyXxeh27JKHAbSnHLYxMXAxJs/KT6r4t4eqlGtp/DeAf+1OB
	d610aUqO/vVb7CB2bXQFdREMX9YB43U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778696817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMY3vjl7HirudEIlBL9RQXThipPsv2YSmm9hm08krqM=;
	b=UWfRRZTEAe5DK2MG9+vW7LYL4ie/9230tpzuWeR8U+Se0O0iSLkfpegh/KmTfRzPRONU27
	sCnPCB7pFBrJLHAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778696817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMY3vjl7HirudEIlBL9RQXThipPsv2YSmm9hm08krqM=;
	b=FhMJJ1Xk2ZqhzR8+BOHNu26g3TctsKnhgOuylmu2zcMuQ9ewQgmJSWlsfYsCiplTR3qmed
	8HXR8BmdcN2BnUs04wQUFnkyXxeh27JKHAbSnHLYxMXAxJs/KT6r4t4eqlGtp/DeAf+1OB
	d610aUqO/vVb7CB2bXQFdREMX9YB43U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778696817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMY3vjl7HirudEIlBL9RQXThipPsv2YSmm9hm08krqM=;
	b=UWfRRZTEAe5DK2MG9+vW7LYL4ie/9230tpzuWeR8U+Se0O0iSLkfpegh/KmTfRzPRONU27
	sCnPCB7pFBrJLHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A108593A9;
	Wed, 13 May 2026 18:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WgTxD3DCBGqKCAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 13 May 2026 18:26:56 +0000
Date: Wed, 13 May 2026 20:26:54 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <songmuchun@bytedance.com>,
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
Subject: Re: [PATCH v2 00/69] mm: Generalize HVO for HugeTLB and device DAX
Message-ID: <agTCbglgY23ydrDx@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513104640.b0f02b844c57f92bc954878e@linux-foundation.org>
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
In-Reply-To: <20260513104640.b0f02b844c57f92bc954878e@linux-foundation.org>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[bytedance.com,kernel.org,linux.dev,ellerman.id.au,linux.ibm.com,oracle.com,google.com,suse.com,gmail.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]

On Wed, May 13, 2026 at 10:46:40AM -0700, Andrew Morton wrote:
> On Wed, 13 May 2026 21:04:28 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> 
> > In this series, HVO is redefined as Hugepage Vmemmap Optimization: a
> > general vmemmap optimization model for large hugepage-backed mappings,
> > rather than a HugeTLB-only implementation detail.
> > 
> > The existing code grew around the original HugeTLB-specific HVO path,
> > while device DAX developed similar but separate vmemmap optimization
> > handling. As a result, the current implementation carries duplicated
> > logic, boot-time special cases, and subsystem-specific interfaces around
> > what is fundamentally the same sparse-vmemmap optimization.
> > 
> > This series generalizes that optimization into a common framework used
> > by both HugeTLB and device DAX.
> > 
> > The first few patches include some minor bug fixes found during AI-aided
> > review of the current code. These fixes are not the main goal of the
> > series, but the later refactoring and unification work depends on them,
> > so they are included here as preparatory changes.
> > 
> > The series then reworks the relevant early boot and sparse
> > initialization paths, introduces a generic section-based sparse-vmemmap
> > optimization infrastructure, switches HugeTLB and device DAX over to the
> > shared implementation, and removes the old special-case code.
> >
> > ...
> >
> >  46 files changed, 743 insertions(+), 1812 deletions(-)
> 
> Gulp.
> 
> I think the first 15ish patches (little fixes and cleanups and
> refactorings) are ready to go in immediately?

I plan to have a (partial ) look at this tomorrow/Friday, but splitting
this series in fixes-that-can-go-straight-away and the feature itself would make more
sense and help ease the review.
Head tends to spin a bit when the patchset grows beyond certain number of patches :-D.

Would that be possible Munchun?

 

-- 
Oscar Salvador
SUSE Labs

