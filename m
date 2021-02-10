Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503F7C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:54:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A1A64E16
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A1A64E16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbLqK0yNLzDsg0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 00:54:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKYD1DDTzDsbM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:36 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4DbKYC2Hzgz9sWY; Wed, 10 Feb 2021 23:57:35 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKYB2xpVz9sW5; Wed, 10 Feb 2021 23:57:33 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20210202130207.1303975-1-mpe@ellerman.id.au>
References: <20210202130207.1303975-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/64: Make stack tracing work during very early
 boot
Message-Id: <161296172570.3178259.12731008832235080789.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:33 +1100 (AEDT)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 3 Feb 2021 00:02:06 +1100, Michael Ellerman wrote:
> If we try to stack trace very early during boot, either due to a
> WARN/BUG or manual dump_stack(), we will oops in
> valid_emergency_stack() when we try to dereference the paca_ptrs
> array.
> 
> The fix is simple, we just return false if paca_ptrs isn't allocated
> yet. The stack pointer definitely isn't part of any emergency stack
> because we haven't allocated any yet.

Applied to powerpc/next.

[1/2] powerpc/64: Make stack tracing work during very early boot
      https://git.kernel.org/powerpc/c/0ecf6a9e47d825b7dddfebca738386b809e59a94
[2/2] powerpc/64s: Handle program checks in wrong endian during early boot
      https://git.kernel.org/powerpc/c/e7eb919057c3450cdd9d335e4a23a4da8da58db4

cheers
