Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3959CC43462
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:10:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C7B6146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C7B6146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQLWh0B7Bz30Q8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 23:10:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQLVG49gtz304c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 23:09:10 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FQLVC5vg7z9vDw; Wed, 21 Apr 2021 23:09:06 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <69f9968f4b592fefda55227f0f7430ea612cc950.1611299687.git.christophe.leroy@csgroup.eu>
References: <69f9968f4b592fefda55227f0f7430ea612cc950.1611299687.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Use r2 in wrtspr() instead of r0
Message-Id: <161901050347.1961279.12121626398624044029.b4-ty@ellerman.id.au>
Date: Wed, 21 Apr 2021 23:08:23 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 22 Jan 2021 07:15:03 +0000 (UTC), Christophe Leroy wrote:
> wrtspr() is a function to write an arbitrary value in a special
> register. It is used on 8xx to write to SPRN_NRI, SPRN_EID and
> SPRN_EIE. Writing any value to one of those will play with MSR EE
> and MSR RI regardless of that value.
> 
> r0 is used many places in the generated code and using r0 for
> that creates an unnecessary dependency of this instruction with
> preceding ones using r0 in a few places in vmlinux.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Use r2 in wrtspr() instead of r0
      https://git.kernel.org/powerpc/c/867e762480f4ad4106b16299a373fa23eccf5b4b

cheers
