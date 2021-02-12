Return-Path: <SRS0=Xeze=HO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1152DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 00:22:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E2A64DDA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 00:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E2A64DDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DcDhp1vNBzDwtV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 11:22:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DcDf00RvtzDvZ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2021 11:19:52 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DcDdz4ktxz9sS8; Fri, 12 Feb 2021 11:19:51 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210202091541.36499-1-aik@ozlabs.ru>
References: <20210202091541.36499-1-aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/kuap: Restore AMR after replaying soft
 interrupts
Message-Id: <161308903938.3606979.4844568618517108372.b4-ty@ellerman.id.au>
Date: Fri, 12 Feb 2021 11:19:51 +1100 (AEDT)
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2 Feb 2021 20:15:41 +1100, Alexey Kardashevskiy wrote:
> Since de78a9c "powerpc: Add a framework for Kernel Userspace Access
> Protection", user access helpers call user_{read|write}_access_{begin|end}
> when user space access is allowed.
> 
> 890274c "powerpc/64s: Implement KUAP for Radix MMU" made the mentioned
> helpers program a AMR special register to allow such access for a short
> period of time, most of the time AMR is expected to block user memory
> access by the kernel.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kuap: Restore AMR after replaying soft interrupts
      https://git.kernel.org/powerpc/c/60a707d0c99aff4eadb7fd334c5fd21df386723e

cheers
