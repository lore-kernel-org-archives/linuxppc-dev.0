Return-Path: <SRS0=oxDq=34=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F799C35250
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Feb 2020 12:57:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1743220726
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Feb 2020 12:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1743220726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48FBz9316KzDqCh
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Feb 2020 23:57:41 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48FBpR0L1GzDqM3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2020 23:50:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48FBpP4qWsz9sRY; Sat,  8 Feb 2020 23:50:05 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d4bf905307a1c90a27714ff7a9fd29b0a2ceed98
In-Reply-To: <daeacdc0dec0416d1c587cc9f9e7191ad3068dc0.1581095957.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Guenter Roeck <linux@roeck-us.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix CONFIG_TRACE_IRQFLAGS with CONFIG_VMAP_STACK
Message-Id: <48FBpP4qWsz9sRY@ozlabs.org>
Date: Sat,  8 Feb 2020 23:50:05 +1100 (AEDT)
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

On Fri, 2020-02-07 at 17:20:57 UTC, Christophe Leroy wrote:
> When CONFIG_PROVE_LOCKING is selected together with (now default)
> CONFIG_VMAP_STACK, kernel enter deadlock during boot.
> 
> At the point of checking whether interrupts are enabled or not, the
> value of MSR saved on stack is read using the physical address of the
> stack. But at this point, when using VMAP stack the DATA MMU
> translation has already been re-enabled, leading to deadlock.
> 
> Don't use the physical address of the stack when
> CONFIG_VMAP_STACK is set.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 028474876f47 ("powerpc/32: prepare for CONFIG_VMAP_STACK")

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d4bf905307a1c90a27714ff7a9fd29b0a2ceed98

cheers
