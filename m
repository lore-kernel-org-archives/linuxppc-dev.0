Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6587C12002
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jul 2021 07:39:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC5B611C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jul 2021 07:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC5B611C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GV6sv2wvSz3bgd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jul 2021 17:39:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GV6sY0W5Wz2yP1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jul 2021 17:39:12 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GV6sX4B2Gz9sXJ; Wed, 21 Jul 2021 17:39:12 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20210716024310.164448-1-npiggin@gmail.com>
References: <20210716024310.164448-1-npiggin@gmail.com>
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S: Fix CONFIG_TRANSACTIONAL_MEM=n crash
Message-Id: <162685313071.1066498.453375758692637604.b4-ty@ellerman.id.au>
Date: Wed, 21 Jul 2021 17:38:50 +1000
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 16 Jul 2021 12:43:09 +1000, Nicholas Piggin wrote:
> When running CPU_FTR_P9_TM_HV_ASSIST, HFSCR[TM] is set for the guest
> even if the host has CONFIG_TRANSACTIONAL_MEM=n, which causes it to be
> unprepared to handle guest exits while transactional.
> 
> Normal guests don't have a problem because the HTM capability will not
> be advertised, but a rogue or buggy one could crash the host.

Applied to powerpc/fixes.

[1/2] KVM: PPC: Book3S: Fix CONFIG_TRANSACTIONAL_MEM=n crash
      https://git.kernel.org/powerpc/c/bd31ecf44b8e18ccb1e5f6b50f85de6922a60de3
[2/2] KVM: PPC: Fix kvm_arch_vcpu_ioctl vcpu_load leak
      https://git.kernel.org/powerpc/c/bc4188a2f56e821ea057aca6bf444e138d06c252

cheers
