Return-Path: <SRS0=dmdX=PA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CA0C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 14:21:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B372021849
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 14:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B372021849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43N4L855hxzDr31
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 01:21:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43N38h2wrNzDqWK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 00:28:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43N38h0RC4z9sNq; Mon, 24 Dec 2018 00:28:20 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43N38g49YCz9sPK; Mon, 24 Dec 2018 00:28:18 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 505a314fb28ce122091691c51426fa85c084e115
X-Patchwork-Hint: ignore
In-Reply-To: <e4bfa53ea8c777105359e1770df906909dde2c57.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Fix HMIs on big-endian with CONFIG_RELOCATABLE=y
Message-Id: <43N38g49YCz9sPK@ozlabs.org>
Date: Mon, 24 Dec 2018 00:28:18 +1100 (AEDT)
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
Cc: linuxppc-dev@ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-10-08 at 04:08:31 UTC, Benjamin Herrenschmidt wrote:
> HMIs will crash the kernel due to
> 
> 	BRANCH_LINK_TO_FAR(hmi_exception_realmode)
> 
> Calling into the OPD instead of the actual code.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/505a314fb28ce122091691c51426fa

cheers
