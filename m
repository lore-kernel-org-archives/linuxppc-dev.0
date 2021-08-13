Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9203AC4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 11:59:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44116109D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 11:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C44116109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GmMYC11M4z3cQm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 21:59:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GmMXk5J9lz30HV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Aug 2021 21:59:02 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GmMXf6FRvz9t1s; Fri, 13 Aug 2021 21:58:58 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, fthain@linux-m68k.org,
 npiggin@gmail.com, Michael Ellerman <mpe@ellerman.id.au>, userm57@yahoo.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <aed174f5cbc06f2cf95233c071d8aac948e46043.1628611921.git.christophe.leroy@csgroup.eu>
References: <aed174f5cbc06f2cf95233c071d8aac948e46043.1628611921.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/interrupt: Do not call single_step_exception()
 from other exceptions
Message-Id: <162885586841.2317031.7293234034031355331.b4-ty@ellerman.id.au>
Date: Fri, 13 Aug 2021 21:57:48 +1000
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

On Tue, 10 Aug 2021 16:13:17 +0000 (UTC), Christophe Leroy wrote:
> single_step_exception() is called by emulate_single_step() which
> is called from (at least) alignment exception() handler and
> program_check_exception() handler.
> 
> Redefine it as a regular __single_step_exception() which is called
> by both single_step_exception() handler and emulate_single_step()
> function.

Applied to powerpc/fixes.

[1/1] powerpc/interrupt: Do not call single_step_exception() from other exceptions
      https://git.kernel.org/powerpc/c/01fcac8e4dfc112f420dcaeb70056a74e326cacf

cheers
