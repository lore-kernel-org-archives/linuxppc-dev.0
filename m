Return-Path: <SRS0=qxeE=IM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CE0C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 10:02:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116B564EC6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 10:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116B564EC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dyw8n5hl6z3ddJ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 21:02:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dyw784nwGz30KF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Mar 2021 21:01:24 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Dyw742KnCz9sWP; Sun, 14 Mar 2021 21:01:20 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, npiggin@gmail.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <53f3a1f719441761000c41154602bf097d4350b5.1614148356.git.christophe.leroy@csgroup.eu>
References: <53f3a1f719441761000c41154602bf097d4350b5.1614148356.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/syscall: Force inlining of
 __prep_irq_for_enabled_exit()
Message-Id: <161571587077.138988.9146414828000820575.b4-ty@ellerman.id.au>
Date: Sun, 14 Mar 2021 21:01:20 +1100 (AEDT)
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

On Wed, 24 Feb 2021 06:34:22 +0000 (UTC), Christophe Leroy wrote:
> As reported by kernel test robot, a randconfig with high amount of
> debuging options can lead to build failure for undefined reference
> to replay_soft_interrupts() on ppc32.
> 
> This is due to gcc not seeing that __prep_irq_for_enabled_exit()
> always returns true on ppc32 because it doesn't inline it for
> some reason.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/syscall: Force inlining of __prep_irq_for_enabled_exit()
      https://git.kernel.org/powerpc/c/91b6c5dbe9e072dbdb181eed89c5c824e92ac0f5

cheers
