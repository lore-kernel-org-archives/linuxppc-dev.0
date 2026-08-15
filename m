Return-Path: <linuxppc-dev+bounces-25882-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAD5C5AD5A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Aug 2026 04:57:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hMRg44Y6Lz2xGZ;
	Sat, 15 Aug 2026 14:57:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786769872;
	cv=none; b=VhLiLw8Fu4uhEEb0sAJUqn7nd58iFyfLBqzWKpTHQraA8MMVhU9EjdApswP4YkQ86hFSKgbslIFXPF6SedK23KgqNfYbIQddcZ6ilIKrBge/r/DBMD2oAWJinYlZTtJ62CLXMRmZKeTwMTl0zQTPvNPcbhza0rqELmi4mKA48jm27Hrth+/QF5lHZ7Oxx5sG5fRt2y0AcEvM8pzenl9NzmRAJVbDNsYg6t5IZB7FDgwAtoql6JF5lykw8YO/YFMPxfPU9ZmZ2W9BnpuS7iorFTj18cFG+f587Bj6fJiBRQ0DAnyaU/2aUxkGlT1igKHfy2VQiOw6I0TQmMDqgab/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786769872; c=relaxed/relaxed;
	bh=tDXBZClvjZ3mO22zZfFxTw3yKq4iUvRblP+m3ta8coE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIFsxypg8hUe+MVdyX8kygiijfno6tft/qSWX2NtTN40ThB+suhGLRXyI2OvBr0BggN+Yc1yKyBmnH7Eq/eztzdHhh5U4KIZpNtZ+t35XysnvFwJMy3dzOBnCsZD1LfpbH+1NamJpOt5zl4gJS2m86DtSFl48cZJQLPnd0EkZ298ZrXgFpdcpA4cVdB0tiWQJ4DMtNRX8KPBqRVYNz9H9nB/SLFl/qD1BXd4PHp0ZTFzxksN1LrUxA+M2O0KHA10jTqbn3lgfOs4e5YEUe2SCgB42B+SfvffjT0iG6ocT/iQn+l6u+kz2iSVPo+hmdB+SQtR1ajYwMR5/PT1tR1elQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rT1aurih; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rT1aurih;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMRg25S8jz2x9g
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 14:57:49 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so2451664a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 21:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786769866; x=1787374666; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tDXBZClvjZ3mO22zZfFxTw3yKq4iUvRblP+m3ta8coE=;
        b=rT1aurihLRkyQH/f6OEPN8uHpCBFf3PFOHKVFn3ybPokjVQZcknQT6WJ8dVQ0ieZSh
         Kx7CsNc2Ey4Gl6dHROk3fkovXNGRvL8leFrUt3gfPsNDj1HxfMQsQhnt7quuaLERSKt2
         Kln/ZRGN/0ss20V0wf/onFtdY6N7ABF0iKgPyZRZPQX8xzBe1UlqoVyFrqjJxD0gANm3
         gG9NvHIKORPTdwEmp6fpcYT6ZxjSSGHNLpGe4P6iXX3k7U3A/6x600T/l3rWJ0FpdD/A
         VcJtmWeNm1TN2LL0RcJxO6Um7vbjNHz5Y4hTqYRma+xfr8Zr2tVbDUCIXkMO+ptRpH7A
         5Tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786769866; x=1787374666;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDXBZClvjZ3mO22zZfFxTw3yKq4iUvRblP+m3ta8coE=;
        b=A6NTuldmzSuv3AQApfBkLKb86WmbUyl7x914CHiwTv1USX5+6nKEnbsq3wAT6FH5qX
         jLs8WpNxgj6SozeVk/o3caTHLmt1a9MFv1QO9mlJa0tEVmxY0KCCCr/LCP/qhmMA5XjT
         gEguwHe3W9DZnj5WaQaO8+tnnkReO5MsJCWK64tB5fLB/KYkOYx4PZ409+tekGfm+hjz
         Qs2MeUno3vMMuWSUixcT9/viHZCDmUfdrCDfHjWYt89Mo9taFxPMQJOUVgRpjq7vK6Ir
         wtefPN3jToD2I1DT0hGT1UVB3JNw9CPe/EblBnNno25aWoRlc4P9Uqy7jFPAiMV7VdV4
         kL6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoBFZ1jQruiEBTHLq0Grz/31DTRym9Lp9sS6Z4jtLL8VS4l85DpQuzpNN9q277BimObQQuPfqDTCZes9QY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywl8MxHzyQnIRTLcUuqZ/t5VCK++j9nLxDZ+WdidJN01YMv2HxD
	oSh/xaXZmN7EKzvBK3TYgQB2BTzmJPpWoXhWNFgNkZg5CbSrWOhtSRFY
