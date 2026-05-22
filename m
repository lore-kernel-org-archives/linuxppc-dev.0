Return-Path: <linuxppc-dev+bounces-21410-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF64CD5BB4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 15:42:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMV0Q6GdRz2xSN;
	Sat, 23 May 2026 01:42:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779464566;
	cv=none; b=l7C6yWb+OcuFrZNRA2Ol0/Z/zeFB6h44ntWaI4iuFy2r8r/qjtsKKD0hmRuqAEKfgTLl9MiIUXLrds97JmXRkrkx3T8iXbXTVzWsDb2pkOk++hJ2PY9/Jv9eJ+bV55Egfa627HrRfq1sIde8KrtLAkves62LyZ7/fKcCFF4XZgkbNzjC6Gp6RufA6NcjcxqDr81GRjscRa4veJaCLb4Xh2bASUJoMHBbEu39iz8npogS9fQ+3S4Ozc1IdlWa+JouOlJ+682JciR0gh1H2Z0HUcNgVhmNa8bBY1iYymM8RJ41nFoK3iIhHlnPoCQUdyqYMIp6AvVa4nSEJlLjpJesBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779464566; c=relaxed/relaxed;
	bh=JCpY0JkuhcYxNLRV1IUbXIozIjXdostYdAAnrNS61cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekpMQ4PLn65/M0C9hu24DrGPmiL2ldmiUue3K3zUAZ7HaHL6NyFerYJzNuUajvVNAFPANX1u6VmPOmXW6wCTqCG3GqS1yHRUF73HVjXYLPUJnLr0a4ieYJbgJWQfKRD+73SHbRY2hctCgklkDe4rQWAYoWmudDBnWGl412xqdxorRrPvQkKvCAtEH/xDu5AkCLaM9EU7aokJGUjD+GtA+dpAlcu3fw4SOeEVPZhZZNdfilZ92WrbINfZEmcIVVJykEj9g/jySMC0NL4v69+eroexlkaLrcwqdiARHY04sgDVaWF/fA4+zbVO23BlHvCn+8okuDb3/j5u4m8zzdwVCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fevBbZWW; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fevBbZWW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMV0Q0L2Tz2xK4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2026 01:42:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CECB060138;
	Fri, 22 May 2026 15:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E9D1F000E9;
	Fri, 22 May 2026 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464563;
	bh=JCpY0JkuhcYxNLRV1IUbXIozIjXdostYdAAnrNS61cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fevBbZWW+amNTaTyKMVEGcATHJGI5beCyHSrNicjKpiIEwqwkPh/z0cIoe3sMBOEF
	 9KpGqhtEFq0bU7LJzRPro+xlky95JCucz80W5KK1l7KFP6+a4UbvOddg/RjiUMRrBc
	 TnJmst4YvoB1b0exji4XGaiDzIYHqxZdQizL+lY9YRCXPqsiUNa4Iwizpjdil6w8kp
	 avB7IiJOReUiZACrj/lPByfzfPgo+MU9KSfdz4bAzD5EbUs+mS2HRvW6EaIzmE8J07
	 jvv3I3rp4Q5xcvMk2ehvO5RHd+1nyNoGg6Bez7jfcnci4AcbssWI275h4ttA7+QWrP
	 1r5bMWvNKzJAA==
Date: Fri, 22 May 2026 16:42:34 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	bhe@redhat.com, chentao@kylinos.cn, chrisl@kernel.org, david@kernel.org, 
	jack@suse.cz, kasong@tencent.com, kunwu.chan@gmail.com, liam@infradead.org, 
	lianux.mm@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, liyangouwen1@oppo.com, 
	loongarch@lists.linux.dev, mhocko@suse.com, nphamcs@gmail.com, nzzhao@126.com, 
	pfalcato@suse.de, rppt@kernel.org, shikemeng@huaweicloud.com, surenb@google.com, 
	vbabka@kernel.org, wanglian@kylinos.cn, youngjun.park@lge.com
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ahB4_m6H37K7kDdO@lucifer>
References: <ag4kj84EcKqamdB-@casper.infradead.org>
 <20260522023305.98223-1-baohua@kernel.org>
 <ahBVh4NM2uoyhPNm@casper.infradead.org>
 <CAGsJ_4zQuJx1reJxgV387Gh0AqWF0KdoFn9KahQ1BNLPRm57TQ@mail.gmail.com>
 <CAGsJ_4zrm3sCp8Uz0Gh+sAwRcdtNF8rDLqX250sFVG3rZy9HNw@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4zrm3sCp8Uz0Gh+sAwRcdtNF8rDLqX250sFVG3rZy9HNw@mail.gmail.com>

On Fri, May 22, 2026 at 09:48:35PM +0800, Barry Song wrote:
> On Fri, May 22, 2026 at 9:36 PM Barry Song <baohua@kernel.org> wrote:
> >
> > On Fri, May 22, 2026 at 9:09 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, May 22, 2026 at 10:33:05AM +0800, Barry Song (Xiaomi) wrote:
> > > > need to touch `filemap.c` at all (probably because you are already
> > > > maintaining `filemap.c` perfectly):
> > >
> > > I'm going to give you one chance to apologise for that.
> >
> > Apologies if my wording caused any misunderstanding.
> > That was not my intention at all.
> >
> > What I meant is that filemap.c already has a very
> > solid design.
> >
> > For memory.c, I had to touch several places for the
> > blacklist; otherwise, the kernel would hang.
> >
> > But for filemap.c, I basically didn't need to touch
> > anything, and preliminary testing shows no issues after
> > moving it from the whitelist to the blacklist. This is
>
> Sorry, I feel I may be causing some misunderstanding
> again.
>
> By "whitelist", I mean I used to allow certain cases
> to use per-vma retry.
>
> By "blacklist", I mean I am now moving to disallow
> certain cases from using per-vma retry.
>
> Right now, I have to add several cases in memory.c
> to the blacklist; otherwise, the kernel would hang.
>
> But it seems that everything in filemap.c is fine so
> far based on testing.
>
> I'm not sure if I've explained things clearly. Please
> let me know if anything is still unclear or insufficient.

Barry - this thread is completely out of hand and getting _rapidly_
unproductive.

It's certainly about as clear as mud where we stand right now, so here's my
suggestion - let's just stop adding to the noise here :) and instead, you
take the approach suggested by Suren at LSF and send that as an _RFC_
series.

That way we can look at that and hopefully actually circle in on a solution
rather than have endless sub threads and sub discussions :) It's far too
sunny out in the UK right now for that ;)

Thanks, Lorenzo

