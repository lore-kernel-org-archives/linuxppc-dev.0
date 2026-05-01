Return-Path: <linuxppc-dev+bounces-20371-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76522CCFA13
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 17:09:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6cwR6x3Jz2xWY;
	Sat, 02 May 2026 03:09:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777655383;
	cv=none; b=XkiQkfG2dou2sdTUdj/d1Fb7ZIOLVIuHdn+f9+RD+ohHUUeM2R0IfvNqrhphLy1WliXDQJdHrHYDfFGvfr/T2QqNUPO7/XclX+jMOfVuJzabHgdJUAocNNVyTAzPCup4SC3VwDjj8klUnKZ6jbKz1xEToKG6bMMpfdoxi7CyTjPOr8aJ6a1VCcoruVYODvbsPnRvO0AU+D2Sh44YIcptd1gtC0DyrxqU0ZTsuPyniOV52b1PE1H8DSfRNL2TYzJjO4/pWPbxx/6WMJX24DdfgvOeRDDVcjhLq5TvuSKUjgKHWAa3OqIQYm2EWsyH1Z6MmUyX8GDfz/b22f7lrxn2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777655383; c=relaxed/relaxed;
	bh=aCKpiD8Crlk0uEQZs9vyjBCgLqxVn32/cxl6Y0AtRGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCwMA9eR+PSBMsfVa48R4bCsWDUqXiLqfy/cRAWhFkeE18CIrDB3UmH3380nok3l3dzJGegwKnfGYsmICMHfenhBSjmQStV0JdlmXebqyAI4EgzrggHDV6OiKUDuOSUXj9GD+Wug8AReVRQfjXap606VQTfY9sa4XiXCLncLznSXK77XkCvFpLZb+1el1CeFXbScZ7Ryq7CbDAE2nkH8H3okut+odsr2D6WL5xX7hJGfZMo1l4coHP2akI7jJgQhHUSw1j3vFXTHFvuV+rGTdZTYGfVGid9T71xSw0EZgoi2OWcxwWbybiRcRW5YuYJ5A8HUA0qhJ3+/Nptzg+oJHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OX2L1x4x; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OX2L1x4x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6cwQ3lzZz2xGC
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 03:09:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DE7D143E9A;
	Fri,  1 May 2026 17:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC2AC2BCB4;
	Fri,  1 May 2026 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777655379;
	bh=aCKpiD8Crlk0uEQZs9vyjBCgLqxVn32/cxl6Y0AtRGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OX2L1x4xFIxbScfPDUbir6mmS+xdX9NmUYzJR0EJkE7ri86qbaeUTkDb4jWI5oeb+
	 aN4JbRR+N5UIrCNNa22w2pCZ2JSMSHoSZwNy2T2qFiVEenmDxH9tkupv+ZDyGU2ObI
	 654hr8gYpcXDtcmeRIPh1KdMIPoWk95vpdUy3GSPXi4IHKF8A7wxn55TDFMfm9T3X7
	 2RVfuwK5n/jkaekIr44u2S02mSaPb7gcycVdlcOtlmx86ngcN1rcmImzOHzRA44jyl
	 l2G+a79TnBeaUy0DKnFo0u2dmfaqSvsLz/R2tzsXHpnuJk6XOz3vggn1h43+SNrKA+
	 0+Ne8WhoVmpcw==
Date: Fri, 1 May 2026 18:09:30 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Barry Song (Xiaomi)" <baohua@kernel.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz, 
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afTeKp90wGNixIOX@lucifer>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <afTKsSj0i-ZkRZN5@lucifer>
 <afTPamwDbtY_tgk_@casper.infradead.org>
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
In-Reply-To: <afTPamwDbtY_tgk_@casper.infradead.org>

On Fri, May 01, 2026 at 05:06:02PM +0100, Matthew Wilcox wrote:
> On Fri, May 01, 2026 at 04:52:12PM +0100, Lorenzo Stoakes wrote:
> > After a brief eyeball I share Matthew's assessment, I really don't like this
> > series, it's piling on complexity for what seem like niche cases.
>
> I don't think they're niche cases ... I think it's a real problem.
> While our current code performs better for this workload than the
> pre-vma-lock code did, it doesn't perform as well as it could.
>
> > We already have enough weirdness in fault code honestly.
> >
> > Let's maybe discuss at LSF if you're attending?
>
> Not only is he attending, there's a topic scheduled (currently 10:30 on
> Wednesday).

Well then, let's revisit this in person in Zagreb :)

Cheers, Lorenzo

