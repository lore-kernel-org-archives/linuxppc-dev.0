Return-Path: <SRS0=7j3x=BP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95375C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 00:44:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC492073E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 00:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC492073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BLtDG3y3DzDqbx
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 10:44:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BLtBB3wWFzDqXT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2020 10:42:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BLtBB2MCcz9sPC; Wed,  5 Aug 2020 10:42:26 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BLtBB1ns1z9sRK; Wed,  5 Aug 2020 10:42:26 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20200722022422.825197-1-mpe@ellerman.id.au>
References: <20200722022422.825197-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/40x: Fix assembler warning about r0
Message-Id: <159658812616.351125.6131435370355606642.b4-ty@ellerman.id.au>
Date: Wed,  5 Aug 2020 10:42:26 +1000 (AEST)
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

On Wed, 22 Jul 2020 12:24:22 +1000, Michael Ellerman wrote:
> The assembler says:
>   arch/powerpc/kernel/head_40x.S:623: Warning: invalid register expression
> 
> It's objecting to the use of r0 as the RA argument. That's because
> when RA = 0 the literal value 0 is used, rather than the content of
> r0, making the use of r0 in the source potentially confusing.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/40x: Fix assembler warning about r0
      https://git.kernel.org/powerpc/c/8d8a629d00a5283874b81b594f31f8d436dc57d8

cheers
