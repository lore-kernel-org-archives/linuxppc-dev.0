Return-Path: <linuxppc-dev+bounces-26481-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C35C624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 09:53:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbFKk2cZdz2yrw;
	Thu, 03 Sep 2026 19:53:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788429226;
	cv=none; b=C/zgfPtqObI456HXukCPvOQIGh8rcdVJ7nzu+jKKnhPOqo3xwabdBB43yy9DW7SSImAjRYL4Se1gYYqC4s6LsZdsMjvRZUjYachnxmcHYzke6zyvoSII6u5bU75PeRoCXDMJjlvvbh20TM1x423LolqxMG7H0phSs6F5TMNYY+DR1uFmawUz8F/pem3jaKqVBfc+JAegxGSqSlVef8641nnkAyWKfn/mdTrn1zGm3iVwlIrgpP5B8Bgkmk3ah6G8MDILmyudT9n2P3g3ff1Wu39gYDmVuSBhp/4P/MmFb41M076XLsP+np0kdu4IJ18dsbKmRepxsYRy+BhnxN56vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788429226; c=relaxed/relaxed;
	bh=VjTE7mUQyicPv56RYXec26w9g2LPwvlr/pPoMSYsqjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/K+qQslZZtkFVsQVhGOJN94EWBDYWJtG4pP7sD4FJbCr9imYyV3NdTShXzFfx6hr9LBemgEvBAIBQ8iukSDmHgFRUn5JxSCw+D8u/vQPsb5O+oQtnbeouuLtwv23mEvOU3yKuUNo8rmrsJnO7PLE2k0teQkDVz80quMS5/8D9YXemlNf8gTnJBLmeSSVlD6R5S06OMhOYuLC5HTG3e4SNL0JZrESPE0XalzdTgswtjJ1a/73niRWYP7x2As1FKQ2sIMmf5uz0n8t6m8LBUjXwjmC8h1uNE23EYOfRi1RCnbV3/KDG3uzF1VgkcylZm+Jc4PkOYcLVw8AATlJzIB8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HR0YNcsL; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FssIU0/6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NbSMRqoH; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8oZ03PsV; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HR0YNcsL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FssIU0/6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NbSMRqoH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8oZ03PsV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbFKh3mtwz2yrF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 19:53:44 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 232D921EDB;
	Thu,  3 Sep 2026 09:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788429216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjTE7mUQyicPv56RYXec26w9g2LPwvlr/pPoMSYsqjI=;
	b=HR0YNcsLnx4YmJ63ziYdhxO3Uxi9c87RconzpqG/S7WiUcD4TNYOo51kvFaOsa2c+BzRjb
	ek4DsvOHUB0l9a1YJKaZuw1SAmebITf4N9ws8ZCFqXlRGvWxsabHIS9aZJzTUkQ9ui1+WL
	1YDY21kTy+4gP8JX8TKMR4nIN/+VQI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788429216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjTE7mUQyicPv56RYXec26w9g2LPwvlr/pPoMSYsqjI=;
	b=FssIU0/6qV3oyMCH4bMZEACnNRRDw2mnl+W2Df8LBYDPQU/JI5gjquPJB5ANoj7oxLdDIq
	hPup94SS+9OhEyBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NbSMRqoH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8oZ03PsV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788429212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjTE7mUQyicPv56RYXec26w9g2LPwvlr/pPoMSYsqjI=;
	b=NbSMRqoHlFVMNNkD+CD4Fa9Rd2Jh4YZzm4hVj7TyZkm8WqHhHW45yEwKr2iXsg5YxoY3MB
	gW0Xg9Mr8hXxbDPPrHCrpwrNQfVkAyJCi5B9ib1yNDZnqnRbN9bf+9vjbyQdWEiWV2/neH
	h8VgvevjLc37v7O7L9mFk2lTq4GpudA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788429212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjTE7mUQyicPv56RYXec26w9g2LPwvlr/pPoMSYsqjI=;
	b=8oZ03PsVg/2agmvlw7LmVc5KRBrIagIBAq0I9goPuLpbujFdYaElo/iOWgiSo3zKTyEoE1
	JFzT7xtv24vVd2AQ==
