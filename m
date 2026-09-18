Return-Path: <linuxppc-dev+bounces-27736-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E70AC982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:52:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmWFm549Lz2y7r;
	Fri, 18 Sep 2026 21:52:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789732348;
	cv=none; b=eJ5HXZdwuZshrtB31YbID6K+Mq77RSCbmJTZigAKOvuowRoUO9MlsHaK3zeGMl8lbDy8ynz7HzAf9vWtQiw5VMYYniJnCesp1teAxThPZ4SeFIfrL196j8ttVQN8dVp/Yuxs0HRCZ3oEjzAgFe5gD7Kk1Vsq2o+aLh5A2TcoSADEqPqS1khvpGBL75ZdAtlPhcZBf6/kYKSlVY2RQKflA4ubJCn0xGpN0V3dnI8DnXHcGgPFlYfjaPhCqLD181IzW8yqenk/u4SUz+2qmxA62R56V8R805dKkYcv0ELofyC0ZkHGrfLql3bjP5v4VZlgbB6Y3b1IJQq6XBQg/AOU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789732348; c=relaxed/relaxed;
	bh=Qt1Qm1bLvFfwd/Vs+YTzayo+9PIjKro/nYVqtJclg+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW33LyCKvvhWYL52hKQVTE/Eur0ViwAiOXB7MVWLcXadLwJolUHOt10cC88lxCCrPxCOiiKFRpMMI3OKUC9Cex1Dl98e85BVg1toAl3OXyVK184qQf8HDuoz7xK5Mnmc84fDJ03TN+xjhfXNCLKEkeXChI59L+kWer1HrBguvmFgvstVj5a1lbyPLoUtboqOzy8gV9ZRrZJLgXDJuV59H5Oa8bJzpI/Q/2ShSiHts1D0P53Q/Y0iDUNB9rx/XkWc3ljiK1g7XFwy7SOpX3qKvndW96vj7KnFCVhgf5qPPe2gcUuN+4QBZRCtuG9CDa+YChBNMJwPPl8iKFs+0t1i3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1UAttn3y; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OMkLHeWh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=okDYjfrC; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=t+XbRbtC; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1UAttn3y;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OMkLHeWh;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=okDYjfrC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=t+XbRbtC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmWFl4C4mz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 21:52:27 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03BCB21B07;
	Fri, 18 Sep 2026 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789732340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qt1Qm1bLvFfwd/Vs+YTzayo+9PIjKro/nYVqtJclg+k=;
	b=1UAttn3ydqtqKM7UO07UbNsqyTLw7+iLOwPDaG2djH+1jNZ342c5GBmqgB+4FS3zp7IhFa
	e/+qt3kXbtWgQtF8pFmVztqHb0yHfkeyaodPDEcMimVBIX8GieR7hv12rilXakpEsoQ48j
	E2Ht3W0EhVjY/IYbwCBeFrrofY/HvLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789732340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qt1Qm1bLvFfwd/Vs+YTzayo+9PIjKro/nYVqtJclg+k=;
	b=OMkLHeWhIA6NReRtMoyMxr1AsgdID9NJlzSNYChMAksCISX48Pz8vEgXc0xMjmK+fTaw7x
	uW01RxZfVM8cBoAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=okDYjfrC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t+XbRbtC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789732336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qt1Qm1bLvFfwd/Vs+YTzayo+9PIjKro/nYVqtJclg+k=;
	b=okDYjfrCzVKLb9rO6WgU/fMp4G+5uINiG8yjHWCkytO7s7ij37v87a2jT4wRt8o1Gy7s7N
	lcQF5rlYB8qJpw1LgVOFBmG7wSSmjL0fWXKIIoyYktWxzG5rPDjlmAau1uwL+E0gvaG5u4
	sPaAKGFcww8MiKX9XNhhdjKtPDSOyI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789732336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qt1Qm1bLvFfwd/Vs+YTzayo+9PIjKro/nYVqtJclg+k=;
	b=t+XbRbtCi0IoeLgZS9GdEe+hqp2aTE8k0Do4StD2r+ApnkU237iEnSHCOs6g9+Z/AEimaX
	GochLxJxj2I2CBCQ==
Date: Fri, 18 Sep 2026 13:52:14 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>, harshpb@linux.ibm.com,
	Gautam Menghani <gautam@linux.ibm.com>, amachhiw@linux.ibm.com,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
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
Message-ID: <aq0l7k7d-eCJCXQZ@kunlun.suse.cz>
References: <aqfTU79SlNB3ykDi@kunlun.suse.cz>
 <25cf64ab-2a32-4d4c-a0c7-2e9007c276d4@linux.ibm.com>
 <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
 <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
 <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
 <aqu9hA1Bq58GFrVw@kunlun.suse.cz>
 <b2a5d53f-05e8-48ae-adb7-12fc74523b4e@linux.ibm.com>
 <aqvnOg9JfkM2k0TX@kunlun.suse.cz>
 <7ad57b61-4567-42c8-a9f6-faaabe7766a7@linux.ibm.com>
 <ed82620e-ecb1-4b7f-a84b-a0f3a773dd36@linux.ibm.com>
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
In-Reply-To: <ed82620e-ecb1-4b7f-a84b-a0f3a773dd36@linux.ibm.com>
X-Spamd-Bar: ++++++++++++
X-Rspamd-Queue-Id: 03BCB21B07
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [12.69 / 50.00];
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
	NEURAL_HAM_SHORT(-0.13)[-0.649];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_ENVRCPT(0.00)[xtra.co.nz,yahoo.com.au,gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ellerman.id.au,linux.ibm.com,xenosoft.de,lists.ozlabs.org,vger.kernel.org,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam: Yes

On Fri, Sep 18, 2026 at 02:56:40PM +0530, Shrikanth Hegde wrote:
> Hi Michal.
> 
> On 9/17/26 7:45 PM, Shrikanth Hegde wrote:
> > 
> > Hi Michal,
> > 
> > > > 
> > > > Give it a try.
> > > > 
> > > > I am suspecting both lockup, stack corruptions are secondary symptoms here.
> > > > While recreate, I have different type of traces.
> > > 
> > > Yes, it does work for the crash I see.
> > 
> > Thanks. Give me sometime to see further on that. Didn't get any time today.
> > 
> This is going to be the fix IMO. It passes all the recreates i have as of now.
> (Please ignore the whitespace mangling if any)
> 
> Let me write changelog and send it across.
> ---
> 
> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
> index 6599fe3c6234..54c8727b48cd 100644
> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> @@ -220,7 +220,9 @@
>  	/* Restore gprs */
>  	.if \allregs == 1
> -	REST_GPRS(2, 31, r1)
> +	REST_GPRS(2, 12, r1)
> +	/* Do not restore a stale PACA pointer if the task migrated */
> +	REST_GPRS(14, 31, r1)
>  	.else
>  	REST_GPRS(3, 10, r1)
>  #if defined(CONFIG_LIVEPATCH_64) || defined(CONFIG_PPC_FTRACE_OUT_OF_LINE)

This also works

Thanks

Michal

