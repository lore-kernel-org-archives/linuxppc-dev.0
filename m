Return-Path: <linuxppc-dev+bounces-19919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64985F94CB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 23:37:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0f0m1bHwz2xTh;
	Wed, 22 Apr 2026 09:37:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776812903;
	cv=none; b=g9nFZEdXpzkR7Ax1uwgi5vhMkg8BQeO/1aEByUXfpFiZXeLG/HtSZKOkiXQZTJc1HwXGSyWPDzN3IvMDxP04NvN7zsYNSbNLrzFOCix9uUs0khqzk3lIlmvW7WVrgsmMPwVp/dX5bhwVPNGHCYviPVY3NqvUCPo7MocF3uXcnFAdj+GkRProi3ND5aJT0N8aQ2rv3PA6xgFH8LBxsBfkSwjj0AOnLxBW5hc3SaQ+4o0M3dn35LegsjMrRYjWIQiwe50MrRofYDU8acfs69FKG/H6/RwOloITn5urkg4ffmrT0Vzk3ACf/mCIGT/jObzTkaYtJ4uBeAuz+7t276NJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776812903; c=relaxed/relaxed;
	bh=lsBekN0KFTH+iM1nqERyJjWnU/VNecFn+8/t8tv1KCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euCp0BedlesbbAjZBvE8JL0fapH6qtc10pepKbB+NOMsbhO7ECiTgkOBDDAWF5JMZTDn+vjKBuaHxGs9lWyVl3IgrJhPxl1jdyAqlmGBQZ5+OsgZTlNt7gyJEvYgDLKiuGwE9N5ukN+PcQ1mJUJRXeQq+2Wusi6Zke2Iwbe8bQDisFFQnSpxgFkPHNOUv/M5D1ItIFSdx3YRIxkPq1EIbwezfEdNY0HWJ1W+plAmS6C1OHS/axCu6yqXv57jRVnxZ9mr/re2DA0ybORtnajCvzJsrBfGDYZGJVHqEKBqw5hOl8omryiaXrEez+I4phdnM8EQ2wAQFTi+dk8bfTvSDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QimX6+fh; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QimX6+fh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0dLt2gJGz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 09:08:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ED8CC4397D;
	Tue, 21 Apr 2026 23:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31973C2BCB0;
	Tue, 21 Apr 2026 23:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776812899;
	bh=3haRLR32clrUrLelGZTHqQcAvYqt3tzlUROwSRS6gLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QimX6+fhUsP2TXEKtnM74nt1kfQkSnbLJfPabpsF5HVm6D93J8N5hjDfq0rDA1mvu
	 RYu+cQ7APnPg+82feP1kAsBIU17u6sY3fhQJUfOB2XCMcBG2b/WUdTDtYNk0zFOkBe
	 lR78a/fkmg5zTECg2FwXISf5diqacoDRSIKAX3DlC04Hy5JhaQ4QupCj9bfMa5yOnm
	 3OfkL+r1PU8Yu9XI67xU/B7AFPxe4IHSd3bzP/Bb7SQ+WD6dgeGeLbGutcVXUbobUm
	 7Aah1UVsPUFWMbtO3K+vKkjKzMYTNcDqXDfbqQA5HX6V+yJZHnm3/iIA+nvje//Tgr
	 4a3icoU8O+Nbw==
Date: Tue, 21 Apr 2026 23:08:17 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
Message-ID: <aegDJssx-ZvbfggI@google.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com>
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
In-Reply-To: <20260408001137.3290444-4-peter.fang@intel.com>

On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducing
> boilerplate at call sites.
> 
> __kvm_vcpu_map() still takes a gfn_t because guest page mapping is
> fundamentally GFN-based.
> 
> No functional change intended.
> 
> Compile-tested on x86 and ppc, which are the current users of these
> interfaces.
> 
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> ---

I was going to suggest a WARN in kvm_vcpu_map() and
kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but Sean
usually hates my paranoid WARN suggestions.

Anyway:
Reviewed-by: Yosry Ahmed <yosry@kernel.org>

