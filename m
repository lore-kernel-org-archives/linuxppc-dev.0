Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5523606A333
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uSga1U3a
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTzN32wzVz2yPq;
	Wed, 18 Nov 2026 22:07:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795000067;
	cv=none; b=NJ+yxMU6x4dAqIt8To6WcphE6RJgplbH+xCWEt6ofFYyOWwhFQSO81BdLMZa4nXsOlcTmHEYaeDOxA0pUnKpVdR3DgzZ+k7nZjPGpyGx8Zx7AfCzDG19a5dg85DiRGM6mLr59tpmZZZFLWVypNlZg3j/hyzhwV3xn9p1M8OttSJRN+O5qdeDZ9EP5NY5GAryaWorqDADPfpQlIfbSEFoe5wM3QqKRf0PLFxdYFJPXFooV0ueE5IepTOfDqKLE8pdiD9Dg5wMCiwxkEe5fXgzfxPn3Gv596EbRlcrzL1tl+sKzlWsLfZqvqVBmehn+tIi42cwnW7DQjIb0FrO6285+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795000067; c=relaxed/relaxed;
	bh=2Pa6D5jNmLHkxjKk3dgAW9SP7lKs94RaoWLtgWbGlqU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=EuXhby6gVyHyP2NgO96uNvyri3+v8CySPTaYIgEDLZtZUdpMp8rJ3Z3QE/POccSNsPr0nblsWThRXdWGfN7EyB+7zmStrjmtJi+2N0Vt18zwHacDdXC6Mj0qAtokuyW7EV8MJZU6vJ/Ur6GSoby2dALrBaZ9JhQvK32DGQwe3tgwdx0HPPSAkj1SPSY+VaaWXrfOteDS7eNVd/RkLL7v5Q3NmNaSCYSRQG/flVjt/oDDoLPFKFnd2Magw+v2fR5aVF7bmxR9RNltmvMKsaeQUR9BgDWILu17V557Cz19IvhxDkGEsyIs/1ruRCYCkPwTSGRKMME2flgVjb1ffMLW7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uSga1U3a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uSga1U3a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com [IPv6:2607:f8b0:4864:20::122c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTzN128Hxz2yLF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 22:07:44 +1100 (AEDT)
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-15dd124bbe7so223407c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795000061; x=1795604861; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2Pa6D5jNmLHkxjKk3dgAW9SP7lKs94RaoWLtgWbGlqU=;
        b=uSga1U3aznyZX/tXr2EtbZwomslQ1aKi5Kxlh7uoi/GJVOhcMllX735WfCHYd36zlm
         CY3KDWdNHbt5Igb8cqhQWABY3oyG6tZDk+1M1+Gqgq0XEz4teY06L2mO4LDLRtmUgojT
         pvju9sBNAbkUVgwH2M9xXkVSKzYjssvYLINqLtK3o8bWTrQyktI9V98zeHL5OOhqRHqE
         r2t5wQFZWDfmuM9xknI61h0bEmekPyuVLddWxvNrZ9lLgLwlBsGdEofPMaMKbWTcUuXa
         UObwbeLhCnsRWIHKc2R7by4A+5+vGpIbPU/nooBFhFqB0A+7cluwo6uAcLijRijM1ZGX
         dRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000061; x=1795604861;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Pa6D5jNmLHkxjKk3dgAW9SP7lKs94RaoWLtgWbGlqU=;
        b=C4zk+n/17iuCvrD7feZ7EQtOpGjZYwF2KGXxAW61lbUvo+dtrpmhCDvS0hH/mRs4uG
         KxEsJ4aFrhbxTV5k4Lb7AhVRbLao27DWQTAPWYUYZNtf3u1MDJ0OQ5dYS8KEGv8HvkJR
         8IdgqovZWftuloU1ZY7Gv0NZk0U283LkH9RcUE/cptnLOjGKz9YpUVpp9wpZwgB3DfM4
         lm+Lfg46v3LWzwef1v3kY5Jr2/+3SxCsI/sOO9TvT2vHZ+VmmeHfFFcmBuuuejblPS9V
         6iYZIQRWE0B/j/MUId3l6KKlg40I4K8beX09QQ6tiK8c1ZWHs28UqG8JowUZvJ80+UFB
         FfdA==
X-Gm-Message-State: APuU4Z88pPZRGQgte30+0LBwc3nu/ZKzrS0fJv1gC5e/DUAK77rjvml7
	mGiB6jWybP204SLctT67LF2JrsCtr7cV+xZMLUj4bNNNOaVmZ/ejL5l6
X-Gm-Gg: AYBFou02wdcuH/5rTKyDrkcAhNVf6EpE5cuyySFn6YDVRO1OaONx3s22eyDvm5Ji0xZ
	HYZVb7O8anJcajy8G9x0tvvtCbFWwoTe0QnRFcH1KtdrUC+NXZjcwOVj3OSOFnGG9lHupdyINBY
	Qt2qf2zkABK/IpDWoEqHD8m7kOEMSEenoDn3Pd1bE4kw53dT9WRuNNPGml4SVj6ctFg2rJql4ip
	Jz+4ojajOgiNbpRqPlz6/9Rd/3jxnRnDvyomkmR2x5WUe1FirAVPgi033HzQuEMsNafoFx6hUtD
	11+VcjiQHa4niTD3Nc2uzJtHtwOtdWz8dpD5D/F9qY5leCqSVdrI6yRyzw/EhpY2w+ywzZQ44kf
	cw3xqMAZPsRAMA+0ETskMBGemKhJ6srv7cufp09N1b7nOg3+qUuayAnPxCDkeRq+nEHO5K+p1QV
	Z5O4MOe/p2l24oJ3qQAW6I0o4I83MffRjRWxGrAet2dOxt6SE+uhX79c5J1UgTt/oEUeAff306c
	aDdGnJfAiRFD5KMUozhhj312SyyZ2z7LKTOBBO9LhzDrdSdle2MVJdt1rwrCgBmD5jrVl+4URzN
	tGLDsetkdRCFWzUTylthX6+iKls=
X-Received: by 2002:a05:7022:ea8a:b0:1b5:1a5a:1dc with SMTP id a92af1059eb24-1b543be9b64mr2272814c88.12.1795000060528;
        Wed, 18 Nov 2026 03:07:40 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447c1193sm5805783c88.7.2026.11.18.03.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:07:39 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, jniethe5@gmail.com, gautam@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Free nestedv2 state on vCPU creation failure
In-Reply-To: <20261118101008.2242596-1-haoxiang_li2024@163.com>
Date: Wed, 18 Nov 2026 16:33:48 +0530
Message-ID: <o6bm765n.ritesh.list@gmail.com>
References: <20261118101008.2242596-1-haoxiang_li2024@163.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
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

Haoxiang Li <haoxiang_li2024@163.com> writes:

> When nestedv2 is enabled, kvmppc_core_vcpu_create_hv() allocates guest
> state buffers and messages through kvmhv_nestedv2_vcpu_create(). If
> the subsequent vcore lookup or allocation fails, it returns without
> releasing those resources.
>
> The caller's error path only calls kvmppc_subarch_vcpu_uninit(), which
> does not free the nestedv2 state. Call kvmhv_nestedv2_vcpu_free() before
> returning from the vcore error path when nestedv2 is enabled.
>
> Fixes: 19d31c5f1157 ("KVM: PPC: Add support for nestedv2 guests")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

The fix for this is already posted here [1]

[1]: https://lore.kernel.org/linuxppc-dev/082c338c69773a73a48cd4e0d0885ee0f6ef5326.1793546707.git.ritesh.list@gmail.com/


