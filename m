Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFEAC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:04:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DF121974
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DF121974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MLh55C8bzDqXY
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 21:04:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLSV46v0zDqWq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 20:54:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43MLSV0PQYz9sNJ; Sat, 22 Dec 2018 20:54:33 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ebd1d3b74f8542a8f3bb80b453692d6d18f84071
X-Patchwork-Hint: ignore
In-Reply-To: <20181205175355.14787-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/32: Move the old 6xx -mcpu logic before the
 TARGET_CPU logic
Message-Id: <43MLSV0PQYz9sNJ@ozlabs.org>
Date: Sat, 22 Dec 2018 20:54:33 +1100 (AEDT)
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
Cc: Mathieu Malaterre <malat@debian.org>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-12-05 at 17:53:55 UTC, Mathieu Malaterre wrote:
> The code:
> 
>   ifdef CONFIG_6xx
>   KBUILD_CFLAGS          += -mcpu=powerpc
>   endif
> 
> was added in 2006 in commit f48b8296b315 ("[PATCH] powerpc32: Set cpu
> explicitly in kernel compiles"). This change was acceptable since the
> TARGET_CPU logic was 64-bit only.
> 
> Since commit 0e00a8c9fd92 ("powerpc: Allow CPU selection
> also on PPC32") this logic is no longer acceptable after the TARGET_CPU
> specific. It currently appends -mcpu=powerpc at the end of the command
> line, after any TARGET_CPU specific:
> 
>   gcc -Wp,-MD,init/.do_mounts.o.d ...
>     -mcpu=powerpc -mbig-endian -m32 ...
>     -mcpu=e300c2 ...
>     -mcpu=powerpc ...
>     ../init/do_mounts.c
> 
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg142315.html
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ebd1d3b74f8542a8f3bb80b453692d

cheers
