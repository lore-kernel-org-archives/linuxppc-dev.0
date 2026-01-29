Return-Path: <linuxppc-dev+bounces-16382-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AABD46C16
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jan 2026 02:01:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1j7Q14ctz2xpn;
	Thu, 29 Jan 2026 13:01:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769648355;
	cv=pass; b=dWOUjqmkWPmHTWRvNPTIyvTDbIklj3X2ugDvFp6kHpm5mnm1ZzkOypJz7EW6SFE5pRSNfA0vQM3RZTa7+qk0jpV0395ChMhnbgfIBX/qb2yctfto4uAaApfnqlP7aCudsIlsO9Y6F18qGThHZepwltzrDeh3jp6rSGfEvOaKbAhxn/arjsX5xym0gMlh8wVTL4QQ6lQsd1i2RzYUegZNuLpeeDzCgDiocb/ZunCmJOMcOUhfJbg589p+toHObui+TauOYnfH6SXF5EP0pT2pHqEMNdoPculJhFihLXDLBYgPONK5u4uTjsdsgOSz7Nrouln6HBC6WszoBOwRqlGZrQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769648355; c=relaxed/relaxed;
	bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYVLyncVPHMRTd8hzlFPVc8eBPhw3dNO8p/wpn03hBKIj5f6LwHutvE+jbSN3vL3R83bo9usr9wN1k7WCgDOie4VSVMatzDNzLoyE9GwKtWwmRmiC9FEi/62GKK4hlD3zIV/PeXDpLWA7YVF4IBqjwnCi/O2Nm7am+KLKRihAqKgYZDIqrgx0JtaAGzgLznLjmUTR3Va8BGq1xoZSrzOxKjeJ7xRhAyPhJSmlDkgHGWaAXLNYHKyuesWBf+03rRBG7H+pBcn6iajVUzqPqg39DyhfTjVxC/K5xq9E/fhLMunyTK20OI/gFQ/qBAybB+BDTNF3r3oca547krJI7EJww==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=N+oWWHAc; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=wusamuel@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=N+oWWHAc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=wusamuel@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1gl60KfJz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2026 11:59:13 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-653780e9eb3so702010a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2026 16:59:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769648348; cv=none;
        d=google.com; s=arc-20240605;
        b=kE61DXT8JNUbLk43YMcyAvtL+qM925MyjFxuydS7rRxCRBq8hIzxFYvfyj9QRwjxOF
         Ke1HqPRH78u0RvXc0p+jUT6CIys9v0L0bALrZivTKt4elhahgH4cQNv98HoLgUc2y5lY
         mkikH8TDDIw/x2vKKborzu/CEIAyDQZvJ3CLI/mq8cqWmYir91jJbo6YlhO9RSC9b73c
         MiM3+c3+Wo0rv0waCyMJmN5h0W6n43Xb55stnW0XyujER94Zfc22hTHd2OhGdNZCB1Dj
         ceFnYdOZlV3k/fkDK8OaSVgIDrcAtggzxQ7iVeIgBpi5snf2YJCU8QGjSYXiZjdCd033
         YJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        fh=bRnd44lHkes4q/SZN8fU6n5BwyiZzjazvHXsE1D3ZkE=;
        b=lKoxr+mELTyPWkz6PrxyJwEoZ+tULuhcLiln3bnRPwWn42/1Mlv0F/QbIBhCuNMCfP
         Y6N6JfEOVAGoUuUlW9nSItOAOuj5iyPt0IGL4+jt629UirQdvafh2ydUJPW82Skpb/3E
         sdkhyPwnik84fLgw462z57iRdg1AaeWOzwXd8ertqyCuzVlQLcwyLkt08Cps3PIFOIP8
         fQYlXBuRpjHj0bH+bIicfzj3DI7fl71T4Q3t4pCc+CTzC3vsSnHAaFDP+02lXPeChU9w
         GRg8rcLKZvOY+esYe1EOlB86RB8HU8PCE8CXA/yHe7vB+xt8O7nZImUuUyBa9yJyvPLR
         +iyg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769648348; x=1770253148; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        b=N+oWWHAcMTq0IMXJq/4Jc51kf6bnFke4MV4sR7m6/YjrvzS0ncBG0xUi3pGDpBOhky
         YSCoqxL4V1Z66/uqhaXDxKy0nRFb0nDIlQrPbqweK0dYZw+wIObGyL57n0eLZ4zRAGrP
         mbHoMoDlwEIS2Iv1Q+R8cgH/Vq9gcRMs2XjW0VaKCwIInySQgAn2eV1lDHHxbjGXnrlJ
         BU+oG6qXzSSjrMR8ZMD/Brk1NNS7Mtn7xHhq/+zBtKeDcxGGdFhXggYN2RmkzHm2tgH7
         luRvxcHH64w3Vbv1phFi52Ni5ogxL57VmEli7TdTGkSrWkLmyPsMUjw0ZAd1U+RvIsfj
         3OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769648348; x=1770253148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ho5qTXSu2PZYffnzQVL+2Xc6poCFB6UxCVa5s6rbRlA=;
        b=gnlNPLgK99YXfDQ1wt2pQUXxSsZZx6Ca/a0u2NvapcieK+5lNvC4sHO1Ja6AzmE6Jx
         5ngCRotqDESgdUhLpQTU9M08tCL/lavyfIAiN6ytnry97CllAieDs+0SzC5Ody9V2EUF
         A7IzqfFvylogbgFqmLkCMEfCxP9np0dFe5V86DVzqP76pldXOTv81vNpzNeJL3IBfj5g
         p1xh20IDSndy5GyFXiyVlW9sOTXWQkrzZ/oxDv+b4MHIJLsIv5twOzhvJYRRzYSZEXrO
         /jMiJ6S95R8MU9mMwIg1slKozwxdj5+zqBMjejXlxRnb5xuJVgoYoGCGYFC68WXKCHvq
         acOw==
