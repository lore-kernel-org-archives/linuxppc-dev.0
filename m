Return-Path: <linuxppc-dev+bounces-27019-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EEDC79FB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 10:31:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgYqv743Xz2xLq;
	Thu, 10 Sep 2026 20:31:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789036283;
	cv=none; b=aZ6kCBgBoOTh4NLbElRraKGbgwaw6CjlWxVAvjlfi0jclLyp7f0+dXvOm8T5lSX8/a/A3wJdQjE+04M9xy2RleO8Q49i7vaI3VROKVdbqp7opdY7XzKhAvrVPvSC1+7EbysOtiCh3K3oM6Qsdws3DKmg5/vTwctxb/n6TzT344qm+tgvcMkaHTkFTuaA/CO5RH2LlCQjArPtdcg2DJyppLGWr4H7sxrhuaw7K15AA680I1zCEanYekrx8I9+UyXkOBYJxQe16CPl3NEyaM7pVl+MEovIH9EX/QBA/AUOrSvLxi3KGx7uLHJmhiZfGKR4xw0ZKxEoez54CuJn2Lx0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789036283; c=relaxed/relaxed;
	bh=LlPmEgT7AmXIh8g8t518MArDyXQcqXJCyhWDk9MliDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5AtsvyJSQtJnCAxHn6XB49pvjznY1XtMhTfuaDke/R2kla4VbMJCv6PMadIbtXi2hr9oeOpTwBEbEM/BOIVw0Z7tAzHnJGSG0gHm8eCB80JQa8R+Ay/odhqbq0IkqCFiaUER6tTA9MEfrUDYiTCb8H+X2QuicW72M20cjmF7HuASbL9gpVJuPnZ9PeJSdj84kzf2NmjWXjT4tdaX0PzP50BXHnpPzU62X1WJl6M2vgojXF0mWT3RW2gKK/IM2H+766EwzN0EPuR3tOy75EDP2gQaQ0R8sm5b9oXVTJeB/9+RFLd7cBFFct8XYtvch2KnWySR378v/yaSLbx0r9Kwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iko0ayLB; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hwichaPg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AtMYCFtw; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=97aPAL4L; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iko0ayLB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hwichaPg;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AtMYCFtw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=97aPAL4L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgYqt5c8Mz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 20:31:22 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4C9B21B72;
	Thu, 10 Sep 2026 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789036275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlPmEgT7AmXIh8g8t518MArDyXQcqXJCyhWDk9MliDw=;
	b=iko0ayLB2D5gQwl3U/HDkgg3kv6J7PWdkNV24Qt4eSqj+sDxQripEqTgNtOU/A9SL/CMEc
	+0fl1ADBjbWJ2EvehJejq7q+6+iNRINgQ1Y7288M6QG5TdZ/NbELYOTPISKDxNCaVHetIL
	z6cXWUvcDZ3UETKljgYmLvAYGMgAUGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789036275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlPmEgT7AmXIh8g8t518MArDyXQcqXJCyhWDk9MliDw=;
	b=hwichaPgL+KO8LADSiggZgKVfRbLI3nUYJLlY3mu8QSB8/ImDNTVXUWFLSZVmpURoofAiD
	B3sN/1dLjnQ7V3AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AtMYCFtw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=97aPAL4L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789036270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlPmEgT7AmXIh8g8t518MArDyXQcqXJCyhWDk9MliDw=;
	b=AtMYCFtwc8xPCfah36A+xhxeHxXKvigXGc48DpK3XDsisPevwZ+TGxAMfYFqLTssAkQPPK
	gs+xEp5snkYSLasioK/rExNy61ANztYQLYEKcMAFw0jeAr0kgbuG3clN9YcjlVM7q2pXgm
	GaEAjsUoPadT6STViFH5lFFzXohTvpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789036270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlPmEgT7AmXIh8g8t518MArDyXQcqXJCyhWDk9MliDw=;
	b=97aPAL4LeiH3xeNFAdZXMjk7MEGhz0kLgASjdIFqr/uCS+tagGzPcqXjxKEC6xZdIgZmaG
	ZmzLz9HeDcOx1/AA==
Date: Thu, 10 Sep 2026 12:31:09 +0200
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
Message-ID: <aqKG7dPFeytFLOjX@kunlun.suse.cz>
References: <ap568I8bQAmSKWj5@kunlun.suse.cz>
 <1D6F66F5-E181-4814-A7E5-E52A678D37A2@xenosoft.de>
 <aqJwL4N9h3cOWLIW@kunlun.suse.cz>
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
In-Reply-To: <aqJwL4N9h3cOWLIW@kunlun.suse.cz>
X-Spamd-Bar: ++++++++++++
X-Rspamd-Queue-Id: D4C9B21B72
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [12.71 / 50.00];
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
	NEURAL_HAM_SHORT(-0.11)[-0.548];
	MIME_GOOD(-0.10)[text/plain];
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

On Thu, Sep 10, 2026 at 10:54:07AM +0200, Michal Suchánek wrote:
> On Mon, Sep 07, 2026 at 01:32:18PM +0200, Christian Zigotzky wrote:
> > On 07 September 2026 at 10:51 am, Michal Suchánek <msuchanek@suse.de> wrote:
> > 
> > There is the obvious question which I did not notice answered in this
> > thread: Did you set up sysrq and/or kdump and find out where the kernel
> > is stuck?
> > 
> > Thanks
> > 
> > Michal
> > 
> > - - -
> > 
> > I think I need kexec for kdump due to the system freezing after activating of KVM HV. Unfortunately kexec doesn’t work on my machines.
> > 
> > Further information: https://github.com/chzigotzky/kernels/releases/tag/Kexec
> 
> So there is some bug with kexec initialization on your platform.

Right, you are missing this part:
https://github.com/torvalds/linux/blob/50d05c7c76c96b90462f24debacca971d2e86713/arch/powerpc/kexec/core.c#L205

Maybe it needs to be called from your platform code or something.

Thanks

Michal

> 
> Sysrg for dumping stacks to console might still work.
> 
> Thanks
> 
> Michal
> 

