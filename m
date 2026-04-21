Return-Path: <linuxppc-dev+bounces-19917-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8214DF94CB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 23:37:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0f0Z70WFz2xTh;
	Wed, 22 Apr 2026 09:37:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776812738;
	cv=none; b=WbjmbVeqxvGGhwA2zDeEWD21R7DsdtaMKMDFf2juBGJHJKaYhxipCa0b3HFZyxMKy0FfGabzxekBWmYQs/fg/F6uIEu5MQfvvph9liB53XNwRGQtC1yFtHwLTslyUrevM3K7EarBztNfyaPdvyzdkdaGNS9gPIh4T5jHp6k6xhkA94SiA6jktFw1lpXWVOnokupKGYEGFuNBwJLHMvIB/wWUBhX9/CRiHEzQeNrUCgRhp8Yfm58UnODTDozt2KXHehuKmiFuIRMFYz2QTiS+KYsXa53s5iyIk6eB8l5/eTj+2IkjbVbJ78lk0P1Omb3Odrx7+A5z8O57DQ/qLYsATA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776812738; c=relaxed/relaxed;
	bh=SUtbsdRPa1DKbOWO0sGa8B0mjaWhWxg/KbPKt4E/G8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8SCoAcBqPFTQfbC0kVakgTR6srGtl/plworPCsawLVWWxFcam9WyRs3WhpUZGvJrwIPOU/FV44/xUFI8b+JqOboloytqYQzpQgtjmPMZrsd+gm3IOupVv0dKkyuTcjsHwxr/FhHLkxlxTuWF/utmNL9NjYr8DATYDJT9SyxTm5cmgpdhUlWQSLrWco1VGSucuSPYgfpyYDQyMNBtxypNWW0m/yB1QclBmxvRayRSFAmLVojUKhGuOY1s9JAxl80fp3uMoWBVjLh3TlQ8iWAYEOwTSWcLVQTxfMKK9fwOu1SGO10UqBdExcH9NU4SaRDSbmhTUT55kImqPStnLJsCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PNn2AdNS; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PNn2AdNS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0dHj3Kxpz30Vv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 09:05:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AD4E040615;
	Tue, 21 Apr 2026 23:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0715C2BCB0;
	Tue, 21 Apr 2026 23:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776812734;
	bh=z1GjpyCzOqlqSWUtL6FZ2ZzqvyWbTkYx0VfbXFhH2ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNn2AdNSNu9pm+CpZmzNYnVdWGsUx4ElgwpwT5tyl3ZbxBXnR3W5caZotDQ8KW+77
	 Qb4Oq/GPi9+1HPO5dM7vjMJcEgx1uwcesf2m9dtjLR2lRAcl/DgAZFPeWnclcMvzfK
	 1S622cN1WegX6iUDG2CyagYoyZQUGGv2bWoGwEz3VfY/ScmVOTrJoy5ZZYr9FhAIO5
	 wSYQnhTbnBKD0seKDLwGIcLBb/0DYZMM47da/y0tLsHyof+ExyAkHGqx+DPNjZyklo
	 YebH/drrNRznIMOqumn30sGDrUX/pEixBgJR4l9XmJto0B843W5vuoAOjVlZbfIA3i
	 /VhMygYk5ZZsg==
Date: Tue, 21 Apr 2026 23:05:32 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	KarimAllah Ahmed <karahmed@amazon.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v2 1/3] KVM: Fix kvm_vcpu_map[_readonly]() function
 prototypes
Message-ID: <aegCsnPq3-P6XBWp@google.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-2-peter.fang@intel.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408001137.3290444-2-peter.fang@intel.com>

On Tue, Apr 07, 2026 at 05:11:28PM -0700, Peter Fang wrote:
> kvm_vcpu_map() and kvm_vcpu_map_readonly() should take a gfn instead of
> a gpa. This appears to be a result of the original kvm_vcpu_map() being
> declared with the wrong function prototype in kvm_host.h, even though
> it was correct in the actual implementation in kvm_main.c.
> 
> No actual harm has been done yet as all of the call sites are correctly
> passing in a gfn. Plus, both gfn_t and gpa_t are typedef'd to u64 so
> this change shouldn't have any functional impact.
> 
> Compile-tested on x86 and ppc, which are the current users of these
> interfaces.
> 
> Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

