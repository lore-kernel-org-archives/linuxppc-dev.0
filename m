Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277F5C7EE22
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 May 2023 02:21:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QHXZB1Tqqz3cCy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 May 2023 12:21:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=MOrpIbVR;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QHXYD33k5z3bdV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2023 12:20:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=MOrpIbVR;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QHXYB59N3z4x4V;
	Fri, 12 May 2023 12:20:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1683858031;
	bh=YpnZWgCaG6YVroZu81SdsFrTFkegNwZ3TdnbsmEw+NE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MOrpIbVRwUOUTxctmg0DjuiUQKNmwQa0TYw6VepM2LSPmeEAMYzu+0RgrPxnerGjX
	 EdaMEpAiFCQfLVWxhaJkJVifguZwArqOVvVWZsT7xf1IdvgVDdhFBPbJUOP67H61ZX
	 qmWhJygu36agCGFsVkwCZ4H2rsIbK6U0oZRGAJzub8MEz2EHHzugxWdOqfG2xy86RJ
	 xD0AvePHEdv8TcuxZj94z8fDw2B8Yr+BJ1DXryJ2J6sqkyYrw5yD1nMiOifrQpthVf
	 +4vwYqfP5svlWVg3O/xdwqLEsuel3qia3531EI4MmtYxUa308sf222ohOUz+uHzUEo
	 Fya0leOIMuOcA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rohan McLure <rmclure@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 03/11] asm-generic/mmiowb: Mark accesses to fix KCSAN
 warnings
In-Reply-To: <20230510033117.1395895-4-rmclure@linux.ibm.com>
References: <20230510033117.1395895-1-rmclure@linux.ibm.com>
 <20230510033117.1395895-4-rmclure@linux.ibm.com>
Date: Fri, 12 May 2023 12:20:26 +1000
Message-ID: <878rdul28l.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Rohan McLure <rmclure@linux.ibm.com>, gautam@linux.ibm.com, npiggin@gmail.com, arnd@arndb.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Rohan McLure <rmclure@linux.ibm.com> writes:
> Prior to this patch, data races are detectable by KCSAN of the following
> forms:
>
> [1] Asynchronous calls to mmiowb_set_pending() from an interrupt context
>     or otherwise outside of a critical section
> [2] Interrupted critical sections, where the interrupt will itself
>     acquire a lock
>
> In case [1], calling context does not need an mmiowb() call to be
> issued, otherwise it would do so itself. Such calls to
> mmiowb_set_pending() are either idempotent or no-ops.
>
> In case [2], irrespective of when the interrupt occurs, the interrupt
> will acquire and release its locks prior to its return, nesting_count
> will continue balanced. In the worst case, the interrupted critical
> section during a mmiowb_spin_unlock() call observes an mmiowb to be
> pending and afterward is interrupted, leading to an extraneous call to
> mmiowb(). This data race is clearly innocuous.
>
> Mark all potentially asynchronous memory accesses with READ_ONCE or
> WRITE_ONCE, including increments and decrements to nesting_count. This
> has the effect of removing KCSAN warnings at consumer's callsites.
>
> Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: Remove extraneous READ_ONCE in mmiowb_set_pending for nesting_count
> ---
>  include/asm-generic/mmiowb.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

This will need wider review, it's used by a lot of other architectures.

Probably best to pull this one out of the series and post it separately.
Add at least linux-kernel and linux-arch to Cc, and probably Will as
he's the original author.

cheers
