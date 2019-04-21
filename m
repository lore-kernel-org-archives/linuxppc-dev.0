Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD6EC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:38:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4027720859
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4027720859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nC4b2bpgzDqL0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 00:38:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBf24PdKzDqNJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:18:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBf21J3Vz9sBr; Mon, 22 Apr 2019 00:18:49 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 80d04b7fabe161a23d143b3bfcfca1b002c23da1
X-Patchwork-Hint: ignore
In-Reply-To: <201903211042.x2LAgMp3003053@sdf.org>
To: George Spelvin <lkml@sdf.org>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: arch/powerpc/crypto/crc-vpmsum_test: Use cheaper random numbers
 for self-test
Message-Id: <44nBf21J3Vz9sBr@ozlabs.org>
Date: Mon, 22 Apr 2019 00:18:49 +1000 (AEST)
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
Cc: George Spelvin <lkml@sdf.org>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-03-21 at 10:42:22 UTC, George Spelvin wrote:
> This code was filling a 64K buffer from /dev/urandom in order to
> compute a CRC over (on average half of) it by two different methods,
> comparing the CRCs, and repeating.
> 
> This is not a remotely security-critical application, so use the far
> faster and cheaper prandom_u32() generator.
> 
> And, while we're at it, only fill as much of the buffer as we plan to use.
> 
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/80d04b7fabe161a23d143b3bfcfca1b0

cheers
