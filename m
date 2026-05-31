Return-Path: <linuxppc-dev+bounces-21767-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0837CD6E52
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 May 2026 14:16:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gSzfD3Nq3z2xld;
	Mon, 01 Jun 2026 00:16:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780236964;
	cv=none; b=T8CnO5QPcF6bf1Ryhizus11wcl8c8Iy+3QL2gd1JLXRyFpH3kCglHPLq1/hUoqevFyn5b/7vl5U+0Egr+qU5m1/D5JPdRJWvPwMPxE08CLg4Z02xQYZJux/euiDR+SWj+xV9qYY/QtvjLBGZNVXUZ9f4YWSeg5gJd+Mbl5cYNpZtUq0z7Pl4R+Cxb6jjat1LWL36A0ygV7cHHBbunHYdUNfMoWCDNU3z7WcWPvRLsJ4vUq73uW/zpO4Z0Cohs5IQwTRCa4C5i1Kj8IwC9oM7bmHXEKRaueVgtR/qSRJPwP4rzcYsKy4fF/uaDkS/lCDFPfIiOUqO7gj173C/4KlEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780236964; c=relaxed/relaxed;
	bh=U23k70jOkOIRnx4xfbsKF3eYCpD6GuFHR3Ka4h+u5QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ul3lAOOJNEGtHD8G9avuf8NaU4fllvmgmCsPWgh7OFS3PM9Oha9jTCPrxJaGOQkV2hvgfQxvMYKdyRCpuwXGjApFmgWViAyNlzalnaD21PFfCsMriWmbHcuzca0ACtbH2UOqWN3KUU+vTHV1/dU63J0SuJN0Op00JddLnzHS5BxgBbnSWBbyvwB0jJq9mTODDLuE38E6kR7EIj0ekS68WgVRZJoiPA3owpz6hApt92dXBlWRLZHENeiC6OTxyaLHVxjh9Tq3ksS1LOPBq7fHNcIIoxPzorXbwACTeif0JI22UcktbJZKrWfrocciaW9S7BhXXSJNDkpGLV1Uvxg86w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=L1qwrvt1; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=L1qwrvt1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gSzfB3Lqvz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 00:16:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 839B1601DE;
	Sun, 31 May 2026 14:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6610C1F00893;
	Sun, 31 May 2026 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780236959;
	bh=U23k70jOkOIRnx4xfbsKF3eYCpD6GuFHR3Ka4h+u5QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L1qwrvt1byj+XyLFyTBGlXK2Kfbd5te7XD/RAphHVLNMS0Sg9PAMJmPGGMhgfUCQm
	 fTzG3mE15uMgHz+b0EWNueao0GIvE+hpS49rK14vsIPUENEmQ/b0fGaNmZCGvaQ+lj
	 /Frbv4wcPTeOhqCQy6MDDurxVuNULNjv3BOrNCh0=
Date: Sun, 31 May 2026 16:15:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: harshpb@linux.ibm.com, zhaotianrui@loongson.cn, maobibo@loongson.cn,
	chenhuacai@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com,
	sashiko-reviews@lists.linux.dev, seanjc@google.com,
	pbonzini@redhat.com, kvm@vger.kernel.org, stable@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	caixiangfeng@bytedance.com, fangying.tommy@bytedance.com,
	isyanfei.xu@gmail.com
Subject: Re: [v2 0/2] KVM: Validate irqchip index in routing entries
Message-ID: <2026053158-cussed-outweigh-6f0f@gregkh>
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
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
In-Reply-To: <20260531135326.2238555-1-yanfei.xu@bytedance.com>

On Sun, May 31, 2026 at 09:53:24PM +0800, Yanfei Xu wrote:
> Validate irqchip indexes for LoongArch and PowerPC irq routing entries
> to reject out-of-range values before indexing the irqchip array.
> 
> v1->v2:
> - Split the patch into two by architecture (Sean)
> - Pick up Reviewed-by
> 
> Yanfei Xu (2):
>   KVM: LoongArch: Validate irqchip index in irqfd routing
>   KVM: PPC: Validate irqchip index in MPIC routing
> 
>  arch/loongarch/kvm/irqfd.c | 3 ++-
>  arch/powerpc/kvm/mpic.c    | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> -- 
> 2.20.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

