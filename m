Return-Path: <linuxppc-dev+bounces-21714-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D502DCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 12:06:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRhsy2fKKz2yQL;
	Fri, 29 May 2026 22:06:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780056406;
	cv=none; b=DR4esCn+6SO3m30yWAN4s9wUa2ZeK+rDMtLwY/mzL6JB7iLWDjjPX1gvknQtr+g7YDCLVVUXRTH4TOEJGvBYGl8/J5ztnvfpnpJnUr8P3X4SieHjHgPX80sV3EKHWIATYtKchKh3C5uhpJ7FSEluuheb28/9HT3Khmhaxvj3PWUYodZTqEePtafhqNt6A/rTHaCYLgh+9o0r7mgp03U5IZbC6y41PVJluDjQNSOk40TTVHtY/MTPKr9gNwYOMd860hYoGoPBFCF2oL6/nHiVsiGpgBqkpRuiUTY4VrdYAPu0CrT0/IBX7yH9zyArO1lvCtHQu3E5UO1Sun/0xQFvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780056406; c=relaxed/relaxed;
	bh=hMTekUZk7VJcI+1Zj/828Egv6I3G6W5x75YXUNbi4R4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=boJsnQHkG1jF3ultPcmiNXMpaCAf3R91aKmpQGKPefJA2oDw/wzkLyNrL8Y2oakh3osyziC78tNwjvCmh9LJZphxLOmaluUWpWMw8+ywo1yTSqPn6psiRLAlhEg00ChLp3ZuW2SD5g5hBlxxlxPC/aBfvpO7pDNSJftPDVqWtX6Bp73G5d6mHEpnEaMoAFS/zoanizOO1fRyU+Y7fEJ7QMSJteKMDrf7eWXqlI5OViStqpumJwZS7yUhowqlMPpj4AStfRKirb8AE4LQX+lyiTfHIsvQX1x+dNXD4QVYpMng8h78Vak9iq7jsJsVB8VJkISdEuQgk5lwlaLkS/rKzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qNa3hADv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qNa3hADv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRhsx5HTBz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 22:06:45 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso7020372b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 05:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780056403; x=1780661203; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hMTekUZk7VJcI+1Zj/828Egv6I3G6W5x75YXUNbi4R4=;
        b=qNa3hADv+LGiu1uB/RnnG/knRAQ/3nOVh1hoZzhzerLE25pJ9vKm0+V4l5Ktmaww/0
         EvUQjeOgStthDOEns2kVby5FAyJuQpFPa0Biu0+wFE0ZPBNIe91vArcMgkTArXFwlGbX
         8sBnoivZ/e774y+WhUyiLFm3aPxdfUbYJrA6cflMjkgxELYWoFPFBdnhs/aM/pK0LrNi
         chHOdk+1Vi3UoJZ08/wwmlG1DXDvB7/nlSOt5LDF6vd06jqRa7dYrFdysO3x84pg3oBs
         ym6PLEMzHvHWZYrpg2CR9u+jsKg3lzJpLk9vnAM4PXzrOQ6XpcaHqP8TbtVONe1KxpHB
         iL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780056403; x=1780661203;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMTekUZk7VJcI+1Zj/828Egv6I3G6W5x75YXUNbi4R4=;
        b=SGd1EBQkTcHT8rjQWEN3oMvSF+yhIxYn0FJ5nv8XRpi8vAibhXi9qgdBr4RpHZaIAX
         QnpxduHqu0g9y30KRTizkaTFYG4CMKEruiRhQdO3Y1PEfIoT/QlrQHSz8Z6UhtY5D+7W
         APOoQaR0LZ0vN4zzEWsdL8Drns5LysPH/eiWh6qN9UyBKLnv2EWZHgREA4meBXt+HrMN
         JFE418mNdcMdZf9EGbnyzlwOmuAjyirPuwhnzW1S0B0xvZztWof1AIsM6sZKmi1SWmpv
         XNA6AcKloHrwNTMtaNhB8ELfgjcls8aqo2FybwRV7EZMxsDiOGJJr4ZU9uT/o3Bcg8Ei
         HQbA==
X-Forwarded-Encrypted: i=1; AFNElJ8voVIxzoCQL/Q9BjDs3wHoHk7jnv+9yq6woMUIwjDxMEz97UFC52OEOOM5BzXdyXLZWI0ifPFrGqCbiis=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwWDg+HJIHNUoasHG9c3IKqEfL3bMTlkiac0PmAX5aqaXcBcEgq
	3Q1aa5LMAfO9XqWMXBNxuA8z0VZzXvECvfAwktQ2dPLXb7cQnVnsPCcf
X-Gm-Gg: Acq92OEaTvDKGCBy3prH2dlz+eOYhRB6DuInjryKUJ6pa0DQ/srTQnH2YImDoYwAdi+
	mtyKSq9Lf9y1XF/j7IQ/JvL0VQgDCSEXavEIcadya0BhouVeqR7gunSWvpWhBktTl27iQBawnLH
	SPzeocjatREq2syudassRSS06Zql1FV1QVmOBx373O2KEWHqKh2/p90FHc2H5ojmXdwnlFWlo22
	cg0gC0ym/hLoR99hf246/YZaXBm8Iq7oZma3sMVMbA1jawhPnk/aqEBULIwEOW8Z0v1p3zpGTIU
	YAotjd/Mv29ZibeGR+oV6RuewJAMgFLEYM0xX20snBg0jqg0rWKd2Sx979qZ3v0LLS9rsLchWu/
	w8yqbyRYRcpMHRXAWqoxTWjD4uKtfViAIiNwwQ6jZLvOsX9Ir58HTQzBu25rvqU0rGfgbtKk/nl
	DxR/pfxzz4tYsYamPghm0n8yyBkR+a20Gg
X-Received: by 2002:a05:6a00:e07:b0:82a:146d:36a3 with SMTP id d2e1a72fcca58-842119f9081mr2172322b3a.21.1780056402907;
        Fri, 29 May 2026 05:06:42 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214afffc1sm1838798b3a.7.2026.05.29.05.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:06:41 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260529141530.fc225a67-e9-amachhiw@linux.ibm.com>
Date: Fri, 29 May 2026 17:23:39 +0530
Message-ID: <cxyewhx8.ritesh.list@gmail.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com> <20260522152744.55251-2-amachhiw@linux.ibm.com> <pl2g6xbz.ritesh.list@gmail.com> <20260529141530.fc225a67-e9-amachhiw@linux.ibm.com>
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

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> So, we would still want to prioritize the whole series
> instead of just this one patch.
>

Patch-1 could go as a bug fix even in 7.1-rc6 (or maybe with 7.2
bug fixes). - Maddy?

So, you may want to add a fixes tag and maybe even cc stable if you are
seeing this issue from older kernels maybe when nestedv2 got introduced?
However the new UAPI discussion might still require more discussion with
the community and I don't think it is ready for 7.2 yet ;)

-ritesh


