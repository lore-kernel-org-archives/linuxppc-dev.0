Return-Path: <linuxppc-dev+bounces-20135-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3D2FF8850
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 00:37:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3l580G8yz2xdL;
	Mon, 27 Apr 2026 10:37:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777250235;
	cv=none; b=jXFcES9kj6g5I31Qztf1ogjDiuAsUqf+GX3mLphjzOwr5jcb1bDaJ/fdIXVnqtYtodFht0VCYSADulrCd36yYwHprsuEKkTWVh6psrD7ZPzdBZ1xAGYHd2/K/GwyAp+EzacnIjFMjuhYdQUJZNj/zFAHhDsSJebpm6kZpxXI6vjhp1lzWcIRKUy+YnuoKE9FD7z8M/ghKuXoD9IcpZo1bmFP1lzioV7XxWnYBEevx7PTd3XtsbaeRRP0A7zaTv+MzmeDxuhDDFGtXvhhGNE3RYrG4uF2x4UN7FdAEjsSCVu2/HKv5N1uSHoWcr7H8sNmucyFHi4r98paucS89sFMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777250235; c=relaxed/relaxed;
	bh=mVdfUhTIoRGg+RbxdXBCn/qp3+VQxZ3cyedRP11wnO8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Dj6Hzxdu920Kndyk4HSRwm9FSzqT6MFrIptESjPANzGREgn9tL/TKpmBfHc26F4NKOIOfErInciq6372XU9aco8XPA3NajUPGwah60ESiiPUQDpa4LKGWwyttZa3BRlZ+Dom1hjonCAqGxR8m1XYv9ChvOiSjKYLDB/qZf4+boYJHHq12IYCOyzq+Y0GAJl0bBU5Zg92ZpH8dYuRhBNIDeyJVq87gtSkgSS0EdVmWy983osgMk+Ga8WANhhY5QIbr+naM4tJdRUW+OtVlFyv4lPCRWjqSNZLumo1DRWJU85X8iAaGHPj9UEtyf5y3mNhCK3+xfdiwahkxE32pHiQqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fNtNJSOZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fNtNJSOZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3l562V43z2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 10:37:14 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-82f351ca23cso4847462b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 17:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777250231; x=1777855031; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mVdfUhTIoRGg+RbxdXBCn/qp3+VQxZ3cyedRP11wnO8=;
        b=fNtNJSOZ1jHxarVXa51reJ/MmzRs9t1xRJ9neJQnHud5fMXd6Xs97vjQPqPQFWj/Hb
         F3Nsspv44lnTyTw3CBlOKhXQU9KjUqhvoHBSHaq+/z0r8YTCFXM0Tv1b27sH44cSbzLp
         skGDIko22iifTOPcdlOoRkAredEC5pc+dPjGha/1uuj49bcGTiF5xbxsc4HyOUSBV5GJ
         0Pqyl7HM4FuIVyfApjpAcnv94rhGs0Sk1ZSpxdGD9KARWwv2M82QyLSISVoDFvHzPcBY
         aDFOB+l01hyfT4sujrau6LcO5H5TgLQMPZB6ax75YXlQHRw3SDhOLHG+71DkX3ZRj6V5
         HpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777250231; x=1777855031;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVdfUhTIoRGg+RbxdXBCn/qp3+VQxZ3cyedRP11wnO8=;
        b=XywNcsQMwE/Ywg5jB/BjxsFTgIVnFoncSqukXkby9PF7hYNaZY4XYI8SdrzJ/RYqpp
         TZ0BlkfBeafM/H+uqZc6unv/NXGFJBPCRuMCwCqTJknmQdhr5nwp2tuSi9Ze9fusRNXf
         afueEdfVF3JXajKYIG8ovhIY2VOdBwxkY+CEU8ssnbMO/k9FdCX5v769bnT1nbkNZ6Z7
         WQMn08aS5cyMR5qZBfNXJrKVenWEldLOaisuQsM/DRlo/A7UEqjFccnD6LA1XQ/IC5GW
         UEpSzGeZYPgOqKinDqOJkL29NMomHE0RF9RdbF1cILIVABRW5/lUjME/wbH7U/NY/I5n
         b2bA==
