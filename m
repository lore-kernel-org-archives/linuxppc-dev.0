Return-Path: <linuxppc-dev+bounces-24862-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CCBC5321C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 09:15:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7tGm6RGRz2yhD;
	Mon, 27 Jul 2026 19:15:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785143712;
	cv=none; b=V6BvNZwMDlySOKhI7T4xkD5QfG9rIV3netIRtHj4BfN5T92LffJ0/9Xde7Le1jLUcKgv6z0cf4B3MIDIkre5qUAMPC3Wwqc5rmurkYPJn9g4KtHjFbWLC0jGxn20eVUlvwJxyhavDi3RFcd9DGSicfZQG2IxHOW+r6JOzM3MvoThUN2CYzO85F8Yw4ksAXRPP5syp7ABpmAk/rHmLKwzYfB1NZgAx9bHZDLLTPXj/kmKHF1vUs+AMgNx2ZigaC+THPNoA6YheMZrtRynyTUAS2t09cjPxdbC7EQLYJwN8Scji7x5MC/Ii2fUgRmRCQuObesKxEZb3RzPa5xE1GW3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785143712; c=relaxed/relaxed;
	bh=Nofef/k2ghi2COUtOHG8Fiu5zrxha6Onv0LZX52ftP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHkZZFb+FCPMNgm3BsZA5P06UqB5iAPodfwQ0xbwiWqNNbI7yQb2l2tf/ZjM5LwIn1q8WqatJioMzkcFTQDadRjvB3rn4u2QYqhWrMalznyitOFmz2w63zGLBzmGHI2fHwgKlHHiZ/SKbHChH7WfO4XMFW4cIbH92hLi7WwC2DvMQM4WDcr3Wtv880Gki137FCsfeL7Fd0+Bq8z00nY5vmNM+pqvnDjvXxUY2i9lGNumx7l5JFezRI20KkIly5DsQOTjBYH8v01lH7ApFQeK1X5T4hyAutnrgx4/8e0E4JHUN/1ZfSqyB7QuxCWNIzOMVKjL1OJpz9sRlUNVXEFUMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XH4COWUi; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bdm02+CD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gT14ov0W; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=59Y51aLI; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XH4COWUi;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bdm02+CD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gT14ov0W;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=59Y51aLI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7tGl54fgz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 19:15:11 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 214317DA77;
	Mon, 27 Jul 2026 09:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785143702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nofef/k2ghi2COUtOHG8Fiu5zrxha6Onv0LZX52ftP4=;
	b=XH4COWUi/uVSTTItRb/nUmfm8hm6XLb+2ccrA+RSH9hDCrCENsMx7DdG1OWFISHT6yiJar
	na1H2WcWdnbTJhAmma6fHG2fZdoBEv0sNydB8Z028wX4I5FNCCSh+4CvoK0zBQnxUDz5sv
	fK0AfBjzu45udqdKvJg4xwhvU+eyHcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785143702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nofef/k2ghi2COUtOHG8Fiu5zrxha6Onv0LZX52ftP4=;
	b=bdm02+CDJ05kV++dhJds+LNeKzhLGoPjHgz72E0kyd3TFAyzK2ZG2IlQFCaDm8PiZrpNT2
	rCtsIQeQl1/lYUDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gT14ov0W;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=59Y51aLI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785143698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nofef/k2ghi2COUtOHG8Fiu5zrxha6Onv0LZX52ftP4=;
	b=gT14ov0WCez/rIUxEy8m1tADx6vn9TvWYnVIlGDTGvvTkjqgKfNlsTpWeYmj3zns/HRrah
	yetFtSmLwPTMVM2yAdcVmh9IB0etgC+Ko7dJ0vjckI/njniugxrFqPUNdwhmH9agXU+RvH
	Vv24fXObUNvrvroqv5eY8mBjjk6l63M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785143698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nofef/k2ghi2COUtOHG8Fiu5zrxha6Onv0LZX52ftP4=;
	b=59Y51aLI6YcXix+Z2oMApRzqEq+GdCAi5lSa72SMl9lcyKfcsYff4UnevNIIfGg1Xje3eG
	/vP8AY5Z6JDlUaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A492779B9;
	Mon, 27 Jul 2026 09:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gy7HOo8hZ2r9DwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 27 Jul 2026 09:14:55 +0000
Date: Mon, 27 Jul 2026 10:14:54 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Helge Deller <deller@kernel.org>
Cc: John David Anglin <dave.anglin@bell.net>, 
	Usama Arif <usama.arif@linux.dev>, Helge Deller <deller@gmx.de>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
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
Message-ID: <amchbBH5zF7Rq5LT@pedro-suse>
References: <20260724102017.141532-1-pfalcato@suse.de>
 <20260724102017.141532-4-pfalcato@suse.de>
 <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
 <amNzLXuwflIZFKtI@casper.infradead.org>
 <253f7ac0-205b-42f1-9fb5-d19eceb581b6@linux.dev>
 <amOEUZlp1BxYh6_t@pedro-suse>
 <fd239383-dcbe-4daf-b337-32facef07076@linux.dev>
 <3e9dece8-4e86-4ce5-bd74-b3ec305f3003@gmx.de>
 <4606e13f-6827-45d0-b3b8-6bc26358f7ae@bell.net>
 <amT0j_bBT3CCxPcg@p100>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amT0j_bBT3CCxPcg@p100>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 214317DA77
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[bell.net,gmx.de];
	FREEMAIL_CC(0.00)[bell.net,linux.dev,gmx.de,infradead.org,linux-foundation.org,kernel.org,arm.com,hansenpartnership.com,linux.ibm.com,ellerman.id.au,google.com,suse.com,suse.cz,nvidia.com,linux.alibaba.com,redhat.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RL764437jfm1qe6abtk9nwyx8m)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,bell.net:email,linux.dev:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sat, Jul 25, 2026 at 07:38:23PM +0200, Helge Deller wrote:
