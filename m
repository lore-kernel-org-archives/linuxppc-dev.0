Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1817C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Oct 2022 13:56:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhfPZ3WCXz3c74
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Oct 2022 00:56:18 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mhf1m2ZGFz3dsK
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2022 00:39:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1m1Q1Pz4xHY;
	Wed,  5 Oct 2022 00:39:08 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220908132545.4085849-1-npiggin@gmail.com>
References: <20220908132545.4085849-1-npiggin@gmail.com>
Subject: Re: (subset) [PATCH 1/5] KVM: PPC: Book3S HV P9: Clear vcpu cpu fields before enabling host irqs
Message-Id: <166488996162.779920.16826184817213539665.b4-ty@ellerman.id.au>
Date: Wed, 05 Oct 2022 00:26:01 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 8 Sep 2022 23:25:41 +1000, Nicholas Piggin wrote:
> On guest entry, vcpu->cpu and vcpu->arch.thread_cpu are set after
> disabling host irqs. On guest exit there is a window whre tick time
> accounting briefly enables irqs before these fields are cleared.
> 
> Move them up to ensure they are cleared before host irqs are run.
> This is possibly not a problem, but is more symmetric and makes the
> fields less surprising.
> 
> [...]

Patch 5 applied to powerpc/next.

[5/5] KVM: PPC: Book3S HV: Implement scheduling wait interval counters in the VPA
      https://git.kernel.org/powerpc/c/e4335f53198fa0c0aefb2a38bb5518e94253412c

cheers
