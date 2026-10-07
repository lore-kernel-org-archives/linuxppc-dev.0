Return-Path: <linuxppc-dev+bounces-28986-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53CFCA5FFF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:10:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j045T0ZVvz30CZ;
	Wed, 07 Oct 2026 18:10:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::9a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791357020;
	cv=none; b=UBHARqQ5mDowHK+GHfsu4Fz0JQhaRsfRi7savEUbKdx4rdLkQhoJTt3uGMEoJxm7MisvEGGU/b1wB/SWXpHxfwTIApG722n1U0PtETC0HijUKqlG+1RoZIPujbUXurtLbb2Y2lursLu9GhKXK0jjfBIgpNzWLWOdTCkLuFMu76OEJq+o4QQECBC/hxgmqO+pWVIXgHSXpBvmA6ceAvQcm/S5VN3TRGnX2mh5Wz+VCKB2yW035BxnsMw6DoYGXBhIwq24/cCKmbYnAPfRd+4U0/vIyax/XtLpnEsLdAg+6/HXRJRHzKhimEdyiZQEVkiMS7h6xwI6h2yGeDyL+2cyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791357020; c=relaxed/relaxed;
	bh=nWznkk9Fjq/D6EuRqmF/M6hW1RRZAYuOo1VRXMA0j/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0QCZuTMadXPGvUgUYAc/C+D8aCvU+OP0M7EN/AxO7kpU8Y96jsC1jJFnXBSoLaAYi5xZCghiE87v6k2z47pq+RHLjAbC9YYsEEIM+db1JdYx+oPZUB1yFEaRuHQrP3NoIeeWd4FHPrMW2GAdyqV1bOQKtRxurc/fckU7BLWhvWrDEdYURex/klX3ZULRWfxnedNhvSBveEu+R0yAvu7NVgeADIlXIyX+Db4a5EE6BrJOcYP7rPYqjXjPSa4PDKieg8Vea9AcfXdo4wRU2KiO9EFEiwei49FBkYQ98X5I1pr1CsxGwCHTNuWEKJM+yAMyngbyIL7tL6wdWpj+SsZOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XQfnyf9O; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::9a; helo=mta1.migadu.com; envelope-from=fuad.tabba@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XQfnyf9O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::9a; helo=mta1.migadu.com; envelope-from=fuad.tabba@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 1425 seconds by postgrey-1.37 at boromir; Wed, 07 Oct 2026 18:10:15 AEDT
Received: from mta1.migadu.com (out-154.mta1.migadu.com [IPv6:2001:41d0:203:375::9a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j045M1pZsz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 18:10:12 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=nWznkk9Fjq/D6EuRqmF/M6hW1RRZAYuOo1VRXMA0j/o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791356994; v=1; x=1791961794;
 b=XQfnyf9O+vUuTArCs3Frdwfh6+2yOAH/6ILZd4x1duhOVRvhsP9mRRFfQfeYQNEq+l88IjN2
 cbFguV1vqBR+8hZdBA4WigjsC+1rwlFGm2aDOdXTZIJFnxCA21XTX9Q2Zspbt8XF2blPXECZFym
 ZV64z6WA4ES/OTWG3NnjQf4I=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 646c9f0e2bb832ee;
	Wed, 07 Oct 2026 03:24:20 +0000
X-Mizu-Trace-ID: 646c9f0e2bb832ee
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba40832934so2855e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 20:24:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzUwyvDoGpAPmxAbkKlbKVFpkzW/FG+wbg5Mxoc62Wrbno2KLWmUfFQpOc7jW3bo678ak6USvzaZ/g6Z64=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKtSyTHc1rmUYfhknboKocxUBsDYMqjYCJNIg9TkAAfDM0QPmCK
	14oaDL4zG425QgF8Fp0HYIfLjY4er5fdYv8VWC05C3wlgGt49Y/O//HRGtluEJ2E45iX9Hsa6TP
	xQ5qcLR82yqEP9ebFLYPWDPlHDRD6JhCFiNg/VMSa
X-Received: by 2002:a05:6512:33d3:b0:5bb:ff6f:b4bd with SMTP id
 2adb3069b0e04-5bcca66e395mr244231e87.14.1791343458771; Tue, 06 Oct 2026
 20:24:18 -0700 (PDT)
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
References: <20260915084441.3846947-1-fuad.tabba@linux.dev>
In-Reply-To: <20260915084441.3846947-1-fuad.tabba@linux.dev>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 7 Oct 2026 05:23:42 +0200
X-Gmail-Original-Message-ID: <CA+EHjTwqmQrLz5aDsCo1JFE2H6mz_dWDf=fkLsNup0cgenMCbg@mail.gmail.com>
X-Gm-Features: AclHuK_KSLUhfLp6Pl2z-XBsxbeEyfCpN3TL9UgSgX_CqN7OtwApebc1PcGPn3k
Message-ID: <CA+EHjTwqmQrLz5aDsCo1JFE2H6mz_dWDf=fkLsNup0cgenMCbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: Replace VCPU_RUN with KVM_RUN in comments and docs
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Oliver Upton <oupton@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Gentle ping on this series.

Cheers,
/fuad

