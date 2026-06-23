Return-Path: <linuxppc-dev+bounces-22925-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57607CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:12:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl2TG4XXFz2yQL;
	Tue, 23 Jun 2026 21:12:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782213122;
	cv=none; b=ZyjptOG191zOpp9Up0SKbp88vEj34ZJZbX5Aq9W6hhZcibIw9V8CcOEguCknnjzX8CVI38xMwR1dvMdUrx3bdpRUI1TNFatD5HrESIPPMH2X4V6A2692bBU11HXoQOAFTA6G9l+v/hadAbQGw2qnT36tw+gpahc+3L0hmwvwMwyKEY3ipQryJd5Z4bZwQ9XQvCreHPtskEbsOIa+YRatod/yAj4rav7It0WLUMF3Juv7d+EyDCv1DL0/Et2GC18VcfZkjtWzzvO4S1eq/PkvKqovWvVilEmTYi6eMVNlw8+AdNRTkuEVcMMng5qR+DvjhM+VFrHgcsnQor12Mf717g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782213122; c=relaxed/relaxed;
	bh=2KC5uz/Q9vZRGxlgx9g/mdIH/o4JfJCdH/4iMSLlLH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ6QmQxaqQBFElJmDJhwXT4G1Jfhqhwsrxp9LbwPjPY3M6BQ2DTdkqH7sf5PkJC0aUPx2U2G722cpwFPxYl8P0mn5FK/61O8bUCMMw7ye7J6rx76W6Th6XasGWRgL1VV8lphh3R092cdMgEzuH6rV8UbWUDsP954DNFED8JXLBN8HQFCRCuo8vOcoWCyGGfkfgcS8+Wd95yuNqVSTa369+sXt4LAHWuOkGqroZUy+zvHmoWfHp9pOYl319u4q2tATp/q1hCu6jcwcFKBGyrUYdlH6QG2Ack68/5FDg9uqwyn9ne+gznNeNGfWcKApTgD4ukRWfRyfTI1ajiQ+hMmdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bA6/ev32; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FFUrV6v3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1Oq78NFI; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JTeBs68m; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bA6/ev32;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FFUrV6v3;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1Oq78NFI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JTeBs68m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl2TF1nqNz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 21:12:01 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95F9275EFA;
	Tue, 23 Jun 2026 11:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782213118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2KC5uz/Q9vZRGxlgx9g/mdIH/o4JfJCdH/4iMSLlLH4=;
	b=bA6/ev32dJCfO+gw01okbit/FFFCyUCQ56AwMnpUQFrLZgexfJm3gNJ4n53HQt8UYna4z0
	Df62F29iMuJQE4VfTYmq9O8wLksRPAm7wFlzfp6dtNQgHDXp5oiJ5AiXYp99RZ7B8zycy0
	Mvg7PYd2FPHS51n5P2vO3wZoMkbPiIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782213118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2KC5uz/Q9vZRGxlgx9g/mdIH/o4JfJCdH/4iMSLlLH4=;
	b=FFUrV6v3iPQgjUWRQnGKD3oX++HPg24ey3E6kSJd8irajCps5Kq/jj7ZNKj0CyiUT0v7Ca
	Vu3NMwH19RCwjfDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1Oq78NFI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JTeBs68m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782213116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2KC5uz/Q9vZRGxlgx9g/mdIH/o4JfJCdH/4iMSLlLH4=;
	b=1Oq78NFI6dxXLnWaYqx0dSWZ9gdci1NheZiUe1+/w1nRWKNyqnkPM/s/Fzxr4B/I7EF6yv
	Zi184i/vX/2UTHsTZICZd4SywYfGsU00JjYJXCjiD1xF0VlHI9PxZzin1oFAUgHiyVq0tV
	fdwfiP5l64zqtzUPeCXYVAlI35ynnaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782213116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2KC5uz/Q9vZRGxlgx9g/mdIH/o4JfJCdH/4iMSLlLH4=;
	b=JTeBs68mPgI+xX3qm/5XBBPtEd/FeRptcNA0qLD7Sso94LtKnQejMSEXoHGoiWUXFAt9mm
	/tfXPep1Y1HdaaCQ==
Date: Tue, 23 Jun 2026 13:11:55 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	oleg@redhat.com, kees@kernel.org, luto@amacapital.net,
	wad@chromium.org, mchauras@linux.ibm.com, sshegde@linux.ibm.com,
	thuth@redhat.com, ruanjinjie@huawei.com, akpm@linux-foundation.org,
	macro@orcam.me.uk, ldv@strace.io, charlie@rivosinc.com,
	deller@gmx.de, kevin.brodsky@arm.com, ritesh.list@gmail.com,
	yeoreum.yun@arm.com, agordeev@linux.ibm.com,
	segher@kernel.crashing.org, mark.rutland@arm.com,
	ryan.roberts@arm.com, pmladek@suse.com, feng.tang@linux.alibaba.com,
	peterz@infradead.org, kan.liang@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
Message-ID: <ajpp-_XnbF3UTM_E@kunlun.suse.cz>
References: <20260427122742.210074-1-mkchauras@gmail.com>
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
In-Reply-To: <20260427122742.210074-1-mkchauras@gmail.com>
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: 95F9275EFA
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [16.60 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.91)[0.970];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLdywaiysxdh7edq8aukuk3thi)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,google.com,arm.com,redhat.com,amacapital.net,chromium.org,huawei.com,linux-foundation.org,orcam.me.uk,strace.io,rivosinc.com,gmx.de,kernel.crashing.org,suse.com,linux.alibaba.com,infradead.org,linux.intel.com,lists.ozlabs.org,vger.kernel.org,googlegroups.com];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.suse.cz:mid,kunlun.suse.cz:helo,suse.com:url,docker.io:url,suse.de:dkim]
X-Spam: Yes

On Mon, Apr 27, 2026 at 05:57:34PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Adding support for the generic irq entry/exit handling for PowerPC. The
> goal is to bring PowerPC in line with other architectures that already
> use the common irq entry infrastructure, reducing duplicated code and
> making it easier to share future changes in entry/exit paths.
> 

Hello,

applying these patches on top of Linux 6.12 causes seccomp to return
different error (ENNOSYS instead of EPERM) causing some seccomp tests to
fail.

A minimal reporoducer is

podman run --rm --security-opt seccomp=<(echo '{"defaultAction":"SCMP_ACT_ALLOW","syscalls":[{"names":["mkdir"],"action":"SCMP_ACT_ERRNO"}]}') docker.io/library/alpine mkdir /tmp/test

This should produce 'Operation not permitted' but produces
'Function not implemented'.

Can you have a look?

Thanks

Michal

See also https://bugzilla.suse.com/show_bug.cgi?id=1268620


