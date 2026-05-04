Return-Path: <linuxppc-dev+bounces-20417-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEF2CD3430
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 13:04:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8MKq2fScz2yZ3;
	Mon, 04 May 2026 23:04:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777899855;
	cv=none; b=JzBr/WrpueJtvW0xbGf5vJmmPp3UfEC+yOJdXuS5rHhUf1zbAEasCbRJSx75yGT6XBFwpce7XzCQjtbuooRpQ8Q71DR+pJcuOpr47NqEuKZmR+2bo8gro90r0TaTaZOfbhgFxpbIqPYjKzfHXc8H66PnqH7KWDrMDqV52RUp9XJ/jMQIXXfxJ5Ho8AWiCCtT1uyZcwqF8uchaWvqxS/qaL+0Yb6Zd8/amQvswu5DGVSbuXWRMliDIplDyNwZ63iBe4nhJMw861K6XltGOT4PMvEo3E/7lNcmv7yz8taBfZHCfyZzm/fdVSL7QMsfnrYaZ8luNNYbuJad+e/XIeUItg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777899855; c=relaxed/relaxed;
	bh=lBtiQAQr6P3N+MHRplixCzeobIB5oib2P5/9uPnbyH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffroHePRJ91MGWXEFXPc0U78+ljeYpRd+xSZjA/BQwIv3Z7udCMOU9RqEstVThDP3hRmtr44I7sKzQL8Ol8u4P55jpdoYSzzVcyJtkYuRuSvLxiXlN0rbsZyczNVfeAgVRtqblcTkPXh3Hw6jP+7UKExGsAjPtcXBazN96M3dBpknc621pVH466JSNdFUUIXOZ/j0KE3w42uaThHSJ4XtSyvZG6CVHfmG5t1o5ViboStkeTdhCyd5Xm1tt4v+xxSQiJX80y+MXhJwHz0caIhunQ2Aw/0Kn5CV0XhC3X29XsAgy0fjD7PDrFBnkW919Lyhgjn8AzliLY0dqwTA8JJ9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JL/XmGCb; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vznWPr7E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JL/XmGCb; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vznWPr7E; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JL/XmGCb;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vznWPr7E;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JL/XmGCb;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vznWPr7E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8MKm3g40z2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 23:04:12 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FB5A6B1DA;
	Mon,  4 May 2026 13:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777899844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBtiQAQr6P3N+MHRplixCzeobIB5oib2P5/9uPnbyH4=;
	b=JL/XmGCbCu7Pn0UFm+jahisb16WhHFai6O+3lv7XPFMu2xae2FLJC9y73Ya7QQ1c594PSp
	zIul6PJ51MjlwxJvLAh3JoWQaiH8bSjtiZuj66e8SanvgvDhY0yDxgFLxCNajU06uEybXH
	6z1rmn93QXxpKSaJmJiYKMHvK8WYKX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777899844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBtiQAQr6P3N+MHRplixCzeobIB5oib2P5/9uPnbyH4=;
	b=vznWPr7EkkLaMX6V8cqN+5Swo1ue1myMCE36D39F6CcK3OfL/g2gaHWLp5fMsKlngpFtjp
	hjbl6G2bCuN8gcDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777899844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBtiQAQr6P3N+MHRplixCzeobIB5oib2P5/9uPnbyH4=;
	b=JL/XmGCbCu7Pn0UFm+jahisb16WhHFai6O+3lv7XPFMu2xae2FLJC9y73Ya7QQ1c594PSp
	zIul6PJ51MjlwxJvLAh3JoWQaiH8bSjtiZuj66e8SanvgvDhY0yDxgFLxCNajU06uEybXH
	6z1rmn93QXxpKSaJmJiYKMHvK8WYKX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777899844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBtiQAQr6P3N+MHRplixCzeobIB5oib2P5/9uPnbyH4=;
	b=vznWPr7EkkLaMX6V8cqN+5Swo1ue1myMCE36D39F6CcK3OfL/g2gaHWLp5fMsKlngpFtjp
	hjbl6G2bCuN8gcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFD4B593A3;
	Mon,  4 May 2026 13:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UPmGOkOZ+GmDfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 04 May 2026 13:04:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BFC89A078E; Mon, 04 May 2026 15:03:58 +0200 (CEST)
