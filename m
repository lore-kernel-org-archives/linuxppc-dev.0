Return-Path: <linuxppc-dev+bounces-21397-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30D3CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 13:12:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMQfl4Yv2z3bsn;
	Fri, 22 May 2026 23:12:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779455535;
	cv=none; b=TKIzbc6HE/d0WHvTZGgULyEr55BVU0+TSpOW8IPLOfnzNekkbNWAeGXDTwUY5IeSnSBREtcm41kIxtm0CXu9/go4jz3OwF0Hnd/zqxFPMuYek5du1lccL9Ipzqy5hFWu2mtWVjX7jyubs5lBSqfUgrtBMCq6H/OJod9G1SNvDXYp8/mVv9MgAgc3doALNDMicjOhSVS8lmcH5rrr4ev0dVf2Co8x26z4ulSAJ+e1tmzZPvU0Ej6e201IiG5yOGEiMksWvXdOJ7AzJN3wRnb8LgLt6C310J7wloqq4mEUkuNlX+4G44eV6a8h0GJnIk4RpGbLuzbf9UzYpCRy6r01Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779455535; c=relaxed/relaxed;
	bh=EQj1Rbpw/H3Oe/sDGMgX6onZ6xyYKXcG7QBzM5CpJi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3Zo72aNq/X1IvFZod30vsZI4uqTD5isPeYxBeWxZnxEhZhLD82/VR67iGw0quNhKKy07Ewa0vgCvjTOIjs+EAcIu/imQjBps9Frvt67LHnghuHXgGZmaUJP4yVYzZKvnTuCvUECSRnW+UYhqurTKEG+f3jCynufkyW5RCTz+MXy9ahRAbTWx7etElKeH2emxP6Mil+wERB05CdTuxy+3KkdTcav8bMQE5N2+R77VwcKFXJ3ZClBQTaUg3IJfSB6i6X4c08UjC2S+ixVrlhFl5ZVFnVNd9KpAoiqRjsDgE1rrrkEmVd0jOhKbUhGVrJQ4OO1hxMV/8mkoounphZAIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=pyFlsOsI; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=pyFlsOsI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMQfW1Hn7z3bsT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 23:12:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EQj1Rbpw/H3Oe/sDGMgX6onZ6xyYKXcG7QBzM5CpJi0=; b=pyFlsOsI1W2H+d/c1dR87cu4A1
	nbk3QdhQ5igmGpectY46XehGUF3atPk8mqBTiAMYhp+RVUaHnf7U7vngJ2F4UAUNwxrJuFWL2uqdB
	d/WzjoEOMMz3D7k6H05YXwgJRsOWxWdJDddNXfpSrUVVgHRj5tJE6frgLHjiVX5xx+Bd6y6rK5bDz
	BjnT1OR4KHVpKXlgod+qjgxUoNjEidgt2I4IkCQEqjwx8IU2B9gxtaWWSot0M7QRZv1MxzvStf58r
	evpBrKrXC124rfJ3AuHL6Tt3FC+WRpKb7tjf8+PbXNt3tbgW/GZM31sgXDj/od4TakCYHwR3VUGW7
	FSgIl7pw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQPd1-0000000A7eI-1OCp;
	Fri, 22 May 2026 13:09:27 +0000
Date: Fri, 22 May 2026 14:09:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, chentao@kylinos.cn,
	chrisl@kernel.org, david@kernel.org, jack@suse.cz,
	kasong@tencent.com, kunwu.chan@gmail.com, liam@infradead.org,
	lianux.mm@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, liyangouwen1@oppo.com,
	ljs@kernel.org, loongarch@lists.linux.dev, mhocko@suse.com,
	nphamcs@gmail.com, nzzhao@126.com, pfalcato@suse.de,
	rppt@kernel.org, shikemeng@huaweicloud.com, surenb@google.com,
	vbabka@kernel.org, wanglian@kylinos.cn, youngjun.park@lge.com
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ahBVh4NM2uoyhPNm@casper.infradead.org>
References: <ag4kj84EcKqamdB-@casper.infradead.org>
 <20260522023305.98223-1-baohua@kernel.org>
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
In-Reply-To: <20260522023305.98223-1-baohua@kernel.org>

On Fri, May 22, 2026 at 10:33:05AM +0800, Barry Song (Xiaomi) wrote:
> need to touch `filemap.c` at all (probably because you are already
> maintaining `filemap.c` perfectly):

I'm going to give you one chance to apologise for that.

