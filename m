Return-Path: <linuxppc-dev+bounces-25542-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2087AC5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 05:01:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGX6x1P63z3bps;
	Fri, 07 Aug 2026 15:01:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786078889;
	cv=none; b=Qhek1xTMY5H+D1jvZ6HeUImd7tUcdz6YPtAKOIAJSnUG6DdJBu2vXBjpr71pcbGb6qKt3JEDGkSgLpMD9u6K62z1FkvYhYnsOSI9MsWZ39j8pF6u7aEA/EBzBom0SVi0+EPxLbRIei4xEcGV0Orll7t1qgqzdlRXhb12/EJzaRz/RdBjNml1c2zpjxbZIGkUtmFQIJPrTcKR8m4IuqQvEWKGpDYOvrW6G51fhPtC8GlCZ1hGsYsalVrh8M+sJZKkypbtZIigl04LUGm5GY9mX+MO27gdvDItYWu+CKjmK9aWDyZcJheQEUxHCfqzmMcM7w4lfskuu8u1mggBqTemGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786078889; c=relaxed/relaxed;
	bh=gaexW5MzRJUBpA4wcPJkWsT4Yi4ofryncF8L6Hb2nTM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CPDN0C6AkIRck1VOlFC7oNPivuAR6ag+lvNfA+jhfWE63pVf4Gj1bRt90QhumOmwd1KO98hAOJ3VTTmVhkm9M0ouREepapfBPmHDMQ8R9v8O0hrRdeJgbxccOmGn5sOJR5wSwfK/5Z04pxr2ISxvpXYJlyMaX3tOpa86DgbdJ5y1Z6u6bSNkDXS0M5w6wvHuhEPVMbHv68fRRwnxXpR4tjhkcyvd2b98evxcXOlBNLxHOQcHC5aqtqYcsbvkDxjKZuZDnVhbwJ4Re72aEgCLO3FIlvnksk4YnHrxcJd+SmuNclG3MlIJtqK1xPQXR1KswT/6OE1cOYb36/8Y5jClrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=atKGgt9Q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=atKGgt9Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGX6w2dtPz2yrQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 15:01:27 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ceab75934dso38640695ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 22:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786078885; x=1786683685; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gaexW5MzRJUBpA4wcPJkWsT4Yi4ofryncF8L6Hb2nTM=;
        b=atKGgt9QQZhVPd7KhPvb7DM4rMF8JGahscaGUyrJJVuJbTb9yhD4zVaD8g2tjGZTDD
         fYOHoDzMoswbaySQV2bgrMrS8pVsk6EvGVtLgXxcGeDrD3TegBexuZxHEWtEdd4JPI5e
         2Ak4vQeJzhXrUAlHC8OaiCQW9UjqMY67wO50FxlozvhlRWcR2obWaGCOpFfE5muIRbnZ
         xkAWqnk/ZWPviQ85owl/RtW/Yro3s50pu355S4RTpqvU6FXeWQVjXw9q56VlZRrtCkL4
         X9rXR0fK8pwTjmU3d81tslX/iwtO08HhFwFOuJHH4V/vhPJCrvpmivzOvs7grGIDXkq8
         NCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786078885; x=1786683685;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaexW5MzRJUBpA4wcPJkWsT4Yi4ofryncF8L6Hb2nTM=;
        b=gCoAI36okfa9I1vaL9jfBia8r7ZPobKNUMyGEP0H33+FKD7JkbRyDDg0Da9HoPeLv7
         H0Vv2t5X9nFjDJ/Bb1wRuYe5O9LqyzRzoj4Ur5POL7H80xGcBvggYLsB4vfss03q0vKs
         TR5u15G36xDACPKPVDkXxEMmR9s7ZEluSl50JkJbvU31g+CbxT5Zu0ZXmzJ9x8mijv+b
         JUgziijda4RLBrg0QJmbHUlzOjwCZwAYo/1QjD6pOKTUwr79+erefea3vz2wFLICKVQx
         IeBC4Zwi5jjR9huq3WEzTR8ePmJvJlZ9UkMu/EBa7vEv1+ufotntXjTTMg7MEtRCjd7X
         3nwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0y6HHjwRar39rrUxiEla2M7PNhcnqcNyMa7zWX3/+GONS7Oj4mWm6OXlMfaU9QYciTeXIeVknuCmGoTI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwEikEe/p2GoxlAF0p5epe3n/E9CxaP3AxnJE6lhWWqmcJ8oVKo
	YUVuq4J9+WJmuIgui1vAFTDI+5JNU0W3rHPFS3NiDzQmB5j9APfumMYx
X-Gm-Gg: AR+sD133SCviZF5dk4dmRALlbUB1+PhYinqdxBJI77LSzztwLi1PJxGsP97c8QwHpAm
	rpSIuJVVNM+o0xblZBtpcufNQyp0bHEc6TnpoR4SuxzUo8vQRiE9hcW+isJnJpXBNHwCySAifoH
	hbv5567IAlUrbCf9LYQGk4IKk/Fa38GnkXjIbwfY5k26BUe+S0pyYN6RnZOgg3JAcr5wALC6wVd
	pdCIScc9qKV+pYIwE4VcId4Mjspdg3Jj8DmpkFkeH1LRw3jJHNdlh2EJrwH0VtKkm7emib/500z
	ff3XR3cwsjdGB3iPurTvPch36HrQ3gGdEAucJ6c8U6OytJEjFTAEHqJnNSS0moiva7hEFjK+Ft9
	25ArNdmU0kMfum9/n5+jH/t4eFD6IfTQAbo97/gIi4ZaMKJCv4ll62ZFQ8K3zfABDHZEjMTgyDm
	0TLF/4ezXtEMnbJDfS1fWatNQo6+8IBI8exQv83nUACcEoIReNI+NZmPCZkOE=
