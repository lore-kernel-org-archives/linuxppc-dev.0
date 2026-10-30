Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CBF606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KuNfZ0Z/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGN2L3D09z30Vv;
	Sat, 31 Oct 2026 00:57:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793368634;
	cv=none; b=VySEFSWnWpm6oCVPLALwg2gZOp0z8mKFlKV1tYUlWD12MCJbvU3lwQvYD8MJk7WDN3wVZtZw7DEmduYLZ8ZkXoY20M1r3XZwdq5oPn14tpJGvJpO6rfmcvv8iMcPh1M5JXvXamBM80O8DJymmeYISs/CyX9q1uKcZ8WddhI6XujzUP87SimUq5ShwYG8tVTx4vsNhywIvnbx5ObI4Wk5jsELUbe4FpUbdkz3cokfHSM/RjvKEL4zRGHIc6mQDiqMGOqg5uaamMI11S8Aym0MfSu9lhIEKA+hGDmF8bB04HAC6NwsdhiARHEmTJupEkKdfcEwZZjQ2UgHzBhwPxdoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793368634; c=relaxed/relaxed;
	bh=GNIOi3l2fXouiVMkzU5S0Fr0utCMy6QmwVq2E0otj7I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=FUSTNZtM017z+Da/WgtUOK+aSLUNM0UWbcNftRtd4ETYHlUv1IjxPHDfOTuh4KaeBn/w39UKB06AEiYUuskbr157LY2+LzlIghcsyrwv+48w+jkI5oqIskwMxThHZhyFN4VrXYNmPqdGUzPz4HeH/f9IPTM64HKtPz+ZlhuybmcOD6t+k9H9bO2+l9slcdcL5FzmrOsuG7R3hccSbiY2Oc7fbi+N6Xi5+qfOSgtFoa7fXU9RpKdpcuyjUYCRNZKGk2UI3DE58R75mS2cG7xSr2rqdl7IZ7WYNMNML2c1y65zdX6PkMT/pbw4R5EMiv5wAubCdrL7VPpZAK0dpFxOVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KuNfZ0Z/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KuNfZ0Z/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGN2K018Nz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 00:57:12 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2ea7987517aso5512935ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368631; x=1793973431; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GNIOi3l2fXouiVMkzU5S0Fr0utCMy6QmwVq2E0otj7I=;
        b=KuNfZ0Z/GloGXqMq6G9DMxWjT0OOzVBA9nyy8Hy6ZgyLdSgsiD5X/ml9IFRKSubX1u
         H4lK9mvf1n4LjnFwDtl++1NpZ225Ij3An2Qe35oveNlv4IuTCYfHfghiqasKkdfINIkA
         mEv4Nw/NMRpNIHK7jSZwPThkA6SKDOyOvUZUNfQjIZcCMQbB0GXcenzEOZQXj32y+SsB
         feratNIOTXOJ8c6Sylx8OFrSgaihhlwgfTdBidbkY20WH9CYJOog744a2qEECrs40PtK
         Jz2YvmAjUUkq2PUy+zCvPCv4Zf6bapmwrcIuq5PULA3GsWj6isT/4lx93iv/36NYzLRV
         7S8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368631; x=1793973431;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNIOi3l2fXouiVMkzU5S0Fr0utCMy6QmwVq2E0otj7I=;
        b=pGcphJzYKADFzaGyjjSJl8f7IeNCydUxcKzeJBJwhskntlgtvC2OYpTObc7PFLdWwE
         VliyjFZqbfJSSwcBnY7zyhILdJOtQsbBnQYhMqu+/MszQg89C8fmDi3kjuEh0Dr1ZbCU
         zEjHxK55Un830tDTlO7Rb7wby7W/KWnWTCzP4Uu15vguS/lDfx3+Mr3K8iU8Nqqz0bJS
         /grqFMPKIjkVHjPnK4y+qudALOIGYbEJQAiUkz7/mwvMsDZCYaUM/VbjJgl4eWn0gj+Q
         cs65QlQiDxlJQurut9qaiwTHVgrdebf+EPnLTY7CrR7aqHdVB6GjQdebgWglhBE4Pos6
         cB4Q==
X-Gm-Message-State: AFq9FYKm5xlHPdvieZPTOzlBnAxY1q7AknQeyTq9DoIn0uSdxb37hK4u
	pkpFP/hP6CUv1Kr606Yr2c+Dy/5ZCewUSuiTzxInq7HYfOlTCnLuXIqM
X-Gm-Gg: AYBFou00m4oXPRfbdX/TAppF4eTCN23BvEkRlnBFp+ck/XOeHaehzDElkFItl40AdJA
	Ve4cdbH4defGutBwyYV4+VqM7GEPYCxuFIcn31/5vJC0CEYv84+0HwCS6VoZOQ8M8P8IBR1aNsr
	KBTf6MYaIp1M1Luuz6KJNkj++j64mg7yup4ipb5J6s62msRUfLko683wQ/FUKZ5sQPXyeqmEqsy
	tvhoj8KSGX77BgD423DoB/81amsVXuQiI5sX5k0YboG5Kxj1YSB2lT0wGz2ORZgcm9ZSRrJ0UKs
	8Nco8u0W+2D8kS8KvZqAotHsOZCK3E6RxYwQOk/avBQa0ooEx+HnFFTATLv5M+/feoY7LvRDtSb
	2TL5aikQXW0UlX8ps/gLVgCNHQ0V6+QrOLiisZOpWiXvb1NNgpLiILO4SYKXH1iehOaPpGxaNZ5
	yeSH5374gOAb8aZchM/wdS2z6pd8EmJI+UkZJW6xKc9baJWn0X+bDyHv+qombRNYFQXOIAUvUE7
	BHJsKx5FhZozN5JYBfew8MJNIbbMQZL4cy0WMY9x9T4OM8ROgQDO8lSOyTlNNwqKyOm6j8AXUx7
	gKDPC5Skn75YLxgRRM68s69CCls=
X-Received: by 2002:a17:902:c94d:b0:2e9:6645:e9a6 with SMTP id d9443c01a7336-2eb365363f7mr26307325ad.59.1793368630732;
        Fri, 30 Oct 2026 06:57:10 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3924c858sm7688305ad.35.2026.10.30.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:57:10 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/4] KVM: PPC: Book3S HV: XICS: Avoid NULL ptr deref in kvmppc_xive_cleanup_vcpu()
In-Reply-To: <20261012082922.218799-4-gautam@linux.ibm.com>
Date: Fri, 30 Oct 2026 19:26:01 +0530
Message-ID: <8q3fwavi.ritesh.list@gmail.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com> <20261012082922.218799-4-gautam@linux.ibm.com>
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

> In kvmppc_xive_connect_vcpu() if there is a failure before
> xc->vp_ipi_data is setup, it can result in a NULL pointer dereference in
> kvmppc_xive_cleanup_vcpu() when accessing the MMIO page in
> xive_vm_esb_load(). Fix this by adding a check before masking
> the VP IPI before accessing the MMIO pages.
>
> Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
> Cc: stable@vger.kernel.org # 4.12+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v3:
> 1. Add some more info to the patch description.
>
> v2:
> 1. New patch - Introduced to fix the scenario where NULL ptr deref is
> possible. (Sashiko)
>

Make sense. However, the order of patch-2 and patch-3 should be
reversed. Otherwise LGTM.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