Date: Mon, 4 May 2026 15:03:58 +0200
From: Jan Kara <jack@suse.cz>
To: Barry Song <baohua@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <n5vsmp6ingbhfztl6wzcwmrz56gkkfbpzardk43scr7rcgqsw5@evtnov34c5bt>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <yezmezj26xntushmylductlmytfgvwsnbnzlhffkfwugfxkt6m@gleq22spziyk>
 <CAGsJ_4y8JtCxEy9hVxVd8eaf8D9WC8BcRQp9afUVu=FJA1-awA@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4y8JtCxEy9hVxVd8eaf8D9WC8BcRQp9afUVu=FJA1-awA@mail.gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[to_ip_from(RLhrg5631p11qpq785u7koq73u)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,lpc.events:url,infradead.org:email,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,infradead.org,linux-foundation.org,kvack.org,kernel.org,google.com,suse.com,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,lpc.events:url,infradead.org:email]

On Mon 04-05-26 03:55:43, Barry Song wrote:
> On Mon, May 4, 2026 at 2:17 AM Jan Kara <jack@suse.cz> wrote:
> > On Fri 01-05-26 18:57:52, Matthew Wilcox wrote:
> > > On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > > > On Fri, May 1, 2026 at 10:57 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > > > 1. There is no deterministic latency for I/O completion. It depends on
> > > > > > both the hardware and the software stack (bio/request queues and the
> > > > > > block scheduler). Sometimes the latency is short; at other times it can
> > > > > > be quite long. In such cases, a high-priority thread performing operations
> > > > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wait
> > > > > > for an unpredictable amount of time.
> > > > >
> > > > > But does that actually happen?  I find it hard to believe that thread A
> > > > > unmaps a VMA while thread B is in the middle of taking a page fault in
> > > > > that same VMA.  mprotect() and madvise() are more likely to happen, but
> > > > > it still seems really unlikely to me.
> > > >
> > > > It doesn’t have to involve unmapping or applying mprotect to
> > > > the entire VMA—just a portion of it is sufficient.
> > >
> > > Yes, but that still fails to answer "does this actually happen".  How much
> > > performance is all this complexity in the page fault handler buying us?
> > > If you don't answer this question, I'm just going to go in and rip it
> > > all out.
> >
> > I fully agree with you we should verify whether the retry code still brings
> > in real-world advantage today with VMA locks. After all the retry logic has
> > been introduced in 2010. That being said if there are realistic loads where
> > one thread needs VMA write lock while another thread is faulting the VMA,
> > then the latencies can be indeed extreme. For example things like cgroup IO
> > throttling happen on the IO path and thus can throttle IO of a low-priority
> > thread for a long time.
> 
> I’m quite sure that swap-in and VMA writes can occur
> concurrently, and this is fairly common. For example,
> Java GC may use mprotect or userfaultfd on a small
> portion of a large Java heap while other portions are
> still under do_swap_page().

OK, makes sense.

> If we start exploring different approaches for anon and
> file, I agree I can revisit this on an Android phone if
> there is a real, serious case where a file VMA can be
> written and a page fault occurs at the same time.
> 
> Please note that, as an Android developer, I am particularly
> cautious about priority inversion. A recent issue causing
> severe priority inversion is zram attempting to support
> preemption[1]. When a task performing compression or
> decompression is migrated to another CPU and then preempted
> by other tasks, high-priority tasks waiting on the mutex may
> be significantly delayed, impacting user experience.

Well, container people are concerned about priority inversion as well. But
usually this is with coarse lock (such as global filesystem locks) but VMA
lock is specific to a task (and a VMA) so there the opportunity for
priority inversion looks more limited.  But the example with Java where GC
thread can presumably have higher priority than ordinary Java threads is an
interesting one.

> > BTW I'm not sure I quite understand Barry's priority inversion problem
> > since I'd expect all threads of a task to generally be treated with the
> > same priority...
> 
> Exactly not. Maybe these slides[2] and this project[3] can give
> you a hint—they aim to standardize things on Linux by
> learning from Apple OS. Basically, tasks are classified
> into five types:
> 
> USER_INTERACTIVE: Requires immediate response.
> USER_INITIATED: Tolerates a short delay, but must respond quickly still.
> UTILITY: Tolerates long delays, but not prolonged ones.
> BACKGROUND: Doesn’t mind prolonged delays.
> DEFAULT: System default behavior.

Again, this is a clasification of tasks but not really of threads in a task
so at least for VMA lock there's no inversion so have?

								Honza

> [1] https://lore.kernel.org/linux-mm/20250303022425.285971-3-senozhatsky@chromium.org/
> [2] https://lpc.events/event/19/contributions/2089/attachments/1797/3877/Userspace%20Assisted%20Scheduling%20via%20Sched%20QoS.pdf
> [3] https://lore.kernel.org/lkml/20260415000910.2h5misvwc45bdumu@airbuntu/
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

