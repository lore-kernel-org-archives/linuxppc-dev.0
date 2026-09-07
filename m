Return-Path: <linuxppc-dev+bounces-26630-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447C0C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 03:10:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdXBQ19htz2yjw;
	Mon, 07 Sep 2026 13:10:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788750622;
	cv=none; b=h0CvtYdGBlSlHfrBRUOOMOG6MovYQoe1Md2UdV8/flc1pBva7gpfwikLuf3r99oI391vdxZMG8oaV/kYJhM1jD4Jt6gDMzYg6tZfNfwn5y7mTbKp7RKfbytMfLtBxRcutu7xq4O7RZculqnqDnvtnPBf0wxRoz6F/4c4qhsKEfMpELNFDv0lSwmCQcMH1Zgbf8F6L1TNRpnK0uw+bUMcbPEFOYSLKnx4d4pjxgKRW6FBuUcRTNlP7ugG0DVreAbZHaVQ2jfN/cJggfTsBD3qjS9IYGUGcwxRl5NLrTK/NrTUHWbZF/aozYYhiilRs9JttTLC1qPwkqerVdl3Caf3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788750622; c=relaxed/relaxed;
	bh=HIclRrkTtHr78xyYNTgEMTIC/Gv1UDVrXFUeoZXXUfA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Fgs7yfucCsdds3aAvyRkFbwv9JAbnEJW0HI2oNmkaXEAWg7XwkOo7/Xj+tOzt0MuA15JuiPXAT7yNtb81ME7c1Z/7n2jIvb3TlMj9seji09daEdcikjHcfmQHhWGFbqSxuaLLfeqV7kTTanBmclFW+CdEsgAAFUkpybLo8KXUetvaGXvshCHpzLgfYEyAkYdXr7gPaQvR8XloVTwsqfBEVKCSSaizGTTBFnX7t61aUDVNlkWHMU4UqQQTwWJEzQzEtuAWWxFxU8ckZ0qAFXZChosXqXDiSd8b1OMqdiyJeC04SUj98MbU1nGZNQogg+MEVmohsgRxgZsSvaEW4LtOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rYVSnegD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rYVSnegD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdXBN33H0z2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 13:10:19 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso2429381a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 20:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788750617; x=1789355417; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HIclRrkTtHr78xyYNTgEMTIC/Gv1UDVrXFUeoZXXUfA=;
        b=rYVSnegDmK+tjpET/+6fq5UQB6udh1q4EvtCMpEnxT4QE4jjg0TiR+qsWS3LuPBvA/
         bV4nyeF7oll+Tdoi2zxzzf35eR+Y3uD8qWPOAkS5ZIurd9Tq0ad9Mccd1F/yHnkHDZxp
         HDbnCSt+RGcN9unZ6oX5FFPW32zAvNlcUsm+gXPZCFB/BuLlsDalCmXRzBaV/lIKQIUw
         M36pW/6udhUQ96xYvDCqq7KCsCW+g8g0jFqJVPGtt+69x40oMGu09DQKmkRI3X/KL6W4
         lcd9QZGVHfip/J5avOPpyjm++NgTxj341fRBxxrBW5AlQ4SY3NRfC28PvEuSTEGR/+2J
         Pc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788750617; x=1789355417;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HIclRrkTtHr78xyYNTgEMTIC/Gv1UDVrXFUeoZXXUfA=;
        b=Otv7fRbzbW+XrWO9IABp3UvAQDhbtkKWTMFF6QcaK0gbkW7Jh7M8fsWZzEpuRlPEoE
         q78vB+OnVj6BbZNFtKh9k09WwlOIpwWpFhNF+CAn3GAH6u8qzB7GTJybMCcOnIZxnSj4
         0Zn8t7E/iow8Rc9beTZBxf980PBn5FL+cysEn0Endom//4PfxuZTQbjNhr1pGuVWp/xF
         wBHX77o0t1YJakhWfeg/AaWYyqhUCLAa2hfCl+QdKBnk13j4Jut5rmWrYtUozoPZ1Q+4
         Rvv9encVr7SBlt3BpQOze6GR940qUR+n4VH0vowuHPAgvbrXsIa2AfyM0mB9JfueUPtj
         ir1w==
X-Forwarded-Encrypted: i=1; AKwUvBzGJkXLdgmKb7BxpVHuPNOHmhXM+3+gsvoPm0JTWD3iYlkMpGeNA/tEyJJb5wv+6jKytgUZxcezjZ/kPfo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mqdI9NOddwkQj8Y5/Mos4BpB2dP8hZGxYU5rP7mv8oh6hrNU01
	BTwG6O2t1nHlWAS95C0eLbkbeAVKLdWqUa4Dt0zehHdF+8LFewPbiwdA
X-Gm-Gg: AYBFou0axJH3trmjUKX32oMX9T1YlAH2hwTiqosiWJoH568k4U3AIMxwh7R8BdFhqNi
	fzZ6J/HHGLMAM+ZeXH3AUVOfDaq6SYymJlVSpYbsvLFOqKhELaVDt8RsPrNNZHdW5mPaKjkKlPB
	4geZZeGKZHWleBxvRZxxE+D45Cgtfe+tHhl7vb3qTznViVfbli+qMmExYofik1ownWBce7K8sKW
	NvwbCz6QsW/a4AxakqtsxR2EKOiC3cejcQ1kTkf8rlijZ9SXyCg6Ywl0zJZoyD+FzkZi/AsYTfv
	9kovCowZ4M7dLVx3VC/b+b+uSlnI+EiOVBmM7mRUO7TCbFZsCHIyKjmKd/SiuXRwNGHLRXkbn4C
	E7uVWPD0rcbAwST3HtXpzJirJE1eV43vzu+hg+USRamSnQZG63GNA3ZQbz0ZJ/lzY7ti3836gxn
	720C9GvZB6z9z3kdaQ1esqdXDmkDZeqRXhDjmvA9K8niPSWYVU7BQV7IuyOtGdi/FPRsOf7dIhX
	T9yyZ2zvyyTbUPrvluUGAhBl2aADSJ/l9Pfd1tMSkdd
X-Received: by 2002:a17:90b:560e:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-39b261e7931mr31545148a91.14.1788750617002;
        Sun, 06 Sep 2026 20:10:17 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243767e1sm19875155c88.6.2026.09.06.20.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 20:10:16 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Haren Myneni <haren@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] docs: powerpc: vas-api: Fix the structure name and the ioctl number in the example
In-Reply-To: <20260907004925.10948-1-kmehltretter@gmail.com>
Date: Mon, 07 Sep 2026 08:37:19 +0530
Message-ID: <jyox21zs.ritesh.list@gmail.com>
References: <20260907004925.10948-1-kmehltretter@gmail.com>
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

Karl Mehltretter <kmehltretter@gmail.com> writes:

> struct vas_setup_attr does not exist; the name is struct
> vas_tx_win_open_attr. The example also defines VAS_TX_WIN_OPEN with the
> request number 1, while arch/powerpc/include/uapi/asm/vas-api.h has used
> 0x20 since the ioctl was added.
>
> Use struct vas_tx_win_open_attr and 0x20.
>
> Fixes: c12e38b1d52e ("Documentation/powerpc: VAS API")
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> v2: also fix the ioctl request number in the example (Ritesh)
> v1: https://lore.kernel.org/r/20260905104313.43620-1-kmehltretter@gmail.com/
>
>  Documentation/arch/powerpc/vas-api.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for fixing the ioctl number too and sending a v2.
LGTM. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

