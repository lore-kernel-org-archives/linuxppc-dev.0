Return-Path: <linuxppc-dev+bounces-25424-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F59C55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:54:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFQjn3M8Dz2xqM;
	Wed, 05 Aug 2026 19:54:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785923661;
	cv=none; b=M2OKsTx4OWuuEToIKevymH5pS0jbCHsvNckMst/i5WAYJn8kMjUjtdnOwPyBAqzDCW5e0LfBeeAITnl6+P64qzwa+v0t7Mc9y1K4qMsS+T/qWVsRSRqChAkMN1cg8w6JVPqAzRwKG2FJ1QaywWnm71Vf0iLghJnZ2t0f8uO7NOvEXgPJ2ZAx7aNb/QjSDTxKW8H17L5b7CPlQaplAmQz24OLYPsyQMJE/llHsVXP4HotvG6siKEXG7yS2tKQB6tomv4K1vHdBNmMvm+1kC96T1tFSxnj5i0Ds0GEMWRgyVG6gKNQFISLXGL2dK5bevkwpUcnOjq9N54OTbZ3Jsxwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785923661; c=relaxed/relaxed;
	bh=CU4WpIubcpWK9hCH2PEh/5TTaHzVeki/xiz4teIymqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIIV0Q5FhnnTljSesbB7mJAqFtvGTYMrjGUGNtS2NLrt1VflGAEHg/50unwMXAsHfaUvYTa+t8h7MVByBkJwhZ3EcdVbtbjjBaCOKWL8MipYfxxw9Nl6BJ+LgIRN1VHJuyK+a6/GLKwpyfJGSqpTHjSFJ+nyDjX6U60E8HsmvIAXKks+Qm1XqKDZ1sPtHzWaO6gNCx/IzFve+DR9yIe3n6lP7gK3Dzvu307+nY3qPcM9mQMv5BKmblG6EyiMjgwt9vdwZ2ifj/Bf83wL2C2zJD5wRQE9E+lrbaQpiQInyU3tHRpcIkOpVJLF7fNFJiclIR7mi6l2aqM7EqW+bG08Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wzR+ohd4; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0NO3IQ4x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sfuHkkSY; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OyGd9H2+; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wzR+ohd4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0NO3IQ4x;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sfuHkkSY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OyGd9H2+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFQjm3bbbz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 19:54:20 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E35817FD43;
	Wed,  5 Aug 2026 09:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785923653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU4WpIubcpWK9hCH2PEh/5TTaHzVeki/xiz4teIymqk=;
	b=wzR+ohd4v+0lgQWsYVhJoHKuZEtEb3YNwJc3v7q8zHLgDVW4LNwaXDrXwWIpNBFvtlK4Mj
	TKoKJO3eGxFZFt+KE9G87nTZpQhcrz1VGNbvP2VnMvCS7Rs9WCoI3nygsN7hvZ2XNO9V/b
	w0zcXDOVtiV3ZIsR0/uj9pv0VbIowqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785923653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU4WpIubcpWK9hCH2PEh/5TTaHzVeki/xiz4teIymqk=;
	b=0NO3IQ4xJEXNmoj/S5jhj6eu/u4nn6+Hww7p8Rcaf6NIkFyJHxb5+ggX0+7QrXFe3cTYaZ
	BY/vkPKrr8vVfjAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785923648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU4WpIubcpWK9hCH2PEh/5TTaHzVeki/xiz4teIymqk=;
	b=sfuHkkSYBH/rMYK9Ymy4w/oFuE/D0G/iXwSNRfeVql/WBcnVstNmrxr04BS1enCpHmVVeM
	2t3u0+WlVHt1sG3GP4x7Yh9a4D3BVInpfVYmHLxHpBLQuBgvnFYLIAZItUdgpCmRDbP52k
	x780PSShWatmHhVTu0TKjUxoZm6GEIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785923648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU4WpIubcpWK9hCH2PEh/5TTaHzVeki/xiz4teIymqk=;
	b=OyGd9H2+JlMMeeivriHeQILv068qUPXI16OSZOsL+0ColwikZcoY/8I86KN0BqQvpuUhe1
	Vlk/VTgRxbyvOLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFCEE779C2;
	Wed,  5 Aug 2026 09:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wl97Lz4Ic2p2TQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 05 Aug 2026 09:54:06 +0000
Date: Wed, 5 Aug 2026 10:54:05 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] mm: constify the pte_offset_map_ro_nolock()
 return value
Message-ID: <anMHQn_mBs6DTrZB@pedro-suse.lan>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-7-pfalcato@suse.de>
 <anHJ48Glq8EdHatd@lucifer>
 <anI6BEyTJFzQY-N9@pedro-suse.lan>
 <595fe323-59d3-4f4a-92a3-ac5d67b7461b@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <595fe323-59d3-4f4a-92a3-ac5d67b7461b@kernel.org>
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,arm.com,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,infradead.org,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	R_RATELIMIT(0.00)[to_ip_from(RLxu57a9hfgn7tttf5jiwuqe5o)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Wed, Aug 05, 2026 at 07:58:02AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 04/08/2026 à 21:22, Pedro Falcato a écrit :
> > On Tue, Aug 04, 2026 at 12:22:19PM +0100, Lorenzo Stoakes (ARM) wrote:
> > 
> > > 
> > > >   			if (!pte) {
> > > >   				mmap_read_unlock(mm);
> > > >   				result = SCAN_NO_PTE_TABLE;
> > > > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > > > index b91b1a98029c..2cfc6e608ef4 100644
> > > > --- a/mm/pgtable-generic.c
> > > > +++ b/mm/pgtable-generic.c
> > > > @@ -308,8 +308,8 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
> > > >   	return NULL;
> > > >   }
> > > > 
> > > > -pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> > > > -				unsigned long addr, spinlock_t **ptlp)
> > > > +const pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> > > 
> > > Can pmd be const too?
> > 
> > I was going to say "yes but then pmdp_get() also needs to be constfified" but
> > actually no, it can't:
> > 
> > pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp) {
> >          if (unlikely(pmd_bad(pmdval))) {
> >                  pmd_clear_bad(pmd);
> >                  goto nomap;
> >          }
> > }
> > 
> > so PTE mapping actually needs to write to the pmdp if the pmd looks bad.
> > Tricky stuff :)
> 
> But if pmd is const, can it be bad at all ?

Yes, you just need a stray write or a bit of memory corruption and it can
go bad. And then we need to do clear_bad() :)

(it's unclear to me whether this is actually common or useful enough these
days; the way this was explained to me, page tables can be best-effort
redundant; but it's not like we know clearing the whole range is ok, and
the way pmd_ERROR, etc work they don't even communicate to userspace what
happened, unlike normal hwpoison mechanisms)

-- 
Pedro

