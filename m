Return-Path: <linuxppc-dev+bounces-22725-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5FECD98E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 18:13:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfw8D67lGz3c3v;
	Wed, 17 Jun 2026 04:13:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781633580;
	cv=none; b=g1SnXrkFgtsOFtwmwDfciTdukWQfyQymJ4zOoNUUfNmKBfAx0msKR+3UOX03EiEiDWj4U14tnPT9LEYTUIalawbsr/SfIqPSW6KnWu+UEOQC5DSR1W4tJ8aUCE2PcfF7iWz820KfVjwK6mD9wnkqqoqb/mwgwb4qEZJQB9qaWMTR7xDeRDFMo3p5d3fk+p9Bc7FtSH94hQg6KGEeP0OkeEHYOq/tvo6RqtWZHCQL+NMVbS3WgNBV3xuw5DN5s/K8MhUyeRoPQ2gqMQK/78igZZKzyaWTQPcEofQBHs8Jy29lvwQ0WM7aBWC3K7jqjl1UAjWGIKgdzj3iswGN3eL6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781633580; c=relaxed/relaxed;
	bh=HfqVrP82kq5rv5P4+q1AH7lRylWPBjjSEnRhd+rTAto=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=kzZN7RUPJ7Teqa6PLXKFGpCuEfxhNi57ucLJMQLJmYgFAZBuTcsujHww6txZsx/RNolLhtC9ngP4kK8C0YDOcdwcF3wR0A/2C6PZICbpcBKEow/rCEzjQ9+hz8ACYjqM0I9m2VblveJTnLsI7eRJsY7i0jy+r/pAzgE2xHMqgx+uKrpoe3HRD5olut3n5yFBOcxYX/Lf6OJFqaicz9AaPCwzQaelMiPQMJ61neKmFpzMtKqGa1f9QU5MS3chmHFFF71gUalw4uGugJApHoGn50+GTUaH8oG0GlkAL3r/5+sXyPbW7jjEwUSMd/ZlEN0T5lTVbgeV/7UM/tdBNzG4Kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0IxSh4/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0IxSh4/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfw8B6HkKz3c3l
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 04:12:57 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso3053858a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781633575; x=1782238375; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HfqVrP82kq5rv5P4+q1AH7lRylWPBjjSEnRhd+rTAto=;
        b=i0IxSh4/feoyoorAZ5eza3PdhBxl1FDijE4b5ne8xkDiQvPVlB4saUvtIcmyZ73jxl
         TNDnYT8CX5L/4DVxpgAiNwgjWdnhNgmLuzMK17G5WJhB2kzkdrPzrAfZ4ZdE6ryKnmkJ
         DlNsYR2QWz+F5rU5ux+eb7NoxuY6ZoP3mYkrksQISMk2Fp0FKsQlNLIMB86tqavic7Em
         mBs62Pl/KxT4Vj5VCWX4V3gzJeTqTu8vkONzFg7dNsQYCDnT0NDAbsP+jiQy0pYJ2z/S
         EWxNMGiWWN3EO1KHHBy0FShBsIvE5Hmv1ntngQtfF/P/0AsupZ/QNPY8drMEgZs3GOsw
         LGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781633575; x=1782238375;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfqVrP82kq5rv5P4+q1AH7lRylWPBjjSEnRhd+rTAto=;
        b=JNSMHz+NR1q5C2kYamrRz9T97mMhiWoDClnypM42jRyLqJCJNhmIitWky2pOFRZmE7
         r7725LloFiz+PdtPmEB/MbnCh7um2hhjByoqLxWTKQ8LlUFcUKv6yBWERaTCF43x9Tv3
         9wwDNchAvB6EwEqvcEqEboLg4UyOHa6zuAwodfzQ90SprxSgvLSbRwWjSOV6ifR4QaZq
         8drcsoVCfCvA4uHOrMXweVcGLHP+3sg2NGZkLZXRAJmoYZF9zfgHRPalQzrEyuHJHBGZ
         THQoDkXtZkFWe6Fc35vwDhV/3ormVLG2AtwYdyotlr3mOhm9LCLU7oYDt6Cmy8S+Vdpv
         DwBg==
X-Forwarded-Encrypted: i=1; AFNElJ8urL9fFSTcCkGf3M5j/yBLJ/4xFfpICSqBfuJVrMwPq70PbFwpn3kEU152lsC9w++XKvsN7x47s4r5aeM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzRz3vluBJ+/8+G6+zFiPe5GVnITF8hG/2AB5rVYpv1mXVkJkGd
	c2YD6Dl7fFg+l5tRxky0JE4wXZnSsWhnS6F+MJAKquQY+pOnm4q3d9BO
X-Gm-Gg: Acq92OHHlTx2Eyfh6QrgxuaYM4FO1o3m1VFan7CNa0Qi30ywnqEbwnJk2oOFzh8SzMC
	Mq0P14fZoTwECsbYM+7t9Bo097oPuIZQ0/mQ/lVT1fuit9DeVecJVS+ZMXN4AN7VNY9p2r9EuOi
	6swHYtG6M/SmkCMpOD2M19xJtbbCGFmrK/HMSwLh8A1GO9mAdP583QzEC/KnhrQSmfUvW8qjetS
	yqP4gouzT9MQ9XU4fkpmo9mttUWLyy7jmy+2WaSoUxRXlOaW+Yf1L5jMoRjF24a9CaGdTPGSlrH
	3EUw4uJ5tYubnL6FN/oMQ2dpvE+n9b7z/ssedR0hD/NQJ/1pRKR2gKg/mt2vjpmW6JHaF1jRPD9
	a15vKW9VEd5uWO9nANbZk1O+A0rUeAe3czT8aTyz1Ei1fSadeQok8U7ijSpTv9d0af+Xa3Qa5ms
	majlnYbYjHZ/SP2C1qtVw4sdv3fQ==
X-Received: by 2002:a17:90b:390f:b0:375:2a38:1d40 with SMTP id 98e67ed59e1d1-37c9369f042mr546951a91.20.1781633575059;
        Tue, 16 Jun 2026 11:12:55 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5228eb5bsm3519929a91.12.2026.06.16.11.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:12:54 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260616163405.96962-1-amachhiw@linux.ibm.com>
Date: Tue, 16 Jun 2026 23:37:53 +0530
Message-ID: <7bnye4ue.ritesh.list@gmail.com>
References: <20260616163405.96962-1-amachhiw@linux.ibm.com>
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
> detect the mismatch and sets arch_compat to PVR_ARCH_INVALID (0xffffffff).
> This sentinel value is architecturally safe: PAPR specifies that valid
> logical PVR values must have 0x0f as the first byte, ensuring 0xffffffff
> lies permanently outside the specification-defined range. Setting this
> value triggers kvmppc_sanity_check() to mark the vCPU as invalid by
> setting vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
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
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Acked-by: Gautam Menghani <gautam@linux.ibm.com>
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Testing: Both Anushree and I have tested the below scenarios:
> 1. P11 guest on P11 host - Works
> 2. P10 compat guest on P11 host - Works
> 3. P11 guest on compat-P10 host - Correctly fails with "Invalid argument"
> 4. P10 guest on compat-P10 host - Works
>

Thanks for incorporating all the changes and adding the test result
matrix in the changelog.

The changes looks good, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


