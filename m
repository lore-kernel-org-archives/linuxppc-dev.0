Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9ADC433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 May 2022 18:07:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KxC1q2Lvbz3cK5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 May 2022 04:07:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=BeB2FaaW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=BeB2FaaW; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KxC123BMCz3bpj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2022 04:06:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dXIZlnwHK15rrJZENweUDVLbVsO7X3h09BOXkfnZAVs=; b=BeB2FaaWyCXFJfYPOVlGrRxyyh
 JkDouCOTyf7MkyluZIxxnUmR87Z/DW0C77jKJIqfoUoI4nPE1ilfTi9PvRLwTXhJhdLROFvWDHHMp
 000VX4SrbogSTZvQ4ISTjHh4zNfXVtbK/k9ItAde5GaNKad/et01ucOFYnGCdxFOMk8ivYtMYUiOa
 LxiuMlpYfAy3bAi35IgiKblbkjCiRIRjJVG9azAjXg28jNJSRdKKWlpLRQquoU1LzZCBVcNqNjl2k
 T6r3MF4ww2+rXqRroJFYp5Aw18fci0MKTzKr92fIKjYfvoNR8En2Q9Oq1MQTSBonEX0blOhFfkm3u
 xJL5hOLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nnlIH-002hid-TS; Sun, 08 May 2022 18:06:09 +0000
Date: Sun, 8 May 2022 19:06:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 00/23] Rust support
Message-ID: <YngGkZTy+byxnD5n@casper.infradead.org>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <202205070056.ACC3C3D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205070056.ACC3C3D@keescook>
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
Cc: linuxppc-dev@lists.ozlabs.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jarkko Sakkinen <jarkko@kernel.org>, linux-kselftest@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, live-patching@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, May 07, 2022 at 01:06:18AM -0700, Kees Cook wrote:
> On Sat, May 07, 2022 at 07:23:58AM +0200, Miguel Ojeda wrote:
> > ## Patch series status
> > 
> > The Rust support is still to be considered experimental. However,
> > support is good enough that kernel developers can start working on the
> > Rust abstractions for subsystems and write drivers and other modules.
> 
> I'd really like to see this landed for a few reasons:
> 
> - It's under active development, and I'd rather review the changes
>   "normally", incrementally, etc. Right now it can be hard to re-review
>   some of the "mostly the same each version" patches in the series.
> 
> - I'd like to break the catch-22 of "ask for a new driver to be
>   written in rust but the rust support isn't landed" vs "the rust
>   support isn't landed because there aren't enough drivers". It
>   really feels like "release early, release often" is needed here;
>   it's hard to develop against -next. :)
> 
> Should we give it a try for this coming merge window?

I'm broadly in favour of that.  It's just code, we can always drop it
again or fix it.  There's sufficient development community around it
that it's hardly going to become abandonware.

