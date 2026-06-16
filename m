Return-Path: <linuxppc-dev+bounces-22695-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D80CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:59:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfjCG3MFlz3bqh;
	Tue, 16 Jun 2026 19:59:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781603994;
	cv=none; b=E2XfV2ODlTy9qksHnYQTVjdk0SI4zf1wbSehfOLvo1eHXtr7WilHzTOMMjMO2MztH/hEQUnCfq4DyxrjUo6lkSXPACT7Ii6gTWO3EPCAGxjfmkcjvtpUO0K/W274hZnCaz6FM3cjqoxgBUjEqNxy3qSrDvcIMrxuWVsafNq9YePgslsKxU1JwPnsMt8hm7tOl20Uov8CHon9KENVWxfjvTOuiOnjWR0OtPKj36wayWSjBOjU77k6Cmm/juTw8BGVMeCeS0WKw9l48mOwaLpTsoHBJ7Z8JtDStTPDjlXcBPRr8AToCSO/4TwP27zq7FLmqbe4qBWCAMJ1TMobfVAMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781603994; c=relaxed/relaxed;
	bh=HbaHTZBnCq318ZtN8K7oKcSJ6YlokHTKs6GlCUe8GzU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ATs3dYORkCVRWih1qlAG7HGmSbprt4srxYUt1Nxwl/Mdlx7shnIRV/oD1XxEpP36fHnAymzUNTYMcXLSp3mIH41LwR+4Rz/qS+sroCE+/WZLiklBvsAQWeaAPeCJyLxV9OPiluepR83bwZhujENV0y8hA5xQlfkOqXAG2+LTaU7yq22T3dAbrTknIT5M0ww+pTOStSJ4IiK2DeUzgg57U66B1aXrXOSjMeOyibt5h++MSr7Cr2diZK9hIJNcVi+13ZwVV1QymorDLu23y7t+GVMGDIf+lAYieFzs2BZrGkFxSkej0L8mrLlH2UqLQHlitU8opOOQgDw/2lXp1ztpyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QnYQ4oh5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QnYQ4oh5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfjCF18MZz3bqM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 19:59:52 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2c0b944f6edso44400485ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781603985; x=1782208785; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HbaHTZBnCq318ZtN8K7oKcSJ6YlokHTKs6GlCUe8GzU=;
        b=QnYQ4oh5cMEvmTZvl4zXKgzWsQMAW1kyXw7MyYJU6eeRnJtS56vHffmDzZpKHSG7n9
         TNG0tJJY6eDf1R+Pect45ljCy0JwZIsfcyD5nnolsVcEdP20s3UfWJ+XOjaCiqXEkg87
         S6x1bbii5bexq1m1hcN/Ng5/DuBvM55WfyvZRNt4zhiDSwjCLTanYa9y8e8zcgD2gtqa
         n9N3mVJW24wXUy/whu9/7YUIPJxRcHHw5y3l6SIUXWNSgCO7TrOCYU5QssQ9uQFQvOxH
         lVoSLtnBy2xTjA12Onsr9Q+KLMLdEhuc0p1r1MN6VN7rp9f4n8AasVN/ea4IFA1PbNi0
         Uvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781603985; x=1782208785;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbaHTZBnCq318ZtN8K7oKcSJ6YlokHTKs6GlCUe8GzU=;
        b=KG3ZoUcN7B4QXXum6Ealir9BvLPfFEkU6MyTB3xExP+63ZF1LFtticXbsgo5E6N6zb
         MZN2vkHKXrvxvFRzb94GMvEUxTHHP++rD92P2huDWORjmX/ik0ypu18HSIow0LL/I1hf
         zDFjowzFxzPIDntmuKbc4elFImqpttsYe+3hydjlwNj03H5jakXbhSerm3o1MYyC7cFo
         lHeBzDsub+LRssWAtFV2OdGqoYxLIBxy6ZD2D+2gaWqC6oSeUC6yoWNy5ea5Idu1dugk
         fhc97TzNm7/v+T/h51EbnMvq7lxFkEPDba61rf0jOM5sm6KJAdSEGkhuTajDShYtMbLa
         wxWw==
X-Forwarded-Encrypted: i=1; AFNElJ9W/fXJOw9NuLjbrjgAlLOVWgmRjKSoRxtHfcxLFqL+msIz3NJ+EebC4OzyIjKntCweY6ATJQXqjfDG2+c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyUxkCP+x7zQ/82F3BJ8aMgURe74cMqm8V9tsONR3gjsOMNcwCk
	kDitcK+P9B0HZ6IezBTd6R4gwWOC0l+bSbypcowhEKn/42gY2aZ7XYGE
