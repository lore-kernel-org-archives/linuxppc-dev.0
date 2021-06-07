Return-Path: <SRS0=rLAe=LB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E19C47094
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 11:54:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CACC610A1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 11:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CACC610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FzBcj2TfCz302y
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jun 2021 21:54:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=XFbDmldc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=XFbDmldc; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FzBc94ttBz2yRD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jun 2021 21:54:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FzBc61xCSz9s1l;
 Mon,  7 Jun 2021 21:54:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1623066854;
 bh=6vsO3F0B+iMvgvjpcar0bj8uHWL1Rpjga+QKyho2BXs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=XFbDmldcheV3iuSUHU07i+8Xir7SZZlVMziHGVXKYwGjaPtpYNttU+XA1nwTCozUQ
 atgVBkV/j+10hdeY8l3eLhJ2l26SDq/GhJVfYpcAORs2zdGIcq+iqdMlT31nI5pcLp
 Xbi7WfOd1C7wDePF95+vjQccvp9XZhvTASJMQBAihPwyvB7AnpjJP/pbSYhKsEbL5W
 /pObX9Ay9ieKZbY2tRWwFqUO1g+04tkmUNKN01ngxgtzazHB4Nr24axZwGLbNt4lQd
 uSKHLflCCtaMA3YiQitEQ1WvsX1J/SRKRm+64JqoQBDxvZh0gsnm0hgUmSZgY4vJqF
 foIRsgTn8cvuQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] powerpc: Fixup for v3 "powerpc/nohash: Refactor
 update of BDI2000 pointers in switch_mmu_context()" in next-test
In-Reply-To: <d2d520231f8082f9c1f7a896af8db1d09565ac84.1623059495.git.christophe.leroy@csgroup.eu>
References: <d2d520231f8082f9c1f7a896af8db1d09565ac84.1623059495.git.christophe.leroy@csgroup.eu>
Date: Mon, 07 Jun 2021 21:54:11 +1000
Message-ID: <87a6o1gaak.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> As mentionned in history, v3 doesn't apply to book3s/32 so the hunk
> on head_book3s_32.S has to be dropped from the commit mentionned
> in the title.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Michael, tell me if you prefer a v4 of the series.

Nah that's OK, I squashed this in.

cheers
