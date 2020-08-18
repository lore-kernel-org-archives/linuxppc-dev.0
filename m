Return-Path: <SRS0=LqqS=B4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A389C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 03:25:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307082078D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 03:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307082078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVx9b1jWZzDqYq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 13:24:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVx5Q4LmXzDqXN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2020 13:21:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BVx5Q3GDFz9sTT; Tue, 18 Aug 2020 13:21:14 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20200817005618.3305028-1-maddy@linux.ibm.com>
References: <20200817005618.3305028-1-maddy@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/kernel/cputable: cleanup the function
 declarations
Message-Id: <159772076231.1537671.8380311708899292462.b4-ty@ellerman.id.au>
Date: Tue, 18 Aug 2020 13:21:14 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 17 Aug 2020 06:26:17 +0530, Madhavan Srinivasan wrote:
> __machine_check_early_realmode_p*() are currently declared
> as extern in cputable.c and because of this when compiled
> with "C=1" (which enables semantic checker) produces these
> warnings.
> 
>   CHECK   arch/powerpc/kernel/mce_power.c
> arch/powerpc/kernel/mce_power.c:709:6: warning: symbol '__machine_check_early_realmode_p7' was not declared. Should it be static?
> arch/powerpc/kernel/mce_power.c:717:6: warning: symbol '__machine_check_early_realmode_p8' was not declared. Should it be static?
> arch/powerpc/kernel/mce_power.c:722:6: warning: symbol '__machine_check_early_realmode_p9' was not declared. Should it be static?
> arch/powerpc/kernel/mce_power.c:740:6: warning: symbol '__machine_check_early_realmode_p10' was not declared. Should it be static?
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/kernel: Cleanup machine check function declarations
      https://git.kernel.org/powerpc/c/388692e943a58f28aac0fe83e75f5994da9ff8a1
[2/2] powerpc: Add POWER10 raw mode cputable entry
      https://git.kernel.org/powerpc/c/327da008e65a25b8206b36b7fc0c9e4edbb36a58

cheers
