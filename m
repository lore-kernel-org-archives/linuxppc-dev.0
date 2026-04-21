Return-Path: <linuxppc-dev+bounces-19918-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ACBF94CB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 23:37:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0f0d6l9Kz2yv8;
	Wed, 22 Apr 2026 09:37:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776812769;
	cv=none; b=CFRVH3m/f8c9cMAsddfuHecR8csA5rBGxU6TzHvxygX88ji8+6m+tBeS4BiQdh2I55aMp9InoyJmjROa0VHddHbf2XvC30Qis9CNuIBCOWa3pAz/sQlsqoiJ7MU71HhLhjIyLrgap9E8Jw7jFwK7iULJAtuloQyDEwXUNS0yo1LIx6sJXqao7f1MU4c10zxyG9kPglTIW5PV9NT4ho7hj8a9IpgbGEVi04GwdL6nNr2bKpF2eIv3HFM9MB5QEDZgWe6Oy72Uvf3qoMwpYovYgYueBlHr+41uxCZNAafXkkMhDsG3AmBY6AdTHcuOakyXPnqj262E2CzBzEXR4G1lwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776812769; c=relaxed/relaxed;
	bh=x/2w7nZXQtHkDSbqu+uDLAFk6D4YH0JISn73mzQBpOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLmpOR4gaGzgjKF3tf8UjmSLY/FJRm/9QhpBXe6gqelRuwlQfnxaDa+pqVOwLzJ/yTlJrd1YrnV22MwErdBux7JdfyhvVyGlQcvbWBM5V9lsskGwAc1DKn9iy6XnKBbpymqHCX5cGAq1T18WgqmGVhUT2zDEpB5/FkctgpLUCuJn2qgluemYSSXILnif3n96u6AfKGkl9aMPNWw3KP+fH8GZdyPe5i3sWPiV2i7V/NeraRE6+m3X1wBSYWrZqENIQiOl212fgKAf+RFwTAoEwTsVS/Kd7S1mJrau8PoNyCZA1Eqp+LOOl0XlxXfXIRWfmOI+ADEtKkqgCT4EJf7ZPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MSj+0VTw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MSj+0VTw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0dJK1gWVz30Vv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 09:06:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 92EA1404E0;
	Tue, 21 Apr 2026 23:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD04DC2BCB0;
	Tue, 21 Apr 2026 23:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776812767;
	bh=gUOrA+M0eFDlj+4WAivTq7ytG3D4fdUcuYjNEftzc+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSj+0VTwb0esKAJE8jTRYdvwem8owfsQeuNUbdBCA0mASigg5aM/ZfLOYSxCYsfk1
	 eFjaQLMZfdh0X3WGysk21K7k2PIzscSMSDkNsZATjXaML7fPbHlcNMUPAsbBBbjm8M
	 veQ8RZmlwvO/REju1uSNBE8AMplYve51cS+ZtFQT7Mf5XAp/eRvZFhDRjztO5X8Qgk
	 Qq4456aHr4YRMIfSHYuIFAznsus83YUSnAUUzpDm6HSrBzP9U2shpmNmZXvTzPYVxm
	 HkLHbpdHbeyWE0FbY/NORE4zT/8rP1p/2QokfM24MFm1sNBvHQUkOGcIsClAK45qhQ
	 BCv9Y9pLlvuEw==
Date: Tue, 21 Apr 2026 23:06:05 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: Move page mapping/unmapping APIs in
 kvm_host.h
Message-ID: <aegC2AONVg7PVf2T@google.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-3-peter.fang@intel.com>
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
In-Reply-To: <20260408001137.3290444-3-peter.fang@intel.com>

On Tue, Apr 07, 2026 at 05:11:29PM -0700, Peter Fang wrote:
> Move kvm_vcpu_map*() and kvm_vcpu_unmap() so that a subsequent refactor
> can use gpa_to_gfn() without a forward declaration.
> 
> No functional change intended.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

