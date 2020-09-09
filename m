Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E3C43461
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 13:40:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78AB21532
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 13:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78AB21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BmjnW3fy0zDqGg
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 23:40:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmjVs6ymxzDqTp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 23:27:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BmjVr4tTQz9sVT; Wed,  9 Sep 2020 23:27:32 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <2b69ac8e1cddff6f808fc7415907179eab4aae9e.1596693679.git.christophe.leroy@csgroup.eu>
References: <2b69ac8e1cddff6f808fc7415907179eab4aae9e.1596693679.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix assembler warning about r0
Message-Id: <159965716573.808686.4713414935633916441.b4-ty@ellerman.id.au>
Date: Wed,  9 Sep 2020 23:27:32 +1000 (AEST)
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

On Thu, 6 Aug 2020 06:01:42 +0000 (UTC), Christophe Leroy wrote:
> The assembler says:
>   arch/powerpc/kernel/head_32.S:1095: Warning: invalid register expression
> 
> It's objecting to the use of r0 as the RA argument. That's because
> when RA = 0 the literal value 0 is used, rather than the content of
> r0, making the use of r0 in the source potentially confusing.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Fix assembler warning about r0
      https://git.kernel.org/powerpc/c/b51ba4fe2e134b631f9c8f45423707aab71449b5

cheers
