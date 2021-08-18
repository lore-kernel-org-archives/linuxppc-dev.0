Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E52C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:52:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762CA60238
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 762CA60238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqTqP19fHz3dCd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 23:52:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqTgy13Mzz3cW7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 23:46:06 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GqTgx1N3Mz9t0J; Wed, 18 Aug 2021 23:46:04 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Masahiro Yamada <masahiroy@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20210729141937.445051-1-masahiroy@kernel.org>
References: <20210729141937.445051-1-masahiroy@kernel.org>
Subject: Re: [PATCH 1/3] powerpc: remove unused zInstall target from
 arch/powerpc/boot/Makefile
Message-Id: <162929389129.3619265.1911733142384487798.b4-ty@ellerman.id.au>
Date: Wed, 18 Aug 2021 23:38:11 +1000
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
Cc: Jordan Niethe <jniethe5@gmail.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 Bill Wendling <morbo@google.com>, Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 29 Jul 2021 23:19:35 +0900, Masahiro Yamada wrote:
> Commit c913e5f95e54 ("powerpc/boot: Don't install zImage.* from make
> install") added the zInstall target to arch/powerpc/boot/Makefile,
> but you cannot use it since the corresponding hook is missing in
> arch/powerpc/Makefile.
> 
> It has never worked since its addition. Nobody has complained about
> it for 7 years, which means this code was unneeded.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc: remove unused zInstall target from arch/powerpc/boot/Makefile
      https://git.kernel.org/powerpc/c/156ca4e650bfb9a4259b427069caa11b5a4df3d4
[2/3] powerpc: make the install target not depend on any build artifact
      https://git.kernel.org/powerpc/c/9bef456b20581e630ef9a13555ca04fed65a859d
[3/3] powerpc: move the install rule to arch/powerpc/Makefile
      https://git.kernel.org/powerpc/c/86ff0bce2e9665c8b074930fe6caed615da070c1

cheers
