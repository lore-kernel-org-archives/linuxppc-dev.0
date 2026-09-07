Return-Path: <linuxppc-dev+bounces-26655-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D509C79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 08:00:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdfdJ0YFpz2yvP;
	Mon, 07 Sep 2026 18:00:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788768036;
	cv=none; b=lRCYYPQCxNYtsgnBt0+qskTWmdV/Ak4mwvhSZkvmJ3EpL8X2yEUOGDQvUDj4AsP6CGyHmYB2EIdtx96wGJJ3q7kgatvI9EGnNz/ZoP6T3BaU2l9VHmoD1/CokeDxV/VAx0lXuwsoy+X0MVmikkxnX5NdOWuYc5vNxAYHPd/KFg0Yi18FDFcs5x25uB/LzUKFw7DBF28YRnfeju1IEFq7pLuk/c+02xy4cDm5hSPF4nnerJu02PiVEiTx8BygZIEzXcUr/peFph4s9EuaGedYNTuaKUuSRZ+QvEc9t2IZ6hY1khaMsjHB3fpXiIgMcgP9SJfMo0pmqGWMHKAHGWAE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788768036; c=relaxed/relaxed;
	bh=FEBOJEt5KZS43kfEoAVZVttylh2W9OoDxC9m7JqILVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNYBQ6+unneirYvGsV/LB02ril6z+1p/6bqeMX+yFVTtS1+0GgViY8+G/z7XFl2FXcDpOVSTbVRPY3o1hBLB3fts0gX1LWIUJOv9P45jax/kFq6F191Q0pcQbRl0IQFWnQVjjtm4rWTtDftetSC3f0GKuu9q1195bBhZCc2QEG4+rvQJq90s4IPUEwwcapjDOGP3M0XUO8t2zsVrEcdF7chHg9Yn/qztRTz0XbLFJcZknDmFijs50xElqdVuoc3QtplYD3aPGrZKxLJZOhdQhsbtTAmdHepwLUgc0YV6bXgQjPWVVLfK1vr37LwGIGlK1Wg3XQUMk6QfLr6rBWRtrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=r/pmLGse; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d7o2qPjc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=1TJA9Wbk; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oPJIiQrZ; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=r/pmLGse;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d7o2qPjc;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=1TJA9Wbk;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oPJIiQrZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdfdG5D9Rz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 18:00:33 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0FF421B18;
	Mon,  7 Sep 2026 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788768024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEBOJEt5KZS43kfEoAVZVttylh2W9OoDxC9m7JqILVc=;
	b=r/pmLGsekhd7MHn0C7eFe8MxWcH31bcPeqT3JcwbB0dcr+7zGxQFYCmfGKgNAOkZQDM3yT
	9D7seJAUtdLV6dci6zbme1zIEvs6yvendeJJeooxAeZgNtE7WVymF/9pgm5EHUAlH/ty7t
	XsZxoJELSMTFbHBRo3qJGLsaWx4USqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788768024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEBOJEt5KZS43kfEoAVZVttylh2W9OoDxC9m7JqILVc=;
	b=d7o2qPjcG3CvSbFGvcuDsnbIROicV07olh1NPoWRfoB8ypU+T1MwvUUAy50jk0UniaWlal
	PYQ9xjHtLtFwRdBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788768020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEBOJEt5KZS43kfEoAVZVttylh2W9OoDxC9m7JqILVc=;
	b=1TJA9WbkKA+fYimVVshOfhTh46dW/mrELdCYovyZmvGsjJYh1XipO6SqkU5LFmbpLSc650
	MB5ErPttx4WaEaSLvqD3qDQ6CE1vDPoyxio7SRWopu1az1F/cRtHZLkBxX7vxQDEtoB9Hw
	XHr6KGnV2T7VAI8oX+gGqVmABP5LXrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788768020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEBOJEt5KZS43kfEoAVZVttylh2W9OoDxC9m7JqILVc=;
	b=oPJIiQrZw/9l8+TlBwJGL8oLUqDbGhyFaM7k+RX57Unr58ULVVZWOLfTmiUkOHfKUTzrf/
	EwmNiTKd7c5ds0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C7271339B;
	Mon,  7 Sep 2026 08:00:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wbYsJhRvnmq2JAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Sep 2026 08:00:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2EF31A13B2; Mon, 07 Sep 2026 10:00:16 +0200 (CEST)
Date: Mon, 7 Sep 2026 10:00:16 +0200
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jan Kara <jack@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>, 
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>, Amir Goldstein <amir73il@gmail.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	David Howells <dhowells@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Theodore Ts'o <tytso@mit.edu>, Catalin Iacob <iacobcatalin@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn <andrew@lunn.ch>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Andrei Vagin <avagin@gmail.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Wang Yan <wangyan01@kylinos.cn>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Malaya Kumar Rout <malayarout91@gmail.com>, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] bfs: remove the filesystem
Message-ID: <fee7t27m5tfbqcf2wsin3yd3mluz3yjnw7z6av6tts2qh6lnwa@qleeg76z37nl>
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
 <20260904-hinnimmt-triumphieren-handgefertigt-4e51fe2ed659@brauner>
 <20260904151054.GG6047@frogsfrogsfrogs>
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
In-Reply-To: <20260904151054.GG6047@frogsfrogsfrogs>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLizrtjkoytmmoj3iud1rzij51)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,infradead.org,ellerman.id.au,gmail.com,suse.cz,posteo.de,linux-m68k.org,redhat.com,alpha.franken.de,mit.edu,networkplumber.org,lunn.ch,orcam.me.uk,linux-foundation.org,kylinos.cn,vger.kernel.org,lists.ozlabs.org,lwn.net,linux.ibm.com,zeniv.linux.org.uk];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Fri 04-09-26 08:10:54, Darrick J. Wong wrote:
> On Fri, Sep 04, 2026 at 12:43:09PM +0200, Christian Brauner wrote:
> > On Fri, 04 Sep 2026 01:29:19 -0700, Ethan Nelson-Moore wrote:
> > > bfs: remove the filesystem
> > 
> > I agree.
> 
> At the moment, I don't.  Nowhere in this thread does anyone mention what
> someone with a B(oot)FS filesystem image should do if they want to
> extract whatever's stored in the filesystem.  Are there userspace tools
> for that purpose (ala efs)?  Does "binwalk -e $bfs_image" suffice for
> that purpose?  Or is there solid evidence that there isn't even a single
> user (ala freevxfs) who strongly wants it to stay in?

BFS was only ever used for boot partitions of some old unix clone (see
Tigran's initial reply). I have hard time imagining someone has some data
on such partition he wants to still read. And if such exceptional case
arises, I agree that just using old kernel in UML / VM is a viable
alternative.

> I'm all for getting rid of old cruft but there still needs to be a
> documented offramp for users.

Yes, I agree that it would be good to document this approach.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

