Return-Path: <linuxppc-dev+bounces-28781-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6FBCA5FE6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 22:12:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxNLp1RG6z2y2T;
	Sat, 03 Oct 2026 08:12:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::548"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790979154;
	cv=none; b=i9XYF5Hg+GM2h69YTSnbKqHQTRDTjr9qS00au/RRJAbnGIHTLvRFI3MdB0BJK8ErUNmXTv+BHOGokqEv/VPbTBVV0lHOhhpsUfw3LlNxDxmmhbYh2iaAcPstBuzSMwV9Wrrw8qae9LRbqKk7XcPZSvIZZGqh1fu0UunwjVw++wW7iYb6cu2DfHDvQzb+arEuYGFNdP1Y9icfV+Gv+OrWc+QFpwuVlH4j9R6U9c9iDB/Ov0KjWLTrM7kQg5QDKK/3iYBXVde78ozZ1UH4SM3gJ4ogDieilstdn/EJa0j58ZTndGt4ThsSltL2LiJxSrlNu4HWczbPdyEr8PrAqftnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790979154; c=relaxed/relaxed;
	bh=m+BE8hAAq8CojA7/qWTm+y4+V1+d1I0cqoqJfhKPjfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jbR90XgWwKrhbUKy9Tq7VNsxn/R2UY6T14uqyvWpobh2zB3Ao+JFBI1RaDr7uFMHwiknnCpDxG9XXGtSD2wDPB7xSD9HMs3uE60l/MpqPlJ77szaOVI+g+jfayz5ai0ughGw0T7TwoBVB80bXoZfgghT1fnziSGAB5WED81AW+mdQOtnC9eNZqBxrGA/aSTJC9ha/f6tjoC67aOixsabq75f8kJFFR0TocAEC5FQtIU+aA7Rduv5bpxVHaiPAyRRiHYysR8fjvVT8aKhnfwVzgIhFsZuf4MpZGJ2rzD4dmiaFCYHNkTmYzq0rXTzLA8Ql33mkWpIjDV813tP5+ZmuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gWs0CJgd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3tszaagykdaqwierngksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gWs0CJgd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::548; helo=mail-pg1-x548.google.com; envelope-from=3tszaagykdaqwierngksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com [IPv6:2607:f8b0:4864:20::548])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxNLm6PKKz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 08:12:32 +1000 (AEST)
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-ccacc75a997so29395a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790979150; x=1791583950; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m+BE8hAAq8CojA7/qWTm+y4+V1+d1I0cqoqJfhKPjfM=;
        b=gWs0CJgd9ROVKmKuYFAP/+Z1pZ+6NsMREbaXYu3K279X2Fg7ORc5wvBFCykWlkUech
         ap9UzNHgfCmi82n3wN1PkdS6dQxYp8lZPhek8JLzFajIqnVOWYliD3XpQzWcdqbsDzEZ
         iq2myk/JKfnPBfy45Mw0gWLhdoU4kVOnSjGXk0YRbi82UDF0d582TysuaaoBdOa6apdf
         +mUbVitDFNDOISw0IcCFqEtj/xUvO5trXBBRHbl9bB9YGW9bGFe6dJvTdich34JWt1+e
         /ve0q8eQsxpxYK7QH7N75hQfoAfuersUahLK8YPpwVW4leiZkjEFKkEdWiB0kRWOwwuQ
         RWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790979150; x=1791583950;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+BE8hAAq8CojA7/qWTm+y4+V1+d1I0cqoqJfhKPjfM=;
        b=hJVe/32GE/LKdvsjace6l3Rv3pvViFkXscLYPbRsleX0y6DIpW7NwCV3rdvUyuSaAr
         qyexf/AxRAQQ5w2Rl1FNCQ22EUfP64Z1wDQ0G1bR/c/CSdeMeQdgC5DfETqY4K82Ld7k
         vgAJC+OlTykgQYeCrYo3mLUgwcYTUiof9cNGc0Ha+C9YO7YURBVv8YrsvowLaYDBgMAW
         zKTE9wDEXaQskFoJicw/NiDPXCxCH4TFqtQJHYUGek1rM12zlJNX9U9p/bw6saPTWe6Z
         AcHGfQRU9wm9bsVM1yW5KxUHoDpuDWM2iID9x6EWaY2ZyMiT8NoVyCBzZ9lnZRx5Tdil
         FB4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzceyEBgNSk1QMPJJdU/KMz45PBx2ZDltBeQIuhLb0JQ8lZZ+ltdxNmxvja8bPbxAI1v3Kzo2aT6ZbM9dk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mV5zFIjplKZQxoWWbe5AtHjnLAk/JKtydvMVaKKkSQjc5An1lc
	SYKUdIX5ppWs9iyNLLkOu9fgtSUY9IQ+zB6SQrK9xKlyuAkm3KsxUuiBTluEMTlDrWNVdSBxHR5
	9d7C0OQ==
X-Received: from pgaa6-n2.prod.google.com ([2002:a05:6a02:6486:20b0:cca:bb35:aa9c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:748a:b0:3e0:b937:8829
 with SMTP id adf61e73a8af0-3e0d6ce0ea7mr619313637.51.1790979149504; Fri, 02
 Oct 2026 15:12:29 -0700 (PDT)
Date: Fri, 2 Oct 2026 15:12:28 -0700
In-Reply-To: <de328dc973a135a956a148dd83d8353b7157d452.1790101179.git.ritesh.list@gmail.com>
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
References: <cover.1790101179.git.ritesh.list@gmail.com> <de328dc973a135a956a148dd83d8353b7157d452.1790101179.git.ritesh.list@gmail.com>
Message-ID: <asAsTMn8naXCxhno@google.com>
Subject: Re: [PATCH v5 1/9] KVM: PPC: selftests: add support for powerpc
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
> ---
>  MAINTAINERS                                   |   2 +
>  tools/testing/selftests/kvm/Makefile          |   2 +-
>  tools/testing/selftests/kvm/Makefile.kvm      |  10 +
>  .../testing/selftests/kvm/include/kvm_util.h  |   9 +
>  .../selftests/kvm/include/powerpc/hcall.h     |  17 +
>  .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
>  .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
>  .../selftests/kvm/include/powerpc/processor.h |  39 ++
>  .../selftests/kvm/include/powerpc/ucall.h     |  21 +
>  tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
>  tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
>  .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
>  .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
>  .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
>  .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
>  15 files changed, 851 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fc320b373656..35df0c39e991 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14349,6 +14349,8 @@ F:	arch/powerpc/include/asm/kvm*
>  F:	arch/powerpc/include/uapi/asm/kvm*
>  F:	arch/powerpc/kernel/kvm*
>  F:	arch/powerpc/kvm/
> +F:	tools/testing/selftests/kvm/*/powerpc/
> +F:	tools/testing/selftests/kvm/powerpc/

I don't think sending KVM PPC selftests changes through the PPC tree will work.
It's "fine" for KVM PPC changes because the volume of KVM PPC changes is low and
rarely modifies anything outside of arch/powerpc.

KVM selftests tend to have a lot more cross-arch and/or common code modifications,
i.e. I think we'll be setting ourselves up for pain if we don't route all KVM
selftests changes through Paolo's tree.

Does it maybe make sense to have all of KVM PPC route through Paolo?  Punting to
PPC made sense when KVM PPC was on life support, but it looks like resuscitation
was successful for at least some flavors of KVM PPC?

