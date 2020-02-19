Return-Path: <SRS0=ebxO=4H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C06EC34047
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Feb 2020 13:07:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6C021D56
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Feb 2020 13:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6C021D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Myg63kl8zDqdr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Feb 2020 00:07:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48My3n6QnxzDq9R
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2020 23:40:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48My3n21Wwz9sSt; Wed, 19 Feb 2020 23:40:05 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 066bc3576e653b615ee3f5230a89d69c8ebeeb71
In-Reply-To: <20200217041343.2454-1-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/xmon: Fix whitespace handling in getstring()
Message-Id: <48My3n21Wwz9sSt@ozlabs.org>
Date: Wed, 19 Feb 2020 23:40:05 +1100 (AEDT)
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2020-02-17 at 04:13:43 UTC, Oliver O'Halloran wrote:
> The ls (lookup symbol) and zr (reboot) commands use xmon's getstring()
> helper to read a string argument from the xmon prompt. This function skips
> over leading whitespace, but doesn't check if the first "non-whitespace"
> character is a newline which causes some odd behaviour (<enter> indicates
> a the enter key was pressed):
> 
> 	0:mon> ls printk<enter>
> 	printk: c0000000001680c4
> 
> 	0:mon> ls<enter>
> 	printk<enter>
> 	Symbol '
> 	printk' not found.
> 	0:mon>
> 
> With commit 2d9b332d99b ("powerpc/xmon: Allow passing an argument
> to ppc_md.restart()") we have a similar problem with the zr command.
> Previously zr took no arguments so "zr<enter> would trigger a reboot.
> With that patch applied a second newline needs to be sent in order for
> the reboot to occur. Fix this by checking if the leading whitespace
> ended on a newline:
> 
> 	0:mon> ls<enter>
> 	Symbol '' not found.
> 
> Fixes: 2d9b332d99b ("powerpc/xmon: Allow passing an argument to ppc_md.restart()")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/066bc3576e653b615ee3f5230a89d69c8ebeeb71

cheers
