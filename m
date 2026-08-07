Return-Path: <linuxppc-dev+bounces-25540-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1975C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGWV04Wmyz3bwf;
	Fri, 07 Aug 2026 14:32:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786077176;
	cv=none; b=GY8eW900TYLAhHkRcEA5qRz09rKyb8R8djhbimJeuy0wLTehL4q9RzLDBxTxK6wSfiA0/LoCLjVnOkNJN46pDQIp/WbfO/fTEQQ3Ztgs7mYrAty1sCX/YpsR6w+Sh6A+tSe+PZBTUUkmfdFAf/ierZaIDr2rAus86sXahlwO/jnHrQHdr7dY5YXn7abNH0mNhmc0LvU/GXANv8+q/H9NTt9NZqmhGRfOBolNukfhO4hQlvGznAtkkovIU4rNRPz4DW1Q5qrrq0owgUlDBfwIMRA679mV5JQLqxhyyahuPmFLQjKcPhTeFH9qlqFHGr7HdlyEQJM9Orog+5RJdmaBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786077176; c=relaxed/relaxed;
	bh=Vkqjg35/cvh8GomrXzxAYhQLuU0mAPIeu9aJpH6Zlvc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=fZWm3v0XIyncpMJalD8NljElWh031RbYD/ErZ3H9SeNV5+HKrDuccEBL0U9geyhNwg7TFyS6HhhOVhRinkldYfvYj0GHdDNUdAoEeHYicdF4TQBoNEOQv4wts5QFy655GjjmeI5gNkmTPZ6YmkSO+JBUAI9bc4TNXPMsclmuqP6DKWdJZS+wadnvdzSLTbPRQ9uA+jdDofpo4I+oy/gVoT7DTceqTylEx+Hk3PBXZKyKtpzkoZit9QTCYI4WoQdilXBucDlqeRZVKLSMgs7seeR/Co6J+qIRTkUk01C9j0hPbNDaNL1zL5M+EukUHvcJK/Wcsox/WYCGhn7I37nIDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gl0McVsa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gl0McVsa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGWTz1m2Fz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 14:32:53 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2cc891373e0so36047995ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 21:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786077171; x=1786681971; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vkqjg35/cvh8GomrXzxAYhQLuU0mAPIeu9aJpH6Zlvc=;
        b=gl0McVsaJJW5AVC/FEoHpPrPFkZDKzFX1PNWzpefsFHVaZT5UJCbmXUJ8IkCQbe4k8
         2NttSdreIR7dzJhOH46mdTRUlZS0NrL09ARIOrfLxWt/NUXdCfMS+SbJB6VPbvCeer1I
         yNrBiowwNNNMfW2GaI4AgVBxj0fuhq5+OmjH+kdwXXER+j01xjl2VbHjJItwyNT+DJiP
         GDwv9CiqZsbH92HlQ/0Wf1C4t4w7PQUX8HKFv4uVcwl7aCajQr82Ew/ZQ5jM20Q2zEpz
         O0E/zCgr8FwTsuBjZvqzTShEB/msWbg0O6hWvA5/VrWccPlKJKjXUPmcWH+Kz5/mCBNO
         z4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786077171; x=1786681971;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vkqjg35/cvh8GomrXzxAYhQLuU0mAPIeu9aJpH6Zlvc=;
        b=cE3AchOTHaTq/XC7/JMLtcHWSbiDUEJXyPlAQ3wTDFNKLnA5AR5jQSHCCPsjA/wBy7
         I/Upb2WojIloIcLg3RSepek3/vXeuYOd4uycn/mSdemXku0Y0Vpav1r3j8ukw/rxDdqY
         F5zPx204W/pF3MHAgezmFNs+w9ZldqWNrsnDPtiV6iuLrxak/6Z8ILmyri7Daakaq94S
         +pBq5inEBuuTkfcJqM7+WwWsOsVPEPpCMXF+JfyiMPgU0g8Wq/L9krjT9D2G7T1Fwb1L
         EVnWc2YOoBc+lwmgdYmuA1qpG8dL+6rTJJrCFoGdRofJYIlOPmj3vXMPMp2Cmxm8ygQ/
         vtIA==