> * John David Anglin <dave.anglin@bell.net>:
> > On 2026-07-25 12:27 p.m., Helge Deller wrote:
> > > On 7/24/26 17:48, Usama Arif wrote:
> > >>
> > >>
> > >> On 24/07/2026 16:32, Pedro Falcato wrote:
> > >>> On Fri, Jul 24, 2026 at 04:03:44PM +0100, Usama Arif wrote:
> > >>>>
> > >>>>
> > >>>> On 24/07/2026 15:14, Matthew Wilcox wrote:
> > >>>>> On Fri, Jul 24, 2026 at 02:36:59PM +0100, Usama Arif wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>> On 24/07/2026 11:20, Pedro Falcato wrote:
> > >>>>>>> ptep_get() does not need write access to the PTE.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > >>>>>>> ---
> > >>>>>>>   arch/parisc/include/asm/pgtable.h | 2 +-
> > >>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>>>>
> > >>>>>> hmm I think you might break build bisectibility if
> > >>>>>> you separate out the patches, you should squash patch 3 and 4,
> > >>>>>> with patch 1.
> > >>>>>
> > >>>>> I don't see how this breaks bisectability.  Can you elaborate on what
> > >>>>> you think would break?
> > >>>>
> > >>>> Patch 1 does:
> > >>>>
> > >>>> -static inline pte_t ptep_get_lockless(pte_t *ptep)
> > >>>> +static inline pte_t ptep_get_lockless(const pte_t *ptep)
> > >>>>   {
> > >>>>       return ptep_get(ptep);
> > >>>>   }
> > >>>>
> > >>>>
> > >>>> ptep_get() takes a non-const arg till patch 3 for example for parsic.
> > >>>> I don't think you can pass a const variable to non const function arg?
> > >>>>
> > >>>> So parsic won't compile in patch 1 and 2, powerprc wont compile
> > >>>> for patches 1, 2 and 3..
> > >>>
> > >>> Aha, yes, nice catch! I'll have to rethink that. Maybe squashing the patches
> > >>> would be the cleanest way forward.
> > >>>
> > >>
> > >> Yes, squashing is the simplest way forward.
> > >>
> > >>> FWIW, the vast majority of architectures aren't doing funny things on
> > >>> ptep_get(). E.g PA-RISC, loongarch only define these so they can use it in
> > >>> their own asm/pgtable.h. I'd really like to delete these but I can't tell
> > >>> if they are *actually* required.
> > >>>
> > >>
> > >> Ah maybe there is something in git history on why it was needed?
> > >>
> > >> If not, hopefully someone from the arch lists could clarify..
> > > I tried to remove ptep_get() and ptep_test_and_clear_young() from
> > > arch/parisc/include/asm/pgtable.h, but this then triggers compile errors:
> > > 
> > >  CC      arch/parisc/kernel/asm-offsets.s
> > > In file included from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/mm.h:31,
> > >                  from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/pid_namespace.h:7,
> > >                  from /home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/ptrace.h:10,
> > >                  from /home/cvs/parisc/git-kernel/linus-linux-2.6/arch/parisc/kernel/asm-offsets.c:21:
> > > /home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/pgtable.h: In function ‘clear_young_dirty_ptes’:
> > > /home/cvs/parisc/git-kernel/linus-linux-2.6/include/linux/pgtable.h:683:25: error: implicit declaration of function ‘ptep_test_and_clear_young’;
> > > did you mean ‘pmdp_test_and_clear_young’? [-Wimplicit-function-declaration]
> > >   683 |                         ptep_test_and_clear_young(vma, addr, ptep);
> > >       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >       |                         pmdp_test_and_clear_young
> > > 
> > > So, I think the answer is, that the local copy of ptep_get() is used in the parisc implementation of
> > > ptep_test_and_clear_young() function.
> > > 
> > > Switching to the default include/linux/pgtable.h seems not easy doable....
> > 
> > Did you remove define for __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG in parisc version of pgtable.h?
> 
> Indeed, I missed to remove that.
> 
> Usama, if you want you can add the patch below to your patch set, thus
> simplifying your series?

It's actually my series but thanks Helge I'll pick it up!

> 
> Helge
> 
> ------
> 
> From: Helge Deller <deller@gmx.de>
> Date: Sat, 25 Jul 2026 19:19:55 +0200
> Subject: [PATCH] parisc: Drop own implementations for ptep_get() and
>  ptep_test_and_clear_young()
> 
> Switch to the generic implementations, which are identical.
> 
> Suggested-by: Usama Arif <usama.arif@linux.dev>
> Suggested-by: John David Anglin <dave.anglin@bell.net>
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
> index 467b8547ac8b..d92dee9fef3f 100644
> --- a/arch/parisc/include/asm/pgtable.h
> +++ b/arch/parisc/include/asm/pgtable.h
> @@ -432,25 +432,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  	return pte;
>  }
>  
> -static inline pte_t ptep_get(pte_t *ptep)
> -{
> -	return READ_ONCE(*ptep);
> -}
> -#define ptep_get ptep_get
> -
> -static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
> -		unsigned long addr, pte_t *ptep)
> -{
> -	pte_t pte;
> -
> -	pte = ptep_get(ptep);
> -	if (!pte_young(pte)) {
> -		return false;
> -	}
> -	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
> -	return true;
> -}
> -
>  bool ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
>  pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
>  
> @@ -491,7 +472,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  #define HAVE_ARCH_UNMAPPED_AREA
>  #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
>  
> -#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>  #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
>  #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT

-- 
Pedro

