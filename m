Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2258606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUtKFF/b
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGM652rxxz30Vv;
	Sat, 31 Oct 2026 00:15:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793366125;
	cv=none; b=RmfMTYcctrbt8rfveNBT6fCcdwcq8hDw1qIbRxrHSqxWp2VNZkUhl4uwKRHMuPPnND1Ykif6wFdbD/J4LtgvHn4ogp1QnybUjqmAoS2bIqOkF+jge4ihCwEKnJmH3LVfcoWqvyzkDIrYET7U20M8Rv3WuY72cpHfd03pKN0M2lA0djabcEYuJSs1GvIX/jVcqjnJCva2WoTUHtuj0IEY6evTra4NLYmGlRPV5AYBlqv+C1VV5dxMsSBMFOz445vh2qFWWc3ARHC4gjZuwNY/rzNPVfGZcHmNMCT3wnUvtyZZgbq0GlPHm/t/I5kmQTNWBq88sVEan9faepSIw60+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793366125; c=relaxed/relaxed;
	bh=flSyLSnr13yYjOEHTPxlFf/254Itc/t+WXiaXgORDKY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=b9WLBc5mrS5d5Dc4myZxzCrLkoN7mBsszaAwJY6cVTsdUIoq3I2ezWLxt7nQzKkExw36bynG774+N+HQQM3q8xggIBkkX8vkiliZyDc9gtrjQETOWlUBFGZAU3lXeVJnQW/8PXYg5rgFuHdWSehsgoppw86wAeWnGWKPgpHyvUmO7f1xIHxXl5g84bXZSuefOVch/3d7ZF7Lp/fM2+TXyrLsnAxdCzwBOgKYXqXf9pgwY4Veq8V5hwky2nF2LMJ+i9zXHQIAqNMKK6bce/I2byUGXrEAh2MznqxRGTgPz5iUb9GaFTiInDALVNgwVYtaFKY5qkwj/W34s9NNpSPemw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUtKFF/b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUtKFF/b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com [IPv6:2607:f8b0:4864:20::1334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGM641h97z2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 00:15:23 +1100 (AEDT)
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-36a315ed211so865625eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793366121; x=1793970921; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=flSyLSnr13yYjOEHTPxlFf/254Itc/t+WXiaXgORDKY=;
        b=IUtKFF/bTBmr7EOn0K/kJAnhm3k38nhB6wG43XEp0Ov0Ze+eEmOFgirXq5Yn9djBG5
         ZyxsNtWumzHEQ/R82vCWI5Ujodp+gUXK1qOdMw3ERAikWLDjklkwtzF+x313bAASJPBs
         xP2+bZ/Q+Iw97quMDhTcxPsfVheMxPmL/+IT3CBuVSFJpo0FnvEYjWJnogxxHMvdM+cA
         71LgNkvfwHhTuHZ+ZaMl8j+DpClRZG4HTlfbbf3a5WCa8/eUQeUGj63r2oes/ik3pOM9
         JY7ki5P3aIY40H5NWuqBVPq2OtRI94EWvvhFbNFAyEUX+D4b/hCnec6vmUrwgRVByOgA
         axsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793366121; x=1793970921;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=flSyLSnr13yYjOEHTPxlFf/254Itc/t+WXiaXgORDKY=;
        b=Yd/EZDA2leLLP0vY2ysQ275DN+jvoZLi+Rc6fYAhK3P0xS6xJ9TqbKSk4zgZOvpYC3
         xMQ2Xyd2fLSBFW87UgrsU281NKFov1XT+anU2FMXzp5uBv72+e9O2qUKcxoQnCQGsL4I
         /3fjVL6Wp7tfSz0BUTYRLtbfkOcGPJnk4PmDXPNpXz2D2WCeGP92zBR7jii55YU3s8tK
         q14FDcV1zaf/JU79POlxNXUXjsR+DW6EB7MYUl9n+hHnmmH1yZEbpkIuoXE7A4bVdbvj
         zpbPQnEE+3NKWva8IZSbyn3RBnFkrhxs8Fiy7jtypQWIW2/E7Iw72xhuiuWQCkRZ94ix
         2WrA==
X-Gm-Message-State: AFq9FYJkv5raYcQlq6v0C06E4XkcnwFZo6DbZ4SLJXAk/zBJ+wm7FVqr
	TXJxjzwd8Hj41bhPPi4H8W9sPrV2EEiVVS4HqY/EhopPogibx4rGqivW
X-Gm-Gg: AYBFou02/Ado/93rs4RmEZCP3Uev5M8FBc0iwRBG1R1Dmn+WcL6aOqgeS3MWVNOqGaH
	o++ZJpr4Yakw8lLainkjbaq5Vc1/nYITvJpIL31SJoEa5UfcNeEatv+eqFjkBPYkMG59sfwvXBW
	wyK/icJowFiPKMtNNGJjj9hOj1WAnrYEu9aAlMbWSyGI5xh3O5TGfEV+/KBIShhykXbyGXT8MlX
	XQa9d+9Z/MHQMaGL8PvzXqALjAvfDTFK4HFafhAiU/5jhxeGXNLMjH5CnaYGarUmfmjLZWIgRWi
	f9F7idetJ4od8KU414Y4QMHRueFU2GRM4tSdmQsGGs03NyMbnT+b3K+TzZZafxqCPCEeilwHie6
	LtGbDsUWBtmMJ9mHn1FNnimmwV1AC1K+7tx42q0Sm80V9iUpySwnpmIW24yg8zz5ckNemPgEPXw
	1Hgb98fAnQvX0JyMxj6zm+C0mfH/bsaCARyMKNfx4o5Lxwp4otNvc0evrHtF86Zvkuj7oBVDfpE
	6u3tYEomEu2GAuyX8O3QlOOa9d8aeixZpw4STJynSt12ebVR7QMyHhFFMOHnmti8XDnS8SnUhWj
	FU/qz94L0jxUUIcrLzd9muESX7M=
X-Received: by 2002:a05:7300:3d0a:b0:35e:2c6:d462 with SMTP id 5a478bee46e88-36a2fc203c3mr7157186eec.0.1793366121263;
        Fri, 30 Oct 2026 06:15:21 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a426681aesm10056827eec.1.2026.10.30.06.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:15:19 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/4] KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
In-Reply-To: <20261012082922.218799-3-gautam@linux.ibm.com>
Date: Fri, 30 Oct 2026 18:43:54 +0530
Message-ID: <a4nvwctp.ritesh.list@gmail.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com> <20261012082922.218799-3-gautam@linux.ibm.com>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

Gautam Menghani <gautam@linux.ibm.com> writes:

> In kvmppc_xive_connect_vcpu(), if any failures are encountered, the
> control flow jumps to the 'bail' label where kvmppc_xive_cleanup_vcpu()
> is called. This cleanup function exits prematurely since
> vcpu->arch.irq_type is set to KVMPPC_IRQ_DEFAULT at this point. This ends
> up resulting in wasted memory.
>
> Fix this by setting irq_type to KVMPPC_IRQ_XICS before vcpu configuration
> starts. This makes XICS initialization symmetrical to XIVE
> initialization done in kvmppc_xive_native_connect_vcpu().
>
> Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
> Cc: stable@vger.kernel.org # 4.12+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>

Mainly fixes the error handling / cleanup routine in
kvmppc_xive_connect_cpu(). The fix looks good to me, feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


