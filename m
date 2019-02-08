Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB479C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:35:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DED72146E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DED72146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wyR03MhJzDqbX
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 01:35:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wwMd1QG9zDqWy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 00:02:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43wwMc2rRdz9sPT; Sat,  9 Feb 2019 00:02:51 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 98ecc6768e8fdba95da1fc1efa0ef2d769e7fe1c
X-Patchwork-Hint: ignore
In-Reply-To: <20181114030218.25508-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/32: Include .branch_lt in data section
Message-Id: <43wwMc2rRdz9sPT@ozlabs.org>
Date: Sat,  9 Feb 2019 00:02:51 +1100 (AEDT)
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
Cc: Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-11-14 at 03:02:18 UTC, Joel Stanley wrote:
> When building a 32 bit powerpc kernel with Binutils 2.31.1 this warning
> is emitted:
> 
>  powerpc-linux-gnu-ld: warning: orphan section `.branch_lt' from
>  `arch/powerpc/kernel/head_44x.o' being placed in section `.branch_lt'
> 
> As of binutils commit 2d7ad24e8726 ("Support PLT16 relocs against local
> symbols")[1], 32 bit targets can produce .branch_lt sections in their
> output.
> 
> Include these symbols in the .data section as the ppc64 kernel does.
> 
> [1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=2d7ad24e8726ba4c45c9e67be08223a146a837ce
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Alan Modra <amodra@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/98ecc6768e8fdba95da1fc1efa0ef2d7

cheers
