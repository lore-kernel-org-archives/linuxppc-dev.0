Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34477C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:28:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB2F2171F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB2F2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4496gW67zSzDqMf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:28:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4496Vb04rRzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:21:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4496VZ4JGRz9s9L; Thu, 28 Feb 2019 20:21:10 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e7140639b1de65bba435a6bd772d134901141f86
X-Patchwork-Hint: ignore
In-Reply-To: <20190226053855.7020-1-natechancellor@gmail.com>
To: Nathan Chancellor <natechancellor@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc
Message-Id: <4496VZ4JGRz9s9L@ozlabs.org>
Date: Thu, 28 Feb 2019 20:21:10 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, Nathan Chancellor <natechancellor@gmail.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-02-26 at 05:38:55 UTC, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> arch/powerpc/xmon/ppc-dis.c:157:7: warning: variable 'opcode' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>   if (cpu_has_feature(CPU_FTRS_POWER9))
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/xmon/ppc-dis.c:167:7: note: uninitialized use occurs here
>   if (opcode == NULL)
>       ^~~~~~
> arch/powerpc/xmon/ppc-dis.c:157:3: note: remove the 'if' if its
> condition is always true
>   if (cpu_has_feature(CPU_FTRS_POWER9))
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/xmon/ppc-dis.c:132:38: note: initialize the variable
> 'opcode' to silence this warning
>   const struct powerpc_opcode *opcode;
>                                      ^
>                                       = NULL
> 1 warning generated.
> 
> This warning seems to make no sense on the surface because opcode is set
> to NULL right below this statement. However, there is a comma instead of
> semicolon to end the dialect assignment, meaning that the opcode
> assignment only happens in the if statement. Properly terminate that
> line so that Clang no longer warns.
> 
> Fixes: 5b102782c7f4 ("powerpc/xmon: Enable disassembly files (compilation changes)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/390
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e7140639b1de65bba435a6bd772d1349

cheers
