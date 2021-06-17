Return-Path: <SRS0=XOTo=LL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AA6C48BE5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 01:49:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3F4613DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 01:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3F4613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G54jj0mW4z3bsC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 11:49:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=WtNZ86RL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f;
 helo=mail-pj1-x102f.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=WtNZ86RL; dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G54jF4WVbz304R
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jun 2021 11:49:03 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id
 13-20020a17090a08cdb029016eed209ca4so2918435pjn.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jun 2021 18:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:message-id
 :content-transfer-encoding;
 bh=7bYaosGE/fa8Mu1OlaYAbGCa68G83xHIE6nxVpigaB8=;
 b=WtNZ86RL6iFpFY5L9JgN0YJ8DVn+0+cJUvN/o0HXK0Uz8ag7wE8FhSNFv78BmfLt/6
 4xG6ZWXXi4YVsw28+ec+nZw44cwSjzhKZgiamsf4yMmUs8UgGs+IMNBXtRg0EnhYFztr
 ICXLmQlj1a7VRGr8OBhBnaQ0k1K3Sp5TRGFnqvJk8mI6jas1AcYfGwrKCkwVDK5qp/np
 GvggqokFoIGTYmg0HXiEymr5Y8qGIit3cgYLX+6M9JjPQb8LucD5qtttgd1IdpuzcF2E
 2KzZXZRnTdZwyLlNt0jjoESPhpxgu0cWyrd7m9vWJpoXRYLhHNKAZRGD0Sz2aq/aIb3i
 5JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=7bYaosGE/fa8Mu1OlaYAbGCa68G83xHIE6nxVpigaB8=;
 b=MnMtmcR0NXIYhsldXqR9hxSoEENUEmgwjg337uTPReCU6R5oaTxcBPH1PDW4VTTvOq
 BbPz6PC4NbnaHV6UZhn4klTYH6N72LeEbc7Adz0EK2dM480V8A1x5GzXFTReHp32GRUV
 XH64OLA0XOZXr0zsoikPmAMo1QY3NpuCEjEbZDKDSr/FFKILBLFL3NXlEjZdSJHzoEpu
 0Es7Xfg4i6N+0GQG36+mkBFv51knzEQUXD7J7RTUStOQOAdWPlD9NBdqRefYeyQHlolF
 Odx5hPTgeKXuMMRbVEceKxFg/Ht0RFp5ageBOeWc/vlfr6g32j4E1tvSshy70/QDSZxj
 L4Mg==
X-Gm-Message-State: AOAM5337t6d1mKrwFbyk+hXMcd7lX+aqvjDVKbPIGs1Xn2wwkgYkscZB
 vsmnuTYd6DI6/QPjVT7Yp4UVB2mFpj8=
X-Google-Smtp-Source: ABdhPJz7g5gVPBjrFU9G5ZskPZrqLlDR3q/WZERd06sgCQFwE+XAKKwhSg0XAvpGLJPZQkVhzzAHHw==
X-Received: by 2002:a17:902:8541:b029:11d:15db:46a3 with SMTP id
 d1-20020a1709028541b029011d15db46a3mr2308743plo.41.1623894539467; 
 Wed, 16 Jun 2021 18:48:59 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id c14sm3497502pgv.86.2021.06.16.18.48.58
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 18:48:59 -0700 (PDT)
Date: Thu, 17 Jun 2021 11:48:53 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/build: vdso linker warning for orphan sections
To: linuxppc-dev@lists.ozlabs.org
References: <20210611111029.1058789-1-npiggin@gmail.com>
In-Reply-To: <20210611111029.1058789-1-npiggin@gmail.com>
MIME-Version: 1.0
Message-Id: <1623894190.q9s66e7wug.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Nicholas Piggin's message of June 11, 2021 9:10 pm:
> Add --orphan-handling=3Dwarn for vdsos, and adjust vdso linker scripts to
> deal with orphan sections.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Okay it looks like modules should discard .PPC.EMB.apuinfo. Not entirely=20
sure about .rela.opd.

Thanks,
Nick
