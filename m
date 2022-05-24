Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D06C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 10:57:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6rk95Wvnz3cB3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 20:57:05 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6rff1xTnz3bt8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 20:54:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6rff17S4z4ySn;
 Tue, 24 May 2022 20:54:02 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220123120043.3586018-1-npiggin@gmail.com>
References: <20220123120043.3586018-1-npiggin@gmail.com>
Subject: Re: [PATCH 0/6] KVM: PPC: Book3S: Make LPID/nested LPID allocations
 dynamic
Message-Id: <165338950053.1711920.5686369689538346050.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 20:51:40 +1000
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

On Sun, 23 Jan 2022 22:00:37 +1000, Nicholas Piggin wrote:
> With LPID width plumbed through from firmware, LPID allocations can now
> be dynamic, which requires changing the fixed sized bitmap. Rather than
> just dynamically sizing it, switch to IDA allocator.
> 
> Nested KVM stays with a fixed 12-bit LPID width for now, but it is also
> moved to a more dynamic allocator. In future if nested LPID width is
> advertised to a guest it will be simple to take advantage of it.
> 
> [...]

Applied to powerpc/topic/ppc-kvm.

[1/6] KVM: PPC: Remove kvmppc_claim_lpid
      https://git.kernel.org/powerpc/c/18827eeef022df43c1fdeca0fde00ca09405dff1
[2/6] KVM: PPC: Book3S HV: Update LPID allocator init for POWER9, Nested
      https://git.kernel.org/powerpc/c/5d506f159b2b9d0c9bee9bb43ccafb4f291143c2
[3/6] KVM: PPC: Book3S HV: Use IDA allocator for LPID allocator
      https://git.kernel.org/powerpc/c/6ba2a2924dcf6026de5078ba7025248a580d8bde
[4/6] KVM: PPC: Book3S HV Nested: Change nested guest lookup to use idr
      https://git.kernel.org/powerpc/c/c0f00a18e2a8c350a9d263aaf9a2c8bc86caa1b0
[5/6] KVM: PPC: Book3S Nested: Use explicit 4096 LPID maximum
      https://git.kernel.org/powerpc/c/03a2e65f54b3acae37f0992133d2f4d1d35f4200
[6/6] KVM: PPC: Book3S HV: Remove KVMPPC_NR_LPIDS
      https://git.kernel.org/powerpc/c/f104df7d519ff1aa92c7ec87e124c88d4e7574cd

cheers
