Return-Path: <linuxppc-dev+bounces-24210-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AF6C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 12:28:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzz9H675sz2yMn;
	Tue, 14 Jul 2026 22:28:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784032083;
	cv=none; b=XTgNncUjg/2FiikA0nWoE+ib+9ZfqojemLSy9T+2Mhrm8LeS7pqB6Ssv0PEj8kJ6jdqydudTGWU9KNZOoEpW6Z6nn1R+4TP7CpL/wqhz+iLyZUyaDBSM9tOKKV3Fc5w60VG18y5t1r+f4eyvOZJVs7D28OKfNoOmcTbp9xCwhHP8jrdSAhbwFT/bKoUP6F0CSppPjnYgClr1W4p0qArd6C+uUV5LzltoK6bEt11MEcPW8Ux0WUuA87F7bcmTEuzl9xvMi67VgtVxCY+wRYdUXt6s/LAQeu4CQS3ZuaKvfI+0lUUnTTWrkKZE4A0fY0/ltqMFeI+8YLrbkVJbTGHF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784032083; c=relaxed/relaxed;
	bh=Mv55jrFDO93gjGYIsU0f7D2xrkBLg3m+YQNtif0jQGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK455lNtdH+AxqB+6jInqNsMi4rwaNjMXQmWU8wx2n2++4hD58EcLZdlofVey+HpkeimUuCISyNeaTFJRkVyit+lJXY+qllrId0lpCGOF/LEk/3sMMwmMh5pZZlXx4biQOoTl8JmOBbCxrUOAOJClcOVxTBHpRjU1VRLv3Wsj0TeQ9Enw6tJenQjcJOSSoqrQRKitfnDgQiSRygqtB44406p7Mmw6Nd/YKNCN/Teb2KFxmvpqPsnRdCkp9hRIFDGDk7uMYiohdgM6sJq49jmg5J/zgrUegJMrM+8JfmaTJOpTxEfsIj5x4b2csUyazUz77dCQWhpIGcDMu0bryqemA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZlsG22+2; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SHQYjcVL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZlsG22+2; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SHQYjcVL; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZlsG22+2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SHQYjcVL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZlsG22+2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SHQYjcVL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzz9G4FzNz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 22:28:02 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B1CE77E59;
	Tue, 14 Jul 2026 12:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784032079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv55jrFDO93gjGYIsU0f7D2xrkBLg3m+YQNtif0jQGw=;
	b=ZlsG22+2qJHsdTgdkxvwmSlcE2jpD1rDFltZ2XBaaBUdxSXZ9XTNs5pK/w4lCTCHx6x/us
	rdRAWawR7siq4niXzhUqnNnE5zb9rtW+qo+o2fR+aSW99C2RM5JEfmFuQ+Ug1+/rcEi/8D
	zneyg7bhMeggThQytWIj8e9LdbZpxPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784032079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv55jrFDO93gjGYIsU0f7D2xrkBLg3m+YQNtif0jQGw=;
	b=SHQYjcVL5VrOKoaQAh2ZpNoUXIv2pbv4B/7Mv1feXJEdCMZcbfPGQCL5NBPQDmIOG9kGxC
	PRv0lwkN6hB1BSAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZlsG22+2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SHQYjcVL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784032079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv55jrFDO93gjGYIsU0f7D2xrkBLg3m+YQNtif0jQGw=;
	b=ZlsG22+2qJHsdTgdkxvwmSlcE2jpD1rDFltZ2XBaaBUdxSXZ9XTNs5pK/w4lCTCHx6x/us
	rdRAWawR7siq4niXzhUqnNnE5zb9rtW+qo+o2fR+aSW99C2RM5JEfmFuQ+Ug1+/rcEi/8D
	zneyg7bhMeggThQytWIj8e9LdbZpxPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784032079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv55jrFDO93gjGYIsU0f7D2xrkBLg3m+YQNtif0jQGw=;
	b=SHQYjcVL5VrOKoaQAh2ZpNoUXIv2pbv4B/7Mv1feXJEdCMZcbfPGQCL5NBPQDmIOG9kGxC
	PRv0lwkN6hB1BSAQ==
Date: Tue, 14 Jul 2026 14:27:58 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Radu Rendec <radu@rendec.net>
Subject: Re: [patch 0/4] entry: Rework syscall skip logic
Message-ID: <alYrTktEcosLvGiw@kunlun.suse.cz>
References: <20260712134433.549076055@kernel.org>
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
In-Reply-To: <20260712134433.549076055@kernel.org>
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: 7B1CE77E59
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.49 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,kernel.org,lists.linux.dev,dabbelt.com,lists.infradead.org,arm.com,huawei.com,gmail.com,lwn.net,rendec.net];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.suse.cz:mid,kunlun.suse.cz:helo,suse.de:email,suse.de:dkim]

On Sun, Jul 12, 2026 at 11:25:12PM +0200, Thomas Gleixner wrote:
> This are the reworked leftovers of the larger entry logic rework series,
> which can be found here:
> 
>   https://lore.kernel.org/lkml/20260707181957.433213175@kernel.org
> 
> The undisputed part of the series has been merged into:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
> 
> After a fruitless discussion about the most resilent approach, I decided to
> give up wasting my time and reworked the series so it caters to the desire
> of powerpc and s390 to be special.
> 
> That results in almost identical behavior except for the case where
> tracing/probe/BPF sets the syscall number to -1 (or any other out of range
> value) and also sets the syscall return value to something different than
> -ENOSYS.
> 
> PowerPC and S390 will overwrite that value with -ENOSYS.
> 
> Loongarch, RISC-V and x86 will not overwrite it because those architectures
> preset the return value to -ENOSYS and skip out of range syscalls
> completely. Loongarch and RISC-V always did the out of range skip. X86
> gained that in the already applied rework, which means that the final patch
> which splits the skip decision from the syscall number does not longer
> change x86 behavior for the above case.
> 
> Documentation is also updated and describes the two implementation variants
> and the subtle difference in the resulting behavior.
> 
> The series applies on top of:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
> 
> and is also available from git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry/rework

Hello,

applying this on top of 7.2~rc3 and running tests for the cases that
were reported as problematic I see results as expected.

This version of the patchset works for me.

Tested-by: Michal Suchánek <msuchanek@suse.de>

This is certainly not comprehensive, there are many corner cases not
tested. Some were broken to start with as well.

Thanks

Michal

