Return-Path: <linuxppc-dev+bounces-20931-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9714FCD37AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 03:55:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGGgT0G62z2xlQ;
	Thu, 14 May 2026 13:55:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778730900;
	cv=none; b=XYRyE8CI/4eLRZZYtnjdd4BLKE8MUMmZPguh29RkJAKzVML1Cn8jf1gw3u88OrhOPF2YRwDpefL3oG6YIlvMIK92GLtcx+Tra1WvMFKo1R38JeWVn4tNQ2M387aVrZMxkjkC9f+qkTILYDSzCSoaT9Plz2fkBh73AAzMe+EkAO/Ah06H5aYtxVfm/CF9YnWp4kuwFmY2AJaq3TnOZuMdqrx4WeaTQduC75WIggWqPhBkNPy5YupbEglKnRng3nR5eTh3KYba0XgwbJRSX/sPbe5Y5mOm5CnQ7z+OWnRaYghw5G6Pmk735+ChrcNAu9CUd38I5PArDjokiLXoHgUNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778730900; c=relaxed/relaxed;
	bh=PKqV86kcIyK48A4gK3vO7m3hgwBILm7DPz49r+DJUUE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=EgJPD3zFRsI7AYjxytDj8RhXDG7urdxR6yisxoNcAykEvrWo44sm1sF/sLMJwTUbv7JbdHUVTKt1GCHdaHTwnOF/eVIRfNCpRYeHVMl26a3EYCEZBh0DK8Vngq8SUADxg9vu3aYgYo2wheAK4Xy+tg7EkYxAsvt7YsG8HL/Tqtdnbd2OHiXJRI52GVEpGIbgD52rFoj44jnECDRUA3PGyVCMLK4AoGBMXCIB29c4hBcELVLZqMotBCPGyUyQa49od7csc11jgXmt+KHzLy6Wa8oPVuvmc7TJfAAHeoGwWufklv0E0MyAnt8AY8mDK2+gZ8UHPVhmX88wpgK2gZLWPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GazMYaB7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GazMYaB7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGGgR38Hrz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 13:54:58 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3684a6f3b0bso1879656a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778730896; x=1779335696; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PKqV86kcIyK48A4gK3vO7m3hgwBILm7DPz49r+DJUUE=;
        b=GazMYaB7lbNZINoQO5ARR056ZNQ5KT9wxo/tnUTjMc76o7infAiwtCFA7j7Qi7hAEh
         61YM63Yc2C7CvH/e505WrLkTuilgQ8cjpcCv+sW4iwFJ+LbIpgPxF1gS6Hak8n0IwNnd
         s5tST40PahTi1mgiwsFOOjYubhaGS93FY/182GEHzBCcDlG/hBTS5y9/RuZ58yBC0vIC
         VX1VoNxg7EjXXNb4nzlLz7NugloS2lCYwTTQfdwcELNuG8Y9JZ0BqdDLjnbqL6Ixgn1g
         0Cy7JDb30lr8VFR/mFSm+oqh0ScWkrxz9UL5wpcSig+xu38FkMHhcLSQsIx7txjuUl4t
         0nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778730896; x=1779335696;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKqV86kcIyK48A4gK3vO7m3hgwBILm7DPz49r+DJUUE=;
        b=K4LpjyU9b2Dl3sogzt1r20mkzAz/tYqsJX/tOtBjgQzODWMbdfLhKRltjyQcNyTbJa
         dVh7tES2TVcsGzdU88Io4HB9XkhCn91B6wLnlGnya7SCC4QoMNzGH6NGhZi2G1lNP48f
         uL3i19cks02GXER+nPrvhM+mdEzTYiC5LCbIgUOjei/sXUkUFbW0Giex0P3uSZdAnO6E
         0TC1UwROHa2tTBALj80CMbFF+xyfC487tEgoGVREpMbhE/Nll/vI0+uoDhnBxKMBORVy
         WphozsEsPRZFWv63z91rx0xktN7kEvd8hVAq1FZVJi4pb42gO2cscztl0JH0BpEdJLKj
         IjlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8L6FKv2y6onLVhF3bhMYpbCxdbQhI/5MtvKMo/GHyzKbT6Lw1t9MW1W/gy5S9U+6f0zAbIVLeVw+956Bo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxpA7IuW5Stlw5QZvdYUX7wPHvEdMQIIJbKQWPiHg8dfiUtp8Th
	cw5DQ7mUOH33TMPHE+js/pZUPL0UKrjJBYyy1WrEpINCs3YxAtDgd5Ki
