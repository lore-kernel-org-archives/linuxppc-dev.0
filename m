Return-Path: <SRS0=iuvT=5L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE7C43331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 13:01:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0252320737
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 13:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0252320737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48p4qM27RGzDqBc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2020 00:01:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48p3d44zGGzDqd0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2020 23:07:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48p3d34sgtz9sRY; Thu, 26 Mar 2020 23:07:02 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: af6cf95c4d003fccd6c2ecc99a598fb854b537e7
In-Reply-To: <20200323222729.15365-1-natechancellor@gmail.com>
To: Nathan Chancellor <natechancellor@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/maple: Fix declaration made after definition
Message-Id: <48p3d34sgtz9sRY@ozlabs.org>
Date: Thu, 26 Mar 2020 23:07:02 +1100 (AEDT)
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
Cc: Ilie Halip <ilie.halip@gmail.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 clang-built-linux@googlegroups.com,
 Nathan Chancellor <natechancellor@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2020-03-23 at 22:27:29 UTC, Nathan Chancellor wrote:
> When building ppc64 defconfig, Clang errors (trimmed for brevity):
> 
> arch/powerpc/platforms/maple/setup.c:365:1: error: attribute declaration
> must precede definition [-Werror,-Wignored-attributes]
> machine_device_initcall(maple, maple_cpc925_edac_setup);
> ^
> 
> machine_device_initcall expands to __define_machine_initcall, which in
> turn has the macro machine_is used in it, which declares mach_##name
> with an __attribute__((weak)). define_machine actually defines
> mach_##name, which in this file happens before the declaration, hence
> the warning.
> 
> To fix this, move define_machine after machine_device_initcall so that
> the declaration occurs before the definition, which matches how
> machine_device_initcall and define_machine work throughout arch/powerpc.
> 
> While we're here, remove some spaces before tabs.
> 
> Fixes: 8f101a051ef0 ("edac: cpc925 MC platform device setup")
> Link: https://godbolt.org/z/kDoYSA
> Link: https://github.com/ClangBuiltLinux/linux/issues/662
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Ilie Halip <ilie.halip@gmail.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/af6cf95c4d003fccd6c2ecc99a598fb854b537e7

cheers
