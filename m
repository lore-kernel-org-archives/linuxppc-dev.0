Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55426C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:50:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03CA60F56
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E03CA60F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7Wy4Hzzz3gbk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:50:54 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7G51l9nz3c5l
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7G50vTTz4xdk;
 Tue,  2 Nov 2021 22:38:53 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211027142150.3711582-1-npiggin@gmail.com>
References: <20211027142150.3711582-1-npiggin@gmail.com>
Subject: Re: [PATCH v3] KVM: PPC: Tick accounting should defer vtime
 accounting 'til after IRQ handling
Message-Id: <163584792636.1845480.13123801071900651705.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:12:06 +1100
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
Cc: Laurent Vivier <lvivier@redhat.com>, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 28 Oct 2021 00:21:50 +1000, Nicholas Piggin wrote:
> From: Laurent Vivier <lvivier@redhat.com>
> 
> Commit 112665286d08 ("KVM: PPC: Book3S HV: Context tracking exit guest
> context before enabling irqs") moved guest_exit() into the interrupt
> protected area to avoid wrong context warning (or worse). The problem is
> that tick-based time accounting has not yet been updated at this point
> (because it depends on the timer interrupt firing), so the guest time
> gets incorrectly accounted to system time.
> 
> [...]

Applied to powerpc/next.

[1/1] KVM: PPC: Tick accounting should defer vtime accounting 'til after IRQ handling
      https://git.kernel.org/powerpc/c/235cee162459d96153d63651ce7ff51752528c96

cheers
