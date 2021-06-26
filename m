Return-Path: <SRS0=IFvE=LU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7497C49EA5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 10:39:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566226157E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 10:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566226157E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GBr316qwjz3c1F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 20:39:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GBr2L3lCCz3026
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jun 2021 20:38:50 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GBr2K3Dtbz9sjD; Sat, 26 Jun 2021 20:38:49 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <49f4fb051a3e1cb69f7305d5b6768aec14727c32.1624619582.git.christophe.leroy@csgroup.eu>
References: <49f4fb051a3e1cb69f7305d5b6768aec14727c32.1624619582.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/ptrace: Move set_return_regs_changed() before
 regs_set_return_{msr/ip}
Message-Id: <162470384781.3589875.1784352665925391904.b4-ty@ellerman.id.au>
Date: Sat, 26 Jun 2021 20:37:27 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 25 Jun 2021 11:13:16 +0000 (UTC), Christophe Leroy wrote:
> regs_set_return_msr() and regs_set_return_ip() have a copy
> of the code of set_return_regs_changed().
> 
> Move up set_return_regs_changed() so it can be reused by
> regs_set_return_{msr/ip}

Applied to powerpc/next.

[1/2] powerpc/ptrace: Move set_return_regs_changed() before regs_set_return_{msr/ip}
      https://git.kernel.org/powerpc/c/5f0f95f1e1b64fe55679059837dafb3439b57012
[2/2] powerpc/ptrace: Refactor regs_set_return_{msr/ip}
      https://git.kernel.org/powerpc/c/cae4644673ec5f54c77deab67a57c41395a1539f

cheers
