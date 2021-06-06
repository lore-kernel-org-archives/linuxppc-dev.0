Return-Path: <SRS0=3A4D=LA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240BCC47096
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 12:17:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61C4611CA
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 12:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61C4611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fyb9p0Gn8z3bvS
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 22:17:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fyb3P6wJ9z3bsb
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Jun 2021 22:12:17 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Fyb3N2vCrz9sXh; Sun,  6 Jun 2021 22:12:16 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nick Desaulniers <ndesaulniers@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20210518205858.2440344-1-ndesaulniers@google.com>
References: <20210518205858.2440344-1-ndesaulniers@google.com>
Subject: Re: [PATCH] powerpc: Kconfig: disable CONFIG_COMPAT for clang < 12
Message-Id: <162298132108.2353459.12234342332245763294.b4-ty@ellerman.id.au>
Date: Sun, 06 Jun 2021 22:08:41 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Fangrui Song <maskray@google.com>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, clang-built-linux@googlegroups.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 18 May 2021 13:58:57 -0700, Nick Desaulniers wrote:
> Until clang-12, clang would attempt to assemble 32b powerpc assembler in
> 64b emulation mode when using a 64b target triple with -m32, leading to
> errors during the build of the compat VDSO. Simply disable all of
> CONFIG_COMPAT; users should upgrade to the latest release of clang for
> proper support.

Applied to powerpc/next.

[1/1] powerpc: Kconfig: disable CONFIG_COMPAT for clang < 12
      https://git.kernel.org/powerpc/c/6fcb574125e673f33ff058caa54b4e65629f3a08

cheers
