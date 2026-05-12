Return-Path: <linuxppc-dev+bounces-20783-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D27CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 11:42:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFF866Cfyz2xm3;
	Tue, 12 May 2026 21:42:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778586166;
	cv=none; b=iDUo/Hseqa9NAc9GhebzVZFrVz0iFacjf1VWmSnnj4GFZQL0jRzTilRZRLAe9yzZW0assaGL5Xd+bQUadNEoU5iaYtnQs+9NQEmO5fwRJ9uNCWHI+jrXPulnYZG8u3qlfHL+qThU8rZE0+QtLY7oqxvmS0qzcJRD+gU2pdFLGc8jv1SeK3Zfj6q1qdQseXSnW6LYXC9KSWhPRNhkoDd61Z8IqngnECFx25s4pnFoHhJ/TkhbGVo6FAlJsYNjgEdh2RSckNm9LFJ4SoJS0KQSbeJkOW/uFBMkz4FS5rMl0mWwPkUmOMaP+Xrn+Fzwjd3pQ+PLmb55pvNdDZxfaliPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778586166; c=relaxed/relaxed;
	bh=QLgB5RUZcid9XLsWsmXqzit5YR0tRKGHMrKjGe72tnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MElenXgU1lMCAca16U6HS/CNn6Nzkx5cghL3SyHFYnDchSVb8Jv12qO2PmgdSF6+xys0PE4nTw4k6lsrOZniKFLBtvjPLGY6duDwpTGYqyPr8bB/0qWIjJnJbs7vsEM5ftbVM1snCukIw7f4/ptvJGysqPZCKQ/LkyWqJ1f9vRYRg5ssC6MnX9JozmFGsKYTIs2RenrwTR7pu59O8syg/Zee0a77ClHM0qjs/eshFQ1+UIJcakM761jdWP/+xYfHWwyRT6rYu7ZxHtMh2J6PJd9MO2ahJcFMAa1nkd69OYxwRvKucIfpgj5yA/YkMOIuC5tGELliWCtrCcJYP+M+eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KEweNcFX; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0J342uiq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KEweNcFX; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0J342uiq; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=dsterba@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KEweNcFX;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0J342uiq;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KEweNcFX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0J342uiq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=dsterba@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFF8527xHz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 21:42:44 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34B7376120;
	Tue, 12 May 2026 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778586161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLgB5RUZcid9XLsWsmXqzit5YR0tRKGHMrKjGe72tnI=;
	b=KEweNcFXbI/4awwwikZwQpLsJhqdcKP/ND/eEIHZpMVZYswHjsmnrwZiU2bxaD8n1OK0IS
	Kc6YjC0sw7nAn6qO/p47INirDH4cevpavEC2j0COzrDVxJtWpDOoi9k2FZAGtUc4QSsWyH
	YY7KnSMmVLtonjV5smZq449Ls/XSOCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778586161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLgB5RUZcid9XLsWsmXqzit5YR0tRKGHMrKjGe72tnI=;
	b=0J342uiqkSfyW8DZyH8r4hsv6i4foe07KIq12qtoXRLRS5m/d+XbyypVqVX3QbmZPnqRJi
	sxhM5qcbrx7pPCAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778586161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLgB5RUZcid9XLsWsmXqzit5YR0tRKGHMrKjGe72tnI=;
	b=KEweNcFXbI/4awwwikZwQpLsJhqdcKP/ND/eEIHZpMVZYswHjsmnrwZiU2bxaD8n1OK0IS
	Kc6YjC0sw7nAn6qO/p47INirDH4cevpavEC2j0COzrDVxJtWpDOoi9k2FZAGtUc4QSsWyH
	YY7KnSMmVLtonjV5smZq449Ls/XSOCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778586161;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QLgB5RUZcid9XLsWsmXqzit5YR0tRKGHMrKjGe72tnI=;
	b=0J342uiqkSfyW8DZyH8r4hsv6i4foe07KIq12qtoXRLRS5m/d+XbyypVqVX3QbmZPnqRJi
	sxhM5qcbrx7pPCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08727593A9;
	Tue, 12 May 2026 11:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rkjQATESA2rLPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 12 May 2026 11:42:41 +0000
Date: Tue, 12 May 2026 13:42:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
Message-ID: <20260512114231.GG2558453@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260512052230.2947683-1-hch@lst.de>
 <20260512052230.2947683-2-hch@lst.de>
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
In-Reply-To: <20260512052230.2947683-2-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[to_ip_from(RLj13sa47em33kcomko4xd63ai)];
	RCPT_COUNT_TWELVE(0.00)[44];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Tue, May 12, 2026 at 07:20:41AM +0200, Christoph Hellwig wrote:
> While the RAID6 algorithm could in theory support 3 devices by just
> copying the data disk to the two parity disks, this version is not only
> useless because it is a suboptimal version of 3-way mirroring, but also
> broken with various crashes and incorrect parity generation in various
> architecture-optimized implementations.  Disallow it similar to mdraid
> which requires at least 4 devices for RAID 6.
> 
> Fixes: 53b381b3abeb ("Btrfs: RAID5 and RAID6")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch should have been sent separately as it has user visible
impact and can potentially break some setups. The degenerate modes of
raid0, 5, or 6 are explicit as a possible middle step when converting
profiles.  We can use a fallback implementation for this case if the
accelerated implementations cannot do it.

