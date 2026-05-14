Return-Path: <linuxppc-dev+bounces-20942-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAF3CD4F25
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 07:56:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGN2S1SrHz2xy8;
	Thu, 14 May 2026 17:56:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778745408;
	cv=none; b=g5QVXEjjOR54dfz5PJkwzoXgFcfOBfcfqpC/l9epDZQCiDGC0YP0S3CvOnLf+ILVuM1iYbek5kTml4n5V3QM0xdNGw1mV0cn8mUHkcszchmPpFU0ikwxg8zMIgrop8Np6W0BqCy+eEvMjT7vUk62jGounyZO8PMfO4UThtrm0GV07EWC4b4LJ9xHLrzjQZffuj2dpq2/FmVv2UGC4ugAPlkZCZFyNEUJ+NoGbgUZnHxw0AaMItEFcIa+/GoLPyRcWWvx/4l5uZefwYVtmVVV5YI1YShvwU/I+Ej5TSFB3VKOcs/fwcj60TJpbgz0rmAU47kY7EsHd/blQy2iDti7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778745408; c=relaxed/relaxed;
	bh=HwFSQfDMERUWUOQUggcVf3A37PosV5rvk/rTsK4+J9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbJ0xtE1zMddTdTtIWmHfo9UekaplrLCRVM427qCr4SsMSaWF+cZPGc85S/L0Sgz2kd/IdfrGDySzR7ZQyXnc9ay20Pk2mcOlTCazyY36Oc5ghNBCgKNnDvz3rnN28GiAWLMhSL5oiqNLwSFka3PM7klHoP/3ZfW1TtJbuvqk9P48+SLmB9L1pNqC1wA5dq0fLCfmszmzOYYjPSLkaeGmLF/KQnqHG8QqHUS3/TMM48gmXWPeQHGWRJXYT6rY5e7ploW8W6OoUpyQvr8TNvxaZARXQ0ZY01eV/DaoUP9beDTCuSbL8oIiz2VddEarFd+50wYVkasqsetLRCkwgUECg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=x/Erx4Nf; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TtIDAUXw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tMaeTE1G; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9xp7FAK6; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=x/Erx4Nf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TtIDAUXw;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tMaeTE1G;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9xp7FAK6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGN2M71cCz2xdL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 17:56:43 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99FA567268;
	Thu, 14 May 2026 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778745400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwFSQfDMERUWUOQUggcVf3A37PosV5rvk/rTsK4+J9I=;
	b=x/Erx4NfTcSQmE++lS/rrpLvevnL6hKmyXFkXCGeayIxwLjHWwwX2McagtqjNTb3YugtO2
	fDDD+dVjx2/ZpzqBrh70SWeCTtC+cCVZ08KCDTXS8sSUo35IDRInjmppj4F350fopUsA2+
	sW11erwwMBSpZZ1PeXkJhV0EqvWLWVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778745400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwFSQfDMERUWUOQUggcVf3A37PosV5rvk/rTsK4+J9I=;
	b=TtIDAUXwuhJFQ9RVUdwnnLdHZh9f/tX90eoRTZvjOqadw2+Gq6IiVFVUdvggEFdrpWmr39
	ixkaEFSsLj4Ab6BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778745399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwFSQfDMERUWUOQUggcVf3A37PosV5rvk/rTsK4+J9I=;
	b=tMaeTE1G2wmNettriYEUN+3VtxUt46taiJjVvnpojK7t+/I7V6l0gW9OSFna2xPovLgLK+
	KR/EBBqeUuOFO83iCGMHF/ExytlvZe5KFI8h6tPOpL/R7pLLXF6TTCZa05auq3MCTYPZM7
	woSqnKntB0IyZbX47+1TvXQblkuZYu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778745399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwFSQfDMERUWUOQUggcVf3A37PosV5rvk/rTsK4+J9I=;
	b=9xp7FAK6lpGh4FznFoaMpPoctBt32DI1ci1gPtYSNBvJW83BIbcC1xrAO86EVk+nh5MVFj
	8nx4wdp4/toVdrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D562593A9;
	Thu, 14 May 2026 07:56:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DDAPHzaABWqICgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 14 May 2026 07:56:38 +0000
Date: Thu, 14 May 2026 09:56:37 +0200
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
Subject: Re: [PATCH v2 02/69] mm/hugetlb_vmemmap: Fix
 __hugetlb_vmemmap_optimize_folios()
Message-ID: <agWANe6i5gsfXFgP@localhost.localdomain>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-3-songmuchun@bytedance.com>
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
In-Reply-To: <20260513130542.35604-3-songmuchun@bytedance.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,bytedance.com:email]

On Wed, May 13, 2026 at 09:04:30PM +0800, Muchun Song wrote:
> __hugetlb_vmemmap_optimize_folios() uses incorrect arguments when handling
> bootmem HugeTLB folios.
> 
> The section number passed to register_page_bootmem_memmap() is derived from
> the vmemmap virtual address of folio->page instead of the folio PFN, so the
> bootmem memmap metadata can be registered against the wrong section. The
> helper is also given HUGETLB_VMEMMAP_RESERVE_SIZE even though it expects a
> page count, not a size in bytes. In addition, the write-protect range is
> based on pages_per_huge_page(h), which does not cover the full HugeTLB
> vmemmap area and can leave part of the shared tail vmemmap mapping writable.
> 
> Fix the section lookup to use folio_pfn(folio), use
> HUGETLB_VMEMMAP_RESERVE_PAGES when registering the reserved memmap pages, and
> use hugetlb_vmemmap_size(h) for the write-protect range.
> 
> Fixes: 752fe17af693 ("mm/hugetlb: add pre-HVO framework")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

did you observe any Ooops or malfunctioning or was just code reviewing?

 

-- 
Oscar Salvador
SUSE Labs