X-Forwarded-Encrypted: i=1; AJvYcCVLrnSTkcJr4HLMSBf4nE27CjdsfiUc2fk5k5p3jYmwURnMKOEE8fT2VnLZ7DKACLYf7tXAHPHzupdu+jg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyS0kRKf7k0tzlSsviBan83UJ3smy7eT27tiMlfBoRFcc+O/x+w
	DfH048OhKCnWWUSt7yij+mdT/t1LombsoiIROlCj/xywdrowfpUXdpCJmfhaxVZEhY8b7iCoXMk
	AdmBYbhVfd2kv3bQiwx1xGrtneM//nRpd4jfDSQ+4
X-Gm-Gg: AZuq6aJdXIrKSjQNKccro3fxOeyIb3rEz7dstrf9y7FViB4WmOKGeTUJ1ZPhRxvQRc+
	1qYpcUuLccLE8fKY+2tflWVB0mptvcD0NaLtmFV1NabcigxphejcAAZoT4C7zznvCNNlKfjVOca
	w/bi6c5H4jjgEuZ13BKz2kcUTCIQeFho2GpzzfsJVFVGJimRbCqsmiQpUhmdNZTkliqQCFZEGLu
	YMC2F7fo9rIK//0St04IdkciXlaAasHI7d/alBBsmgXpKU8/hVnbn0iD5tV6lFgqE1tkvXfDhDH
	gg5jU1DY2hB1Q/wXOaqV5BAgnazEnQ==
X-Received: by 2002:a17:906:f585:b0:b87:d722:f824 with SMTP id
 a640c23a62f3a-b8dab3cf66amr455166566b.63.1769648348337; Wed, 28 Jan 2026
 16:59:08 -0800 (PST)
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
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV>
In-Reply-To: <20260128045954.GS3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 28 Jan 2026 16:58:57 -0800
X-Gm-Features: AZwV_Qg5mDXEWLmzjtDFHSng8MB2HQLUBKHQ6Wr860X_lRTmL3Z_ZmvOjLnN07o
Message-ID: <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 8:58=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:

> Very interesting...  Does 1544775687f0 (parent of e5bf5ee26663)
> demonstrate that behaviour?

Reverting only 1544775687f0 (functionfs: need to cancel ->reset_work
in ->kill_sb()) does not fix the issue. With 6.19-rc7 as baseline, the
simplest working recipe at the moment is with 6ca67378d0e7,
c7747fafaba0, and e5bf5ee26663 reverted.

