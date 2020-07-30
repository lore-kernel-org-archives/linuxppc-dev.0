Return-Path: <SRS0=fR6Q=BJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2CDC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 13:38:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5435320829
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 13:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5435320829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHWhv1v76zDr7x
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 23:38:55 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHVfg5bs3zDqxQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2020 22:51:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BHVfg212Kz9sSt; Thu, 30 Jul 2020 22:51:55 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BHVff52Mbz9sSy; Thu, 30 Jul 2020 22:51:50 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20200727070341.595634-1-mpe@ellerman.id.au>
References: <20200727070341.595634-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/fadump: Fix build error with
 CONFIG_PRESERVE_FA_DUMP=y
Message-Id: <159611349908.1605534.13544680784147570902.b4-ty@ellerman.id.au>
Date: Thu, 30 Jul 2020 22:51:50 +1000 (AEST)
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

On Mon, 27 Jul 2020 17:03:41 +1000, Michael Ellerman wrote:
> skiroot_defconfig fails:
> 
> arch/powerpc/kernel/fadump.c:48:17: error: ‘cpus_in_fadump’ defined but not used
>    48 | static atomic_t cpus_in_fadump;
> 
> Fix it by moving the definition into the #ifdef where it's used.

Applied to powerpc/next.

[1/1] powerpc/fadump: Fix build error with CONFIG_PRESERVE_FA_DUMP=y
      https://git.kernel.org/powerpc/c/5f987caec521cbb00d4ba2dc641ac8074626b762

cheers
