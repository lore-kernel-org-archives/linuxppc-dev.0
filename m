Return-Path: <linuxppc-dev+bounces-19920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFA2F94CB8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 23:37:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0f0v32wwz2xll;
	Wed, 22 Apr 2026 09:37:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776813956;
	cv=none; b=oYrkJ9DR0IRxWbat5Q/6INMejjXYgb1wIllHK02jI5vWtuyMAnJLQqmy0biBDYX4azv4GAyy14hBRB+7RiOB1IF8MuL9Vaue2GSWDilP3nxgDX6gKStYGxxFXYYQDn7KVadtCP9V0c8bz4MeC8Ek4qADsdKuON9OAAf0lv22IT1KtVAdx8w+OFkERZFoYZn9V1R4uHimbCJB682Il8IeMclf/qXa4fMPHdrpyUSQQC2j5ZWFI9OaFnwzcd2JIbc+o9vfkv5ABbIo4Ey8xoUnOj3blt1NxBIacnveUTD7haU7GBqMZcxynszEn07KFESmZ8efLK0nwbomNKc+F6L3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776813956; c=relaxed/relaxed;
	bh=53o5l3XdMp0SeTY4rZNGVENqg9Sa8H7qaqELkF5PX+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp4n5L6liLer5/Wp5Shrdop296KZwsdZ+3RWaB5e1j1OkNe/3pDg8QNZ3liLKLZngWO//vGlepfboUgWxwr37epQkcd6guDyeHqNhQBBfpG6EQEN1C+8Z1VYjynN3yXNzyL6Mkw7oGwUHwl3saqRR1twy40Yu9utEJprYcQyiSk/Hkq95j2vaoKYKupyyQ6MvuowmF7jfMNuV1CothePrQIk3vRPpg6HGLEQStbp0u4auWR6ha11lDdsgnQ7hYfxz0vcDSHz3+5wBnErLEql4vPuoyZ5Etfe7AjO8M8uIiEc+84vY8kVYpm4uB65WL/b8k1KHU5kuk4pXQ27+EZoSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=izyOuPOR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=izyOuPOR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=yosry@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0dl76HC9z2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 09:25:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DD91E6001A;
	Tue, 21 Apr 2026 23:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45BEC2BCB0;
	Tue, 21 Apr 2026 23:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776813952;
	bh=elyV3lZqAtgWQ4j9hhssoiVA6LYW5W2kDn6tN9c0c6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izyOuPORTuxjKW5U2mdSF+VAOnjQQgG69VP+OVa5FCQ53AEaa/fE3VfMzK1CHYfmt
	 /F5YMUPGIxO1UaoG0ax3A3jDZaAAX9ASTu030KHSqpGriuZLxJf7bm1qBzKq3G+hvb
	 4N7f70lQFNJPX9CsdlFFl0+iMOcRFnXglJhSu+c9Jgp1VKqATuKJzvKpJYd5k1VqcL
	 ngHDPCLoiz/Iu7XbuMXfqfnR0RsW5UsvsQpKUbB1LKMVaVVgf1t54f+kYKo6xDEdTh
	 KV9eI2uzuAbPTpIQe0VGETkyHxbFYWnjvbw35KQxZykWCOKZKnk0ZkKQNkLQ3j4WHK
	 w6CkKROwLQx+g==
Date: Tue, 21 Apr 2026 23:25:50 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
Message-ID: <aegHZrDn3GouTpZf@google.com>
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com>
 <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com>
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
In-Reply-To: <aegF59gToidudIUC@google.com>

On Tue, Apr 21, 2026 at 04:19:03PM -0700, Sean Christopherson wrote:
> On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> > On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> > > Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() and
> > > kvm_vcpu_map_readonly() so that they take a gpa_t directly, reducing
> > > boilerplate at call sites.
> > > 
> > > __kvm_vcpu_map() still takes a gfn_t because guest page mapping is
> > > fundamentally GFN-based.
> > > 
> > > No functional change intended.
> > > 
> > > Compile-tested on x86 and ppc, which are the current users of these
> > > interfaces.
> > > 
> > > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > > ---
> > 
> > I was going to suggest a WARN in kvm_vcpu_map() and
> > kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but Sean
> > usually hates my paranoid WARN suggestions.
> 
> Heh, for good reason.  Adding such a WARN would be triggered by this code:
> 
>                 if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr, map)) {
>                         vmx->nested.pi_desc =
>                                 (struct pi_desc *)(((void *)map->hva) +
>                                 offset_in_page(vmcs12->posted_intr_desc_addr));
> 
> The PI descriptor only needs to be 64-bit aligned, not page-aligned.

I didn't know that, thanks for pointing out. You meant 64-byte aligned
though, right?

