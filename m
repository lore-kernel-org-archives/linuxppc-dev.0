Return-Path: <linuxppc-dev+bounces-26458-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28999C624A4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 04:51:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb6ct0xYLz2y2X;
	Thu, 03 Sep 2026 14:51:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788411086;
	cv=none; b=Gm3Nl3q2XIA9y88ryQ5fadfbIIK8SF756tOefSLLAjEPfL3jE2CX6QNSxVDMjLT289MsJKZTur95FeahEE6pcborpdlWc/sgVzHBQ+RrvSTGlO8UVtuzg3tQNjD6vN2VuSB+fWqqFjJeG8YmamstgThZMDq98UAKyCnyYXUPmYlNTvHolt9y12K5DzW2aGzF/IIGlyCwSRg5yHjD3JnBPDbu0rr1GVb5dY7KYLx/V8fRRUq9hXX7bV5UBeUtAVA1h1SEiFma2FqbMu7eJwg3ZEbiw2K0ptfeYA8ITGRGSuhRsFaDMp5whFBjEH+Yb56xZMiDHLgkyyUL0v6tTii8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788411086; c=relaxed/relaxed;
	bh=CaGBqtS3DaFjj+Xhag/F/YKxRfKgZg+1yNv7vfDeCeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOlPL+6QExvMOTMZdcIfso0qY9McvvPfwUS+WtWlcW6gLLB33PXElfjwBcxuh65VEoYVKelSOB4thKuXXvnyMqgSQsKMOnjM8u8uwQjDo3LZq7KR4I6allreogjU9Jf9vSYSl1pG6xofSFtWZqicBTNmFEcM6hCaHF3W4uG4Gq5AO9Of9NwbMjUvHVVuDJuy3bvwEJLdFd2RCSY6jIhYl2H1R8twMQ/bybUss801ITAVUc4xGAv75ok5tD82Cx2hLJuZrFXTxX4grrPyJDSTupp5taXvPzoM4fTq26XVJNzN7tEpT4YnkZGqqspDtSziWnQJiwiviwOj0P+zQXmDTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W1/YB5Nq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W1/YB5Nq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hb6cs29xFz2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 14:51:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F0A6B600C8;
	Thu,  3 Sep 2026 04:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE7A1F000E9;
	Thu,  3 Sep 2026 04:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788411081;
	bh=CaGBqtS3DaFjj+Xhag/F/YKxRfKgZg+1yNv7vfDeCeg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=W1/YB5Nqpv5ClZyywMABL+9A3vkt5053BEnqzPT84CQCxKXOy1N0QNMVMABkGWhHn
	 Ml/hG0yYR6EiHGjGy9tnPDtn4WC+yLvENQX3fbLC9jLMVi85m54efR1mFkM8Y/TRSD
	 yvLI/CPmAthCKh3gcG0U/KFRKdZ6TbZeQzWoet7xXFKLgLHuAdWdTomJLjkvNkSEvC
	 L9swObU/eBhbVKx3k36gQRUa0BhUMBCo+z6RC8vb7JnlbtMF2vR2Ytw2e2/VkhG2vu
	 vg3FsB0DxiSeHWlEmXFbOu1oyK4RwxbZaQlSQRgppVXKUQfT/bfI33/haiymulkcBS
	 kjOjoNTGgBS9Q==
Message-ID: <8130e76e-931b-415c-bdfb-4e9ae1e39968@kernel.org>
Date: Thu, 3 Sep 2026 06:51:17 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/entry: Fix double accounting of user time on
 interrupt entry
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20260902050628.2553909-1-aboorvad@linux.ibm.com>
 <cd25ffa5-5efc-42f1-b145-0c1c6539b4c4@kernel.org>
 <742182de86c038f6b8a01a6c418469e7f8255595.camel@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <742182de86c038f6b8a01a6c418469e7f8255595.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Aboorva,

Le 02/09/2026 à 21:44, Aboorva Devarajan a écrit :
> 
> The history is as follows:
> 
> Commit 09a9d3a8499d ("powerpc: introduce arch_enter_from_user_mode")
> introduced the arch_enter_from_user_mode() function with the accounting,
> but the function was not called at that point. Commit 893082ac769b
> ("powerpc: Prepare for IRQ entry exit") introduced arch_interrupt_enter_prepare()
> and copied the accounting from interrupt_enter_prepare() into it, but the
> new helper was not used either. Both changes were preparatory and did not
> change the accounting behavior.
> 
> Commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") made both paths
> active. The syscall path removed its open-coded account_cpu_user_entry() and
> started accounting through arch_enter_from_user_mode(). But the interrupt path
> started using arch_interrupt_enter_prepare() followed by irqentry_enter(),
> which also invokes arch_enter_from_user_mode(), while the accounting in
> arch_interrupt_enter_prepare() remained. This resulted in the same user-time
> interval being accounted twice for interrupts taken from user mode.
> 
> I used bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") as the Fixes
> tag because 893082ac769b only introduced the accounting call while
> arch_interrupt_enter_prepare() was unused. bee25f97ad24 is where the duplicate
> accounting actually became functional.
> 
> Would it be ok to keep bee25f97ad24 as the Fixes tag? Please let me know if
> you think 893082ac769b would be more appropriate.

Ok, lets keep bee25f97ad24, I guess a bisect would land here. Anyway 
they all appear for the first time in v7.2

Christophe

