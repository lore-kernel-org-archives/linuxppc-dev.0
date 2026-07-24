Return-Path: <linuxppc-dev+bounces-24790-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77654C531FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 15:32:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6Bny4zbPz2yYf;
	Sat, 25 Jul 2026 01:32:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784907174;
	cv=none; b=WRRJQJYGgUjUgzumzRsQoRe+Vyw6yiZb1JRD+C1M6z2TCi8jWUGv6PVBdqMfCnTMJAQCLEzkndJx/X3vgaAG/7iJe5TDnIkJHPxYnAbGHotPseJ1RSQcDCcuvJTAIXlxzty8Is7U0phWrRwMlmfpJxwfT+qjNFJQFXdUyz5w/KSE7wWam0i01oG6AAI16oVjUdOjmIGLVZASvw8+h3aOj1exZVpbvIAvhmTkDDrt7LgceRNRU4EvOageOuGtwBs3VGM7TM044uIaxMhk90be/frRpOH7/X8pi9YcleH+wMwJccAbtNWLwZc7Q/p8tNOSO+/EPYVkJOztJqaYzGM/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784907174; c=relaxed/relaxed;
	bh=MgLR94cnov6/P8Yl4U/7T81H0kr3VMn5Pq5dQ8bzHh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jllXAs6VlKVX+oN8p4/Q20h4sINVEh8O4EHJEf8Yhn+OEGyzsi4XPNeIhRj7IpRKs/b6U/qglOE8HSYD3pWgguofgb4mEHOhQAVmyFAzqywHpmAdaOBmwM778JVelVz1W/faU0L6XxdO5AuknG9/jr6Ya+ixNzwehXHZXRPkP8bpOYNizCj457JOyHItfWgvlHseZ8AFqjAq6q1JwbglBc3ebFU4VZMJAnHveZ4OcKGP4wnazT65jYK/Ck8Mso1YtYtnYIgTDMEaySwMPzM2LW9PCOtxsotiATJcUWtywIMu9nOEYnMMuS4/QW3gLASn7Gp4qwfLgMq85wbXkDS0Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2LOVYft9; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ngn5ZFPe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2LOVYft9; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ngn5ZFPe; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2LOVYft9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ngn5ZFPe;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2LOVYft9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ngn5ZFPe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6Bnx3V6Gz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 01:32:52 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 401727BA2C;
	Fri, 24 Jul 2026 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784907168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MgLR94cnov6/P8Yl4U/7T81H0kr3VMn5Pq5dQ8bzHh8=;
	b=2LOVYft95wMJIyhJa6PZSbwOiNmbFFPbcqUTuJ8eG3N/5dEfFfS1xnrE15U2j40DHgjDmq
	6SVMdKicnUTzPnTNepl6LS43ziFb719IQZ/YpmgYwEQMWN5wsTERRtQjRxILqRY7bav/0w
	AiPtTwFDpTdCdCi2BNy9lyN9DKbBWuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784907168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MgLR94cnov6/P8Yl4U/7T81H0kr3VMn5Pq5dQ8bzHh8=;
	b=ngn5ZFPemuxkfH460JBtHk6gBgwLnC/4m+F/Wm5dLwshckWwMM8hRMhkcYUYLvLbPxDwRh
	a99cvpioZ+OPOGDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784907168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MgLR94cnov6/P8Yl4U/7T81H0kr3VMn5Pq5dQ8bzHh8=;
	b=2LOVYft95wMJIyhJa6PZSbwOiNmbFFPbcqUTuJ8eG3N/5dEfFfS1xnrE15U2j40DHgjDmq
	6SVMdKicnUTzPnTNepl6LS43ziFb719IQZ/YpmgYwEQMWN5wsTERRtQjRxILqRY7bav/0w
	AiPtTwFDpTdCdCi2BNy9lyN9DKbBWuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784907168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MgLR94cnov6/P8Yl4U/7T81H0kr3VMn5Pq5dQ8bzHh8=;
	b=ngn5ZFPemuxkfH460JBtHk6gBgwLnC/4m+F/Wm5dLwshckWwMM8hRMhkcYUYLvLbPxDwRh
	a99cvpioZ+OPOGDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C990E779BA;
	Fri, 24 Jul 2026 15:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KCyrLZ2FY2ozGgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 24 Jul 2026 15:32:45 +0000
Date: Fri, 24 Jul 2026 16:32:43 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Usama Arif <usama.arif@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/parisc: constify ptep_get() argument
Message-ID: <amOEUZlp1BxYh6_t@pedro-suse>
References: <20260724102017.141532-1-pfalcato@suse.de>
 <20260724102017.141532-4-pfalcato@suse.de>
 <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
 <amNzLXuwflIZFKtI@casper.infradead.org>
 <253f7ac0-205b-42f1-9fb5-d19eceb581b6@linux.dev>
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
In-Reply-To: <253f7ac0-205b-42f1-9fb5-d19eceb581b6@linux.dev>
X-Spamd-Result: default: False [-6.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	R_RATELIMIT(0.00)[to_ip_from(RLxu57a9hfgn7tttf5jiwuqe5o)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,linux-foundation.org,kernel.org,arm.com,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]

On Fri, Jul 24, 2026 at 04:03:44PM +0100, Usama Arif wrote:
> 
> 
> On 24/07/2026 15:14, Matthew Wilcox wrote:
> > On Fri, Jul 24, 2026 at 02:36:59PM +0100, Usama Arif wrote:
> >>
> >>
> >> On 24/07/2026 11:20, Pedro Falcato wrote:
> >>> ptep_get() does not need write access to the PTE.
> >>>
> >>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> >>> ---
> >>>  arch/parisc/include/asm/pgtable.h | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >> hmm I think you might break build bisectibility if
> >> you separate out the patches, you should squash patch 3 and 4,
> >> with patch 1.
> > 
> > I don't see how this breaks bisectability.  Can you elaborate on what
> > you think would break?
> 
> Patch 1 does:
> 
> -static inline pte_t ptep_get_lockless(pte_t *ptep)
> +static inline pte_t ptep_get_lockless(const pte_t *ptep)
>  {
>  	return ptep_get(ptep);
>  }
> 
> 
> ptep_get() takes a non-const arg till patch 3 for example for parsic.
> I don't think you can pass a const variable to non const function arg?
> 
> So parsic won't compile in patch 1 and 2, powerprc wont compile
> for patches 1, 2 and 3..

Aha, yes, nice catch! I'll have to rethink that. Maybe squashing the patches
would be the cleanest way forward.

FWIW, the vast majority of architectures aren't doing funny things on
ptep_get(). E.g PA-RISC, loongarch only define these so they can use it in
their own asm/pgtable.h. I'd really like to delete these but I can't tell
if they are *actually* required.

With those gone only PPC 8xx and generic would need to be squashed (arm64 also
defines its own version of ptep_get_lockless()).


-- 
Pedro

