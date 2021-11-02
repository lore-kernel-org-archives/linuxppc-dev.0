Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3058C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 23:18:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634DE6109D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 23:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 634DE6109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HkQmq4bcLz2ynG
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Nov 2021 10:18:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Z2bW7gwF;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HkQm36pJwz2xD8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Nov 2021 10:17:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Z2bW7gwF; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HkQm10VJcz4xbc;
 Wed,  3 Nov 2021 10:17:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1635895042;
 bh=ps6Fsd1Kfh3xQmGesz/FWIJjeJpokinvWr6rUJKMid4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Z2bW7gwFcu1oO29X03+OyZOp+qhqgWkfVtDpTYwBJa29iPGx/3kz7Y6vBq2EN27A9
 n9UUDh60+QOfWHEH0D4v3e6ee8ALXEpSvOq3LtWlLqWeFwrNHvq3Q4on68gQl4h5bp
 9in53ycpN6mG+zyV9z0iLTNYFhGryEt60/YXpw/h6BeuVsCaOQRG4AiUi5Jl/3lyHa
 R3G4Hrb59Ac2kJIzzCD1LxGqZPu9GhT2sXPg0H5fm68wj9tqk7AzZ2BRHc2a0rxwlx
 W3shWRLkKtErwTOIyQUDKm2++QdIfqo37nYlXJ8dhqCiLJYQBJxoPXqK/djIm7VZvc
 UW9Z95mNHF5/w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Ellerman <patch-notifications@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
In-Reply-To: <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
 <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
Date: Wed, 03 Nov 2021 10:17:19 +1100
Message-ID: <87czni87wg.fsf@mpe.ellerman.id.au>
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
Cc: linux-audit@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
 Paul Moore <paul@paul-moore.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Tue, 24 Aug 2021 13:36:13 +0000 (UTC), Christophe Leroy wrote:
>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
>> targets") added generic support for AUDIT but that didn't include
>> support for bi-arch like powerpc.
>> 
>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
>> added generic support for bi-arch.
>> 
>> [...]
>
> Applied to powerpc/next.
>
> [1/1] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
>       https://git.kernel.org/powerpc/c/566af8cda399c088763d07464463dc871c943b54

And then reverted in:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=b7472e1764bfc0fe3d6578cb281e81c812ca5886

cheers
