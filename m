Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DD8C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 10:56:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6rjm1nv0z3chP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 20:56:44 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6rfd4HdQz3brx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 20:54:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6rfd3Z1zz4xYY;
 Tue, 24 May 2022 20:54:01 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220303053315.1056880-1-npiggin@gmail.com>
References: <20220303053315.1056880-1-npiggin@gmail.com>
Subject: Re: [PATCH 0/6] KVM: PPC: Book3S HV interrupt fixes
Message-Id: <165338950547.1711920.6804386197310741563.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 20:51:45 +1000
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
Cc: Cédric Le Goater <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 3 Mar 2022 15:33:09 +1000, Nicholas Piggin wrote:
> This series fixes up a bunch of little interrupt issues which were found
> by inspection haven't seem to have caused big problems but possibly
> could or could cause the occasional latency spike from a temporarily lost
> interrupt.
> 
> The big thing is the xive context change. Currently we run an L2 with
> its L1's xive OS context pushed. I'm proposing that we instead treat
> that as an escalation similar to cede.
> 
> [...]

Patches 2-6 applied to powerpc/topic/ppc-kvm.

[2/6] KVM: PPC: Book3S HV P9: Inject pending xive interrupts at guest entry
      https://git.kernel.org/powerpc/c/026728dc5d41f830e8194fe01e432dd4eb9b3d9a
[3/6] KVM: PPC: Book3S HV P9: Move cede logic out of XIVE escalation rearming
      https://git.kernel.org/powerpc/c/ad5ace91c55e7bd16813617f67bcb7619d51a295
[4/6] KVM: PPC: Book3S HV P9: Split !nested case out from guest entry
      https://git.kernel.org/powerpc/c/42b4a2b347b09e7ee4c86f7121e3b45214b63e69
[5/6] KVM: PPC: Book3S HV Nested: L2 must not run with L1 xive context
      https://git.kernel.org/powerpc/c/11681b79b1ab52e7625844d7ce52c4d5201a43b2
[6/6] KVM: PPC: Book3S HV Nested: L2 LPCR should inherit L1 LPES setting
      https://git.kernel.org/powerpc/c/2852ebfa10afdcefff35ec72c8da97141df9845c

cheers
