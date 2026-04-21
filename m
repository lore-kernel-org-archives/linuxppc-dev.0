Return-Path: <linuxppc-dev+bounces-19862-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943BAF5A8DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 03:45:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g07YY0XN3z2yfS;
	Tue, 21 Apr 2026 13:45:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776743152;
	cv=none; b=Hj/Ds4RV5vDgUkmUHY4m/ku7wlEbXwWkhdI9DOTNR9vS1NdtaLgsYEUy7GAcQBhamltyJc3+CiGutBB7dwYNzLAXl7EosWDY/95g8LEYxgvsc3Ee9WzvmGq8qy4QoXtl3RYz9FGjOr5//mSY9TRYlDTF8bsrl20+hv0iRq35D0+PJZKCuni+6B7AM4pQHRPrku9UhixHwppIJFWdDLGYDMDm27/MnKipm1S5sLw1J6my7nI2xAUtumiM759PWZ1KZENfr9Rt7scUjTq1IPUiV0c6mcwu7SOyZSW09+YqFlhe4tTy0Ax97lcjme9Uor2WCNNB8nLpDBJPKtyCYFI58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776743152; c=relaxed/relaxed;
	bh=cJfTWXk1mSbZKfRW0DNvuHTmZm6Tw2gEEwGye/AIRbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je7xj/lHoPioc9dYzwEaE8IZTUsQWVscJAI5toWY+x2KvuPsrawLj5YQ+KQpPxl4kppeMvAuOKCd1pmZJ7dDuO4zy8/wKWcOsK4NbfkoZnCdqAhv5SkRaPfS+2ws9xUImcTfw4a+9euHMu+9fCgDyadgDpBOdzA0X4KZBngUqb2uZB++CU6VpAj90ySA5wV7k/mRJnN1gze8lN3gJ6/rKgbBnbxZ221Gqa3LZPKsSDKA3yWBVuFc/dgycKKvzXZxV49EFAiOi8iTz3R2aWWbDe0hb9bteFbXlydVvt8CBaPEknqYy0TwK6sdAQ993CwN4hefUQwQacRCY/lIhhODLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FwnwfsJN; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0g7slwHV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FwnwfsJN; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0g7slwHV; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FwnwfsJN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0g7slwHV;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FwnwfsJN;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0g7slwHV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g07YW0BCLz2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 13:45:50 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46DCF6A7EA;
	Tue, 21 Apr 2026 03:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776743147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJfTWXk1mSbZKfRW0DNvuHTmZm6Tw2gEEwGye/AIRbg=;
	b=FwnwfsJNvJQyvE7l3cZfssEq4WjipWOchHPpCqYz8LwmH6Lmo4/24QiaMzyyBHixkRk2Oa
	MwuJTB0IcEOhwQzhpCCeVMOh9sNxCCEzpo4GLEbJ0KtsHSY19OyMkQDAofkMXzyNPLSRgK
	xGKCMsBZAoyXj6XV7ATB+ZIxX6pv6qM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776743147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJfTWXk1mSbZKfRW0DNvuHTmZm6Tw2gEEwGye/AIRbg=;
	b=0g7slwHVd1GI62pXsPEDF4i5WYqsG2QxlBjPi3h2Aoz/fswC+9NDUJM0gq63WiR24nZtWp
	RNRv9RnJqNtv4xCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776743147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJfTWXk1mSbZKfRW0DNvuHTmZm6Tw2gEEwGye/AIRbg=;
	b=FwnwfsJNvJQyvE7l3cZfssEq4WjipWOchHPpCqYz8LwmH6Lmo4/24QiaMzyyBHixkRk2Oa
	MwuJTB0IcEOhwQzhpCCeVMOh9sNxCCEzpo4GLEbJ0KtsHSY19OyMkQDAofkMXzyNPLSRgK
	xGKCMsBZAoyXj6XV7ATB+ZIxX6pv6qM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776743147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJfTWXk1mSbZKfRW0DNvuHTmZm6Tw2gEEwGye/AIRbg=;
	b=0g7slwHVd1GI62pXsPEDF4i5WYqsG2QxlBjPi3h2Aoz/fswC+9NDUJM0gq63WiR24nZtWp
	RNRv9RnJqNtv4xCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58617593AF;
	Tue, 21 Apr 2026 03:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U/DjEury5ml4VwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 21 Apr 2026 03:45:46 +0000
Date: Tue, 21 Apr 2026 05:45:40 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mm/sparse-vmemmap: Fix vmemmap accounting
 underflow
Message-ID: <aeby5KB7E8Hr8l6G@localhost.localdomain>
References: <20260421022044.1217503-1-songmuchun@bytedance.com>
 <20260421022044.1217503-2-songmuchun@bytedance.com>
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
In-Reply-To: <20260421022044.1217503-2-songmuchun@bytedance.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,ellerman.id.au,linux.ibm.com,oracle.com,google.com,suse.com,gmail.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]

On Tue, Apr 21, 2026 at 10:20:41AM +0800, Muchun Song wrote:
> In section_activate(), if populate_section_memmap() fails, the error
> handling path calls section_deactivate() to roll back the state. This
> causes a vmemmap accounting imbalance.
> 
> Since commit c3576889d87b ("mm: fix accounting of memmap pages"),
> memmap pages are accounted for only after populate_section_memmap()
> succeeds. However, the failure path unconditionally calls
> section_deactivate(), which decreases the vmemmap count. Consequently,
> a failure in populate_section_memmap() leads to an accounting underflow,
> incorrectly reducing the system's tracked vmemmap usage.
> 
> Fix this more thoroughly by moving all accounting calls into the lower
> level functions that actually perform the vmemmap allocation and freeing:
> 
>   - populate_section_memmap() accounts for newly allocated vmemmap pages
>   - depopulate_section_memmap() unaccounts when vmemmap is freed
> 
> This ensures proper accounting in all code paths, including error
> handling and early section cases.
> 
> Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

