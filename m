Return-Path: <linuxppc-dev+bounces-21128-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A64CD4F49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 16:18:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK2z519mwz2xpn;
	Tue, 19 May 2026 02:18:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779121089;
	cv=none; b=ivgoLDGkRt4PlXv4reXl6Ui2Y6jN7vh4OpAJtx+CIBI9hSxGkOGbOTPbtcxPJ+boo268rEZuz/JKiwmlKg7/xMDZerA2q3qmZW64hq648aHlJ7MYw8WronpcvVr35ubrn5LBELrMyRqu4m5mfi0K4Hd+5iXFW2/qSXcpN32Qhk+Q6PSNWIfjwV6iDGAJyKIhpmttJVG0PAWBzvGG5u0v5A4R76QK/VHQI/Htexu2A8k6mPAqWD0mCc1Hbug6dYBxU56YjcUvvNSa2tZp8HUUvuXi3uRjQNjvDQBJi3VxQMfjysdH6HQQy2vAVl7HIj0iMVX6u8ALkvbHTpeR6szh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779121089; c=relaxed/relaxed;
	bh=GQ3AyNwcHkDwyotJKfmaIM16qng3evSu5qPs3Xeesp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDuF9xKEwuBsZsSIXo8pjFhCZIAYcCc5U5ZSHgwhv0EzEnhDGDvfLjR7K7scxcZAF3Dlx2o1Vc2kAxwYZPgEDVGdXasTcL4ecuH4FItxdpEDrjY91KX9XiZw2KtWMZIIGAcmlwVc8wRw+XOPAzr/qIAQ0XQojeXvVoe2rfWv2sracFPlu+TW9Q+Fqqy36qJjOB25BwFtOoz3LXMXqziYSS1wsm1f1OWvcpySHLtdPf/PajxBA3a+g7NjQRCqk/rdRvXmNNl3hEE6/WzGUaHyfdXusPLcfsooswdhmqrzX60k0InMcJWak9ncCbDNBcLTXsPV0deG2IWq6dGhPUtETA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fU3+SCOF; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fU3+SCOF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK2yz1j16z2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 02:17:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GQ3AyNwcHkDwyotJKfmaIM16qng3evSu5qPs3Xeesp0=; b=fU3+SCOFfUUlkOUmyIuTsbnywe
	89kqfFg93eDsIn1f4q6CEtRQBpKAuBqXFwczvVeUyK1MqiAmO/Is7GNS6SQajMkq/Ou4EEPXO5gjd
	QG3X5RgIMMIHaZt2k6X7tQJKlMJUiidUWjRLLsCK96ufITmHS/etRFdCcKGXPu9m3Y/9455P1VY+7
	yI95TKqa8/ath+SxD9IFOJNLaKt8Sstckq3piVjXElv/WkNhCMR7wKydSnX4sVdCnnWMjLyWBjQ2b
	4vkZR2poj4v3QZS8BJi9xbkgnOoh2L9CaUbogqrM9GJMbxKImRWLaIAgDeo+jPw7Sed1HBtUwdBx+
	aOLN/sjA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP0em-00000004wNm-3PR8;
	Mon, 18 May 2026 16:17:28 +0000
Date: Mon, 18 May 2026 17:17:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	mhocko@suse.com, jack@suse.cz, pfalcato@suse.de,
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com,
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ags7mPK7Ong0ZsBf@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>

On Mon, May 18, 2026 at 07:25:54PM +0800, Barry Song wrote:
> We have clearly observed that the `fork()` operations of many
> popular Android apps, such as iQiyi, Baidu Tieba, and 10086,
> end up waiting on page-fault (PF) I/O when the VMA lock is
> held during I/O operations. This has already become a
> practical issue. I also believe this can lead to chained
> waiting, since the global `mmap_lock` blocks all threads that
> need to acquire it.

It's always been a terrible idea to call fork() from a multithreaded
application.  For example, this question:

https://stackoverflow.com/questions/53601200/calling-fork-on-a-multithreaded-process

or this lwn thread: https://lwn.net/Articles/674660/

Do we have any insight into why these applications are doing this
horrible thing?

