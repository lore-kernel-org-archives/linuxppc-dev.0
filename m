Return-Path: <linuxppc-dev+bounces-25450-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D39C55ABA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 19:04:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFfwf49xWz2xqM;
	Thu, 06 Aug 2026 05:04:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785956674;
	cv=none; b=ZcluhL1MeANzYwt9+dkQpZ4D+D6OlkJh5vLHZ5mIAocjXMgDubw9NvYrEARNCiuKHePQgKOx3fF77l9fjKEUsfBuIkYP5IHK/G4jsPNnsYM2BiGJdn+58TIqu/oepitju4fPEbAkhblctaHHsMPYIFLZQ4EFsQI9xvni8yDhaqBnl3ILvl2b79R/iJKG7woWeGfuSxlp3mazh/ER7TCU8rJgh6Jb4Bu8rlGbJE8AcZmeei62rlwlBMbB1XwitSAfVm/UQkVTMPjgOJvIN6Dw/8wOx6H/EXITsEkn8pRwq5PvyQqUl8gS8U87VHmpGt8fABwYo+o7OrFHeQnjA7k+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785956674; c=relaxed/relaxed;
	bh=V5Nj3gKC4yEN6e3D1EtvSjC4Has3vClSVMr6RcOyF2w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=mCho/kEOz0SXc1IsB7BQIiQ4j2BTzBRw7uo3opcsIHgM5gA5f4kkPjiRoV4IFIlRe9y5mYHKHRfxFmrreW/2c+S3KEpWeQnFVg1nYX6Xc4/tN2LCPDS5wgXYo5BZMw4E8RHKJMnl0Fd0yYsFQ0Mng/wFG3i4rVUZIXF5jzkXWX7e4hXbC45m6QwLzz+Qo7VSXmv3q2qCuM8ln+sjQMr1YSsxQddEROjrihGK82E2H9drOZZZvnT4wmXQVXuxhkf5Zn+QLs6JSdb4qyMNQVwFhs6+jewFYAAzIFH5JQhBs0GYQquwNrLuN/9K0NpTh+h8stLXLXmuJLh4VM4F5kpQmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BqRiFybo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BqRiFybo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFfwd0Mxwz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 05:04:31 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c998fd549a8so1069786a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785956669; x=1786561469; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=V5Nj3gKC4yEN6e3D1EtvSjC4Has3vClSVMr6RcOyF2w=;
        b=BqRiFyboc4yqt/2Rd7WaY/O9Xox5/X/dRPsR2WgYctCDioJWADSUDtDpFgz0pieA97
         faUu0qaamQ6XIIGxL71G33WpfHDlmIGdfylRlx+K7oC7CYZomYwew3yzg+/DfSCaz2Ks
         TrgjRa0RwMKMezcM0m0lb9bfVcOYsi9NMNXvzMBmKvnqtj6AEC4l6V5WIBVl+r4NO40p
         3uiSq24DEb8efbrYYdYqw72WTqPOD5etmvWxtOXkAfyCuvZHSfgmHS+jFlI6d1zbsZcU
         /TxKPhpkiGO7wtxqROXUx9zLiHKznvDcH2GqHVDKu351DJlw4+FkReqKgN1WV5JlE/WS
         H7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785956669; x=1786561469;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5Nj3gKC4yEN6e3D1EtvSjC4Has3vClSVMr6RcOyF2w=;
        b=Gt4dUN4z9/NBtPlq1fuC6k5Jr0tCjLZpMa6aNAqnvLYVCvT24X0xIQqqstKEjEA+dx
         sXlntSE3+KHKTJdyBMDI72MQI5nR8kDwmLbDfAfSkGi1r17pPCY2uaL7ac3nEudlZIG9
         HF++igpS/m+GeUodvloH8dL1y47eJ9K9UQ881qvVEu1y+OzFk61cvYgOShsen9jqYJLr
         f1fFfcm/v7B+FF0OALdoPGhLDMNtDd2fxUEAY3FW6+dVxyCOaASej7Te+kNVThaedWlU
         eXZfDgUMLASRGXu2uUVW4Y4uaKRHuHW8qNBG21hMvz5pGoYtQH5e5tVZPC08mqxfSCw3
         N+Lg==
X-Forwarded-Encrypted: i=1; AHgh+RpNMtXcgov0QPOt6dWDv6eUn5V6M+AOi9QQvJPOyq2mHLhxQggRkKYcxAdQ+WL+4euBxfRKJPzXR8eMMeM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx78Y6r16Yo5h6TuoYtBiqtOm7QWbyYZ3xYp5EZ6jC7ZXBoHdom
	aWxioCjQuJ2H2jMVTfMiyv0bWqrOFFlXWatyTKTI7+oIy43HW7Y2bA+E
X-Gm-Gg: AR+sD13VmtUw4W7UrGFvaXu0B7+B/T7ih7TzjdD10KJCGRQW4wy6ECIEqwtyOhkEoDq
	gO2Qa95QTVGgmqhy2/KrT568pz6bDgYO1DXZ820qaIK+rrPeOsdauAnOtu1vJfvBWxVYQpVtNvN
	hcUGAycpmVDYnfytvGcKG44K38oKDpAhrhu3KwMJDXO9BXAFEbTClVoxgF8b97DVNjvdos1pxaZ
	94EwlETHtUA66+TqVBf9fZqnKW4j0JL0iWvdUuwolJfoRM3NjmcRZq0G8lUTI0vrtp7Mgu8/CG9
	Zf5J0fIa73wTonjcH/M7jmtU/g1JkGArySLBIYmxdcmD3p14m7AUO9cD3+QjinUig5VaLSeAchh
	8OurRiVZWiFBQQRbhpVIIXkdAVv+xaz5HoRxgXTLrKInzauRXAOSYSyDNe1a3GwEev09QZdRLOK
	hmgoaaop/nBfyLgF9KdXFAUDH3m3eP4tHePigY39UREy2wZyTJ93Is2srqpYM=
X-Received: by 2002:a05:6a20:918e:b0:3c4:46ca:334b with SMTP id adf61e73a8af0-3cb85e2acc2mr8616548637.9.1785956669049;
        Wed, 05 Aug 2026 12:04:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a68fdsm31787485eec.25.2026.08.05.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 12:04:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 0/4] KVM: PPC: Expose CPU compatibility modes for nested guests
In-Reply-To: <20260804180705.59160-1-amachhiw@linux.ibm.com>
Date: Thu, 06 Aug 2026 00:09:43 +0530
Message-ID: <tsp8l8cw.ritesh.list@gmail.com>
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
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
> This series provides a mechanism for userspace to query the effective CPU
> compatibility modes supported by the host, so it can select an appropriate
> CPU model for nested guests.
>
> To achieve this, the series introduces a new KVM capability and ioctl
> (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
> compatibility modes supported by the host.
>

Sorry, but I am somehow not convinced on whether we need all of this
machinary just to get these 3 bits of information, which we are
returning today.

Since KVM_CHECK_EXTENSION can already return an int, so why can't we use
KVM_CAP_PPC_COMPAT_CAPS itself and return the bitmap of supported compat
modes to the user?
Say if the cap is not supported, we can return 0, otherwise we can
return the bitmap of supported compat modes. This will easily allow us
to use 31-bits which as I see would be hardly a problem in the near
future. In the future if it grows - we can always use KVM_CAP_PPC_COMPAT_CAPS2.

This should reduce the code complexity both in the kernel and
userspace and we don't even need a new ioctl then.

Thoughts?

-ritesh


