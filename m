Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E0FC432BE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 13:31:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C694260FD9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 13:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C694260FD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gx0x13kWmz3fsv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 23:31:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ellerman.id.au; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gx0ky3Zpnz30R2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2021 23:22:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0kx4Wypz9t0T;
 Fri, 27 Aug 2021 23:22:49 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
In-Reply-To: <20210811160134.904987-1-npiggin@gmail.com>
References: <20210811160134.904987-1-npiggin@gmail.com>
Subject: Re: (subset) [PATCH v2 00/60] KVM: PPC: Book3S HV P9: entry/exit
 optimisations
Message-Id: <163007018125.52768.7502212191984719774.b4-ty@ellerman.id.au>
Date: Fri, 27 Aug 2021 23:16:21 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 12 Aug 2021 02:00:34 +1000, Nicholas Piggin wrote:
> This reduces radix guest full entry/exit latency on POWER9 and POWER10
> by 2x.
> 
> Nested HV guests should see smaller improvements in their L1 entry/exit,
> but this is also combined with most L0 speedups also applying to nested
> entry. nginx localhost throughput test in a SMP nested guest is improved
> about 10% (in a direct guest it doesn't change much because it uses XIVE
> for IPIs) when L0 and L1 are patched.
> 
> [...]

Applied to powerpc/next.

[01/60] KVM: PPC: Book3S HV: Initialise vcpu MSR with MSR_ME
        https://git.kernel.org/powerpc/c/fd42b7b09c602c904452c0c3e5955ca21d8e387a
[02/60] KVM: PPC: Book3S HV: Remove TM emulation from POWER7/8 path
        https://git.kernel.org/powerpc/c/daac40e8d7a63ab8608132a7cfce411986feac32
[03/60] KVM: PPC: Book3S HV P9: Fixes for TM softpatch interrupt NIP
        https://git.kernel.org/powerpc/c/4782e0cd0d184d727ad3b0cfe20d1d44d9f98239
[04/60] KVM: PPC: Book3S HV Nested: Fix TM softpatch HFAC interrupt emulation
        https://git.kernel.org/powerpc/c/d82b392d9b3556b63e3f9916cf057ea847e173a9
[05/60] KVM: PPC: Book3S HV Nested: Sanitise vcpu registers
        https://git.kernel.org/powerpc/c/7487cabc7ed2f7716bf304e4e97c57fd995cf70e
[06/60] KVM: PPC: Book3S HV Nested: Make nested HFSCR state accessible
        https://git.kernel.org/powerpc/c/8b210a880b35ba75eb42b79dfd65e369c1feb119
[07/60] KVM: PPC: Book3S HV Nested: Stop forwarding all HFUs to L1
        https://git.kernel.org/powerpc/c/7c3ded5735141ff4d049747c9f76672a8b737c49
[08/60] KVM: PPC: Book3S HV Nested: save_hv_return_state does not require trap argument
        https://git.kernel.org/powerpc/c/f2e29db156523bf08a0524e0f4306a641912c6d9
[09/60] KVM: PPC: Book3S HV Nested: Reflect guest PMU in-use to L0 when guest SPRs are live
        https://git.kernel.org/powerpc/c/1782663897945a5cf28e564ba5eed730098e9aa4
[10/60] powerpc/64s: Remove WORT SPR from POWER9/10
        https://git.kernel.org/powerpc/c/0c8fb653d487d2873f5eefdcaf4cecff4e103828

cheers
