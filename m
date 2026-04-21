Return-Path: <linuxppc-dev+bounces-19864-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA21F5A8DE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 04:00:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g07tT1KDwz2yfS;
	Tue, 21 Apr 2026 14:00:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776744033;
	cv=none; b=I3kpI2EkjmqJY961NsjFbL22KzdaUptZtgWB6N4Q+Vu1WthCvScgt4UIHC16/P0ZkZsAF43lQmniaSquBsU8C3ztuPb1Q97kfMd9yHftufJiGn27oSshB7iV7iT6qLbHJrdv8OKWtrvpzdMVbJzmt29gBpXeDbiz65yJT8OyK3KXZw2hdFSAOSVvH3Gq5OPaCgySFcA4ZnAjr084KOJhNxNBiLJ191/+jJoca56eZHg2PxU2MuhSYJdqTHJCx3k44Yn2m4E1FhRdzS015L620M9LVF97fbPGsqm15oocszWmeTqMA7CjeuohFlJsmZhwiBOT1jh5ad5SZO0QkgB+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776744033; c=relaxed/relaxed;
	bh=4A0ljlz7kc/WriQ+M/v/RuPawRjA5LvJ8/tA1kiAeS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ31R+1QSmk4opM2x7mNmboxEdxvQXeiHURQE9n42NWZD22Qq9hUA1LTN6vpg792TCnYlFamyUq9MIhlVXmsheugbJ6wlw7lslamRzcth9o09PFr9reK5oVaOwiZ/SJY8sAwkQEqvJBKQx+IvzfvOse/5QjsHpNiwtrUDBQgsL7O4jbWaxQcN6/AAcicOS7z85kVP2D8N2y+AFJVAk6t5HH498noTZIE11HOWTkMOAsuCnQO598+z6nrpKi2+tRWOiuj2pr9yQqO5PfIBmdyz8VxGP4OC0zpWOFhDE+zZ6963va/kTUh9iZNbeaPiD89Vm6lNvE1W3t2dM6yPFei8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l/rWzc7W; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qkBNhF1f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l/rWzc7W; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qkBNhF1f; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l/rWzc7W;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qkBNhF1f;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l/rWzc7W;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qkBNhF1f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g07tS3ZNFz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 14:00:32 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F05785BCDB;
	Tue, 21 Apr 2026 04:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776744030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4A0ljlz7kc/WriQ+M/v/RuPawRjA5LvJ8/tA1kiAeS0=;
	b=l/rWzc7WXlG1ul7xO38sOUa9Pgk1j890efsw9F/Rih7jfUqvFT7L7nTXY3ZWZA+jmp0C2r
	dBUr61YekC/8vZQR31aqOPcgWTO2+xJhDf4A5Qr0ZTSZxy/UAguM2PH0P5ivfSBvxWJjHF
	CWxvRGDpMuS2nfweEHs4sK/nYABxexs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776744030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4A0ljlz7kc/WriQ+M/v/RuPawRjA5LvJ8/tA1kiAeS0=;
	b=qkBNhF1fpYtHAmCt1yloAGLz1VUrShhp9DtGMDvaI/6hb/adOboe+fZLsHz1I9RCe4JdVg
	snuwQAq3XP92dLAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776744030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4A0ljlz7kc/WriQ+M/v/RuPawRjA5LvJ8/tA1kiAeS0=;
	b=l/rWzc7WXlG1ul7xO38sOUa9Pgk1j890efsw9F/Rih7jfUqvFT7L7nTXY3ZWZA+jmp0C2r
	dBUr61YekC/8vZQR31aqOPcgWTO2+xJhDf4A5Qr0ZTSZxy/UAguM2PH0P5ivfSBvxWJjHF
	CWxvRGDpMuS2nfweEHs4sK/nYABxexs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776744030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4A0ljlz7kc/WriQ+M/v/RuPawRjA5LvJ8/tA1kiAeS0=;
	b=qkBNhF1fpYtHAmCt1yloAGLz1VUrShhp9DtGMDvaI/6hb/adOboe+fZLsHz1I9RCe4JdVg
	snuwQAq3XP92dLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB57A593AF;
	Tue, 21 Apr 2026 04:00:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CS6oNlz25mnwYwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 21 Apr 2026 04:00:28 +0000
Date: Tue, 21 Apr 2026 06:00:19 +0200
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
Subject: Re: [PATCH v3 3/4] mm/sparse-vmemmap: Fix DAX vmemmap accounting
 with optimization
Message-ID: <aeb2U5tUQQe1YzJY@localhost.localdomain>
References: <20260421022044.1217503-1-songmuchun@bytedance.com>
 <20260421022044.1217503-4-songmuchun@bytedance.com>
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
In-Reply-To: <20260421022044.1217503-4-songmuchun@bytedance.com>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid,suse.de:email]

On Tue, Apr 21, 2026 at 10:20:43AM +0800, Muchun Song wrote:
> When vmemmap optimization is enabled for DAX, the nr_memmap_pages
> counter in /proc/vmstat is incorrect. The current code always accounts
> for the full, non-optimized vmemmap size, but vmemmap optimization
> reduces the actual number of vmemmap pages by reusing tail pages. This
> causes the system to overcount vmemmap usage, leading to inaccurate
> page statistics in /proc/vmstat.
> 
> Fix this by introducing section_vmemmap_pages(), which returns the exact
> vmemmap page count for a given pfn range based on whether optimization
> is in effect.
> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

