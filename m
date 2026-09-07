Return-Path: <linuxppc-dev+bounces-26659-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B2DC79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 08:51:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdgld6sfZz2y2L;
	Mon, 07 Sep 2026 18:51:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788771069;
	cv=none; b=FxtOL92jr3M4aUsQdk2fugLc1n5eQ0IinQE61rZFSSRzqKY4Vz9zZ8Gn/GSjsX90qUnxFW0IxS2HYvrak2AC+AxTlvgyUlOwOY5pymxlP+ZDNb9R5aI85vaLpXXG+A2HdB9ke3dUl2UQonhtebKv7djRJzGtN6iRK2kcy5JzDzWN7dsb7TFOnYVQRhz8SQ613Uw+O49BTQn7VAlv17UwUO0+1kB3HJAE0aW+Zf0/eeosTwpiJPBXgLGGSI0o0Q2rab394ZgRcf+Pi9wGYaqvBaWaqdW9tl1+6kG+zhZAM+SC5B/SK8Wj7FYQM5r9bJKlyPzdCtgp2PDkQysylbHifA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788771069; c=relaxed/relaxed;
	bh=40aLBR81Y6/ptVTXtLO+TkgVrZagUte3uf7IRacSj2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjbBOeJOpXPCLKiRv0/0T95ceGI5PWcXMLZroCqHmkbL6gbK+/F0dKsK7jRCYSiD8MJKLgEsNvUMCDPkosAWAGhvynu3zU958EpYE4cxtw2riHWIg/Bhmh5nPUMXIKmhDeUZ1VsWBe2JWNSkCRly2q8WqcQZQAnKADTep1prZJc04K8tPmViuLt8SMpzfsA/DtQu5qEiK2aOlsiQDMKiqabf2djaPsOE/WTpmCM7+ddyEKT0k2SSwgcl1dLrogOsBID5vnwhRwHV1vd239eUUaFeWPsLwEO5NKlJPO7LgV+LvLKlhmTrp0q66wbxsYeWw36IzTtmmq4pady5N5h0YA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=H2/3IM+N; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zmMMaZgv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zvsxhw+u; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=euXzQlT0; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=H2/3IM+N;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zmMMaZgv;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zvsxhw+u;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=euXzQlT0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdgld1KWtz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 18:51:09 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 658C021AF6;
	Mon,  7 Sep 2026 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788771061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40aLBR81Y6/ptVTXtLO+TkgVrZagUte3uf7IRacSj2E=;
	b=H2/3IM+NLEiJeMYCyUy+w2ZKOLrAqKrc8tlgT8ECGuZAK/ni0yQZUgI5pWAxolWBNtwbaB
	vSPrpBtcqZGJqfHyjZnpnh1sdWKXLboA88Cn8Xrs0Cwz3W4F3A9R7PhkT/pPO2HXzLwuKH
	3D1xIl2j8fklQlaou1DxIhf4SbKOR0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788771061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40aLBR81Y6/ptVTXtLO+TkgVrZagUte3uf7IRacSj2E=;
	b=zmMMaZgvpS5LCNGTbgtRra7MWWR2ppHYDQbzNlcDy2hktNVadY5P23S2E0zEV59EcxBe5H
	Y5Is3jCNSOkZ9KDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zvsxhw+u;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=euXzQlT0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788771057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40aLBR81Y6/ptVTXtLO+TkgVrZagUte3uf7IRacSj2E=;
	b=zvsxhw+ulawcIBSCzQf/Mqgi3MYStlm670e/22QncqsS7KGG1Wr87o41sIVtVYKfcni4nb
	hJtLfueSONiyCAwfvU7gHW4o3WtcsAz8Hti4QePA5Ln3t+bJyedQRy52FlsP7pY/Qr9i5r
	gVe5UZFJ3ccz8YMyQpIvWND2lYm3OQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788771057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40aLBR81Y6/ptVTXtLO+TkgVrZagUte3uf7IRacSj2E=;
	b=euXzQlT0zxVj4DilfpW8+BFUXoQ4GMbUzG+Kj0JmGwXds5tZS5nwIy8HJSvUmXjBIs0Qas
	hZt070lA+Io9laCw==
Date: Mon, 7 Sep 2026 10:50:56 +0200
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
Message-ID: <ap568I8bQAmSKWj5@kunlun.suse.cz>
References: <af7a8fa3-8ac8-4b97-bff7-5257867e7209@linux.ibm.com>
 <0B5355D7-4FE4-4B16-8ADE-CBB05A1D6C16@xenosoft.de>
 <25834fb4-ac52-01f3-11c1-c277af5a4c8d@xenosoft.de>
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
In-Reply-To: <25834fb4-ac52-01f3-11c1-c277af5a4c8d@xenosoft.de>
X-Spamd-Bar: ++++++++++++
X-Rspamd-Queue-Id: 658C021AF6
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	NEURAL_HAM_SHORT(-0.13)[-0.648];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[xtra.co.nz,yahoo.com.au,gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,lists.ozlabs.org,vger.kernel.org,infradead.org,xtra.co.nz,yahoo.com.au,gmail.com,xenosoft.de];
	SPAMHAUS_XBL(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,kunlun.suse.cz:helo,kunlun.suse.cz:mid]
X-Spam: Yes

On Sat, Sep 05, 2026 at 03:07:40PM +0200, Christian Zigotzky wrote:
> On 04/09/26 11:34, Christian Zigotzky wrote:
> > > On 04 September 2026 at 11:24 Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> > > 
> > > ﻿can you try with latest code? maybe 7.2? there is usage
> > > of generic api to handle the work now which renders the patch shared long back
> > > which you tried irrelevant.
> > Thanks. I will test the RC1 of kernel 7.3 with PREEMPT enabled.
> > 
> > - Christian
> 
> I compiled and tested the RC1 of kernel 7.3 with PREEMPT support today [1].
> Unfortunately the issue [2] still exists.
> 
> The entire FSL Cyrus+ board freezes when using KVM HV with PREEMPT.
> 
> I will disable PREEMPT with the Kconfig.preempt.patch [3] for the RC2.

There is the obvious question which I did not notice answered in this
thread: Did you set up sysrq and/or kdump and find out where the kernel
is stuck?

Thanks

Michal