X-Received: by 2002:a05:6a21:7a9c:b0:3bf:983d:e9b4 with SMTP id adf61e73a8af0-3cb8603af0dmr23716971637.33.1786078884954;
        Thu, 06 Aug 2026 22:01:24 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm3026655eec.28.2026.08.06.22.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 22:01:24 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 3/4] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
In-Reply-To: <20260806170645.11892-4-amachhiw@linux.ibm.com>
Date: Fri, 07 Aug 2026 10:24:18 +0530
Message-ID: <bjbeledh.ritesh.list@gmail.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com> <20260806170645.11892-4-amachhiw@linux.ibm.com>
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

> Currently, when booting a compatibility-mode KVM guest (L1) on a PowerNV
> hypervisor (L0), the guest runs with the expected processor
> compatibility level. However, when booting a nested KVM guest (L2)
> inside the L1, QEMU derives the CPU model from the raw host PVR and
> attempts to run the nested guest at that level, instead of honoring the
> compatibility mode of the L1.
>
> Extend host CPU compatibility capability reporting to support nested
> virtualization on PowerNV systems (PAPR nested API v1).
>
> For nested API v2 (PowerVM), compatibility capabilities are served from
> the cached nested_capabilities value (populated at module init via
> kvmhv_nested_init() using the H_GUEST_GET_CAPABILITIES hcall). This
> information is not available on PowerNV systems.
>
> For nested API v1, derive the compatibility capabilities from the L1
> guest by reading the "cpu-version" property from the device tree, which
> reflects the effective (logical) processor compatibility level. Map this
> value to the corresponding compatibility capability bitmap using
> KVM-specific constants.
>
> The mapping is cumulative: a system running at a given compatibility
> level is assumed to also support older generations down the supported
> chain. Note that unlike KVM on PowerVM (nested API v2), KVM on PowerNV
> currently does not strictly enforce older generation compatibility modes
> for nested guests - the reported capabilities reflect what the host CPU
> can present, not what the hypervisor independently validates.
>
> Introduce a helper kvmppc_map_compat_capabilities() to translate CPU
> version values into KVM_PPC_COMPAT_CAP bits using a fallthrough switch,
> and integrate it into kvmppc_get_compat_caps(). The implementation
> applies masking to ensure only supported processor modes are exposed.
>
> This allows userspace to query host CPU compatibility modes on both
> KVM on PowerVM and on PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS
> ioctl.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 152cd08a5b38..4d0307f55e06 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6523,20 +6523,56 @@ static bool kvmppc_hash_v3_possible(void)
>  	return true;
>  }
>  
> +static int kvmppc_map_compat_capabilities(u32 cpu_version,
> +					  unsigned long *capabilities)
> +{
> +	switch (cpu_version) {
> +	case PVR_ARCH_31_P11:
> +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER11;
> +		fallthrough;
> +	case PVR_ARCH_31:
> +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER10;
> +		fallthrough;
> +	case PVR_ARCH_300:
> +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER9;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
>  
>  static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
>  {
> +	struct device_node *np;
>  	unsigned long capabilities = 0;
>  	long rc = -EINVAL;
> +	u32 cpu_version = 0;
>  
>  	if (kvmhv_on_pseries()) {
>  		if (kvmhv_is_nestedv2()) {
>  			WARN_ON_ONCE(!nested_capabilities);
>  			capabilities = nested_capabilities;
>  			rc = 0;
> +		} else {
> +			for_each_node_by_type(np, "cpu") {
> +				if (!of_property_read_u32(np, "cpu-version",
> +							  &cpu_version)) {
> +					of_node_put(np);
> +					break;
> +				}
> +			}

What happens when we don't have "cpu-version" DT property?
Check this commit
5a61ef74f269f2 ("powerpc/64s: Support new device tree binding for discovering CPU features")

And also why do we need to parse the DT properties again?
Shouldn't we check something like this?

	if (cpu_has_feature(CPU_FTR_P11_PVR))
		capabilities |= KVM_PPC_COMPAT_CAP_POWER11;
	if (cpu_has_feature(CPU_FTR_ARCH_31))
		capabilities |= KVM_PPC_COMPAT_CAP_POWER10;
	if (cpu_has_feature(CPU_FTR_ARCH_300))
		capabilities |= KVM_PPC_COMPAT_CAP_POWER9;
	

-ritesh

> +			if (!cpu_version)
> +				return -EINVAL;
> +			rc = kvmppc_map_compat_capabilities(cpu_version,
> +							    &capabilities);
>  		}
>  	}
>  
> +	if (rc < 0)
> +		return rc;
> +
>  	host_caps->compat_capabilities = capabilities & KVM_PPC_COMPAT_BITMASK;
>  
>  	return rc;
> -- 
> 2.50.1 (Apple Git-155)

