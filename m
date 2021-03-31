Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C60C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:12:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233FB619CA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233FB619CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F97b75cz5z3dhf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:12:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F97XM6DpRz3bxj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 12:10:11 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F97XM1Wjnz9sWK; Wed, 31 Mar 2021 12:10:10 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <e4d1aae7604d89c98a52dfd8ce8443462e595670.1615809591.git.christophe.leroy@csgroup.eu>
References: <e4d1aae7604d89c98a52dfd8ce8443462e595670.1615809591.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/math: Fix missing __user qualifier for get_user()
 and other sparse warnings
Message-Id: <161715297749.226945.13016701345166471627.b4-ty@ellerman.id.au>
Date: Wed, 31 Mar 2021 12:09:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Mar 2021 12:00:09 +0000 (UTC), Christophe Leroy wrote:
> Sparse reports the following problems:
> 
> arch/powerpc/math-emu/math.c:228:21: warning: Using plain integer as NULL pointer
> arch/powerpc/math-emu/math.c:228:31: warning: Using plain integer as NULL pointer
> arch/powerpc/math-emu/math.c:228:41: warning: Using plain integer as NULL pointer
> arch/powerpc/math-emu/math.c:228:51: warning: Using plain integer as NULL pointer
> arch/powerpc/math-emu/math.c:237:13: warning: incorrect type in initializer (different address spaces)
> arch/powerpc/math-emu/math.c:237:13:    expected unsigned int [noderef] __user *_gu_addr
> arch/powerpc/math-emu/math.c:237:13:    got unsigned int [usertype] *
> arch/powerpc/math-emu/math.c:226:1: warning: symbol 'do_mathemu' was not declared. Should it be static?
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/math: Fix missing __user qualifier for get_user() and other sparse warnings
      https://git.kernel.org/powerpc/c/e448e1e774dc0ca307c17e961daf7ede2e635c57

cheers
