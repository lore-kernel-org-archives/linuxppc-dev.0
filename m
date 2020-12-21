Return-Path: <SRS0=4INi=FZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E40C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Dec 2020 11:25:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7C7227BF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Dec 2020 11:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7C7227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CzxwV6JDkzDqCk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Dec 2020 22:25:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CzxR70xStzDqNg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2020 22:03:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CzxR66P7qz9sW9; Mon, 21 Dec 2020 22:03:30 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, Leonardo Bras <leobras.c@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20201208215707.31149-1-leobras.c@gmail.com>
References: <20201208215707.31149-1-leobras.c@gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc/kvm: Fix mask size for emulated msgsndp
Message-Id: <160854857761.1696279.18011483882082447442.b4-ty@ellerman.id.au>
Date: Mon, 21 Dec 2020 22:03:30 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 8 Dec 2020 18:57:08 -0300, Leonardo Bras wrote:
> According to ISAv3.1 and ISAv3.0b, the msgsndp is described to split RB in:
> msgtype <- (RB) 32:36
> payload <- (RB) 37:63
> t       <- (RB) 57:63
> 
> The current way of getting 'msgtype', and 't' is missing their MSB:
> msgtype: ((arg >> 27) & 0xf) : Gets (RB) 33:36, missing bit 32
> t:       (arg &= 0x3f)       : Gets (RB) 58:63, missing bit 57
> 
> [...]

Applied to powerpc/next.

[1/1] KVM: PPC: Book3S HV: Fix mask size for emulated msgsndp
      https://git.kernel.org/powerpc/c/87fb4978ef8f7e3d6f51ea8e259638c4e96f2fc0

cheers
