Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282E9C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:23:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC11420760
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC11420760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49h0Rl5jQ9zDqjY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 16:23:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gzFb1VmWzDqRr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 15:29:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 49gzFQ1NT0z9sTH; Tue,  9 Jun 2020 15:29:14 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49gzFP2FLlz9sTN; Tue,  9 Jun 2020 15:29:12 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20200525055004.2182328-1-mpe@ellerman.id.au>
References: <20200525055004.2182328-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add ppc_inst_as_u64()
Message-Id: <159168033279.1381411.4562321446237082737.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:29:12 +1000 (AEST)
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
Cc: jniethe5@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 25 May 2020 15:50:04 +1000, Michael Ellerman wrote:
> The code patching code wants to get the value of a struct ppc_inst as
> a u64 when the instruction is prefixed, so we can pass the u64 down to
> __put_user_asm() and write it with a single store.
> 
> This is a bit awkward because the value differs based on the CPU
> endianness, so add a helper to do the conversion.

Applied to powerpc/next.

[1/1] powerpc: Add ppc_inst_as_u64()
      https://git.kernel.org/powerpc/c/16ef9767e4dc5cf03a71ae7bc2bc588dbbe7983e

cheers
