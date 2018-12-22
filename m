Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FE2C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:29:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036DD219FE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036DD219FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MMDc1pfqzDqlp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 21:29:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLSk6QpQzDqXJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 20:54:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43MLSk4Sy8z9sPK; Sat, 22 Dec 2018 20:54:46 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43MLSk3Rcnz9sPH; Sat, 22 Dec 2018 20:54:46 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2b874a5c7b75fdc90fdd1e2ffaa3ec5a9d21e253
X-Patchwork-Hint: ignore
In-Reply-To: <20181214135711.10552-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/configs: Don't enable PPC_EARLY_DEBUG in defconfigs
Message-Id: <43MLSk3Rcnz9sPH@ozlabs.org>
Date: Sat, 22 Dec 2018 20:54:46 +1100 (AEDT)
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
Cc: alistair@popple.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-12-14 at 13:57:11 UTC, Michael Ellerman wrote:
> This reverts the remains of commit b9ef7d6b11c1 ("powerpc: Update
> default configurations").
> 
> That commit was proceeded by a commit which added a config option to
> control use of BOOTX for early debug, ie. PPC_EARLY_DEBUG_BOOTX, and
> then the update of the defconfigs was intended to not change behaviour
> by then enabling the new config option.
> 
> However enabling PPC_EARLY_DEBUG had other consequences, notably
> causing us to register the udbg console at the end of udbg_early_init().
> 
> This means on a system which doesn't have anything that BOOTX can
> use (most systems), we register the udbg console very early but the
> bootx code just throws everything away, meaning early boot messages
> are never printed to the console.
> 
> What we want to happen is for the udbg console to only be registered
> later (from setup_arch()) once we've setup udbg_putc, and then all
> early boot messages will be replayed.
> 
> Fixes: b9ef7d6b11c1 ("powerpc: Update default configurations")
> Reported-by: Torsten Duwe <duwe@lst.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/2b874a5c7b75fdc90fdd1e2ffaa3ec

cheers