X-Gm-Gg: Acq92OFvjFQueFZJe/6G9RSFjkWE8tu8wYDb35SGcvoNTVVtzU/8wIblJxBK+NQ9OQi
	QeecEmoBcSAW5TDUgiy6f9XM/ca434cp5Mjdz18pFvEDDzz08d6BkP/4/kY6OsXSIODHIhEkZ2K
	D3EKT5tCb5zIKPUlqvva726YmbobqmfpNmE1FR0HXku8v2kc8s2Of7WqnDzbUfUZcRzWuEKO0UL
	nmLFCsiuLnYuYi0cOXWARl0ybYCvQTJOYU1lqbpHsyRN1tE9sN1DwOlBXjTRH/bOUzj8AzuBxml
	Nllq71pvaGb6oMmc4UP4QmpYxCk02Wc/a1flsSX+HA7m9m7F1nTJlIrySKTw7NJsuRzgRsJeeWI
	K48v8TcVYT3iTc3nWOwvWg06otirDxXWsDf8T+mdZ4aQhhgSb3SuRbq47emBFO6FugmTmarDgXO
	vA8jda8hVkQn0iEi/ej6VWq7ZlYQ==
X-Received: by 2002:a17:903:234f:b0:2c6:a21d:5bb with SMTP id d9443c01a7336-2c6a21d0986mr10010875ad.33.1781603985350;
        Tue, 16 Jun 2026 02:59:45 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433460a60sm153761925ad.76.2026.06.16.02.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:59:44 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260609053327.61563-1-amachhiw@linux.ibm.com>
Date: Tue, 16 Jun 2026 15:17:59 +0530
Message-ID: <cxxqerzk.ritesh.list@gmail.com>
References: <20260609053327.61563-1-amachhiw@linux.ibm.com>
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

> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
>
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
>
> As a result, userspace may request a Power11 arch_compat for the L2
> guest. However, the L1 partition, running in Power10 compatibility, has
> only negotiated support up to Power10 with the Power Hypervisor (L0).
> When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> hypervisor rejects the request, leading to a late guest boot failure:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>
> This situation should be detected earlier and rejected by KVM. Without
> proper validation, if userspace ignores the error, the guest may continue
> to boot in Power11 raw mode on a Power10 compatibility host, which should
> not be allowed.
>
> Introduce a validation mechanism that detects unsupported arch_compat
> values early in the guest initialization path. When an unsupported
> arch_compat is requested (e.g., Power11 on a Power10 compatibility mode
> host), kvmppc_set_arch_compat() uses cpu_has_feature(CPU_FTR_P11_PVR) to
> detect the mismatch and sets arch_compat to PVR_ARCH_INVALID. This
> triggers kvmppc_sanity_check() to mark the vCPU as invalid by setting
> vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
> checks this flag and returns -EINVAL, preventing the guest from running
> with an invalid processor compatibility configuration.
>
> With this, when a Power11 arch_compat is requested on a Power10
> compatibility mode host, the guest fails early during boot with:
>
>   error: kvm run failed Invalid argument
>
> This provides a much clearer failure mode compared to the previous
> behavior where the guest could boot in Power11 raw mode (if userspace
> ignored the error) or fail late during H_GUEST_SET_STATE.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in v3:
> * Fixed null pointer dereference in kvmppc_sanity_check(): added check for
>   vcpu->arch.vcore before accessing arch_compat, as vcore is NULL for Book3S
>   PR and BookE guests (only Book3S HV uses vcore) [Reported by Sashiko AI]
> * Added Reviewed-by tag from Vaibhav
>
> Changes in v2:
> * Fixed issue where v1 allowed guest to boot in Power11 raw mode when
>   userspace ignored the error, by adding validation in kvmppc_sanity_check()
>   to ensure early failure during vCPU run [Found the issue after posting v1,
>   also reported by Gautam.]

Would be nice if we could post the matrix test results which Gautam
posted earlier with this v3. I guess you meant you already tested all of
those - it would be nice if we could explicitely put that info in the changelog.

> * Introduced PVR_ARCH_INVALID constant for marking invalid arch_compat
> * Dropped all Reviewed-by and Tested-by tags due to code changes; requesting
>   fresh reviews
> * v1: https://lore.kernel.org/all/20260603141539.47620-1-amachhiw@linux.ibm.com/
>
> Changes in v1:
> * Moved this patch out of the v3 series [1] as discussed here [2]
> * Addressed below review comments from Ritesh:
>   - Based the PVR validation on cpu features
>   - Fixed hcall name typo
>   - Stable backport
>
> [1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
> [2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
> ---
>  arch/powerpc/include/asm/reg.h |  1 +
>  arch/powerpc/kvm/book3s_hv.c   | 15 ++++++++++++++-
>  arch/powerpc/kvm/powerpc.c     |  4 ++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 3449dd2b577d..7472b9522f71 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1356,6 +1356,7 @@
>  #define PVR_ARCH_300	0x0f000005
>  #define PVR_ARCH_31	0x0f000006
>  #define PVR_ARCH_31_P11	0x0f000007
> +#define PVR_ARCH_INVALID	0xffffffff

Logical processor version is defined as part of the PAPR spec. We should
ensure that this invalid PVR is also documented in the PAPR spec.

If you have already taken care of that, then please confirm and feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


