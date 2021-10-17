Return-Path: <SRS0=XWqB=PF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C69C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Oct 2021 12:28:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E730461260
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Oct 2021 12:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E730461260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HXK7B1GQhz3cDq
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Oct 2021 23:28:54 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HXK6g4Ztkz2yYd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Oct 2021 23:28:27 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HXK6b2fk7z4xqM;
 Sun, 17 Oct 2021 23:28:23 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Cédric Le Goater <clg@kaod.org>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211011070203.99726-1-clg@kaod.org>
References: <20211011070203.99726-1-clg@kaod.org>
Subject: Re: [PATCH] powerpc/xive: Discard disabled interrupts in
 get_irqchip_state()
Message-Id: <163447368300.1156783.15492137091707859947.b4-ty@ellerman.id.au>
Date: Sun, 17 Oct 2021 23:28:03 +1100
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
Cc: stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 11 Oct 2021 09:02:03 +0200, Cédric Le Goater wrote:
> When an interrupt is passed through, the KVM XIVE device calls the
> set_vcpu_affinity() handler which raises the P bit to mask the
> interrupt and to catch any in-flight interrupts while routing the
> interrupt to the guest.
> 
> On the guest side, drivers (like some Intels) can request at probe
> time some MSIs and call synchronize_irq() to check that there are no
> in flight interrupts. This will call the XIVE get_irqchip_state()
> handler which will always return true as the interrupt P bit has been
> set on the host side and lock the CPU in an infinite loop.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/xive: Discard disabled interrupts in get_irqchip_state()
      https://git.kernel.org/powerpc/c/6f779e1d359b8d5801f677c1d49dcfa10bf95674

cheers
