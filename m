Return-Path: <SRS0=pfuI=TG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96B2C04A6B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 14:10:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEE92054F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 May 2019 14:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEE92054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44yPl45SHlzDq8g
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2019 00:10:08 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44yPNf4qp0zDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2019 23:54:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44yPNf0rL1z9sDQ; Mon,  6 May 2019 23:54:09 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 67d53f30e23ec66aa7bbdd1592d5e64d46876190
X-Patchwork-Hint: ignore
In-Reply-To: <3a330ee8d98fce60c08c3d26054d2f0f8f53b66a.1557130203.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: fix section mismatch for setup_kup()
Message-Id: <44yPNf0rL1z9sDQ@ozlabs.org>
Date: Mon,  6 May 2019 23:54:09 +1000 (AEST)
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

On Mon, 2019-05-06 at 08:10:43 UTC, Christophe Leroy wrote:
> commit b28c97505eb1 ("powerpc/64: Setup KUP on secondary CPUs")
> moved setup_kup() out of the __init section. As stated in that commit,
> "this is only for 64-bit". But this function is also used on PPC32,
> where the two functions called by setup_kup() are in the __init
> section, so setup_kup() has to either be kept in the __init
> section on PPC32 or marked __ref.
> 
> This patch marks it __ref, it fixes the below build warnings.
> 
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x169ec): Section mismatch in reference from the function setup_kup() to the function .init.text:setup_kuep()
> The function setup_kup() references
> the function __init setup_kuep().
> This is often because setup_kup lacks a __init
> annotation or the annotation of setup_kuep is wrong.
> 
> WARNING: vmlinux.o(.text+0x16a04): Section mismatch in reference from the function setup_kup() to the function .init.text:setup_kuap()
> The function setup_kup() references
> the function __init setup_kuap().
> This is often because setup_kup lacks a __init
> annotation or the annotation of setup_kuap is wrong.
> 
> Fixes: b28c97505eb1 ("powerpc/64: Setup KUP on secondary CPUs")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/67d53f30e23ec66aa7bbdd1592d5e64d

cheers
