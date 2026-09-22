Return-Path: <linuxppc-dev+bounces-27946-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3A8C98302
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 19:19:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq8z63LJBz2ygK;
	Wed, 23 Sep 2026 05:18:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790104738;
	cv=none; b=SZfDnRqNDHn0Bihn8T4sPuoTI9sBLNr+xlpGIQnnTBA+9nzw4W6hbEAWeYKnmorr+56Fc/clfpuLDiUv7CD9z5UkT+XB+/BTrXaC/aW2f+bI7aqw7JMD9pFIpmppOlnoYOYKpgCi1e/kukEeA5o3QMC/H5G9wO+rCqRIw+4Bib44zveULR2/Xc9qtmDsHrM5hRVPoJYR8maxu7JvbmBUFnf0oa7cnvrLFq+C2oQoAf6r1AEgoZKE6X084fTUGWiyqFHzqljZuZVTyRPziHoGGVENR8uv9IU9V469l1jBI3l0vPRgECYn6w9DhceNJZT7c2OB7QQLxGb2FG8KUh+Rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790104738; c=relaxed/relaxed;
	bh=rG9jdeE1GgpZ721Ylayiu0WJux0e9upMn4hAQNazN1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lovOCSIQKuOY2suoquLF++Ly86mIbZs6dJxE0DwwFfZpgk9TzdUtYHywbqYJyoAQwzWkeyASd7RB1q0fRAr0hq8ja1a7d5YlWuansjKMkqxHbDdG13y0XOe0w86d2HiWo/d9RrC5TD5gFzg4Adp19VAehIotIey/9RJXZNaMFmf9uJTn1lgJUeZVQwnY7uANtapGBFzVxJCSfB3l1J7mabc5GiyO3VaZKbsmN/KsUYoIDOXgeXBnzkTHkIZv7WrB0ufHrKco639WxfGLaVhkzJphqsQrjh3rLLKvyCvn9hbjCODAeKB3mOU+bxfLNc2Rn2r4VfjdgGMnvw/MX/gSzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVZNMwZy; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=naveen@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVZNMwZy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=naveen@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq8z527g3z2ySj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 05:18:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B1A71401D6;
	Tue, 22 Sep 2026 19:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB921F00893;
	Tue, 22 Sep 2026 19:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790104733;
	bh=rG9jdeE1GgpZ721Ylayiu0WJux0e9upMn4hAQNazN1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nVZNMwZymUoYnWyP9PHedZApvviQf4Cvlsyp/06Z2xBBaXCbkfJh1lO8fG0QPlX5E
	 9CbIKE3oQ3X5YPwWe1ZvPlL9d+D8/0kHepKHOdR3CyJBFJGMaDljbvuVYus4pjWJKP
	 qGYOQBGbQDWJSkiTYQCy1L9lvKTdbg5G0OLyjJWqJA/VSlMLlMVLUapYFccALw2jP9
	 hXmVSigBJMTg0tgCDzSp/ymC8iFI0b80Wa764Lnt6nrXofGRVGZ8AnqYl3ShLMmvR2
	 vj2DahjSlvc6WSBMpR8dtdWGcJAc7tuOkrmINccYugToUbmJjd1TseNI0Woo4pazI2
	 GCbNy1MCv7Q/w==
Date: Wed, 23 Sep 2026 00:45:39 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, =?utf-8?B?UGF3ZcWC?= S <spawel523@gmail.com>
Subject: Re: [PATCH v2 0/7] KVM: Serialize vCPU creation and revert vcpu_ids
 tracking
Message-ID: <arLSZuDixbzXrevV@blrnaveerao1>
References: <20260921174445.911676-1-seanjc@google.com>
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
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>

On Mon, Sep 21, 2026 at 10:44:38AM -0700, Sean Christopherson wrote:
> Serialize vCPU creation by holding kvm->lock for the entirety of
> kvm_vm_ioctl_create_vcpu(), and then revert the now-redundant tracking adding
> by commit 97d65b544f48 ("KVM: Check for duplicate vcpu_id as early as
> possible").  I botched the math when justifying the vcpu_ids tracking; it's not
> an extra 256 bytes, it's an extra 2048 bytes.  Roughly doubling the size of
> "struct kvm" tripped x86's KVM_SANITY_CHECK_VM_STRUCT_SIZE, and obviously isn't
> something we want to do in general.
> 
> The TL;DR of why it's a-ok to serialize vCPU creation is that no VMM actually
> does parallel vCPU creation.  As with so many things, KVM's current behavior is
> the result of decades-old cruft, not intentional, deliberate design.
> 
> Patches 1-3 are a tangentially related cleanups and bug fixes; I included them
> here because holding kvm->lock for all of vCPU creation allows WARNing if KVM
> attempts to lock all vCPUs if vCPU creation is in-progress (the caller must
> hold kvm->lock).
> 
> v2:
>  - Tweak patch 1's changelog to clarify that that only x86's manual checks are
>    dropped. [Sashiko]
>  - Add patches to convert additional arm64 and RISC-V usage to 
>    kvm_is_vcpu_creation_in_progress(). [Sashiko]
>  - Remove acquisition of kvm->lock from s390 and PPC vCPU creation flows.
>    [Christian, Sashiko]
>  - Add Jean-Christophe's Tested-by to the revert.
> 
> v1: https://lore.kernel.org/all/20260914181223.289061-1-seanjc@google.com
> 
> Sean Christopherson (7):
>   KVM: Reject attempts to lock all vCPUs if vCPU creation is in-progress
>   KVM: arm64: vgic: Rely on vCPU creation check in "trylock all vCPUs"
>   KVM: RISC-V: Use kvm_is_vcpu_creation_in_progress() instead of
>     open-coded equivalent
>   KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock
>   KVM: Move check for existing vCPU ID to the top of vCPU creation
>   Revert "KVM: Check for duplicate vcpu_id as early as possible"
>   KVM: WARN if vCPU creation is in-progress when locking all vCPUs

This addresses the Secure TSC splat I reported previously:
https://lore.kernel.org/all/apgj5l7DZGsScsNc@blrnaveerao1/

I booted a SNP guest with Secure TSC enabled and didn't see any lockdep 
reports. For what that's worth:
Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen


