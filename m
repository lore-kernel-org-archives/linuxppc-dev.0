Return-Path: <linuxppc-dev+bounces-20343-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F96FF8873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 12:37:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5twt1xCwz2xpk;
	Thu, 30 Apr 2026 22:37:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777552654;
	cv=none; b=ay5tB4mfotaz3EU6MVq01jHWswtngyr6LGi0vIfxjXu7wMjYelzbUIEicGcToPZhxjD6ilEMxIqLFv841EHm43FASgIGtwqjtLmusNmdViouVNeInvA3uwhIM9mId6qRgntKEMunkzxhCQGkr0aXWYyM6L9KWAhdy3va8T2oxo5WN2S+PAsLZ7RX/oAjyaflyfhYxIRPOYE6W9TNAuBEq7o2E72zIBxvbkMmGxvwZj4CS6YPZ6gFmP8JFK2H0JrNmGrDcnL6Pff0r4uNIsYTJkZ85gbIYhNLzH7oGDQXSEqmL6+XX7dON+rUTtNtf4Ofi2WWWIlwiD0Ecs/mHiOnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777552654; c=relaxed/relaxed;
	bh=z/YmOm364MLgKTekAQcMcyvI8WeWgw/tah25yx/smkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5HSmLxBkR7BVtQVMH9aQzro14E4BC3sHy8kcXPzEi1gytNK7LTBDWzAhoHfrSLjIAmbgvZSyiIICpOA9rFqbI57VQfvEsfGBVllV9tP26K38EVTT4lOjjHVehmjOA7xqdegsgDRuizj9YF+ziLXqhbwKXIWk8HX41FwRGMqXvfwOYLrcJ1rpQ3QcKAdqXWAOYWRRor7918NfgJV3TihjheAYX90AmQehKfrPbjuf27GF3YSkH4JCIUv2rRsOy3h/Wpl3zr0MBN8UlWXUFfwq1FfwAZrbrE9MR2UnaEJbS8seNMyJD4Q/t3Q+5+FhfX2V/TTJ7aGfR+P644IfvsiJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=OVEuy04Z; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=OVEuy04Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5tws46W2z2xnt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 22:37:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z/YmOm364MLgKTekAQcMcyvI8WeWgw/tah25yx/smkI=; b=OVEuy04ZJAcBaKwk8cxrvq7Tt5
	XT82G1jqIw0PkdnsdUVlw+7QCza/twzfpnsx2kAqSxg7PTBm0kBexRmE2xwQdNMnRyEnteCqgWzIn
	pGkT+4EL2ASd9E3W3zW7yYDg3jwhiv9VQjK8KHyhy+eeJpz4dqkaLDP6PuXP1J2eRrmKWTk8F9tKW
	CawTIBqH87INZkKlSIMhv2zjWwFJnSYo+4xe4HesOWqi4rik/G82R6PqrkV5YTcbPWHu29MwOaGgj
	jzKa0vAXrEAUkOYciTPNLGggQqRFBNNvsXY3E40Q+hwIcMj9vZmSiwG6RsfdSJ+eO9OpzQbCzsngB
	wKLRaGvg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIQdn-00000007Dwg-0sn0;
	Thu, 30 Apr 2026 12:37:15 +0000
Date: Thu, 30 Apr 2026 13:37:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz,
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn,
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com,
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com,
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afNM-gIqxpyJ6ro7@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
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
In-Reply-To: <20260430040427.4672-1-baohua@kernel.org>

On Thu, Apr 30, 2026 at 12:04:22PM +0800, Barry Song (Xiaomi) wrote:
> (1) If we need to wait for I/O completion, we still drop the per-VMA lock, as
> current page fault handling already does. Holding it for too long may introduce
> various priority inversion issues on mobile devices. After I/O completes, we
> retry the page fault with the per-VMA lock, rather than falling back to
> mmap_lock.

You're going to have to do better than that.  You know I hate the
additional complexity you're adding.  You need to explain why my idea of
ripping out all the complexity now that we have per-VMA locks doesn't
work.

