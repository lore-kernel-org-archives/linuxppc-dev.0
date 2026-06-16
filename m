Return-Path: <linuxppc-dev+bounces-22682-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854C1CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 05:26:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfb806fdXz3bpx;
	Tue, 16 Jun 2026 15:26:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781587600;
	cv=none; b=dPRMPiPjdVae3jA12vF+oJmM5H+FKO3Mp8Gzo/o8l+YZi1qsjOva0YuENKpdn8l3/yQxTJGTKoKOIB6d7GQOhOZ/w6DWnO/66QKR8eo2TC5XwonA9XubWM6B5zQe71M2I3W7jK6+WeMTxK+thxF1VUyD5NW2tTbfGXd9BXs0ImiBYg99+staY51PiFIvuonHA6juK9kk9zisZUYsqXc9n3xlE/3M5XrVIkgo2Ci9Y73Y1M7j57dL4rmrURNRMJRHJoK6q+XuFdZDAAteQnYA3uTtu0xRLuXWk7QYXk4YAxcUppxfrEfAHt0w9yrQSer3Fe2OgWLDti0z37IKAqA//g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781587600; c=relaxed/relaxed;
	bh=i4n6qBl+KTq7TdCOLaPzBA6e4TkFS/AdafSUnLDct10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/5Z/0tBWM99eLzpdXg5tQnXq8qlccCF2wOVFyFEfidEWuSG3rKqu/mrvchZPY5SdPFVkIVnxQbXFgrJtJ3A4RTpyDJSQPQRrurAj4Nb46hBmIuKuHYLuKVLNqxwEHzMhgXYe3u7E9nWOCgctngPVghycfhwc0++Bg/rDNu1NXoLDQP5xlDfYdfil4hCo68Hwk94Uke189EBY44lz0mWupT2pAtNDFm/sy8wOB1Li+LZ54QI+7js+2gUVXuunJvxcMIBeCZBqWxEBIavVvsbhJUcsnO18L9edgehZd7CLcjlWNT0Q5f+BIbdj3CdvXlpWzxbg9kSCMFFiTRJRSHGVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b8aQcrvj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b8aQcrvj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfb7z68FSz30FP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 15:26:39 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so3288907a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 22:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781587597; x=1782192397; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4n6qBl+KTq7TdCOLaPzBA6e4TkFS/AdafSUnLDct10=;
        b=b8aQcrvjEJ5XMJ8ObOeUj/mXx1SsCj0G+Rk8W39W0ycRpunUIZ4yJPJj0Z6JzbSu7y
         7lJxHBw/4nh8VmN43puWcEA8VIAzhmjSAltp6aWZUEW15XQq+I/EjGku1+teDcEiTWBi
         fU9QpwVCrRFQ0NugZ5ppVycKtLFSQfPlMSl7NGHn2KarxO87XzbZ0xxXxd9n5566c5Hz
         RbkyLmxsObcr14tPTc5z5ILg0GEhdbf/MqbuMXje7VokDNJFCJufRURIjwM7PECBUHVF
         NsviBQE2mbqbihdsUXZoJFUm2b+INAO1CuYjX09hmzb2DBYYSO8hJ3Ymh8ZS78mQ8dmU
         MuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781587597; x=1782192397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4n6qBl+KTq7TdCOLaPzBA6e4TkFS/AdafSUnLDct10=;
        b=YvfPYxrLYlgSxSl3oXJZ2alkkdMKu0k5VLl092rgsndo3IXA9WRqT2ZaD0gLIZnLKX
         GbLn1TO5j6FAPTGh4w5sJFBXKHCWFMrW4zW5ghq5+pz3MCO3JfSnoqYlznuoafhTgX1p
         yEGkltmjYIwQXhyV6S7EVudaPi2Q7E0Ps9DcxOTE4/l/Mflx8Qb+VbcP8Nhf35Yfk/L0
         ilbsKzE93AXmFzPVTeOg2geQzex98asvIxduDtrFW40DvLLxlgpzqcm4XzyPBH8sw/ra
         rTke40gPCKU/aeTfPWNkYaMGPCVrpKlfUY8hUeM1+LPzBuIASRbEWrWuv5MtLLLstoy3
         ZFRw==
X-Gm-Message-State: AOJu0YxuiHjuA+3zjfdpNxd9B3Ro+qnJ4Q9seEZEio5pmCNZVbj1BImt
	gW2H6kWoZMmMzBGyoD6Qz59zVH3HPIpKZ0DaQP6qYtq3dnbl7vx2fHJH
