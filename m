Return-Path: <SRS0=Ue3/=7K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718FEC433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 14:10:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFD220663
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 14:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFD220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49XqNr2FkvzDqYC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 00:10:52 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49XqFl5LLdzDqXL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 00:04:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 49XqFl35jsz9sPK; Fri, 29 May 2020 00:04:43 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49XqFl0f6Qz9sSJ; Fri, 29 May 2020 00:04:42 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200520133605.972649-1-mpe@ellerman.id.au>
References: <20200520133605.972649-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64s: Disable STRICT_KERNEL_RWX
Message-Id: <159067441581.2990081.7187942119514227933.b4-ty@ellerman.id.au>
Date: Fri, 29 May 2020 00:04:42 +1000 (AEST)
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

On Wed, 20 May 2020 23:36:05 +1000, Michael Ellerman wrote:
> Several strange crashes have been eventually traced back to
> STRICT_KERNEL_RWX and its interaction with code patching.
> 
> Various paths in our ftrace, kprobes and other patching code need to
> be hardened against patching failures, otherwise we can end up running
> with partially/incorrectly patched ftrace paths, kprobes or jump
> labels, which can then cause strange crashes.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/64s: Disable STRICT_KERNEL_RWX
      https://git.kernel.org/powerpc/c/8659a0e0efdd975c73355dbc033f79ba3b31e82c

cheers
