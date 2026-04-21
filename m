Return-Path: <linuxppc-dev+bounces-19863-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9850FF5A8DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 03:55:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g07n40l92z2yfS;
	Tue, 21 Apr 2026 13:55:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776743752;
	cv=none; b=MQXR3l7zrHbm9pHEMv7fKpDqwrtTjLets9xXIaYi/H5MsbVIu7XfvjmmFzlR1jq61LATkb6QiZ4VOH8LQaDxq655VRPcaFpuFi90B9gFNK9SwqUatgwYc4hl5j+Icw5p1S9QgPZPXtsz/YOhHuxQMyxFt42oNujoS/uJ2uzAghubxCRqZfgJgfbE979bEne16me34ZIgQVLN9FH2vYfi2vVd+P3uY0eGclGmogdEwdLZGwctqQvipf0uBhC8nG7LdiA65B0BILhyVKPmRn3H14tdNkB+rcE5tN7371WNisF8Ck5ha/D2sfvZS6xUDOeCj2JTtpp03D1frGDCRa9SYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776743752; c=relaxed/relaxed;
	bh=IDVUbgdLvJLIeQVXYQIqbs7pEdXqPLVFAHC8mrcXVSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWDTqtagYiuBJ6DjW0ykUoqA9fNGRifF4Yg2nW50HejR4ohtMtjjU6sc/J01DOUnvlm2AlFhZIknJgrD8TC3qsUECPR/F7b67VvvUMfGWdwcCwS+zsB319bwcA+IgylKXm41XwwfyC58RXjyYrw4Gbzw/UlLig1L3yspDtqz7zsHmXi3ptzC4dRnN0Z+4Pvr+t1ilvF8yJ4POmRL1egpv7utbYxaa/JqbzrTBa3jNYtKdcslJIwYAh2FRCBbF3YdiHzdhpnS9jPl6j0hbfNxVrPxWB79IPAHJSg5qn2leGaTWg8qY9Sjhs6rKxB5bBqk4XBvSH41IabFSFXt+Tum0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=z+aTATz0; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bFbKc3gi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=z+aTATz0; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bFbKc3gi; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=z+aTATz0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bFbKc3gi;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=z+aTATz0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bFbKc3gi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g07n329g2z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 13:55:50 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 301705BCDB;
	Tue, 21 Apr 2026 03:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776743746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDVUbgdLvJLIeQVXYQIqbs7pEdXqPLVFAHC8mrcXVSg=;
	b=z+aTATz0T6umjQ5O0z+TOGIn74fHWAefJyFfgsKaUncEB4dmC30Iq37o2gy1hsv8uUp89u
	oJmIEcBm9v4JB6hBc7kgD0Od9amhicQy9vYyZQj8ckQf+u6hBjG/3ICY+iOWCPHRP9UXQt
	LSPoJJ4TqwaF/FPM0wJm2OoxxHbZevA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776743746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDVUbgdLvJLIeQVXYQIqbs7pEdXqPLVFAHC8mrcXVSg=;
	b=bFbKc3gikECZQSviGQs0y1uKj+LVkV0Wg3WuYg04UDC7GzXWXzmKSt7B9Z/5pUiF5l8Lwe
	nuLmnak/+N32IPAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776743746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDVUbgdLvJLIeQVXYQIqbs7pEdXqPLVFAHC8mrcXVSg=;
	b=z+aTATz0T6umjQ5O0z+TOGIn74fHWAefJyFfgsKaUncEB4dmC30Iq37o2gy1hsv8uUp89u
	oJmIEcBm9v4JB6hBc7kgD0Od9amhicQy9vYyZQj8ckQf+u6hBjG/3ICY+iOWCPHRP9UXQt
	LSPoJJ4TqwaF/FPM0wJm2OoxxHbZevA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776743746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IDVUbgdLvJLIeQVXYQIqbs7pEdXqPLVFAHC8mrcXVSg=;
	b=bFbKc3gikECZQSviGQs0y1uKj+LVkV0Wg3WuYg04UDC7GzXWXzmKSt7B9Z/5pUiF5l8Lwe
	nuLmnak/+N32IPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C208593AF;
	Tue, 21 Apr 2026 03:55:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +2K0C0H15mk2YAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 21 Apr 2026 03:55:45 +0000
Date: Tue, 21 Apr 2026 05:55:35 +0200
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
Subject: Re: [PATCH v3 2/4] mm/sparse-vmemmap: Pass @pgmap argument to memory
 deactivation paths
Message-ID: <aeb1N2T1rX6GHrXn@localhost.localdomain>
References: <20260421022044.1217503-1-songmuchun@bytedance.com>
 <20260421022044.1217503-3-songmuchun@bytedance.com>
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
In-Reply-To: <20260421022044.1217503-3-songmuchun@bytedance.com>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,ellerman.id.au,linux.ibm.com,oracle.com,google.com,suse.com,gmail.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email]

On Tue, Apr 21, 2026 at 10:20:42AM +0800, Muchun Song wrote:
> Currently, the memory hot-remove call chain -- arch_remove_memory(),
> __remove_pages(), sparse_remove_section() and section_deactivate() --
> does not carry the struct dev_pagemap pointer. This prevents the lower
> levels from knowing whether the section was originally populated with
> vmemmap optimizations (e.g., DAX with vmemmap optimization enabled).
> 
> Without this information, we cannot call vmemmap_can_optimize() to
> determine if the vmemmap pages were optimized. As a result, the vmemmap
> page accounting during teardown will mistakenly assume a non-optimized
> allocation, leading to incorrect memmap statistics.
> 
> To lay the groundwork for fixing the vmemmap page accounting, we need
> to pass the @pgmap pointer down to the deactivation location. Plumb the
> @pgmap argument through the APIs of arch_remove_memory(), __remove_pages()
> and sparse_remove_section(), mirroring the corresponding *_activate()
> paths.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

The change looks good to me, but I was wondering whether we should pass a
mhp struct instead to low-level functions like arch_remove_memory and
__remove_pages and have __remove_pages then pass the right stuff down
the road.
That way it would mimic more what we do in hot-add path.


-- 
Oscar Salvador
SUSE Labs

