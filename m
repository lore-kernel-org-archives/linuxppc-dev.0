Return-Path: <SRS0=e0K3=L2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D63C11F68
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 11:00:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4C4613EE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 11:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4C4613EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GGXDS5hDtz3bWr
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 21:00:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GGXCt1h0jz2yN3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jul 2021 20:59:53 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GGXCq46CSz9shx; Fri,  2 Jul 2021 20:59:51 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210701125026.292224-1-mpe@ellerman.id.au>
References: <20210701125026.292224-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Only build restart_table.c for 64s
Message-Id: <162522358081.303689.1915142573283705407.b4-ty@ellerman.id.au>
Date: Fri, 02 Jul 2021 20:59:40 +1000
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 1 Jul 2021 22:50:26 +1000, Michael Ellerman wrote:
> Commit 9b69d48c7516 ("powerpc/64e: remove implicit soft-masking and
> interrupt exit restart logic") limited the implicit soft masking and
> restart logic to 64-bit Book3S only. However we are still building
> restart_table.c for all 64-bit, ie. Book3E also.
> 
> There's no need to build it for 64e, and it also causes missing
> prototype warnings for 64e builds, because the prototype is already
> behind an #ifdef PPC_BOOK3S_64.

Applied to powerpc/next.

[1/1] powerpc: Only build restart_table.c for 64s
      https://git.kernel.org/powerpc/c/4ebbbaa4ce8524b853dd6febf0176a6efa3482d7

cheers
