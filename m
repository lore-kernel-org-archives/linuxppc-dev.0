Return-Path: <SRS0=Sk7F=Y7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84502C5DF60
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 08:23:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C64521882
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 08:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C64521882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 477xHp14kdzF62N
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Nov 2019 19:23:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 477q73425rzF5wX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2019 14:45:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 477q7216Dlz9sQp; Thu,  7 Nov 2019 14:45:34 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 477q720WRBz9sQy; Thu,  7 Nov 2019 14:45:33 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e44ff9ea8f4c8a90c82f7b85bd4f5e497c841960
In-Reply-To: <20191024004730.32135-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/tools: Don't quote $objdump in scripts
Message-Id: <477q720WRBz9sQy@ozlabs.org>
Date: Thu,  7 Nov 2019 14:45:33 +1100 (AEDT)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-10-24 at 00:47:30 UTC, Michael Ellerman wrote:
> Some of our scripts are passed $objdump and then call it as
> "$objdump". This doesn't work if it contains spaces because we're
> using ccache, for example you get errors such as:
> 
>   ./arch/powerpc/tools/relocs_check.sh: line 48: ccache ppc64le-objdump: No such file or directory
>   ./arch/powerpc/tools/unrel_branch_check.sh: line 26: ccache ppc64le-objdump: No such file or directory
> 
> Fix it by not quoting the string when we expand it, allowing the shell
> to do the right thing for us.
> 
> Fixes: a71aa05e1416 ("powerpc: Convert relocs_check to a shell script using grep")
> Fixes: 4ea80652dc75 ("powerpc/64s: Tool to flag direct branches from unrelocated interrupt vectors")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/e44ff9ea8f4c8a90c82f7b85bd4f5e497c841960

cheers
