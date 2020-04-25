Return-Path: <SRS0=123t=6J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC8DC54FCB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 23:54:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35547206BF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 23:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35547206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 498nvZ2R0yzDqfY
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2020 09:54:34 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 498nqm12BnzDqVj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2020 09:51:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 498nql587Wz9sSJ; Sun, 26 Apr 2020 09:51:15 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 94c0b013c98583614e1ad911e8795ca36da34a85
In-Reply-To: <20200416221908.7886-1-chris.packham@alliedtelesis.co.nz>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, benh@kernel.crashing.org,
 christophe.leroy@c-s.fr, tglx@linutronix.de, paulus@samba.org, cai@lca.pw,
 oss@buserror.net
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc/setup_64: Set cache-line-size based on
 cache-block-size
Message-Id: <498nql587Wz9sSJ@ozlabs.org>
Date: Sun, 26 Apr 2020 09:51:15 +1000 (AEST)
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
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2020-04-16 at 22:19:08 UTC, Chris Packham wrote:
> If {i,d}-cache-block-size is set and {i,d}-cache-line-size is not, use
> the block-size value for both. Per the devicetree spec cache-line-size
> is only needed if it differs from the block size.
> 
> Originally the code would fallback from block size to line size. An
> error message was printed if both properties were missing.
> 
> Later the code was refactored to use clearer names and logic but it
> inadvertently made line size a required property. This caused the
> default values to be used and in turn leads to Power9 systems using the
> wrong size.
> 
> Fixes: bd067f83b084 ("powerpc/64: Fix naming of cache block vs. cache lin=
> e")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/94c0b013c98583614e1ad911e8795ca36da34a85

cheers
