Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC1FEE4993
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 12:12:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW4q221s2z3fCG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 22:12:46 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW4cq2BxKz3c3x
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2023 22:03:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cq0Lc3z4x2W;
	Wed, 23 Aug 2023 22:03:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <2322dd08217bccab25456fe8b189edf0e6a8b6dd.1692121353.git.christophe.leroy@csgroup.eu>
References: <2322dd08217bccab25456fe8b189edf0e6a8b6dd.1692121353.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/32s: Cleanup the mess in __set_pte_at()
Message-Id: <169279175571.797584.13098002018270735977.b4-ty@ellerman.id.au>
Date: Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 15 Aug 2023 19:42:40 +0200, Christophe Leroy wrote:
> __set_pte_at() handles 3 main cases with #ifdefs plus the 'percpu'
> subcase which leads to code duplication.
> 
> Rewrite the function using IS_ENABLED() to minimise the total number
> of cases and remove duplicated code.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Cleanup the mess in __set_pte_at()
      https://git.kernel.org/powerpc/c/7cb0094be4a5dfb3c91d285977f489d334455e19

cheers
