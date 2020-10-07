Return-Path: <SRS0=XBts=DO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB49C4363C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 03:40:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F88208C3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 03:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F88208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C5g8549VLzDqFH
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 14:40:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C5fkW0m5rzDqFs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2020 14:21:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4C5fkT3FZKz9sTR; Wed,  7 Oct 2020 14:21:20 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200918093050.37344-1-oohall@gmail.com>
References: <20200918093050.37344-1-oohall@gmail.com>
Subject: Re: [PATCH v2 1/9] powerpc/eeh: Rework EEH initialisation
Message-Id: <160204083249.257875.6446899551182195599.b4-ty@ellerman.id.au>
Date: Wed,  7 Oct 2020 14:21:20 +1100 (AEDT)
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

On Fri, 18 Sep 2020 19:30:42 +1000, Oliver O'Halloran wrote:
> Drop the EEH register / unregister ops thing and have the platform pass the
> ops structure into eeh_init() directly. This takes one initcall out of the
> EEH setup path and it means we're only doing EEH setup on the platforms
> which actually support it. It's also less code and generally easier to
> follow.
> 
> No functional changes.

Applied to powerpc/next.

[1/9] powerpc/eeh: Rework EEH initialisation
      https://git.kernel.org/powerpc/c/d125aedb404204de0579b16028096b2cc09e4deb
[2/9] powerpc/powernv: Stop using eeh_ops->init()
      https://git.kernel.org/powerpc/c/82a1ea21f1bac42eb8e3f77d5d249201855f2c85
[3/9] powerpc/pseries: Stop using eeh_ops->init()
      https://git.kernel.org/powerpc/c/1f8fa0cd6a848ff072bffe0ee776554387128f60
[4/9] powerpc/eeh: Delete eeh_ops->init
      https://git.kernel.org/powerpc/c/5d69e46a2104050c0a458c6bf6abba5f58f56e4c
[5/9] powerpc/eeh: Move EEH initialisation to an arch initcall
      https://git.kernel.org/powerpc/c/395ee2a2a15ba1c4c7c414db24dc3082ba8feab8
[6/9] powerpc/pseries/eeh: Clean up pe_config_addr lookups
      https://git.kernel.org/powerpc/c/f61c859feb5d19787c93d6b2b3d4beeca7260034
[7/9] powerpc/pseries/eeh: Rework device EEH PE determination
      https://git.kernel.org/powerpc/c/98ba956f6a3891b233466b8da064f17d16dc2090
[8/9] powerpc/pseries/eeh: Allow zero to be a valid PE configuration address
      https://git.kernel.org/powerpc/c/42de19d5ef71b91765266557705394e52954adb3
[9/9] powerpc/eeh: Clean up PE addressing
      https://git.kernel.org/powerpc/c/35d64734b64315f2c5716c5a0a380ed1ba8fbe4a

cheers