X-Forwarded-Encrypted: i=1; AFNElJ+egWyk5TQVXqSRlEKx0DhnJF0PxqVeXHL8n3n999xsv+ATUED2Mn2x2svPv52YWeova/4nuFLaefuN72A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIMbq9h0IL0kQhswuUjOkn6sFuqme9jwLzkOzMiTOn/tKdDdWR
	q54AErLCU454F4MfeVk8loiLjEmDvRE9RJY7dNZbG7ttV9fg+3AfVwV6
X-Gm-Gg: AeBDieshyBlwshM0PMfeRZQrLb0eqWM4Ulo7Qb7bKdW4/lPXODQPNf0pUM3QRfgjkBT
	VbWnGYkHC350weyydKO2wBjtmw0iLZ5LylD9oRpc0Mh63CR+dO0/sHPRIw6xCw0EVQ6F97F05wD
	tA7N4THbAf2EqhgnXVC2R5tuBd4PYzHV+AYb/JHj61xUUNQSADYjkSY8JmX3U+N0MCToFW+ADgc
	nUVntB9Sak2BDAUt1yYg15XyYyz+sb95xKUw07VRm9i3AvxzyLdvcaIKeNW3uvzFEzD/yW7A4h9
	XCIdW4b4bcaWja6w28VvV/ag+mp1DNB0PZdB9E+HIkim3Gb+BGCxpjWKppEB0Ya0QsTI9yEyWAc
	bO4RdhJZafxdlWWyvUcGY5Z3Lkxh3Hwcmj8yM+T/EUb6hQfp7q+TreeiCiQ8cQeZxXEFGX3utqR
	tqkVcd5fsr9jFPx27eYaHBtmSt0eqOSWaO9tuBfyjDCl8=
X-Received: by 2002:a05:6a00:4308:b0:82f:3733:2f96 with SMTP id d2e1a72fcca58-82f8c82e853mr41049342b3a.8.1777250230657;
        Sun, 26 Apr 2026 17:37:10 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83336687182sm2598534b3a.35.2026.04.26.17.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:37:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for tracing exits
In-Reply-To: <20260424092558.31798-1-Gautam.Menghani@ibm.com>
Date: Mon, 27 Apr 2026 06:00:46 +0530
Message-ID: <lde9s0qx.ritesh.list@gmail.com>
References: <20260424092558.31798-1-Gautam.Menghani@ibm.com>
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

Gautam Menghani <Gautam.Menghani@ibm.com> writes:

> From: Gautam Menghani <gautam@linux.ibm.com>
>
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
> trap reason is displayed as string instead of a vector number when using
> the kvm_guest_exit tracepoint.
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  arch/powerpc/kvm/trace_book3s.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
> index 9260ddbd557f..eafbaeb5a9db 100644
> --- a/arch/powerpc/kvm/trace_book3s.h
> +++ b/arch/powerpc/kvm/trace_book3s.h
> @@ -28,6 +28,7 @@
>  	{0xea0, "H_VIRT"}, \
>  	{0xf00, "PERFMON"}, \
>  	{0xf20, "ALTIVEC"}, \
> -	{0xf40, "VSX"}
> +	{0xf40, "VSX"}, \
> +	{0xf80, "H_FAC_UNAVAIL"},

So I ended up looking into other trace_symbols too and I don't think we
should have a trailing comma here. It may cause some issues silently in
trace-cmd or other places. I remember going through it when I was doing
some other tracing work earlier but I don't recollect it now.

Can we just remove the trailing comma and send a v2 please?

btw, 0XF80 is correct as per "arch/powerpc/include/asm/kvm_asm.h"

#define BOOK3S_INTERRUPT_H_FAC_UNAVAIL	0xf80

-ritesh


