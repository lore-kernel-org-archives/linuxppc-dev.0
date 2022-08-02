Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B0EC00140
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Aug 2022 12:27:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LxvQd6SWbz3c6t
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Aug 2022 22:27:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=wBqS2CGp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LxvPj41YLz2xHL
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2022 22:27:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i+Zl91q4t+AZoHrEuNohjOyc7HDaxjH2xIeIWp7puuQ=; b=wBqS2CGpTw57Y88TURyJ4aTzj8
	8rA9zlyUQVdeZi0SP6WeltO8x64WM2LPUJbZVVC9vyEvcTQAvLSqpCU4SHM0zaQY9o9OrcdaBHZUh
	chmVGrmleKNL5N3TDrjg+ibrLYbwS53UAzvK3KElODt+f7h/w5gi+6ldrpx7Tm/yeEUiofU0dBDeX
	FbHeAzOiq9gf3BwXU38L2H1pGh5PUVyhGn6vnq+zYqs/YA3Pvf7oi7Z7cPZG0u/xpO9Hz/Tp1HGwz
	oL5k2sD1WrQc2lLN3YLU266NK2sWUfhJXbwwljK9tqmKmI8tRrOhN3HJGG+3q4+Epob0XnjfJ2x5S
	xfW/iZZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIqz1-008LTX-CP; Tue, 02 Aug 2022 12:26:47 +0000
Date: Tue, 2 Aug 2022 13:26:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v8 00/31] Rust support
Message-ID: <YukYByl76DKqa+iD@casper.infradead.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-gpio@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, linux-fsdevel@vger.kernel.org, live-patching@vger.kernel.org, linux-riscv@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Aug 02, 2022 at 03:49:47AM +0200, Miguel Ojeda wrote:
> Some of the improvements to the abstractions and example drivers are:
> 
>   - Filesystem support (`fs` module), including:
> 
>       + `INode` type (which wraps `struct inode`).
>       + `DEntry` type (which wraps `struct dentry`).
>       + `Filename` type (which wraps `struct filename`).
>       + `Registration` type.
>       + `Type` and `Context` traits.
>       + `SuperBlock` type (which wraps `struct super_block` and takes
>         advantage of typestates for its initialization).
>       + File system parameters support (with a `Value` enum; `Spec*`
>         and `Constant*` types, `define_fs_params!` macro...).
>       + File system flags.
>       + `module_fs!` macro to simplify registering kernel modules that
>         only implement a single file system.
>       + A file system sample.

None of this (afaict) has been discussed on linux-fsdevel.  And I may
have missed somethiing, but I don't see the fs module in this series
of patches.  Could linux-fsdevel be cc'd on the development of Rust
support for filesystems in the future?
