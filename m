Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C840C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 May 2022 12:08:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KzVsg0jBXz3c7p
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 May 2022 22:08:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=XP41nict;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KzVrz0cYhz3bYJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2022 22:07:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=XP41nict; 
 dkim-atps=neutral
Received: by gandalf.ozlabs.org (Postfix)
 id 4KzVry74Znz4ySn; Thu, 12 May 2022 22:07:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KzVry2jy9z4ySc;
 Thu, 12 May 2022 22:07:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1652357250;
 bh=VZSW+kLwiLdM89tx8T02OMcLyU8N86ihiltmUjTWwjI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=XP41nicttMOhY9hwW7ifQg2VaHXrgfn5gqxy72pbMcNrCIDLFnLRtS6w6og9CNqK6
 nfglk3q4XgkwHUkKXU2YAPNMA6T+LY+efjCMwbPkEjfG7K0jSWdZgbC26jbu/U3Xcl
 5oEbIbP5B31AYRCtrtiLL941I4qH1NkcSEECG4hfVklIAfPOY/c3oDymRLW/N/gs/8
 2nABeRNQSF+J6FzFKg0RD6jU3loze5R0Qj/Exft5+7TIpmm0GH+KfhdI3Lzf+saYbY
 eFMKhvv5GqDVbGt9d2R8lw8p+jKhswUJjJCCd+elCw/toBYU19BWQ19jXOHAty0KmP
 ZMGFbGsOj+R7Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: request_module DoS
In-Reply-To: <871qwz8aot.fsf@mpe.ellerman.id.au>
References: <YnXiuhdZ49pKL/dK@gondor.apana.org.au>
 <874k1zt0ec.fsf@mpe.ellerman.id.au>
 <Ynk9j6DQmVGAA3Jf@bombadil.infradead.org>
 <Ynvl6wCQRFdYsHar@bombadil.infradead.org>
 <871qwz8aot.fsf@mpe.ellerman.id.au>
Date: Thu, 12 May 2022 22:07:26 +1000
Message-ID: <87v8ub6jk1.fsf@mpe.ellerman.id.au>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, fnovak@us.ibm.com, linux-modules@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Luis Chamberlain <mcgrof@kernel.org> writes:
...
>
>> Can someone try this on ppc64le system? At this point I am not convinced
>> this issue is generic.
>
> Does your x86 system have at least 784 CPUs?
>
> I don't know where the original report came from, but the trace shows
> "CPU 784", which would usually indicate a system with at least that many
> CPUs.

Update, apparently the report originally came from IBM, so I'll chase it
up internally.

I think you're right that there's probably no issue in the module code,
sorry to waste your time.

cheers
