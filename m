Return-Path: <linuxppc-dev+bounces-21753-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B281BCD6E49
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 22:51:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRzB41xcVz2xYg;
	Sat, 30 May 2026 08:51:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780095100;
	cv=none; b=XdXnhK2SMlNvGp4xWKbAciT97GWXx0ipi8HejCKUoUm1SPCBcT1dyh1F4hWRzaXhn2/MXW1RdbLfJx9i6CT1SrMQ7LmwNvSCBY0LqpvS1+CMePslDsPzcWVTPGXKYfSOTo8WcEFr3UPrVL0JbwjwJnnQ89+Uk3bAk9QeERkrr3btffkD1HzIfKubxOD2CU50SRPiApYLw76+R4lzm3c1hnyQrPLYgnmxAww+i1BitxEvUP5L42ri/FZPTQjVwlICTIm33h7nHcdvoU4Zi9x7QVtVeRYfKgZeIn8BMkdOABz/aPxzZHeo0kz8DTSAfLBDFoQ8izBAVPFi8ITIfV5FoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780095100; c=relaxed/relaxed;
	bh=iDamTyASUWUv87s6Ugw+3o5D1xad/djiw+VyKIvP/1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ju7K9ImsVK4AvF9zHFeSr93uuKl8U6p1qMxJxmXHMQuWSc5jTzsahfkdGiI1O3NATXR4WJJwQVxeJSxe88xGw3s+LFgbieXD2nMTV47DOrlS+8cPUBIWV9K293YCS7JPU35iRtZY8+L85C4yILE8ije8mR9Vdc8/7HPI7MApc0VH8xuzfc+cSnJyxmTPXFVKKoSEMl8MtASw4qr1JPn+s+OMgF3ZGncDtSVGbANkSpn+3aETlVY1FDRryf8l4zTInSCFzYhq5M8FrRRZvwbTUS/BX3erK9uT9oPgCyC0NTWx4u46Pm8IgiRW6IoeeZkKHDVW3g8Wd01OkXt9lwfGqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Q8W89Zc9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3dxgaagykdggykgtpimuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Q8W89Zc9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3dxgaagykdggykgtpimuumrk.iusrotadvvi-jkbroyzy.ufrghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRzB30WnVz2xVK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 08:51:38 +1000 (AEST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-83536dc3be5so16373647b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 15:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780095096; x=1780699896; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDamTyASUWUv87s6Ugw+3o5D1xad/djiw+VyKIvP/1s=;
        b=Q8W89Zc9BzBTxpVnLI6sT097rssfPiOJD1rIZd55fD8iK8f5cXWOH9Ats7yxoX2uXK
         YWqPO0Cx9L6aoG2EJIwo51geXJvi8y9xhCx6hReewAo+wJEHsqFINWNqNA0C8c1MXm73
         L5ZJw5tB2qWHNSZ3emquoIB5+6aC4atNGahU0A+8Ef54VZneUzWaba2oG93XHjdtyX07
         v1XZRgxvA983Vzzo8xMz9mW0MfNWuSnqmB3ffV3V32G1tEWv+6XUACUt7JHtGk9EeLWY
         id3UYwWN91FTpc5EMZnk8GT7I+BnaPhbKyNRsbFGsEPemgOb4wRq9kLlKMbKZgm91zbI
         jwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780095096; x=1780699896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDamTyASUWUv87s6Ugw+3o5D1xad/djiw+VyKIvP/1s=;
        b=GROQf0rTPVgvXe5GY52QyyX9eXDzZm4ZKaa0PhNbyq3o7cXupHTmn5Rh6W43kQ/XkN
         N8m3q8vI1q27szQqdi1YrV7X7dQuMhPdlg/YKfLvwQ8m29p+EzVYNQhJ0E7L+2CRQC6G
         2LEw2X8KQPmMPw10IH4iK6bHYvpvbV4ph6T0YVbs1lnAt5z25kMtQ0CDxIjOFyop8bLA
         FUG1H8VFSX+mTQle0X0E2aaDBu3Ajr8nQnMalTANvK+Bc5SblVWfXjccX0GynT8rqM7X
         Ha2o/Ilx4wbMBze460aEAlM7Ti2Pmz546SRy8QZ2mc6xcfdkx7+T0r6Hi1Hu3KdWmf7S
         Vp9A==
X-Forwarded-Encrypted: i=1; AFNElJ8gPuL4kx1QWrHsSC+Txb0K80EI32QXenyKRvoxcaRn7rXAHAS+sT4AkGN06tuDBi4Mp3KO90b3aYcDZFU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw50HC8ojinFW+gc8S/G+v4dxseXaVw6nbiucOLYEB4ul1kgixQ
	yNwpDn13OA7vuffn/bMQg2uIpgLrbsJ1OrIrupTDR5xKgOjrPxlEL3oQiMs8zFYMw9cAj2V/STZ
	HynvUKw==
X-Received: from pfhz14.prod.google.com ([2002:a05:6a00:240e:b0:82f:7242:4cb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e19:b0:82c:2555:b9b2
 with SMTP id d2e1a72fcca58-8422532a6ddmr1429112b3a.10.1780095095672; Fri, 29
 May 2026 15:51:35 -0700 (PDT)
Date: Fri, 29 May 2026 15:51:34 -0700
In-Reply-To: <20260525070154.495455-1-yanfei.xu@bytedance.com>
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
Mime-Version: 1.0
References: <20260525070154.495455-1-yanfei.xu@bytedance.com>
Message-ID: <ahoYdrs9dVzp6Ps6@google.com>
Subject: Re: [PATCH] KVM: Validate irqchip index for LoongArch and PowerPC
From: Sean Christopherson <seanjc@google.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, chenhuacai@kernel.org, 
	maddy@linux.ibm.com, npiggin@gmail.com, sashiko-reviews@lists.linux.dev, 
	pbonzini@redhat.com, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com, 
	fangying.tommy@bytedance.com, isyanfei.xu@gmail.com, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, May 25, 2026, Yanfei Xu wrote:
> Sashiko reported that irqchip index is not validated for LoongArch and
> PowerPC. Add validation and reject out-of-range irqchip indexes to avoid
> indexing past the routing table's chip array.

Can you split this into two patches, and send a v2?  I suspect the reason no one
has picked this up is because it straddles two completely different (sub)subsystems.

That would also make it easier to get the fixes backported to stable trees.  PPC
has been around a lot longer than LoongArch, so I assume the PPC fix will need to
go further back in time.

Thanks!

