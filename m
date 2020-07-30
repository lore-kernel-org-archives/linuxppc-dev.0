Return-Path: <SRS0=fR6Q=BJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E4BC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 13:18:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB87F2074B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 13:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB87F2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHWFT0CV3zDr6W
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 23:18:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHVcx0hgRzDqyY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2020 22:50:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BHVcw5wlHz9sRX; Thu, 30 Jul 2020 22:50:24 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BHVcw3ljxz9sR4; Thu, 30 Jul 2020 22:50:24 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200724092528.1578671-1-mpe@ellerman.id.au>
References: <20200724092528.1578671-1-mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/5] selftests/powerpc: Add test of stack expansion
 logic
Message-Id: <159611327263.1601380.4813279952363405661.b4-ty@ellerman.id.au>
Date: Thu, 30 Jul 2020 22:50:24 +1000 (AEST)
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
Cc: linux-kernel@vger.kernel.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 24 Jul 2020 19:25:24 +1000, Michael Ellerman wrote:
> We have custom stack expansion checks that it turns out are extremely
> badly tested and contain bugs, surprise. So add some tests that
> exercise the code and capture the current boundary conditions.
> 
> The signal test currently fails on 64-bit kernels because the 2048
> byte allowance for the signal frame is too small, we will fix that in
> a subsequent patch.

Applied to powerpc/next.

[1/5] selftests/powerpc: Add test of stack expansion logic
      https://git.kernel.org/powerpc/c/c9938a9dac95be7650218cdd8e9d1f882e7b5691
[2/5] powerpc: Allow 4224 bytes of stack expansion for the signal frame
      https://git.kernel.org/powerpc/c/63dee5df43a31f3844efabc58972f0a206ca4534
[3/5] selftests/powerpc: Update the stack expansion test
      https://git.kernel.org/powerpc/c/9ee571d84bf8cfdd587a1acbf3490ca90fc40c9d
[4/5] powerpc/mm: Remove custom stack expansion checking
      https://git.kernel.org/powerpc/c/773b3e53df5b84e73bf64998e4019f50a6662ad1
[5/5] selftests/powerpc: Remove powerpc special cases from stack expansion test
      https://git.kernel.org/powerpc/c/73da08f6966b81feb429af4fb3229da4cf21d6d9

cheers
