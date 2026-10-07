Return-Path: <linuxppc-dev+bounces-28988-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E35CA5FFF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:06:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j080y6m2Bz30Cj;
	Wed, 07 Oct 2026 21:06:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791367602;
	cv=none; b=OGJg3fiJFdbIex23OcUSPryLrez//MXqNOdh58cqGDqKaXZO+X8P7YszHjg+Rv71zwsHz8MwfdAs+2WiMhn62Wtifbz5Jzfh+IYhEFpXT9mxlGFMih1Uq00IHLf9fHsLe4p5nJ+P5HG9KjUqViUhjlV8aTtO1OV/9UZpKHVNhsrD5+aDTD1ESc34UDv7UsnGort6r/LNhzMTT32y0BeXsIw9cqgHIxRPwon0GCewfcld4FzogL5lH1oLLFyL4vtJ6S/9rOlA+zWnZFjNE2nUCefRNxCyKjvay6ykffDOuezmrbeRgQCOJqo/ZeTc2GLGb9i9FL4lxnd+YWlg4HMzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791367602; c=relaxed/relaxed;
	bh=APsB50ihhU3A5Y/b7mc2nvs0/aMHP/B00/9rsQ9YSxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKr2x0RvI1xJpExknEbAKIy0BwDZtVoIBmdv7mBn47HHrzUS1TTezWwTD1U5qKGezPW/3Ij9QHF/bQyl/SMIJ+LDt5JhgMzcp7U6llGR+JXscp/llFdH2+P1RnXSSZ7f10Qy48/2SDxC3kUT+ddC24Y5DJKgn3KbWEmk80Aqe8Er+BbpBj5r1UfCmjFgens7NJPcJJIp2ExMNLKjvrSSFsSmU3mPcO8XAbyTp7I/0SefAyMYwGX6al270/KwiUqcKBief50Sn1gyKoTCcIp0uo2tDn0tjykPbksBvZVh2E3DLGNQLFiWRghVHXUnKSgtDm3ajHmDAb0z8GfH8V9oGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Peb6+4o/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Peb6+4o/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j080x5KsPz30CZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 21:06:41 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E91EF601FF;
	Wed,  7 Oct 2026 10:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9BE1F0089B;
	Wed,  7 Oct 2026 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791367598;
	bh=APsB50ihhU3A5Y/b7mc2nvs0/aMHP/B00/9rsQ9YSxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Peb6+4o/Fn/871ib2bcjk6CVPyHsZ+t3auV/PL1ronyahYmQVdjngxwCs6X//kxNr
	 YK0UXr80xdGYqWr//KVL1FP4ErY2mQ3/Yi0Hp9C4cZAaaJzP6pe2wFn2Tled1Abeyf
	 fvf0gD+qSIk1LN2XC3lJzu/OlZ4x9OhnY3BNyumK3QDKj3ncenA92PbkY0hxofvgVj
	 uu4kbhRA5MxkCbm2sFKurjTlNHl1IObRD+Qg9PBEwxFOMB5nZa6E2Au4YzlJ8FcMtm
	 yR2R2CBs6YwiLLbvPt8TRczYHbMIOkmBaWOy0pOXhldTOrH8Nvq6G872nFft8g6/sf
	 d7GT5kCx2W/cg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xEOXk-00000000Den-0sAt;
	Wed, 07 Oct 2026 10:06:36 +0000
From: Marc Zyngier <maz@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Oliver Upton <oupton@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Will Deacon <will@kernel.org>,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] KVM: Replace VCPU_RUN with KVM_RUN in comments and docs
Date: Wed,  7 Oct 2026 11:06:33 +0100
Message-ID: <179136758616.696606.4614783559462928506.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915084441.3846947-1-fuad.tabba@linux.dev>
References: <20260915084441.3846947-1-fuad.tabba@linux.dev>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: pbonzini@redhat.com, oupton@kernel.org, maddy@linux.ibm.com, fuad.tabba@linux.dev, seanjc@google.com, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, seiden@linux.ibm.com, npiggin@gmail.com, will@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 15 Sep 2026 09:44:38 +0100, Fuad Tabba wrote:
> This one has been bugging me for a while. Five comments and doc lines
> name a VCPU_RUN ioctl (KVM_VCPU_RUN in book3s_hv.c, VCPU RUN in
> kvm_host.h). The ioctl that enters the guest is KVM_RUN.
> 
> The patches are independent and split by tree, one each for generic
> KVM, KVM/arm64 and Book3S HV, so each can go through its own
> maintainer. Nothing else in the tree refers to the ioctl by a wrong
> name.
> 
> [...]

Applied to next, thanks!

[1/3] KVM: Fix comments that refer to the non-existent VCPU_RUN ioctl
      commit: 8233000034a630432a7da0311d94e8725207a095
[2/3] KVM: arm64: Fix references to the non-existent VCPU_RUN ioctl
      commit: 0ab1034969130967bda8e6eab5b8dd6745604f1b
[3/3] KVM: PPC: Book3S HV: Fix comment naming a non-existent KVM_VCPU_RUN ioctl
      commit: 6ce8b5c0effb227f5625b35965c0f74c0e953efb

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



