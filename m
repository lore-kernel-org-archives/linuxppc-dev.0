Return-Path: <linuxppc-dev+bounces-28498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F44C9832A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:13:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvKs96v37z30Vv;
	Wed, 30 Sep 2026 00:13:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790691197;
	cv=none; b=fHg2Jpk5rcwW71N4yQofJJ+tX2z+GYszA81Q9+ahFoPChJFC0kN9nAU1AWLWDM1ADxYAqwq3LhPoL9oHUJajadCp/GCyL9c/+24J1PQdOMAohkeS67stJqFGHxgMmrylCSZTlmV2NgisQpWgi7jipnGstPiCiYTiCNNQ6BId9ha7xcTC9pMCri3QT2vKLYSpMUKbvlW9UJj5GsX/RqP5A4uCEOrUjNsdcZUEOWpGLEZwdKiWofXuY466vt75X+vh2MEnsUhs2xg8tBp35EnxB+1RDscMw5NC2xhEEwK4TO+ijobgvfY3Cy1f7HZEnUajQFeRhb5Mj4xwFpUh1KZYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790691197; c=relaxed/relaxed;
	bh=vmN2npans1p2hiojZm1+Q8GxyaP/JELuYTlJ/y3BRQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2r3F24QrYCIfphjWpSBIDA3AlqWqpSjcO3jnwFISwWsMcw4XN6z53q7TOl0LteVXv9lKa2HL5JZSzy7SbQWuLKTmMyeOPfEn+VT77uSPjZuj2+GBPxQdCDK1kbVjq3UCfJ6mouq+02Xw1DN7d2OXKj15AIkoB3Z9KlSznAU8WnVGDPSbkOdrisC9ysOHf+xeevloxpK49OAoWXLSDK/5qQSaF5H7/FAf87TQfGQMjK3njmSVekQ3tRbLlQ+AFUbTcM7w6Wah6fhzSnHeIxLIn5OthlSsNjOMZXpq9YCtIMfo9cMRO8JKnDWZYYjNvn9y92KpXBNKSzdBdIXtW0HmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Y0zYeXNw; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Y0zYeXNw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvKs20HMcz30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 00:13:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vmN2npans1p2hiojZm1+Q8GxyaP/JELuYTlJ/y3BRQY=; b=Y0zYeXNwr7kdWeSbBogWYUob6o
	9cgz39NZAJ3Ym9ac2DoumN9NiQS9Qc66DShV8kFzHupTsNsh/oi79uHfX9AyP7dwYG/2t0CgW88/9
	rR6PFkRO9N5jB5CGBxftCd0CZJuKhIzKVcQhghVenshrM1kG962ygGG/J4QEq+wLotuKJx/5ZPmgW
	oAxx0CeooAVBT8LnXo1/DDhWRAm7RCsP2yF4btfDeNNA0jEQZ24jd4GF61M/1tDKtLmd6is9bcR0E
	GK2/o13vz65TlGlLOjV8z2CNacHPx3QOVDX2C5doxYZO4iAMi8nC1jWQIkk37E5CeCJNkSs/4n16Z
	oEVNU/kA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBYZb-0000000Dmfz-1vmf;
	Tue, 29 Sep 2026 14:12:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 19C9A300446; Tue, 29 Sep 2026 16:12:44 +0200 (CEST)
Date: Tue, 29 Sep 2026 16:12:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sv@linux.ibm.com,
	alexandre.chartre@oracle.com, alexghiti@rivosinc.com,
	aliceryhl@google.com, ardb@kernel.org, bp@alien8.de,
	chleroy@kernel.org, elver@google.com, ihor.solodrai@linux.dev,
	jpoimboe@kernel.org, kees@kernel.org, legion@kernel.org,
	lossin@kernel.org, maddy@linux.ibm.com, masahiroy@kernel.org,
	mpe@ellerman.id.au, nathan@kernel.org, npiggin@gmail.com,
	nsc@kernel.org, ojeda@kernel.org, pmladek@suse.com,
	rostedt@goodmis.org, tamird@kernel.org,
	thomas.weissschuh@linutronix.de, thuth@redhat.com,
	yuxuan.zuo@outlook.com, sourabhjain@linux.ibm.com
Subject: Re: [PATCH v2 3/6] objtool: Fix "can't find starting instruction"
 warnings on vmlinux
Message-ID: <20260929141243.GA88198@noisy.programming.kicks-ass.net>
References: <20260929055138.43489-1-shivangu@linux.ibm.com>
 <20260929055138.43489-4-shivangu@linux.ibm.com>
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
In-Reply-To: <20260929055138.43489-4-shivangu@linux.ibm.com>

On Tue, Sep 29, 2026 at 11:21:34AM +0530, Shivang Upadhyay wrote:

> find_insn() is also looking for symbols of size 0. But, objtool does
> not store empty STT_NOTYPE symbols in the rbtree. 

81cf39be3559 ("objtool: Add empty symbols to the symbol tree again")


