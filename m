Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA559606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=P3crDTR2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fSUUtdbR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQKL23kfpz2yqs;
	Thu, 12 Nov 2026 23:23:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794486202;
	cv=none; b=mG9pLFs2rpXhVRVf8dWtpNpO4F3Xg7F376FdFNL8KCBn80bzc/ehz98h6D7oxJLm6hCtUC91lqNb1TB/uj+3XRnpauSHND3qd9iLU6rALhu2y+c5RkeVH62hl8muzR/dUElN3+EyDidnEuGmcN+ald9KUg8yvdB9D8hCoNkDzPItlZknnuKxcddllF9ALAquEwl1YRCpnoSZarRJ8SJtuHdlqnYYaGLt9pbzrsDgxJP+umcdSfh7kYE+X1rW80ifPOlnwU2vb759wMtZdf0Q06uN84hTbYV9CqkguC+ZW+xQ0NgJGRfBUhSV+uug7sftSfpCOywl4du/vgQ5cBATyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794486202; c=relaxed/relaxed;
	bh=pQQOtAWIajuSIjlpRm2vXAuyWpPNUiVztPgT4AugiJU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ijEz8dr3KIiaMA29FuAr1Z/7BSuUGGXE7grWPeHKH2dPdw0rMnx1ZmAKxKaqH5E1cnGKZcvZ5jwf9hd46lZX2aT6xzYN3mwjaOA71JGj/0pXGBu2vV5r0S3fyONjzPcsyW0eXqjcq51++X7WP8o3wAZVGt8+IEEO096kPhnGG3quL4n+l6UcHEfIi3bdnJwmKkEq/tMA9QPjzQcWdQpFKR1Xk+gvYZXPuKLpTLILs1sOwpXHDfH7i1N3a0ghLrz0+mMKx+QpO5chaaEy6CI98likR9If+QPY4I7EPKQxLyhefzBqKJzW92103eQguKygNXDKpnVQQi386VYZt9/j5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=P3crDTR2; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fSUUtdbR; dkim-atps=neutral; spf=pass (client-ip=202.12.124.154; helo=fhigh-b3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=P3crDTR2;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fSUUtdbR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.154; helo=fhigh-b3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQKKy2K6Dz2ynW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 23:23:17 +1100 (AEDT)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F8D97A0089
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 07:23:14 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 07:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794486184;
	 x=1794572584; bh=pQQOtAWIajuSIjlpRm2vXAuyWpPNUiVztPgT4AugiJU=; b=
	P3crDTR2QrE3mDKXA0pzvG/J0bybuc/GE0R2+MUdZp264RpkSMcQVZUcYrDDpZgb
	IF+xz7OFlA2tZ1mPVXTCRlHno9SutFrCMpp0k51JBZDEbv0keJE4XFc7UCBBsbu1
	z5onelRGFLzhRVe4TDGTEy+caDsXmV/0vQkR9L3QcLqzqVWjjRtJV/GZsPcOQArg
	TFVocEfVeZn3ldcZG9Zw+36qsWWQweFRqkf561gT/9CziFep7xz+6ynjjfATsBE0
	dDxnnAdPXLtTWCfAR5HvCihTN1MenKC3qxdhalWsDf9cehT8iPjbkvssqTUmP8Ca
	rixYuPIXf6Edl8S85rwsgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794486184; x=
	1794572584; bh=pQQOtAWIajuSIjlpRm2vXAuyWpPNUiVztPgT4AugiJU=; b=f
	SUUtdbR4HBO45/mk5eu0YAqBeAKShi7GKHdQyo/BWkb825A8Zi9EIqwWRVSs1pcN
	2shVokvXjHddAXp7isok9lwDLIHuHWfHz6MNmkmQtn9hidGG8xcTZrxrxLs4ERmj
	nnVUzsilTXAPPOFMD/tFoVHWYowqJS6SM+jBC74dDQt6d6doMt0uaYne/4RzxYm/
	89EbxzKiZzolJ3h7lYx/Ky2Cl1+SZPPNnWFwJxKLaG7R284peEknvZBcSlslGRzw
	5132kjSPejun9DRxwYozg+HXZkI0d5PX085EOoASVy5d7xZ1sJCrtlCPdoVwB7q1
	IGZa0lXrdLbZFFX1aXggQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794486184; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg==;
	s=fm2:rsa-sha256:PjVjSMWo7jbJr5xsML1Qa8CytX1VaXTh+YwE/GnbRz6KKjt
	IfScJBc76xnIqfbXVQBgpzCuKzhviugOiqeVbhwDR+nABRRfQ5vj+PI4zYD2225q
	3GuPv2qugLeILLNtB6IaIm2Lfbs6O2+jtmiOAK9s/5KyZvW9Jb968oFZ1Bmh1cMl
	mkFPJ2F7pzR4iuCGV0c1MrN5N+biCqAqsh0i0D5WeOsoQT2O8BxLtJclt0crkhVN
	Aewsg57d3N4iuoWj62JYst5qNXqOGl3hJRSyu8Nga7H52JPzgMf3XiO28cM8psFh
	r/wW/II4oCkt1lfpxdhTnwFyb41Yvo+bqUlXbdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:70yQGtggowVYDRHL6YKfPxDiilpVHlWmnUJX12t/gPs=:O91qDgHCDp/h71v8TAj9HM3/MV9+IU2QNkfmjp6XH8o=;
X-ME-Sender: <xms:n6_1al4q7t8sPbNHk9ZcDabDfZWI--PS3yobCtKgM18RJUCK6pIt8Q>
    <xme:n6_1attRr8BlRCZWHT1U2n7s_V_y0dEuMhbW4yU00VZPFcT55_MhPxgRjZRP0LOYJ
    6l7M0RT8hyR_0q_RtCQItOEBMp-FqCFbVSgk_l-UUC_MGSuMH9MnC0X>
X-ME-Proxy-Cause: dmFkZTENDWCLZ1AsP1BwOxKngdvuCCtkQqE4MZA6iiupg9JFXObYdnXpxnrsIceDQ9snZR
    PmdDa3QNSvwQc2VnXG8kK3uQ1fnh26r6EfLM4tXSRfWOEQqnKY9QII707R7oHHunYlR01g
    GM8ofyASf4KacOR/q5T8wLVy3McGB/LL6qJQykGIUi+PLyL3GEZNkdC7swMBvRvdaUSHOa
    M6JzuiMhYCBPCJMgSaZEwSMVRz1tUEnOxeRtP65pSti3rsT7bpdM3lDN4Cj8hM9B2GWc3F
    gYdQn21QY9Vm2bWRWZGFAt8nRliVdU80mdPzxWLE6QfIrmj+LKKjwBinE059J3TaxrezFd
    z+ptb/+kggG/4zwdHsIjICNOsvzsn93x8woktqYPxE5S138aWckanjQhcqqD3Xz5I3QGwZ
    HyaIy4NSEFB3rZpP65nB+MFiBId3H/KnEp59m+ePZJsd888ZbLhkbYQZBeCeRGpIjbN/rN
    xFntOBhfjEJQcdR2QVwqMwq3LV//Yn2vUarjPKtXnJF8ZmzxZS26D454NlUS8+eCVnL8WG
    j1LYpBLCtx3CXLg73JmvkDA+JkFH5xFnfEXNtSuMu37pKYM8585zicLTLL57nFdGvPMTk0
    Dqe4DgJjMPnlK4WgoG4UoRPv8KB5d+hbDv2o2t79uWli2h6kBR+54AW77UpA
X-ME-Proxy: <xmx:oq_1apRThMMkkNGJOzyUpycDUFHQQE4INZFdKrFWfr2OWu8HTU-TLQ>
    <xmx:oq_1anplsAN-TbH3FxxNXMyiawEjF_2FUQ0eKkV3FpIIPUs0FEFGpw>
    <xmx:oq_1anYZC5n6m5Iqm1LV-oAHoxmb1zzdOln3kyIuaSt5-UeCt-vtNA>
    <xmx:oq_1aiQqZcsE9b5m0AGqWLb_c4i5j2hdZ504PsPdpJkby3ByOXXBsw>
    <xmx:qK_1alc9eIARixlfcZspNkIdgxoj4uKJOu89rmelOEnZi-d-kZjREk4z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 79EFA32A0099; Thu, 12 Nov 2026 07:22:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfXj_ROFnIdR
Date: Thu, 12 Nov 2026 13:22:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mike Rapoport" <rppt@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Matthew Wilcox" <willy@infradead.org>,
 "Malin Jonsson" <malin.jonsson@est.tech>,
 "Richard Weinberger" <richard@nod.at>,
 "Russell King" <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Message-Id: <219f5451-1cb7-4a2a-8423-3a071f8ad42e@app.fastmail.com>
In-Reply-To: <avWnS7MLyPaJLaLR@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-4-arnd@kernel.org> <avWnS7MLyPaJLaLR@kernel.org>
Subject: Re: [PATCH v2 3/6] ARM: drop CONFIG_HIGHPTE support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026, at 12:47, Mike Rapoport wrote:
> On Thu, Nov 12, 2026 at 12:25:25PM +0100, Arnd Bergmann wrote:

>>  	if (!pte)
>>  		return NULL;
>>  	if (!PageHighMem(pte))
>
> With HIGHPTE out this can be 
>
> 	if (pte)
> 		clean_pte_table(pte);
>
> 	return pte;
>

Makes sense, changed now.

     Arnd

