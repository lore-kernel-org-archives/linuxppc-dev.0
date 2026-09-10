Return-Path: <linuxppc-dev+bounces-27014-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C73DC79FB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 08:54:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgWh01y3Qz2yFK;
	Thu, 10 Sep 2026 18:54:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789030464;
	cv=none; b=gR5FwzgOdN2C3LeKR0iRjUfM8lOOBdF4q5ktk2+h78Ja/zGFgIs4PS8iGt2GO6EWcxOODGjr6qBzbjUSnl8XLUWYtd0iEX9thfD3muS6ai+/dh4RSshcHvxGso3DDs1aksVF7p+ucV4JXK5rNl/+0Odct+aaww+F4aFIyIwQFD/c3HJdqbgwqNPj3ZZ8v3DUiCDVHQkYNep4B+bcJhH1UJR/Ttmi1dDDZ2s7y6tJ4aVnRzp8F2koJEQPusEHS9u8FRDFcqYKSKLITCLMTyYgyAZNYIIw8JMgNaCS4ipVAzqK9C/jYRFdg02LXK9np1j+82DjhpmFzL9Aa73gWKDP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789030464; c=relaxed/relaxed;
	bh=UeffumlS8Gx39HedsU6NbWjsw3Z0Arhj3Egvzx+VirQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqvQahZF0hmiu+gyp+a3yteh64OfTf6WuT9AMG25Ldk3nBPl7EYmkZ2Z7uWJUozDRcY2Nxa8w2VGXgzxTLzMnBv6uhHZVnW6qEaohQg2GWxdMkZSa8oddVtQo2iF6/s7yH+p54syPWcD7U4shiCKqVKKDF1XYTKi6s0BNkESjvsWkihqiTqTjXKJb5U/Mw7ysQGPdXZmPYj/dZ2ZTOi95jpBlv8zsGq3lSg+8tehFgeefwyDgoiPxa3MvEYb1urg12vrNA9NBlw7X1Mcdgq3aegmgnoVlRMTVxMu3BhK4++4ti3Up+DxET8vIvTI3ul1uqeM3e3bT2vbnTU5qE3Bww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AN+iMCxr; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7XmOIgAV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xGZ4hwSY; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MjMZ7yta; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AN+iMCxr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7XmOIgAV;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xGZ4hwSY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MjMZ7yta;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgWgx6f9Rz2y2L
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 18:54:21 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A2041FDA6;
	Thu, 10 Sep 2026 08:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789030452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeffumlS8Gx39HedsU6NbWjsw3Z0Arhj3Egvzx+VirQ=;
	b=AN+iMCxrAIzvQN49JwsW67p0dKYGSNClJKgBQPWwH0zZBtAX2cjF9hAh6+puSldaE2fWxV
	89L+8XAN7j7shGrRtiI5Tft9uNNToF2ftML0IM6DILOVxtCk0CHlbuO6jHiQIE7jngslwX
	tZ7oj4k609vENgGjxi3oco6vKW3ZDLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789030452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeffumlS8Gx39HedsU6NbWjsw3Z0Arhj3Egvzx+VirQ=;
	b=7XmOIgAVv6o0u4StfQjvb8xuT4kadN9xzzyxI5srnyun6ASKu5YJ8kmHqrCHxlKjUnpgRK
	rfmtlJhLo1GNmLCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xGZ4hwSY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MjMZ7yta
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789030448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeffumlS8Gx39HedsU6NbWjsw3Z0Arhj3Egvzx+VirQ=;
	b=xGZ4hwSYpLJyVvxpYYSA3SyH4sT1xuZrpyt43GvpO+Hrf5XMK0fT42CKZpFVSWJIxPlzDH
	MHIGpfwzt9uKN48GzBnbOOLhLWEd/+UNN7qZ0r0yomWrxpe6HBmlR52tkYMHQpetOGIDFR
	F3N35+7ww7TU/71Ree9gCcCobkMa5Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789030448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeffumlS8Gx39HedsU6NbWjsw3Z0Arhj3Egvzx+VirQ=;
	b=MjMZ7ytaQZdCx0uuP43DtPK1EHkR2EsheOUWHRPY/ZQh9ZVjFhKFOjfMHYpL0p03dW2dCv
	tY+nIUtmUcge7mDw==
Date: Thu, 10 Sep 2026 10:54:07 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	kvm-ppc@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
	mad skateman <madskateman@gmail.com>,
	Christian Zigotzky <info@xenosoft.de>
Subject: Re: [Linux PPC] Disable PREEMPT
Message-ID: <aqJwL4N9h3cOWLIW@kunlun.suse.cz>
References: <ap568I8bQAmSKWj5@kunlun.suse.cz>
 <1D6F66F5-E181-4814-A7E5-E52A678D37A2@xenosoft.de>
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
In-Reply-To: <1D6F66F5-E181-4814-A7E5-E52A678D37A2@xenosoft.de>
X-Spamd-Bar: ++++++++++++
X-Rspamd-Queue-Id: 4A2041FDA6
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [12.74 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	R_MIXED_CHARSET(0.63)[subject];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.389];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xtra.co.nz,yahoo.com.au,gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,lists.ozlabs.org,vger.kernel.org,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com,xenosoft.de];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Spam: Yes

On Mon, Sep 07, 2026 at 01:32:18PM +0200, Christian Zigotzky wrote:
> On 07 September 2026 at 10:51 am, Michal Suchánek <msuchanek@suse.de> wrote:
> 
> There is the obvious question which I did not notice answered in this
> thread: Did you set up sysrq and/or kdump and find out where the kernel
> is stuck?
> 
> Thanks
> 
> Michal
> 
> - - -
> 
> I think I need kexec for kdump due to the system freezing after activating of KVM HV. Unfortunately kexec doesn’t work on my machines.
> 
> Further information: https://github.com/chzigotzky/kernels/releases/tag/Kexec

So there is some bug with kexec initialization on your platform.

Sysrg for dumping stacks to console might still work.

Thanks

Michal

