Return-Path: <SRS0=BXao=BG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A2EC433E4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 12:31:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D0E20663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 12:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="EWr+X3jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D0E20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BFfLF72C6zF1PF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 22:31:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BFfGg3KH1zDrDY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 22:28:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=EWr+X3jv; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BFfGf6HzJz9sRW; Mon, 27 Jul 2020 22:28:10 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BFfGf4B1wz9sRN;
 Mon, 27 Jul 2020 22:28:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1595852890;
 bh=j7IswI7LeuXrByn9IRbR3NmoDK1ZKhlctszqUmkC7uE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=EWr+X3jvsCyLG4bhtvXSK0U+qEdG7lQGAjFKGLEDOhXnpWIYEX+YcDUPWf2BUVtla
 +8ag4sQMY/VB2/KwFAb/8kLKZT5s0UzFv2aOi/SCBOpdcXDmr2/nKZypxtKkqvnlQo
 HWktAq7rZMfSuGZEwHEdjKEn0lb64/vPaMVZQ13PTztXXqhh2rKcIzsRrto9Gv9MDn
 9IVzQf9rzb1GplxBId+TIJA80jgX7aQ/Fj4se1cL/C57nn9bUXSuF4AOiGxUrEygRR
 EttPAOJhO0ebEOlm1gkoKxaLZpmv+04Zdm/nar2Y1IP6Y5no9KXdnLKxF3f9KZ5J0e
 k1gw4x3Yc4cpQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH v2 2/5] powerpc: Allow 4224 bytes of stack expansion for
 the signal frame
In-Reply-To: <20200727082331.GA2110@lt-gp.iram.es>
References: <20200724092528.1578671-1-mpe@ellerman.id.au>
 <20200724092528.1578671-2-mpe@ellerman.id.au>
 <20200727082331.GA2110@lt-gp.iram.es>
Date: Mon, 27 Jul 2020 22:28:09 +1000
Message-ID: <87mu3l6t2e.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Gabriel Paubert <paubert@iram.es> writes:
> On Fri, Jul 24, 2020 at 07:25:25PM +1000, Michael Ellerman wrote:
>> We have powerpc specific logic in our page fault handling to decide if
>> an access to an unmapped address below the stack pointer should expand
>> the stack VMA.
>> 
>> The code was originally added in 2004 "ported from 2.4". The rough
>> logic is that the stack is allowed to grow to 1MB with no extra
>> checking. Over 1MB the access must be within 2048 bytes of the stack
>> pointer, or be from a user instruction that updates the stack pointer.
>> 
>> The 2048 byte allowance below the stack pointer is there to cover the
>> 288 byte "red zone" as well as the "about 1.5kB" needed by the signal
>> delivery code.
>> 
>> Unfortunately since then the signal frame has expanded, and is now
>> 4224 bytes on 64-bit kernels with transactional memory enabled.
>
> Are there really users of transactional memory in the wild? 

Not many that I've heard of, but some.

Though anything that does use it needs to be written to fallback to
regular locking if TM is not available anyway.

> Just asking because Power10 removes TM, and Power9 has had some issues
> with it AFAICT.

It varies on different Power9 chip levels. For guests it should work.

> Getting rid of it (if possible) would result in smaller signal frames,
> with simpler signal delivery code (probably slightly faster also).

All the kernel code should be behind CONFIG_PPC_TRANSACTIONAL_MEM.

Deciding to disable that is really a distro decision.

In upstream we tend not to drop support for existing hardware while
people are still using it. But we could make a special case for TM,
because it's quite intrusive. I think we'd wait for a major distro to
ship without TM enabled before we did that though.

cheers
