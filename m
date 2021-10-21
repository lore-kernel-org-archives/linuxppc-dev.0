Return-Path: <SRS0=ebkI=PJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB19C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 11:08:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37804610CF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 11:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37804610CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HZl8z43Ddz3bnG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Oct 2021 22:08:51 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HZl8X3nTNz2yZf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Oct 2021 22:08:28 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HZl8W4ks0z4xbL;
 Thu, 21 Oct 2021 22:08:27 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211020094826.3222052-1-mpe@ellerman.id.au>
References: <20211020094826.3222052-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/idle: Don't corrupt back chain when going idle
Message-Id: <163481446090.3437586.5094721778895983974.b4-ty@ellerman.id.au>
Date: Thu, 21 Oct 2021 22:07:40 +1100
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
Cc: npiggin@gmail.com, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 20 Oct 2021 20:48:26 +1100, Michael Ellerman wrote:
> In isa206_idle_insn_mayloss() we store various registers into the stack
> red zone, which is allowed.
> 
> However inside the IDLE_STATE_ENTER_SEQ_NORET macro we save r2 again,
> to 0(r1), which corrupts the stack back chain.
> 
> We used to do the same in isa206_idle_insn_mayloss() itself, but we
> fixed that in 73287caa9210 ("powerpc64/idle: Fix SP offsets when saving
> GPRs"), however we missed that the macro also corrupts the back chain.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/idle: Don't corrupt back chain when going idle
      https://git.kernel.org/powerpc/c/496c5fe25c377ddb7815c4ce8ecfb676f051e9b6

cheers
