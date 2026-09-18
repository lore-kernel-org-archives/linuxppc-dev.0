Return-Path: <linuxppc-dev+bounces-27666-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415F8C982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:11:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmP13616Pz2y2W;
	Fri, 18 Sep 2026 17:11:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789715463;
	cv=none; b=W0IlTDiyp6GUwWM3vhWKBF39/V0JwEJ5daMRrwnmR8jlqvqJJkyvc5LOu/aWFFKRenK/lzBtlAFeMU42Ahdv54h1TieppoMqkgHkFPSbMRrp5bJktLH8Zf7ZPbdw8OfTTvkAgbYdR7ZfTFAGRwkWnpY5tRNruiPGUC4u1WCRmlLf4zU0h9LYBW+ypIj3R7/+NE/FLtOXIZ5HHu9Jdyi/jzpZ9X+ev3MlvacQ6rudY8b+DSsBXinH249UZRDBFAWDqgS6UmyFGFIIZDYSlDYEF65reDDX7AuFdinPTxU1b6haQ6k6UUo8qlOUyNVBTFLyFNg3OgYuO1dXmYG5y56bew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789715463; c=relaxed/relaxed;
	bh=k60kmaxZEAG3r8DSjRBXDk2STpzxByjYnkfbH5n2v/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvR8UyCN9eyKjFRUrZE8oPKzaVhdqR8mhfE0dEMQ53s6Z2HoBroq6DQx2aOeg67Srqrn7K5k7hkCGhEW0mQfxzhEY+xhjFmM3xv0cyx/61MSmJb+aci4dYP6dCn/auBcfQHkGmpGuCxo0LjiI/IZmkyfOgYwj2w2lZ+jFezla73baR2y1fHibEqcu0VhwrAchHhQfsMO+pcsbzc39noVrIjON3JPewp5n/qf61y9cXW7vu3ER4rMOAo3ltLXQOmhDGqJQMeEQYkrIQGKYCaBqWcNVcJ+mlN8So4xcrKe/5tidxBbuUNKKSq5jFhZ8AQRvh7/bHJWGpyfuEH0aUxQ5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wnVysW5H; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=StX7yY83; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=C0OFh2bB; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XIZjFd8H; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wnVysW5H;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=StX7yY83;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=C0OFh2bB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XIZjFd8H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmP115qypz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:11:01 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A893220077;
	Fri, 18 Sep 2026 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789715452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k60kmaxZEAG3r8DSjRBXDk2STpzxByjYnkfbH5n2v/Q=;
	b=wnVysW5HtceW0kII3QhLxhVCL8+ImJ/XzbqClwjVA2fMF9zoY+gjRfKMeFkHNEh3rod5UL
	3Bxb10pwQIWPGICiDF13Cnub5V1dM/4m4wlWuenyQbnERr5s8mNYej+Oj6qY6ITR6XZuDN
	fDeLPMZIcd6hYI04hJIdc0c0Zgf3bYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789715452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k60kmaxZEAG3r8DSjRBXDk2STpzxByjYnkfbH5n2v/Q=;
	b=StX7yY83UT+x/ZAdhzZOgzNh9WgoE5XEQXw4YX64TaFdJAB9dpAxXXPYGexXo5kXTWK3HI
	v0vyDkHjQzR+BEDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C0OFh2bB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XIZjFd8H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789715448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k60kmaxZEAG3r8DSjRBXDk2STpzxByjYnkfbH5n2v/Q=;
	b=C0OFh2bBFJOZm1aMX3KVbRMqF2SI0WzpPB6fwu6f/caAhnGwmbeEE9N8ZaQBZW3K+N2WQ6
	rHb7KmyRN4rQvHj8ctyw1xt2YZsMF5bMnZar2/IGT7/CUQh6dTO7iwRxYoqGPRP4Y/Qab1
	318u65tNB9Qw4nlMZ5YtZR17pp2kNSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789715448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k60kmaxZEAG3r8DSjRBXDk2STpzxByjYnkfbH5n2v/Q=;
	b=XIZjFd8HqWuXyOE8DZ5hnYiQEN8ji/U6Qm6/nfvMZw55GH1uDS8Qda/9znmoqCPluQexZ4
	3nMWhtyxhyHaHEAg==
Date: Fri, 18 Sep 2026 09:10:47 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>, harshpb@linux.ibm.com,
	Gautam Menghani <gautam@linux.ibm.com>, amachhiw@linux.ibm.com,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>,
	Samir M <samir@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Narayana Murty N <nnmlinux@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <aqzj9xsPRsGgCI5M@kunlun.suse.cz>
References: <aqfTU79SlNB3ykDi@kunlun.suse.cz>
 <25cf64ab-2a32-4d4c-a0c7-2e9007c276d4@linux.ibm.com>
 <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
 <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
 <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
 <aqu9hA1Bq58GFrVw@kunlun.suse.cz>
 <b2a5d53f-05e8-48ae-adb7-12fc74523b4e@linux.ibm.com>
 <aqvnOg9JfkM2k0TX@kunlun.suse.cz>
 <7ad57b61-4567-42c8-a9f6-faaabe7766a7@linux.ibm.com>
 <7e06fb84-ca2e-dbb4-47bd-e95ee11113c9@xenosoft.de>
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
In-Reply-To: <7e06fb84-ca2e-dbb4-47bd-e95ee11113c9@xenosoft.de>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: A893220077
X-Spamd-Result: default: False [12.69 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	R_MIXED_CHARSET(0.63)[subject];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.12)[-0.623];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xtra.co.nz,yahoo.com.au,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,ellerman.id.au,lists.ozlabs.org,vger.kernel.org,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com,xenosoft.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spamd-Bar: ++++++++++++
X-Spam: Yes

On Fri, Sep 18, 2026 at 04:39:57AM +0200, Christian Zigotzky wrote:
> On 17/09/26 16:15, Shrikanth Hegde wrote:
> > 
> > Hi Michal,
> > 
> > > > 
> > > > Give it a try.
> > > > 
> > > > I am suspecting both lockup, stack corruptions are secondary
> > > > symptoms here.
> > > > While recreate, I have different type of traces.
> > > 
> > > Yes, it does work for the crash I see.
> > 
> > Thanks. Give me sometime to see further on that. Didn't get any time
> > today.
> > 
> > > However, we hijacked the report
> > > of KVM locking up on FSL Cyrus+, and that is likely a different problem
> > > still not addressed.
> > > 
> > 
> > Ah, that's what you meant. Yes, i still don't know where FSL Cyrus+ is
> > stuck.
> > 
> > I would need help from FSL Cyrus+ to get some logs or is there a way we
> > can spin of
> > a QEMU guest of it? We should have the log to start somewhere.
> > 
> > 
> It's difficult to get a log because it freezes and can't write any error
> messages to the log files. This bug is very old. We had this issue some
> years ago but we was able to disable PREEMPT because we don't need it.

I would expect serial console and sysrq could give something, depending
on how much of the kernel is frozen.

Thanks

Michal