Date: Thu, 3 Sep 2026 11:53:31 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <aplDm-byYL79laYG@kunlun.suse.cz>
References: <40154f6a-39da-959d-e039-5ab9ff62db3c@xenosoft.de>
 <709b864f-9daa-4a48-b3d6-39baedce63b2@linux.ibm.com>
 <dbbb7998-5245-170f-626b-81bc75a32591@xenosoft.de>
 <843b7c60-23f1-47d0-b4e8-2147c3e40c23@linux.ibm.com>
 <2a27e6fc-7eb4-41a5-ba88-58f6a22625b5@xenosoft.de>
 <1d79ec6f-ce7f-4432-80e0-a54fa1668642@linux.ibm.com>
 <e425cd24-e19a-3860-aad2-11e91af8323f@xenosoft.de>
 <1c9b879a-7907-4849-a416-5df3db5617d6@kernel.org>
 <34112e67-85a5-a380-a42b-24c6562d65be@xenosoft.de>
 <8c6f2510-1dc5-4c45-9288-6b9c8f9b6b24@kernel.org>
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
In-Reply-To: <8c6f2510-1dc5-4c45-9288-6b9c8f9b6b24@kernel.org>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: add header
X-Rspamd-Queue-Id: 232D921EDB
X-Spamd-Result: default: False [12.73 / 50.00];
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
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.418];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xtra.co.nz,yahoo.com.au,gmail.com];
	FREEMAIL_CC(0.00)[xenosoft.de,linux.ibm.com,lists.ozlabs.org,vger.kernel.org,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:url,suse.de:dkim]
X-Spamd-Bar: ++++++++++++
X-Spam: Yes

On Thu, Feb 26, 2026 at 02:24:50PM +0100, Christophe Leroy (CS GROUP) wrote:
> Hi Christian,
> 
> Le 26/02/2026 à 06:37, Christian Zigotzky a écrit :
> > On 25/02/26 08:16, Christophe Leroy (CS GROUP) wrote:
> > > +Peter
> > > 
> > > Hi Christian,
> > > 
> > > Le 25/02/2026 à 06:54, Christian Zigotzky a écrit :
> > > > Hello,
> > > > 
> > > > We were previously able to disable PREEMPT in the kernel
> > > > configuration, but the latest kernels now enable it by default
> > > > and it is no longer possible to disable it.
> > > > 
> > > > Is it possible to let us decide whether to activate PREEMPT or not?
> > > 
> > > Can you give more details on why you want to be able to deactivate
> > > PREEMPT ?
> > > 
> > > Read https://eur01.safelinks.protection.outlook.com/? url=https%3A%2F%2Fgithub.com%2Ftorvalds%2Flinux%2Fcommit%2F7dadeaa6e851e&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C7006c8b4b98c4315a7e508de74f9388a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639076810956939768%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=6xLB%2FOVSkmgZRamaBM9zaxm%2FUTk9ssf4409QJdiXkDg%3D&reserved=0
> > I use PREEMPT_NONE kernels on my Linux PPC servers. (Without desktop)
> 
> You are doing that today because it is possible. Tomorrow it will not be
> possible anymore, for the reasons explained by Peter.
> 
> My question was not to know what you are doing but why, and why you think
> you still need PREEMPT_NONE and why the modern PREEMPT_LAZY is not good
> enough for you.

Hello,

I tried to compile a kernel with preemption for pSeries, and while
PREEMPT_VOLUNTARY works for me PREEMPT_LAZY crashes.

The kernel crashing is certainly a reason why a preemtion model would
not be good enough for me.

This is not the latest kernel so it might have been fixed in the
meantime for the platform in question. Will need to check that.

Nonethless, there are quite a few platforms. Originally no preemption
was the only option, and that's the reason why many people run that.
It's the conservative, known working option. And that's the reason a lot
of platfrom code does not get tested with more aggressive preemtion
models, and never gets fixed to work with them.

Simply disabling the no preemtion option does not make the platform code
ready.

Thanks

Michal

> 
> Christophe
> 
> > > 
> > > 
> > > > 
> > > > Currently we use the following revert patch for our non-preempt kernels.
> > > > 
> > > > --- a/kernel/Kconfig.preempt    2026-02-14 10:06:32.000000000 +0000
> > > > +++ b/kernel/Kconfig.preempt    2026-02-08 21:03:27.000000000 +0000
> > > > @@ -16,13 +16,11 @@ config ARCH_HAS_PREEMPT_LAZY
> > > > 
> > > >   choice
> > > >       prompt "Preemption Model"
> > > > -    default PREEMPT_LAZY if ARCH_HAS_PREEMPT_LAZY
> > > >       default PREEMPT_NONE
> > > > 
> > > >   config PREEMPT_NONE
> > > >       bool "No Forced Preemption (Server)"
> > > >       depends on !PREEMPT_RT
> > > > -    depends on ARCH_NO_PREEMPT
> > > >       select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
> > > >       help
> > > >         This is the traditional Linux preemption model, geared towards
> > > > @@ -37,7 +35,6 @@ config PREEMPT_NONE
> > > > 
> > > >   config PREEMPT_VOLUNTARY
> > > >       bool "Voluntary Kernel Preemption (Desktop)"
> > > > -    depends on !ARCH_HAS_PREEMPT_LAZY
> > > >       depends on !ARCH_NO_PREEMPT
> > > >       depends on !PREEMPT_RT
> > > >       select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
> > > > 
> > > > ---
> > > > 
> > > > Thanks in advance,
> > > > 
> > > > Christian
> > > > 
> > > 
> > 
> > 
> 

