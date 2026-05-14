Return-Path: <linuxppc-dev+bounces-20945-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FCFCD4851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 08:12:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGNNZ4VyYz2xy8;
	Thu, 14 May 2026 18:12:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778746350;
	cv=none; b=gRPwHQFEdOhf99a5sd8mBpJqQA+zkhMTYg4BLsYn0jOo59tvRR7h9JHviDsw8WwSJhy2ZjHd0HTB3+XN6shRO8XCAtHKiE3oHngf2OvWd2pOkw/VmrLh4z8k19AKQ4eGhWlX3I0ti+XZvcJomMPfznAojt4i9hXsSvxaT6ldVcp+JOVmbmw29BGnw+ZBXrIBRFMYS0Nkfm+Uw2EhbtrUDTGWpS+mYbaVFwDoNw6ENv4v074jOQhyvN+IRYfsThPYgEBXx0eNjYN0gtOc8ibePtqfuVlstslX8h9qP+ojjkBBHOzBIz89yBwTVyu0klNWpICCHFFJktRXbM9Iqh9qHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778746350; c=relaxed/relaxed;
	bh=ETngYR2j68Acn31dR1IX4qVn4fOT6tuFxnVWZdzLlIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USGMpq8DI6Ky1mWxjJ8awkmzO6dTXnDTwnGxIML7XKODzp7I8giQ3uaZwLCuNATAttZkbZXuBszUy78/lLIKcDr/5HrE1YZl8+uZgSXJAj6zg7SVTPgP7RZhRcD0P/dNGn4Nzk5Q504ONqYHwhVu9Jt/5csJ7j/M4XdgoOQiP1+bYTSvMdYm3TRu7MyAOh6pzOHm5a4BV5kHxRq+C0G3CxxSI8ZuHYkzD9IxYxg8P8jvOV4vl2UmhT1ZUZ6lS3nI3OqcRBLVKR6whEKuxnltAkQ7kQjufoUi/0lhPyJeL+M2WOue8Sn3Iy8+cHvrzY+yS/wn1FKcgqy3+geJxFoauA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BYfnfFYh; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s4j43AXD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BYfnfFYh; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s4j43AXD; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BYfnfFYh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s4j43AXD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BYfnfFYh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s4j43AXD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGNNV3XY8z2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 18:12:26 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AAA2666E05;
	Thu, 14 May 2026 08:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778746343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETngYR2j68Acn31dR1IX4qVn4fOT6tuFxnVWZdzLlIM=;
	b=BYfnfFYh2W/bA11kp0OY5ZlLkNcowTz0mbGaG4zNJAimsSL0TMCy46ohzg+0ZiCqNI9hSA
	SedYdrkijjifG5IQfb5P7Vanw1dgZSuazlsHSvqUn0+lfvSQZdi0vTDjlQxqNKf442glVA
	JYFATDOpFQD519fJzCL9qT5SVwFx6cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778746343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETngYR2j68Acn31dR1IX4qVn4fOT6tuFxnVWZdzLlIM=;
	b=s4j43AXDYJKsTr2rpuJn/O977uq3cjI07syszbtRPp9siNJtl1cdSG6nu5U9mtpqJHzhE+
	JsaJekvrtUWW4dDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BYfnfFYh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s4j43AXD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778746343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETngYR2j68Acn31dR1IX4qVn4fOT6tuFxnVWZdzLlIM=;
	b=BYfnfFYh2W/bA11kp0OY5ZlLkNcowTz0mbGaG4zNJAimsSL0TMCy46ohzg+0ZiCqNI9hSA
	SedYdrkijjifG5IQfb5P7Vanw1dgZSuazlsHSvqUn0+lfvSQZdi0vTDjlQxqNKf442glVA
	JYFATDOpFQD519fJzCL9qT5SVwFx6cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778746343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ETngYR2j68Acn31dR1IX4qVn4fOT6tuFxnVWZdzLlIM=;
	b=s4j43AXDYJKsTr2rpuJn/O977uq3cjI07syszbtRPp9siNJtl1cdSG6nu5U9mtpqJHzhE+
	JsaJekvrtUWW4dDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A467C593A9;
	Thu, 14 May 2026 08:12:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1HGVJeaDBWrRGQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 14 May 2026 08:12:22 +0000
Date: Thu, 14 May 2026 10:12:21 +0200
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
Subject: Re: [PATCH v2 05/69] mm/mm_init: Simplify deferred_free_pages()
 migratetype init
Message-ID: <agWD5ZYu0In6vaHN@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-6-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-6-songmuchun@bytedance.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,ellerman.id.au,linux.ibm.com,oracle.com,google.com,suse.com,gmail.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,bytedance.com:email,localhost.localdomain:mid];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: AAA2666E05
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Wed, May 13, 2026 at 09:04:33PM +0800, Muchun Song wrote:
> deferred_free_pages() open-codes two loops to initialize the pageblock
> migratetype for a range of pages.
> 
> Replace them with pageblock_migratetype_init_range() to remove the
> duplication and make the code clearer (Note that deferred_free_pages()
> may be called from atomic context).
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

