Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F57C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jan 2022 11:16:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JmBbt31Zhz3cWG
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jan 2022 22:16:42 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JmBZ93RP1z2ymv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jan 2022 22:15:13 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4JmBZ933kZz4xcX;
 Sat, 29 Jan 2022 22:15:13 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220122105530.3477250-1-npiggin@gmail.com>
References: <20220122105530.3477250-1-npiggin@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV Nested: Fix nested HFSCR being
 clobbered with multiple vCPUs
Message-Id: <164345486658.1545234.9360665577761660110.b4-ty@ellerman.id.au>
Date: Sat, 29 Jan 2022 22:14:26 +1100
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
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 22 Jan 2022 20:55:30 +1000, Nicholas Piggin wrote:
> The L0 is storing HFSCR requested by the L1 for the L2 in struct
> kvm_nested_guest when the L1 requests a vCPU enter L2. kvm_nested_guest
> is not a per-vCPU structure. Hilarity ensues.
> 
> Fix it by moving the nested hfscr into the vCPU structure together with
> the other per-vCPU nested fields.
> 
> [...]

Applied to powerpc/fixes.

[1/1] KVM: PPC: Book3S HV Nested: Fix nested HFSCR being clobbered with multiple vCPUs
      https://git.kernel.org/powerpc/c/22f7ff0dea9491e90b6fe808ed40c30bd791e5c2

cheers