X-Gm-Gg: Acq92OHvMHU+RFAohvwWGDojMhczhf8pPlCoDD2oVcl4vOtzfxAx/VaUsiGCGgdTbK3
	tH9QSgreX4qkjd8a1lSqMV7V5UIKacUyminf1CC7OGrEZt4k50whzg0Gn+U8E25l9zvCQoF/om3
	QAReoaDU30PlTlfxC1ULX39DBQALf9eoErPd39FXVEOTHw9rqFS2fm2xuNXc+K1pYcxRrEdhwT8
	v5aYS5cBVTXJc518LI50Uu5IWcAEhExURtYmgb5L6KEW4ApXG4bIxhVu5fODPCMJpuwAT5Owylj
	X8HwNLWg060VpPiuDQtNYLVSI1kor+ffDcucNR6QXnWBpZccwv/PEiymoWa2bSY5ltb11RYVHg7
	tRCnRUTZnOJW8c+dboYTsHGMs+lWdM11EZBiFwmKtgOSPUawCrQNkX25GAaSvZB3wy4eoNLjCIH
	ZB5+/BeV+rBr2POIEuuev+mRwD9xo1GVl6lhB3jSr7lFJVnGR7RdtydBP6oVpkJItkVPGIAo4=
X-Received: by 2002:a17:903:b06:b0:2c0:b5c1:8e22 with SMTP id d9443c01a7336-2c69a14a408mr22728725ad.12.1781587597232;
        Mon, 15 Jun 2026 22:26:37 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43345e3ffsm119203765ad.71.2026.06.15.22.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:26:36 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:56:29 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and
 later processors
Message-ID: <ajDeMuSaHSyJuZ9m@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260614173437.26352-1-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260614173437.26352-1-amachhiw@linux.ibm.com>

On Sun, Jun 14, 2026 at 11:04:37PM +0530, Amit Machhiwal wrote:
> When using device tree CPU features (dt-cpu-ftrs), the kernel bypasses
> the traditional cputable-based CPU identification and instead derives
> CPU features from the device tree's "ibm,powerpc-cpu-features" node
> provided by firmware.
> 
> However, CPU_FTR_P11_PVR is a kernel-internal feature flag used to
> identify Power11 and later processors, and is not represented in the
> device tree's ISA feature set. While ISA v3.1 support (indicated by
> CPU_FTR_ARCH_31) is present on both Power10 and Power11, the
> CPU_FTR_P11_PVR flag is specifically needed by code that must
> distinguish between Power10 and Power11 processors.
> 
> Without this flag set, code that checks for Power11 using
> cpu_has_feature(CPU_FTR_P11_PVR) will incorrectly return false on
> Power11+ systems using dt-cpu-ftrs, leading to incorrect behavior.
> 
> This issue manifests specifically in powernv environments (bare-metal
> or QEMU TCG with powernv machine type), where skiboot/OPAL firmware
> provides the "ibm,powerpc-cpu-features" node, causing the kernel to
> use dt-cpu-ftrs. The issue does not affect pseries guests, where SLOF
> firmware does not provide this node, causing the kernel to fall back
> to the traditional cputable path (identify_cpu) which correctly sets
> CPU_FTR_P11_PVR during PVR-based CPU identification.
> 
> In powernv TCG guests, the missing flag causes KVM code to trigger
> warnings when attempting to create KVM guests, as cpu_features shows
> 0x000c00eb8f4fb187 (missing bit 53) instead of the correct
> 0x002c00eb8f4fb187 (with bit 53 set).
> 
> Fix this by setting CPU_FTR_P11_PVR for all processors with
> PVR >= PVR_POWER11 when ISA v3.1 support is detected in
> cpufeatures_setup_start(). This approach ensures forward
> compatibility with future processor generations.
> 
> Fixes: 96e266e3bcd6 ("KVM: PPC: Book3S HV: Add Power11 capability support for Nested PAPR guests")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Related: https://lore.kernel.org/all/20260609053327.61563-1-amachhiw@linux.ibm.com/
> ---
> 
>  arch/powerpc/kernel/dt_cpu_ftrs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 3af6c06af02f..e5853daa6a48 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -704,6 +704,15 @@ static void __init cpufeatures_setup_start(u32 isa)
>  	if (isa >= ISA_V3_1) {
>  		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_31;
>  		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_1;
> +
> +		/*
> +		 * CPU_FTR_P11_PVR is a kernel-internal flag to identify
> +		 * Power11 and later processors. While ISA v3.1 is supported
> +		 * by Power10+, this flag specifically indicates Power11+
> +		 * for code that needs to distinguish between P10 and P11.
> +		 */
> +		if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER11)
> +			cur_cpu_spec->cpu_features |= CPU_FTR_P11_PVR;
>  	}
>  }
>  
> 
> base-commit: 424280953322cf66314f3ba5e2d1ef345f21c770
> -- 
> 2.50.1 (Apple Git-155)
> 
LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

