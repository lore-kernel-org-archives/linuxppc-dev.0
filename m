Return-Path: <SRS0=fdF7=ZG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB808C432C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 09:43:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6785120709
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 09:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6785120709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DGkY62tmzF3SZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 20:43:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DFxn32BSzF59y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2019 20:07:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47DFxk6wMPz9sRs; Thu, 14 Nov 2019 20:07:54 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3b05a1e517e1a8cfda4866ec31d28b2bc4fee4c4
In-Reply-To: <20191021142309.28105-1-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/security: Fix debugfs data leak on 32-bit
Message-Id: <47DFxk6wMPz9sRs@ozlabs.org>
Date: Thu, 14 Nov 2019 20:07:54 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-10-21 at 14:23:09 UTC, Geert Uytterhoeven wrote:
> "powerpc_security_features" is "unsigned long", i.e. 32-bit or 64-bit,
> depending on the platform (PPC_FSL_BOOK3E or PPC_BOOK3S_64).  Hence
> casting its address to "u64 *", and calling debugfs_create_x64() is
> wrong, and leaks 32-bit of nearby data to userspace on 32-bit platforms.
> 
> While all currently defined SEC_FTR_* security feature flags fit in
> 32-bit, they all have "ULL" suffixes to make them 64-bit constants.
> Hence fix the leak by changing the type of "powerpc_security_features"
> (and the parameter types of its accessors) to "u64".  This also allows
> to drop the cast.
> 
> Fixes: 398af571128fe75f ("powerpc/security: Show powerpc_security_features in debugfs")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3b05a1e517e1a8cfda4866ec31d28b2bc4fee4c4

cheers
