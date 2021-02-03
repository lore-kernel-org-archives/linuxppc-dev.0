Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F84C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:54:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BFA64F4E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BFA64F4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW1q71jw3zDwvL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 23:54:43 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW09m3M5ZzDwsr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:40:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4DW09l0Hwmz9vG7; Wed,  3 Feb 2021 22:40:43 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW09j6yJqz9vG6; Wed,  3 Feb 2021 22:40:40 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20201217005306.895685-1-mpe@ellerman.id.au>
References: <20201217005306.895685-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64s/kuap: Use mmu_has_feature()
Message-Id: <161235200005.1516112.5569812810079543982.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:40:40 +1100 (AEDT)
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

On Thu, 17 Dec 2020 11:53:06 +1100, Michael Ellerman wrote:
> In commit 8150a153c013 ("powerpc/64s: Use early_mmu_has_feature() in
> set_kuap()") we switched the KUAP code to use early_mmu_has_feature(),
> to avoid a bug where we called set_kuap() before feature patching had
> been done, leading to recursion and crashes.
> 
> That path, which called probe_kernel_read() from printk(), has since
> been removed, see commit 2ac5a3bf7042 ("vsprintf: Do not break early
> boot with probing addresses").
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64s/kuap: Use mmu_has_feature()
      https://git.kernel.org/powerpc/c/7613f5a66becfd0e43a0f34de8518695888f5458

cheers
