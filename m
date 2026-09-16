Return-Path: <linuxppc-dev+bounces-27470-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E789CC982C5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 07:09:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl94k2mQXz2y2Q;
	Wed, 16 Sep 2026 17:09:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789542598;
	cv=none; b=RMlrfr32W4FsP7OyLvuzz3CHuEvSic3y941dc0KZRMyq6ZH2k59chmQOTF39kpkIsy96MEZ6rLPUW+WY1Fs7KW5a9njwd+X/B+8I1kuFPoOWD5DCnTo9Jd89ey7720S3fiY4LRHm0ggc9XOBFELHB8+HecCOjGVBYOX1bNiFNtHF14sIVVArw210fz1wFJX67nTKKVW1dcUfFKkpkvCrG7edf4rj8pm6kORfjG+ROMgmwbLYJ8c/lqthfXw6OxweHs8pNCeL0Ee+pvMu9EIodCHzy1DZbVJrcnhLoxOqKcS57kS/9s6a5JBc7YIIIQ3wXqIOV4wM7B7/we9xZOvcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789542598; c=relaxed/relaxed;
	bh=p2gx8+1v2YG2nXZ5rZ43ZGOVbgNWYwB+4lHcBSPfXX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcnRWEp9wZ7707WMRnKhc4ocugiNYvL1pcfzdyn28lggqFjRuZsLJqw1arutCFlQoxiFWNt6GgGW6/4aIvJrbpPhZsME1EyTImC1lxtPgU7IwY6EvAYTdPYlt0tqw6BdYvTp7pS2pzEglnmweTxSg5JW9wZX4e1mjG8NMgsTvKGfzdF19TLb0N6OM4tIN4uBKlRoszG6J0cCfNLXzNFvWGUCDgrKua/1ipYcQZzSLgbdPt0+h0sBA+dJDFRndJdDFYsXTyWz+kBC5d2e/P+dKO6R6pdGX1HjasMdpmtytx1tWVC5SjMN07mQ92yr4YnBEw+xr0v8oU+Npclvo7PCxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7SwAZ5T; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7SwAZ5T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl94j1NzWz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 17:09:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ADAFF6053A;
	Wed, 16 Sep 2026 07:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165081F000FF;
	Wed, 16 Sep 2026 07:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789542593;
	bh=p2gx8+1v2YG2nXZ5rZ43ZGOVbgNWYwB+4lHcBSPfXX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K7SwAZ5TQox94KhnzDZgdWak9JeascnEJT6tgsdFitx13oH/yvHVurs3emFIQIidi
	 xcR0gIE20GLza50nMYtjBg//0e7WD22sTKu3OHciVTO0Egw6dpfNvS97BoC4LpWgvN
	 ZD0aZmUahuws0zfu0FGKie6dskhpn2wDFZH1gLvxR0Y/XLP3PDKD59Q3XEFPNj3iGd
	 l3nMpo+kKycUGKylVUc5DFObZlUBNTgMifgw32kRkszA3iFJ9ppTn7CES9cJYrH1JE
	 XD/gyr3hXov/6xjsaqqL1FGY+8ZmWmmW0Gqlh80XrHJbwZzvXyNf+hmB3sQ+DilGUR
	 S0XyD3cx8I3Gw==
Date: Wed, 16 Sep 2026 09:09:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
	io-uring@vger.kernel.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
Message-ID: <20260916-seilbahn-heimvorteil-edelmut-bad3637b3a95@brauner>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
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
In-Reply-To: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>

On Tue, Sep 15, 2026 at 09:02:31AM -0700, Linus Torvalds wrote:
> On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
> >
> > TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> > allocates a descriptor like get_unused_fd_flags() does and records it in
> > a slot on the task. fd_stage() attaches the file to that slot and
> > returns the number.
> 
> Honestly, I am *not* a fan. At all.

I'm really glad that you don't like it! I hate it too.

To quote back from the cover letter:

> The idea in this series is old-ish and really never let go of me and so
> I wanted to at least dump it onto the list once even if it's just for
> illustrative purposes.

I think the cleanup-based solution we've added a couple of releases ago
is the better appraoch. Which is why I chose it over this.

But this install-on-the-way-out idea has been brought up quite a few
times as the "better approach". I never really believed it would work
nicely. Now we have an implementation on the list that we can point to
and we can move on from this.

