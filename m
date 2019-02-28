Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE03C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:33:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808332171F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808332171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4496n902v1zDq6l
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:33:49 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4496Vf28xlzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:21:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4496Vf0vRHz9s9T; Thu, 28 Feb 2019 20:21:13 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 27da80719ef132cf8c80eb406d5aeb37dddf78cc
X-Patchwork-Hint: ignore
In-Reply-To: <dccb392cd3e2b1825608576ecf2487cc5d84466d.1551205086.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Diana Craciun <diana.craciun@nxp.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/fsl: Fix the flush of branch predictor.
Message-Id: <4496Vf0vRHz9s9T@ozlabs.org>
Date: Thu, 28 Feb 2019 20:21:13 +1100 (AEDT)
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

On Tue, 2019-02-26 at 18:18:48 UTC, Christophe Leroy wrote:
> The commit identified below adds MC_BTB_FLUSH macro only when
> CONFIG_PPC_FSL_BOOK3E is defined. This results in the following error
> on some configs (seen several times with kisskb randconfig_defconfig)
> 
> arch/powerpc/kernel/exceptions-64e.S:576: Error: Unrecognized opcode: `mc_btb_flush'
> make[3]: *** [scripts/Makefile.build:367: arch/powerpc/kernel/exceptions-64e.o] Error 1
> make[2]: *** [scripts/Makefile.build:492: arch/powerpc/kernel] Error 2
> make[1]: *** [Makefile:1043: arch/powerpc] Error 2
> make: *** [Makefile:152: sub-make] Error 2
> 
> This patch adds a blank definition of MC_BTB_FLUSH for other cases.
> 
> Fixes: 10c5e83afd4a ("powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)")
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> Reviewed-by: Diana Craciun <diana.craciun@nxp.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/27da80719ef132cf8c80eb406d5aeb37

cheers
