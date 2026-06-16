Return-Path: <linuxppc-dev+bounces-22684-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D50CD98D2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 05:39:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfbQb0XMrz3bpx;
	Tue, 16 Jun 2026 15:39:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781588359;
	cv=none; b=hL7WlwJOYnOfuUi/aiCENpqiJ3yYPZ9QXrutEgcQADZ7vUJF2C0Qk6a6MuzxH+JhVg2rSRKhYWPsymPXDjku0j/154+azBBlE/mZXyhl1lO5qzaPLMvq9b9o8ErtEggcllQ7/akKfCshDzOVfSAakDQG3m8HMKVjJ7Ab/+oRslV42NHOTgu2Wqcd6jaA22kO8DH3CQY2Ygnlv7VDZGtEHFYD6d2YrX2DsAiDsbckFluk+qlAgLhBl9AAobXtFepyvkkV+a6wRiCJC72unBkKfroIy8kS7uK3kzqXEkm7VN3xTvCT9xHvBK7kHtumpmsC6Y11eqvLTK6YP+G+OtJukw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781588359; c=relaxed/relaxed;
	bh=kIf5jcPlK/FXHU7GwogCMydsg42yt/iPtkSvM9+H/BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqWMEpnoJLSovocx9egURnkU4wyTzYWta4zZKJegjiwo+mXv6v38CDR3K/74jYNz8HA71Vp+NprO0senEkv3ZXyswHAkFZBYM1tkBt1mbsKVl45lf5fp07MzM35YMDx/ScEnq+gF5Nm8M3qQ23AFZVBXJ+s+lrk9wcsQ8i/GNGK7csT56SdqffufKXiYL9Vo5n+v5tbDE+gtw4nW5eDpqJoXJ5Bu22lCTk4Imr4UI9CkVCfsf10nsRWWuaYaV2pkcA/4vV5q7KfX6EUSmJ4rb1MPr9hqQfsWl4CNYenq3LxX03hbcXM+P5oHP6reEFTjAUokR99GqWIqDdtDdsz5CA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKSXcyvu; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKSXcyvu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfbQZ1PhFz30FP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 15:39:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CC9F043A24;
	Tue, 16 Jun 2026 05:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1531F000E9;
	Tue, 16 Jun 2026 05:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781588355;
	bh=kIf5jcPlK/FXHU7GwogCMydsg42yt/iPtkSvM9+H/BI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GKSXcyvu+LE0qsL3QnTaDAzncwwZ2m/nhhOxeeWeAHbTB09uQJdFvQAcV+N3GHVzb
	 w1xgQ5db/ZypQkGjNdN7fBbPx9XYQk94GAkqYzMnQwwI4+c+aRU5HajeoEK+sw4kkO
	 RPxkRCiuEXTQW3R3TrrGeR13z0acza4vW/gQNlREHTLmQ6qZvChizlgIlgUHo57taX
	 UaMSPQFRRgN6RA8blnyzfMjaPFJIRSXMGmc0wnSFiYEOKONxLOzGMxdoUdPlqA2rfQ
	 JDubYHAoFeo8f9LO1Enso7Z9rKs6kRQ+PonNCZkqf0iFm6kN0j2X7Xn68LxnOSRI1b
	 JcbvFugQ59tXg==
Message-ID: <56dfa6bf-1eb0-4e27-974b-03f963c5eed1@kernel.org>
Date: Tue, 16 Jun 2026 07:39:10 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and
 later processors
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260614173437.26352-1-amachhiw@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260614173437.26352-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/06/2026 à 19:34, Amit Machhiwal a écrit :
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
>   arch/powerpc/kernel/dt_cpu_ftrs.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 3af6c06af02f..e5853daa6a48 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -704,6 +704,15 @@ static void __init cpufeatures_setup_start(u32 isa)
>   	if (isa >= ISA_V3_1) {
>   		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_31;
>   		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_1;
> +
> +		/*
> +		 * CPU_FTR_P11_PVR is a kernel-internal flag to identify
> +		 * Power11 and later processors. While ISA v3.1 is supported
> +		 * by Power10+, this flag specifically indicates Power11+
> +		 * for code that needs to distinguish between P10 and P11.
> +		 */
> +		if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER11)

Are we sure this test will always be correct ?

For instance PVR_PA6T is higher than PVR_POWER11 allthough it is not ISA 3.1

Wouldn't is be cleaner and safer to just do:

	PVR_VER(mfspr(SPRN_PVR)) == PVR_POWER11

> +			cur_cpu_spec->cpu_features |= CPU_FTR_P11_PVR;
>   	}
>   }
>   
> 
> base-commit: 424280953322cf66314f3ba5e2d1ef345f21c770


