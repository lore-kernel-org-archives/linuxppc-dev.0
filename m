Return-Path: <linuxppc-dev+bounces-22279-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89638CD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 17:52:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ03z4Wp2z2yS4;
	Tue, 09 Jun 2026 03:52:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780941135;
	cv=none; b=X+ybWoCZpZVembzBG2oTXGfJqoi0Ujq33QQg3/suwHHGGn5WTYukcrYhT+9VXuQuiGaC7zX8lmnDj43G10TXLVyq04acjRvOu8YIOkB8+n0tQQ/GAAX1PmiH2zk2Xgcgn3Jdo991Q/8/X+EufV08npFywT2AQ7DXSGszJ72D9krAuIJX/1+kasMLs5jPGUNCatyqOxXaWv9gwleFY1Tp/FrT/PN/qCfPy2Rebnq9QV8rdzyuYPcfhNqGl38T7+NhwdDYV1gGCnmcq1BwrvbaM2yQpXU77B2BoOJuJrk7D3l5fE+80Ph14bleZVg95Rv9XbQWLO8xeCpPAAAySYAw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780941135; c=relaxed/relaxed;
	bh=O6KGwCQLUB46ZJGHfZKCF8HhhDSqJeRYogGX97iCj1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCsb4CSGqjlOPs5jehQkFnQnUq8ivumL9RtA1cvH9rJPL3+7NfePFvLcXIpyTjikZgW+YsLG83ANdDQ3tAb4na+4bXUiuaAf6pyjKY2w+DTq2+GbiJVNxX5ej3PVRqHg3ijdZLwEilxLMnItarIgiFqQe1UgmMLe2ieKps60DliMC6t9VWK+18BaxuasVKHIQpmWnJz94xURt7ExvAIGmaqnjhXXPoAhRJemjMEdS4i+oU6xKd/Dvbk7me+yLJ+ckQkqAMSjxjpj1Mo9lqDoHVUYnbGOByWk5A4CfqENxEXgy4ERrhUTyY0tT0JBLMw892KTjp82m751uM2T8Qsw6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org) smtp.mailfrom=8bytes.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=8bytes.org (client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=lists.ozlabs.org)
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ03y3R3Vz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 03:52:13 +1000 (AEST)
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 46872202AB5;
	Mon,  8 Jun 2026 19:52:09 +0200 (CEST)
Date: Mon, 8 Jun 2026 19:52:08 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, ashish.kalra@amd.com, michael.roth@amd.com, nsaenz@amazon.com, 
	anelkz@amazon.de, James.Bottomley@hansenpartnership.com, 
	Melody Wang <huibo.wang@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, x86@kernel.org, 
	coconut-svsm@lists.linux.dev, joerg.roedel@amd.com
Subject: Re: [PATCH 35/60] kvm: Add VCPU plane-scheduling state and helpers
Message-ID: <aib8n5lO6HKbLC4Y@8bytes.org>
References: <20260608144252.351443-1-joro@8bytes.org>
 <20260608144252.351443-36-joro@8bytes.org>
 <e7eb0dba-790a-4644-9895-5c9a7420d7fe@redhat.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7eb0dba-790a-4644-9895-5c9a7420d7fe@redhat.com>

Hi Paolo,

On Mon, Jun 08, 2026 at 06:47:54PM +0200, Paolo Bonzini wrote:
> On 6/8/26 16:42, Jörg Rödel wrote:
> > From: Joerg Roedel <joerg.roedel@amd.com>
> > 
> > The algorithm is to always run the lowest runnable plane. Plane
> > switches are done by stopping the current plane and setting another
> > runnable.
> > 
> > Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> 
> This was left arbitrary in my version because for example Hyper-V VTLs use
> highest-runnable instead.  It also made pure userspace scheduling possible,
> though that may not be very important in the grand scheme of things.

IIRC what Hyper-V does is always the run the highest-privileged runnable level,
no?  Maybe in their numbering level 0 has the least privileges?  Anyway, I am
happy to make changes here, also based on input from the VSM side.

> Did you drop it because it didn't work, or just for simplicity?

The user-space scheduling worked, my 6.17 planes implementation used it. But
there are some problems with it going forward, because TDX Partitioning (and
likely ARM CCA Planes as well) do not allow arbitrary switches forced by the
hypervisor. All they allow is a forced switch to the highest privileged plane,
the SVSM on SNP will force the same constraints by making lower-privilege VMSAs
not-runnable when it executes.

So exposing an interface for user-space to chose which plane to run does seem
to gain some weird, platform dependent semantics going forward. TDX and CCA
also require in-kernel switching as they can switch planes without a VMEXIT, so
I decided to have it from the start.


-Joerg

