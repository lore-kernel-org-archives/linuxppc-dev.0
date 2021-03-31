Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262F8C433C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 11:25:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F73961990
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 11:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F73961990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9P9x1lFrz3c5v
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 22:25:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=FmuoyXuH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=FmuoyXuH; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9P9Q4FHkz2yxS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 22:24:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F9P9P3VdPz9sW4;
 Wed, 31 Mar 2021 22:24:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1617189881;
 bh=7mUSZiZW2B14bW+Hi4YeBpbqTn7wYMNTKPDBdA5zBBk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=FmuoyXuHNvbgbuJlGcLNByz1Y1otDLrJwvMF3blAjoCDpK8B5u913VqdXY7gEya4w
 cvGZch5fDeZZD2Nf5PvfKpQvBeEqhF9JzUFFKTipPh9bOtEl3Qz4P+47QuNunSFR0K
 kHZ1ewPLjhAMoJkH1PpZES0P9cPx9ce323uAKzFy0222TMIoqLFsRxLoeoB/9Q34zR
 PM0uwosrq37pGAVr4TtxQqqBYokeIC6Gm0fWsfH68x4Rk4tq2xnGKyf7LRL6W2u1S3
 GCQo1bv/pSs1O6eppgh5qeYJMbmOzqseFWPE9Hpqy/SzXIcO25VJbb7njrOvI2j0fm
 254/ifECFwE2g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v10 06/10] powerpc/mm/ptdump: debugfs handler for W+X
 checks at runtime
In-Reply-To: <20210330045132.722243-7-jniethe5@gmail.com>
References: <20210330045132.722243-1-jniethe5@gmail.com>
 <20210330045132.722243-7-jniethe5@gmail.com>
Date: Wed, 31 Mar 2021 22:24:40 +1100
Message-ID: <87im577eh3.fsf@mpe.ellerman.id.au>
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
Cc: ajd@linux.ibm.com, Kees Cook <keescook@chromium.org>,
 Jordan Niethe <jniethe5@gmail.com>, cmr@codefail.de, npiggin@gmail.com,
 naveen.n.rao@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jordan Niethe <jniethe5@gmail.com> writes:
> From: Russell Currey <ruscur@russell.cc>
>
> Optionally run W+X checks when dumping pagetable information to
> debugfs' kernel_page_tables.
>
> To use:
>     $ echo 1 > /sys/kernel/debug/check_wx_pages
>     $ cat /sys/kernel/debug/kernel_page_tables
>
> and check the kernel log.  Useful for testing strict module RWX.
>
> To disable W+X checks:
> 	$ echo 0 > /sys/kernel/debug/check_wx_pages
>
> Update the Kconfig entry to reflect this.
>
> Also fix a typo.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> [jpn: Change check_wx_pages to act as mode bit affecting
>       kernel_page_tables instead of triggering action on its own]
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
> v10: check_wx_pages now affects kernel_page_tables rather then triggers
>      its own action.

Hmm. I liked the old version better :)

I think you changed it based on Christophe's comment:

  Why not just perform the test everytime someone dumps kernel_page_tables ?


But I think he meant *always* do the check when someone dumps
kernel_page_tables, not have another file to enable checking and then
require someone to dump kernel_page_tables to do the actual check.

Still I like the previous version where you can do the checks
separately, without having to dump the page tables, because dumping can
sometimes take quite a while.

What would be even better is if ptdump_check_wx() returned an error when
wx pages were found, and that was plumbed out to the debugs file. That
way you can script around it.

cheers
