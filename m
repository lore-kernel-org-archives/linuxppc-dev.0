Return-Path: <linuxppc-dev+bounces-20764-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AACCD4F26
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 08:45:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF9CH2W39z2ynn;
	Tue, 12 May 2026 18:45:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778575515;
	cv=none; b=DsVXqTiV7ZfCwDgx0htoiLP+Mb4YtAX2eNMUsbBq3eNw+qs1ar3UPHDjsjzt9YNPZG5bL90iZkpu3lN0jCdBN8QrtGLhi/hbtyGDeS37g38k2nBHcBt9xOHgJRAviYPdO2SnyzzHhsshGVR5WgiulaO0EqE7NXKSTBjXUml2xFbvuAo5OqD2VEqhxe8I0vs8boFvcJ8kJkbmZ/v0yh5Wzt9MkLVeOW4+X59DBvnbkBaQHW+RZGt38Lo4smIvtnfthsmfZl9spASbhqkI1XXlh/tRsyUx6o3V/UY26AlfKIlN1KF6B7GVBD3kLU6ti2cHRNqEpVh52ER6qob5ap6XRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778575515; c=relaxed/relaxed;
	bh=VVhUu+lg1kvYAZheHCbKtRrVHTg43eeZOy4q05OgGw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK+aMgXAeTMAFKupLOnFKitCc2ryqPj1tnh2HO5uA4DjXwglNwYRVCZfz0lTt1hFJubz9o/iWVI/M7TlW+zd+MhsDb0SLvZxwhKIuIfD0Bqmra4qbDOKaXCgW4K5/mTN3okxxos8wzUaUVTtqqRGUx+A7RBgXBlR0By6glDtIDKqdWGDgoFNbw7rapawnqjlZCFTZ4GqSLrAWauXuw3iR51+nMPDEBstYGfoGcFGK6ad6Po74wosuztXV+Wa3HvLbwOSSQkFhTNd/kcRNtuHlHyTnSbladJeXMcJdbXJZY5g2uz4Jvwwtm0JssgCXTfOro/V+nzSaLqLYYgEXcv7tQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0DIAw/Lb; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wlS+ubs2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0DIAw/Lb; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wlS+ubs2; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0DIAw/Lb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wlS+ubs2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0DIAw/Lb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wlS+ubs2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF9CG3xy7z2yYs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 18:45:14 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EADE5D634;
	Tue, 12 May 2026 08:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VVhUu+lg1kvYAZheHCbKtRrVHTg43eeZOy4q05OgGw0=;
	b=0DIAw/LbkWRCYPpD3+i1wnlozxRda8gJxf0kVkjNTDXsTbOdeGH/d4BBCo6imoUNbuN6hC
	A+aBChhNKHHqLAz+qr+5HJ/EO0w9hc6E3Euu0JajBE6G32rTNIRLPKJjnBwwRBLnG/raic
	dzzpDPMWy2jOOFSnfNkzfdC4jyKQCdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VVhUu+lg1kvYAZheHCbKtRrVHTg43eeZOy4q05OgGw0=;
	b=wlS+ubs2D6Ep/tmUl0C2jTHAHUUW9og+1my0meSb8uJ28QcnzxeTrdYUZof5QUj/PfTmeB
	6ZtA3N0+klZT+5Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VVhUu+lg1kvYAZheHCbKtRrVHTg43eeZOy4q05OgGw0=;
	b=0DIAw/LbkWRCYPpD3+i1wnlozxRda8gJxf0kVkjNTDXsTbOdeGH/d4BBCo6imoUNbuN6hC
	A+aBChhNKHHqLAz+qr+5HJ/EO0w9hc6E3Euu0JajBE6G32rTNIRLPKJjnBwwRBLnG/raic
	dzzpDPMWy2jOOFSnfNkzfdC4jyKQCdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VVhUu+lg1kvYAZheHCbKtRrVHTg43eeZOy4q05OgGw0=;
	b=wlS+ubs2D6Ep/tmUl0C2jTHAHUUW9og+1my0meSb8uJ28QcnzxeTrdYUZof5QUj/PfTmeB
	6ZtA3N0+klZT+5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23421593A9;
	Tue, 12 May 2026 08:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uZmDBpfoAmo7DAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 May 2026 08:45:11 +0000
Date: Tue, 12 May 2026 10:45:09 +0200
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
Subject: Re: [PATCH 0/8] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 1)
Message-ID: <agLolRUSzT9gnMZn@localhost.localdomain>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid]

On Mon, May 11, 2026 at 04:05:28PM +0200, David Hildenbrand (Arm) wrote:
> We want to remove CONFIG_HAVE_BOOTMEM_INFO_NODE. As a first step,
> let's limit the remaining harm to x86 and core code, removing
> sparc, ppc and s390 leftovers, starting the stepwise removal by removing
> and simplifying some code.
> 
> Once a related x86 vmemmap fix [1] is in, we can merge part 2 that will
> remove CONFIG_HAVE_BOOTMEM_INFO_NODE entirely.
> 
> Tested on x86-64 with hugetlb vmemmap optimization in combination with
> KMEMLEAK, making sure that the problem reported in dd0ff4d12dd2 ("bootmem:
> remove the vmemmap pages from kmemleak in put_page_bootmem") does not
> reappear -- hoping I managed to trigger the original problem.
> 
> Heavily cross-compiled, but let's let build bots run on it for a bit.
> 
> [1] https://lore.kernel.org/r/20260429-vmemmap-v2-1-8dfcacffd877@kernel.org 
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Awesome cleanup David, thanks for doing this ;-)

 

-- 
Oscar Salvador
SUSE Labs

