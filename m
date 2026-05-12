Return-Path: <linuxppc-dev+bounces-20755-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3166FCD4F26
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 08:29:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF8rZ5PYLz2yYs;
	Tue, 12 May 2026 18:29:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778574542;
	cv=none; b=lu1L6svmP4x54akJuawebAnyK59+VXfCq3xJKW6fm40VVuuhA6sogakkQP2Ngjlkn/yO+IgKsZUG50ztSLf6kaJqMxp0Xx1EaZxoQOVlVsyj+f1o0D+4mNubtcb7I65Ol4hJzCqkwZkL439Iz8+8/Vi0/J92rx41eN/+RJO8fQjkJnPSLgYBkqruga3dfuCgXyWs8zI+boyRTyFPeNO7+z8YaLFvG8QU+fP23tjVczSXIcT0hY5pSTKr1ibnUmIbglIT6/SCfGOVHqMZ61iNe4UYWmpEXGLe+1NDiF4kkuNdzhgQMf3tPY3eyry/tB4hd9DNa8xvdVKGXCzckJRiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778574542; c=relaxed/relaxed;
	bh=IC6xPzST+TZhZT7b1WIo6RFfE0Aey6ccxBiATRxTi4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6nC2HaHIEOgQbATzEykhghtjvwBKAPXzymi2R0k+3BV07KK2bmarrfGH/ij7Xxxe9l4O8Cjs/Mwva4jnbAHOKDQ4TUyj1TrpE49jpboGDhN8BfTe/ldWCVT+yoJ2oxnSF76HyXYKsac8no0ztAFM/GtCrHZEYvOgz19V8wOOT0cBwsDvRiJUCwcrD2b5EJ/daS2+MB3pYgybFnd/64chOBo3tUX7HhY9xWjWhsQcEtV1CGMMoA5rlB2B6Lo9bck/gZ2zjY8R1k9aG5TdQM36YILR9S84zfOJToHa3990Oe5GvecAp2FfIr5YUu4S5TLPolXwlL/fLPBw8UuLgpcew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0cb/jXDm; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WrQ6pNAl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0cb/jXDm; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WrQ6pNAl; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0cb/jXDm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WrQ6pNAl;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0cb/jXDm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WrQ6pNAl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF8rY3Dj3z2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 18:29:01 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DC9375945;
	Tue, 12 May 2026 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778574537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IC6xPzST+TZhZT7b1WIo6RFfE0Aey6ccxBiATRxTi4A=;
	b=0cb/jXDmbTUTOFNVqvSALI0F/JLIGlZa+ISDVhETi7RIgHnQAFCL2FUIVLOPyI2BcE4DPH
	D3zKfFHuY4IbaF43v/qG0Pwf+Y9ggOovwObNOOityEAK9xFZZ10RYgzz0YQKwiTn1NGkL4
	Z/H6E8qJqYBu2oY65BbElKFojkZxHG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778574537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IC6xPzST+TZhZT7b1WIo6RFfE0Aey6ccxBiATRxTi4A=;
	b=WrQ6pNAlxMrbbhvFBJ1inQltEsG5LvqeRs8lVC7DSvf/p5PZbOtGB7cGqYIDMHYw2o+KFv
	4XitzC/nndVhJEAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778574537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IC6xPzST+TZhZT7b1WIo6RFfE0Aey6ccxBiATRxTi4A=;
	b=0cb/jXDmbTUTOFNVqvSALI0F/JLIGlZa+ISDVhETi7RIgHnQAFCL2FUIVLOPyI2BcE4DPH
	D3zKfFHuY4IbaF43v/qG0Pwf+Y9ggOovwObNOOityEAK9xFZZ10RYgzz0YQKwiTn1NGkL4
	Z/H6E8qJqYBu2oY65BbElKFojkZxHG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778574537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IC6xPzST+TZhZT7b1WIo6RFfE0Aey6ccxBiATRxTi4A=;
	b=WrQ6pNAlxMrbbhvFBJ1inQltEsG5LvqeRs8lVC7DSvf/p5PZbOtGB7cGqYIDMHYw2o+KFv
	4XitzC/nndVhJEAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AB7A593A9;
	Tue, 12 May 2026 08:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n1NXF8jkAmpyewAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 May 2026 08:28:56 +0000
Date: Tue, 12 May 2026 10:28:54 +0200
From: Oscar Salvador <osalvador@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/8] mm/bootmem_info: drop initialization of page->lru
Message-ID: <agLkxhtQLnupEPbT@localhost.localdomain>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

On Mon, May 11, 2026 at 04:05:30PM +0200, David Hildenbrand (Arm) wrote:
> In the past, we used to store the type in page->lru.next, introduced by
> commit 5f24ce5fd34c ("thp: remove PG_buddy"). The location changed over
> the years; ever since commit 0386aaa6e9c8 ("bootmem: stop using
> page->index"), we store it alongside the info in page->private.
> 
> Consequently, there is no need to reset page->lru anymore.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