X-Forwarded-Encrypted: i=1; AHgh+RpACcvPHKIrbB8MChYSX3K8L4PUv1YH/biogOxcOEb5fVmWayCCKkRGmZPBVSI/oCsvFoeHKBVKOc+gYTM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxRTERhE4YEtHwRdxLFFh6PnHH8XQsdH1rBjs2NCraQUb1mgkr4
	aPPvZWGzTli33eDByD4Q1eCo/gv6lp+3zKiOaoX09Ale47PiwptoV/xe
X-Gm-Gg: AR+sD12lzDa0INphQ8Vo9uLQjgOx5Z6KbEPBK759G/FMWiw2FR7774Ukajnq5MTitms
	1Kd20Z602Uuew1Xvcz+vKFG0iQ/xOHAjmOPdXwrNG15Cbkj/snnaYC4tf6caQ7YeEqnoLVU5tht
	wqsBUMIxx4AwwNdzwYx4nRzTKj8DwYB570+wY9gGJ0me4BunISC5s7ZKWLfdEdwCTeVj1p3/qCP
	UkMKRvb5a6vVxT3Hq+3+kHQKQGnK4kYfeHHY6c9mfIYjCzyA3DFEtvQkgq/4/nj9RjOZlxcsqy8
	y3yOiNw7nmwFbE4pL6XMBg/pUnmV+VG/MpEpGNAn4hYKzJL0k3P0pfPP0YIRyyzCPMhoCUDgQzr
	jZup+47PMoG61I6O2b1MdGOXkxEACckyRn1+mMYjjbjRMpblGF6Z1V5KxEvPeg7frUEbqObxMee
	JwoLVovSgKaMEtGC9GbPFsTfmIGLGEZeGw+S+gAB3JBbLciieo66s9hBz4QvO1mZaVCnIf1g==
X-Received: by 2002:a05:6a21:685:b0:3b3:1b38:d9c3 with SMTP id adf61e73a8af0-3cb85e99243mr23742133637.4.1786077171329;
        Thu, 06 Aug 2026 21:32:51 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde353sm2604158eec.23.2026.08.06.21.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:32:50 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 2/4] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
In-Reply-To: <20260806170645.11892-3-amachhiw@linux.ibm.com>
Date: Fri, 07 Aug 2026 10:01:58 +0530
Message-ID: <h5l6lfep.ritesh.list@gmail.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com> <20260806170645.11892-3-amachhiw@linux.ibm.com>
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

> On POWER systems, the host CPU may run in a compatibility mode (e.g., a
> Power11 processor operating in Power10 compatibility mode). In such
> cases, the effective CPU level exposed to guests differs from the
> physical processor generation.
>
> When running nested KVM guests, QEMU derives the host CPU type using
> mfpvr(), which reflects the physical processor version. This can result
> in a mismatch between the CPU model selected by QEMU and the
> compatibility mode enforced by the host, leading to guest boot failures.
>
> For example, booting a nested guest on a Power11 LPAR configured in
> Power10 compatibility mode fails with:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>
> This occurs because QEMU selects a CPU model corresponding to the
> physical processor (via mfpvr()), while the host operates in a lower
> compatibility mode. As a result, KVM rejects the requested compatibility
> level during guest initialization.
>
> On pseries nestedv2 systems, add support for retrieving host CPU
> compatibility capabilities for nested guests on PowerVM. The capability
> bitmap reflects the processor modes negotiated between the Power
> hypervisor (L0) and the host partition (L1) via the
> H_GUEST_GET_CAPABILITIES hcall, but is retrieved from the cached
> nested_capabilities value populated during module initialization,
> avoiding repeated hypervisor calls. A WARN_ON_ONCE() flags the
> unexpected case where nested_capabilities is zero on a nestedv2 system.
> The implementation defines KVM-specific capability constants
> (KVM_PPC_COMPAT_CAP_POWER9/10/11), masks unsupported bits, and exposes
> the result through the KVM_PPC_GET_COMPAT_CAPS ioctl.
>
> Hook the implementation into the Book3S HV kvmppc_ops so that it can be
> invoked by the generic KVM ioctl handling code.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h | 10 ++++++++++
>  arch/powerpc/kvm/book3s_hv.c        | 20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+)

Looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

