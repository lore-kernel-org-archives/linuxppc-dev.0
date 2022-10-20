Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDF7C4332F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Oct 2022 10:02:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtNSW3QQCz3drb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Oct 2022 21:02:35 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtNRx0cmJz3c69
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2022 21:02:05 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MtNRv2hfsz4xGQ;
	Thu, 20 Oct 2022 21:02:03 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Haren Myneni <haren@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, fbarrat@linux.ibm.com
In-Reply-To: <aaad8813b4762a6753cfcd0b605a7574a5192ec7.camel@linux.ibm.com>
References: <aaad8813b4762a6753cfcd0b605a7574a5192ec7.camel@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries/vas: Add VAS IRQ primary handler
Message-Id: <166626010855.237349.2129238862469049267.b4-ty@ellerman.id.au>
Date: Thu, 20 Oct 2022 21:01:48 +1100
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

On Sun, 09 Oct 2022 20:41:25 -0700, Haren Myneni wrote:
> irq_default_primary_handler() can be used only with IRQF_ONESHOT
> flag, but the flag disables IRQ before executing the thread handler
> and enables it after the interrupt is handled. But this IRQ disable
> sets the VAS IRQ OFF state in the hypervisor. In case if NX faults
> during this window, the hypervisor will not deliver the fault
> interrupt to the partition and the user space may wait continuously
> for the CSB update. So use VAS specific IRQ handler instead of
> calling the default primary handler.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries/vas: Add VAS IRQ primary handler
      https://git.kernel.org/powerpc/c/89ed0b769d6adf30364f60e6b1566961821a9893

cheers
