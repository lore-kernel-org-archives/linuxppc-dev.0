Return-Path: <linuxppc-dev+bounces-21138-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1498CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 01:01:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKGZY6ZfLz2xrC;
	Tue, 19 May 2026 11:01:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779152469;
	cv=none; b=QMV4jDOjV9t50JAiLY0/mEYCGO7gUQYjtkruOp/wAiHTpksJa2lqWjHPgRkguC+6VfYXuend/6s+W0sdLGgLQZIXlCOZdHmXII1RiTX1GcFEYtWfRI6FEOLyg4QO7kGsWxA1vAx6M3X/Jrp+9BXK6wgsAd1J97m85ZWuUhnwx19ebxStSviYIUQzEMY7Hir6rhxlaGQb5MfOgMgy+Bsfzsu2H2KPVbo4anFo7HuudJXOSpoLIXCu14BNSTlPQuacQKQlV+i9g7nXay7KBZ54SmlAPJ0/ii4Jjbhnmxkxbq9DB01lDDwXwN+BTbW4NKI6QdEPOsSbYcPa6P6owyO77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779152469; c=relaxed/relaxed;
	bh=w73//z+ksqLYZY7XAV6NM87fwXUCu0O1TweAlcOUwYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nwuov9co5Sirx9fmfRcp/BjQjkWuPUt+ILhYt1s05uWhm99lFUKHjI9fsOEe3Ln3vMXwTNF1ZqzU6BNr7+TWZjFS387ygHm83SMFjZ3t7Prs4AW9TpdL2St/BA6BGvRWFu27c3wlWGcmE+auHZfuaWba8WSvMRo46elSFX1IYfeCpZwPUdE3nbvf9mqzPYWRjVpZo6AazT4r0XQhJVI3tAAuHsCsunZmKTJyoq7n7/qK4rdQE2dIx6mmMAs49yUvk72zI9FP7VxMAskvOfmLZFzHsM75aqCvpijFOxINc08pG1Kk7SCE/AwJXtuVqkuCBDu2vDgzmNG2A3Tysc6qHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MJh4hBzE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3ubylagykdeqykgtpimuumrk.iusrot03vvi-jk1royzy.u5rghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MJh4hBzE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3ubylagykdeqykgtpimuumrk.iusrot03vvi-jk1royzy.u5rghy.uxm@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKGZX5f11z2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 11:01:08 +1000 (AEST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-8354503d9acso4138422b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779152466; x=1779757266; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w73//z+ksqLYZY7XAV6NM87fwXUCu0O1TweAlcOUwYI=;
        b=MJh4hBzErntnBNthEEr1j+EovK9UUfIGbvv4Z0nejqpPmHD0114nxxxkIECwKbB0CS
         mtgpFNuaCW4Qy2yd/mypm55ed5R0jdnQPMKLcoV8gK/U/CBJCYrgIrXpMKQXmIE7RSWh
         qpTnz89Yd3hJQ+9oyCInO/3r34gZ/u3TQvxLNOE++DZpOd3i1BeHg3BAkwhOqicmAAD2
         iEvyrOXAeRvVOIwAKLPFMiyd7CCkzwfz7+O9CgQzXbuxLFYLN4W9x3hTOO+wVqAdAtjQ
         48lsJm4ZWE6RlD7uvpazktNdnc+Bi4eNJcEpiQMqqhIvGP5jHJttfzbUuys+UTqLgp2r
         Q0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779152466; x=1779757266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w73//z+ksqLYZY7XAV6NM87fwXUCu0O1TweAlcOUwYI=;
        b=p36lbp/zxjoxUboE+PkL6ovCAvHWkRWm/qCoN7HnR+NShGBAa6twEW+U2wwNBpmlIT
         jiZLqE6YeFtu8n+yVQpEGOkTyi9QJBxJKNSmC/XzrC95ihgulFCr3NYCbsQ60L0QQZ4b
         Dh7FJkoM1FE1iF4ZX5OlHeM1VLXauXMNzP8+NJRrASLX0K2Yrc/T809F56+3oiBeSkZw
         OVQj9nnBq9aZRVP6L0wOwB00BB73rIKzJLB8b0Ra40diqf6793aJVh+wPek0qU3i0Isf
         o3e7h8R2KceBw4YrGxWKLp3KSCOO10d+grz06HjxGq2c/aimRGvvQaHSj0Hij1B+aAVO
         4pnA==
X-Forwarded-Encrypted: i=1; AFNElJ//9pSGWx5w0fN4T8mc6p1S4CSifEhz0qy6bYJXiLXcDStNqQ3XslP5Onl1SkZuLuHRXnUNbSgvAolYnKk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzs8/0erG0HhKu9IYDxS0ZWb9BQ4Vihb6Z0hXugfrBTKxvmHSb4
	a8upxj7ksVlqFiuTeEVh3bhpAkeDaQazn+XL9w0dd+RDJe7HK3Fdh7B6ygqEj+1nHK8v2C6EJC2
	OW1kdNQ==
X-Received: from pfiy14.prod.google.com ([2002:a05:6a00:190e:b0:838:dc32:5349])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c0e:b0:83e:d52c:e6bd
 with SMTP id d2e1a72fcca58-83f33c9bc80mr17829172b3a.38.1779152465512; Mon, 18
 May 2026 18:01:05 -0700 (PDT)
Date: Mon, 18 May 2026 18:01:04 -0700
In-Reply-To: <20260518044150.34632-1-gautam@linux.ibm.com>
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
References: <20260518044150.34632-1-gautam@linux.ibm.com>
Message-ID: <agu2UAi6lWclxFYh@google.com>
Subject: Re: [PATCH v2] KVM: PPC: Kconfig: Enable CONFIG_VPA_PMU with KVM
From: Sean Christopherson <seanjc@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, atrajeev@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 18, 2026, Gautam Menghani wrote:
> Enable CONFIG_VPA_PMU with KVM to enable its usage. Currently, the
> vpa-pmu driver cannot be used since it is not enabled in distro configs.

That seems like a problem to take up with distros, no?

