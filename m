Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F27C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:00:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FD2219FD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FD2219FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MMwd3ZFPzDr69
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 22:00:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLT23zQnzDqX0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 20:55:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43MLT217xxz9sPZ; Sat, 22 Dec 2018 20:55:01 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e213574a449f7a57d4202c1869bbc7680b6b5521
X-Patchwork-Hint: ignore
In-Reply-To: <20181102004455.10157-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] raid6/ppc: Fix build for clang
Message-Id: <43MLT217xxz9sPZ@ozlabs.org>
Date: Sat, 22 Dec 2018 20:55:01 +1100 (AEDT)
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
Cc: Jinsong Ji <jji@us.ibm.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-11-02 at 00:44:55 UTC, Joel Stanley wrote:
> We cannot build these files with clang as it does not allow altivec
> instructions in assembly when -msoft-float is passed.
> 
> Jinsong Ji <jji@us.ibm.com> wrote:
> > We currently disable Altivec/VSX support when enabling soft-float.  So
> > any usage of vector builtins will break.
> >
> > Enable Altivec/VSX with soft-float may need quite some clean up work, so
> > I guess this is currently a limitation.
> >
> > Removing -msoft-float will make it work (and we are lucky that no
> > floating point instructions will be generated as well).
> 
> This is a workaround until the issue is resolved in clang.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=31177
> Link: https://github.com/ClangBuiltLinux/linux/issues/239
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e213574a449f7a57d4202c1869bbc7

cheers
