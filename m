Return-Path: <SRS0=cpv1=BH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A2FC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 03:39:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30853206D4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 03:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="pjVPeiiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30853206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BG2VW14DKzDqlZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 13:39:47 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BG1130JHGzDqt0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2020 12:32:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=pjVPeiiB; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BG1123FZFz9sSn; Tue, 28 Jul 2020 12:32:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BG1115sGBz9sTj;
 Tue, 28 Jul 2020 12:32:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1595903558;
 bh=GVppKHacNBK9byV2AhBgk8LPoELuuI3KrLw/+QEzQ/Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=pjVPeiiBTIagXa4E93EO9ZTHN2JESxXsOXdz5cEZY3SxtPrEkItcko61k/i3vbklZ
 CawiMR+OssdGfPNCK+IbvIsAiMY4fr4Eet+dGsELz/2XviC4InQZlCn7rKEeH0FJE0
 /kptzj1ZdRjUUSHI0cFYR8/1UqEmRiF8qboxXJVaLYKpcqIXcyOVF2D3guVk0S60md
 cjsMTtnvZuZ+rA5gUbJJ3V1bh2hFf+6iIMl0CoXmPmagfMU7Tkaf98lwV4DJ84SfNv
 jUeExm8DqOLXZbGLafozLXfJfaEAtm+phntYLJJscW6Hsmhl3qe3zvzjSonY3805ak
 vpFxI8xE5875A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 4/5] powerpc/mm: Remove custom stack expansion checking
In-Reply-To: <87tuxtrrvb.fsf@dja-thinkpad.axtens.net>
References: <20200724092528.1578671-1-mpe@ellerman.id.au>
 <20200724092528.1578671-4-mpe@ellerman.id.au>
 <87tuxtrrvb.fsf@dja-thinkpad.axtens.net>
Date: Tue, 28 Jul 2020 12:32:33 +1000
Message-ID: <87eeow74ji.fsf@mpe.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Daniel Axtens <dja@axtens.net> writes:
> Hi Michael,
>
> I tested v1 of this. I ran the test from the bug with a range of stack
> sizes, in a loop, for several hours and didn't see any crashes/signal
> delivery failures.
>
> I retested v2 for a few minutes just to be sure, and I ran stress-ng's
> stack, stackmmap and bad-altstack stressors to make sure no obvious
> kernel bugs were exposed. Nothing crashed.
>
> All tests done on a P8 LE guest under KVM.
>
> On that basis:
>
> Tested-by: Daniel Axtens <dja@axtens.net>

Thanks.

Always nice to have someone review my patches!

cheers