X-Gm-Gg: Acq92OGjPpVNh6z5umHM24poKDSxFBht7nuD9hsSlo/RDZmQvqJj17tRROAiczyhHWl
	RMDSB0vZWLEXjBMqqEz9DQe3EvIi4p6z6oV4MPpsYFHDkQTirpVfBWTTx/hq35teK2JZ99ELsvd
	pDdguvFKJm6HMVQfGmZi70u6PKPQuh59yNty0ge23tL5hms7azMQZW2IgL0MPbYtINvp8Mx7nwb
	YlyeWSTV++M4AJHC8EKg5+YZJWA2qLi9BKUTyOKMH1Q9rIlZUw9KW0+mkpTu2vYhTEDyAhGWzMa
	In7hjoAMOew0Rg8voAWcas6/lCf5TcWTeALIPBgnbic1rpyCM2xZF5SHCe+VSKuHWHHWqhM4edN
	WHJ/X3QY4kk5zLtwDJB+Eg0sdGeqWLRfdsiertU2MBf0zseZ+5wExtt8nks5uMEGN2/3c8jjzq6
	lrQZ53mgjf+VC8Kfjt3gOgbw==
X-Received: by 2002:a17:90b:56c4:b0:366:44a4:ab0f with SMTP id 98e67ed59e1d1-3692346f997mr1680017a91.4.1778730896205;
        Wed, 13 May 2026 20:54:56 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ede20a50sm4803643a91.3.2026.05.13.20.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 20:54:55 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] KVM: PPC: Handle CPU compatibility mode for nested guests
In-Reply-To: <20260513100755.83215-1-amachhiw@linux.ibm.com>
Date: Thu, 14 May 2026 08:49:59 +0530
Message-ID: <o6iir82o.ritesh.list@gmail.com>
References: <20260513100755.83215-1-amachhiw@linux.ibm.com>
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


Hi Amit,

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On POWER systems, newer processor generations can operate in compatibility
> modes corresponding to earlier generations (e.g., a Power11 system running
> in Power10 compatibility mode). In such cases, the effective CPU level
> exposed to guests differs from the physical processor generation.
>
> This creates a problem for nested virtualization. When booting a nested KVM
> guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
> userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
> and attempt to configure the nested guest accordingly. However, the L1
> partition is constrained by the compatibility level negotiated with the
> hypervisor (L0), and requests exceeding that level are rejected, leading to
> guest boot failures such as:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>
> This series addresses the issue in two steps:
>
> 1. Detect and reject invalid compatibility requests early in KVM to avoid
>    late failures.
>
> 2. Provide a mechanism for userspace to query the effective CPU
>    compatibility modes supported by the host, so it can select an
>    appropriate CPU model for nested guests.
>

Do we really need to add a uapi change for this? Tools like Qemu can
read the device tree info of the host, isn't it?

> To achieve this, the series introduces a new KVM capability and ioctl
> (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
> compatibility modes supported by the host.
>
> The implementation supports both:
>
>   - PowerVM (nested API v2), where compatibility information is obtained
>     via the H_GUEST_GET_CAPABILITIES hypercall.
>   - PowerNV (nested API v1), where compatibility is derived from the device
>     tree ("cpu-version") representing the effective processor compatibility
>     level.

See there you go, for PowerNV if this info is provided in the device
tree, then Qemu could as well just read that info, no?

... yup, kvmppc_read_int_dt() can do that I guess.

So, my request is, can we look into this to see, if there is a possible
alternative to this? maybe we already have a mechanism which Qemu could
use to get this info already?

btw - I haven't given a full read of the patch series, but reading the
cover letter, I felt  we should atleast add this info to the cover
letter on, why a uapi change is really needed here, why can't the
existing alternatives work for us. 

-ritesh

>
> This allows userspace (e.g., QEMU) to select a CPU model consistent with
> the host compatibility mode, avoiding mismatches and enabling successful
> nested guest boot.
>