X-Gm-Gg: AR+sD13bLt7EvLAybjqNiKw7exS02Lff0DbR/2cvQx7aXW0R3ccA7vaNuJHEpbmKC26
	ND5J/swvBzxhnV4coxiF/+HsgcUY1VaXdIXCw6I+kRJuCMcHVwfnzKBIi8rY4GaHE8LT3gS8B3/
	/SKWdFDRuQeVehYrPsh9co485PfRNU0fw8P7gqCqrJ2K4vSqXwqqgis3xplH7Jz+4wHB+W4GKSn
	CNPix2qTsvjXr7EJUVcVnzfpARArVRL3vI/b4egmcs5ym0a2rvaiLvZz61/KOnJbuUDf0fHnuU7
	4VrPbvjThASaGIm3aA2gfb2yE2W30Ixqji2CZgxdWupEkGiNQ2A+OudwArt88Kudvwqtn6p+ZzH
	8QcXNSbtUbZHJY6RZ+DRzcee94zntwHCx8f/n2uWQZYiehtjGoSM1lalpHEJN16zRNjgHkdbDVH
	g33OxY5qyPHwRkIDFKhyJ98hQt1LoP6oHU7yoo4q9wNbx06w68m+xK3jMZNj0A3/8OFVvZrhWuR
	wTs8UEstdOO7ElZKaZn055wxHZDv/nI97ZC
X-Received: by 2002:a17:90b:1d01:b0:38e:7f22:f674 with SMTP id 98e67ed59e1d1-3933b09e9e2mr8863706a91.11.1786769866365;
        Fri, 14 Aug 2026 21:57:46 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d61e1568sm10929301eec.11.2026.08.14.21.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 21:57:45 -0700 (PDT)
Date: Sat, 15 Aug 2026 10:27:39 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, mchauras@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc/entry: Use hard_irq_disable() in
 arch_interrupt_exit_prepare()
Message-ID: <an_xbqRgm4RaRw0r@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260812152035.1661781-1-mkchauras@gmail.com>
 <e49d543e-80b2-4c8c-968d-0c8b68717cbb@linux.ibm.com>
 <an6w517sUDWwpVfZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <an6w517sUDWwpVfZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

On Fri, Aug 14, 2026 at 11:42:22AM +0530, Mukesh Kumar Chaurasiya wrote:
> On Fri, Aug 14, 2026 at 11:06:43AM +0530, Shrikanth Hegde wrote:
> [...]
> > This is good explanation, but what i not understanding is,
> > 
> > why pattern of setting PACA_IRQ_HARD_DIS changed?
> > Previous code at interrupt_exit_kernel_prepare which did local_irq_disable too.
> > 
> > Please check where was PACA_IRQ_HARD_DIS set without GENERIC_ENTRY which was preventing
> > this from happening?
> 
> That's an excellent point. I think we are looking at this incorrectly,
> If this is related to the nested soft replay interrupt than this whole 
> dynamics changes, local_irq_disable will work for the actual interrupt
> but when we go nested something is telling that the nested interrupt
> that interrupts are enabled. Let me look at this more deeply.
> 
> Regards,
> Mukesh

Hey Venkat,

Can you try this diff,

diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
index d5c48d1b0a31..2fbfebef74fe 100644
--- a/arch/powerpc/kernel/irq_64.c
+++ b/arch/powerpc/kernel/irq_64.c
@@ -117,7 +117,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
 	local_paca->irq_happened |= PACA_IRQ_REPLAYING;
 
 	ppc_save_regs(&regs);
-	regs.softe = IRQS_ENABLED;
+	regs.softe = IRQS_DISABLED;
 	regs.msr |= MSR_EE;
 
 	/*


