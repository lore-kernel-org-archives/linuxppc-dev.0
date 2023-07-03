Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68BDEB64DC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jul 2023 11:43:37 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=DsCykzQA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QvkZw07jnz3bxL
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jul 2023 21:43:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=DsCykzQA;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QvkYw6Z3Kz30QD
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2023 21:42:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1688384564;
	bh=YP1dIoFq8VlflriUVMMU3qavwn5qp6pssvBClxyYvGQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DsCykzQATMth4df5hd9JAuNbqZfUnuyhtN+ih9n3EK0Y/xaBEyUiaBUwzWQVUDorv
	 BysRCgszOuhJV50/oZgpF2pILY9jF1OeQV5rxB3kdnA3K9JHG11dQfR7jTNVvwvM2p
	 UURZoNsXDYz2I/9gIowIX5YSE8svKKFDtLSMVp5NO36NoKBAszflMiMJIKvhqaj8Xy
	 pT0maaYt95YQ3l6PyfTqzkKJeol+Shb6SOjzIGZZuhYMXrzDVZdOeK6Le7gWWWLXlo
	 dDPeECVIVDrwyYlF96OQWw0R7beFHvvSLR67/fmE8yZMIeU1MOwwfV7zdSC/aIYavs
	 lMJDm98iP1nFg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvkYv5P9Kz4wZp;
	Mon,  3 Jul 2023 21:42:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>, Douglas Anderson <dianders@chromium.org>
In-Reply-To: <20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid>
References: <20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid>
Subject: Re: [PATCH] powerpc: Include asm/nmi.c in mobility.c for watchdog_hardlockup_set_timeout_pct()
Message-Id: <168838439191.114505.4051178096870320792.b4-ty@ellerman.id.au>
Date: Mon, 03 Jul 2023 21:39:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Petr Mladek <pmladek@suse.com>, Jilin Yuan <yuanjilin@cdjrlc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Haren Myneni <haren@linux.ibm.com>, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Tom Rix <trix@redhat.com>, Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 29 Jun 2023 12:45:06 -0700, Douglas Anderson wrote:
> The powerpc/platforms/pseries/mobility.c calls
> watchdog_hardlockup_set_timeout_pct(), which is declared in
> <asm/nmi.h>. We used to automatically get <asm/nmi.h> included, but
> that changed as of commit 7ca8fe94aa92 ("watchdog/hardlockup: define
> HARDLOCKUP_DETECTOR_ARCH"). Let's add the explicit include.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Include asm/nmi.c in mobility.c for watchdog_hardlockup_set_timeout_pct()
      https://git.kernel.org/powerpc/c/6cb44bef35ac11724ef22c5ae4f1bc607e2ef3d8

cheers
