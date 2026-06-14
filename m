Return-Path: <linuxppc-dev+bounces-22608-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06DECD98D2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2026 07:43:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdQGP0tYLz2xtC;
	Sun, 14 Jun 2026 17:43:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781422989;
	cv=none; b=aNqwFuIasx2H+tfBliXjhazmsYjm4q1XYS4q4l8aRgllD9nwz+eir+jhfGO93ZZHc6AxOu+jzvSksWTZA5fSf20X/Xh8m+rwsOnk1E8oevmiEUo7EADEu8Os8WCvDOVVIz2vA86Cw/dZFcj+hg1bm0WHA3T6TDXprwnDoNVdYLgQ4Q8mkAOKDFcZHjEvWWWSWhRQgZPu/qPe3CArmFHtWyx+wAUm9Fv2g4We/woDNBha2GQOX6vRSHRSXJwc1WonI8VD5LF+UjLQ8nUQwnBIgwu5y/8uNwtBdsKe8HrWd/pR87X6PPlEFYW/LJzcXk1i/1DZSZCfpUU9XGK5ADJg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781422989; c=relaxed/relaxed;
	bh=Tic0p+pSkHb4hbn4DKqBJzYkscK6Ityq2p9UK/h/iLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foB++k+Fx84UIsmnxvHIHMurziKIJ4NwMnjYrxMFyq5C3/ThQHuSEH+DeMEC51Srhd7tJOvhpFDncNYflHLwBqGI8kHRtUjviIXFWE1d+BvkI3Z6sC+3WXeH2m0vIhRr76xG+OfC1Y768ys3v3nHzoq7da4TFz6FMIfhG6rlvX/IivxTci/q7jiFsfJ9HiEKwtslFA8HhON3nenyc64ELnKXkzdCnYvpz5TS0MebbQwJk2msfpu6Eiz/K0rJZWdEFGn4sFLZ3VgcbDEYh8l/hZhWB5sjJR2pkb0G6wA+7ypnH8/xqJ4ng2nUG1bb+bMr4NOnAKGQBhTex2cQVrIEfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ASrYAdAi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ASrYAdAi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdQGM1S4qz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2026 17:43:06 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-8423efd76c8so1740393b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2026 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781422979; x=1782027779; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tic0p+pSkHb4hbn4DKqBJzYkscK6Ityq2p9UK/h/iLc=;
        b=ASrYAdAi2VVc2T4atbb/mDtNLVXyr2B3u5jouMnLf0SM4U4K7mBL8A0aMIG3QH0F8z
         HqhGAxownM95YOMb0726V8J3TNsLwWckXYW+RbiubDNN8o9F4WbpPuNr9ejc+IHrYlk1
         ca4OrmF1gpURpnu9ls8/OM9RHosd7ohVu6lQsvdSQkAkkmGfGABTVX7ZLthp4HD04nIX
         jXLPZvntFqwf2dGh8aL7fqlfAX15ENOhvE0QzzrVY13noYbNpKNsuczLznNiU/BR9XOd
         rszNy+oltphZJ4HvpnQ76cDbLN6W1kM07A278avhKCPUlWeABbN4hj9FGQ+YZyYfiUol
         vUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781422979; x=1782027779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tic0p+pSkHb4hbn4DKqBJzYkscK6Ityq2p9UK/h/iLc=;
        b=FEZjQRp2tCr4+eErZhb/K8sPoFw3yCSpmRVT0WlDPxczA5f6JlJEuWeqUqSQgGleqG
         jM4CQEksM+ZvIS+MIJay6kkCsQxmcEnsW/eyoQ90SGbPMFyq5Z+5BX76C1Q/njsHDJVA
         oWYCpIrFm+rjhqTzGZrmBLcCPzg0BkSU3ztrMdZbIUTidt07rdjSVJfx9IQhiJm+J1vH
         IMe/C3D+WJSXBjtSovfda2Ruh8hd9uLZb6/A0lN/r0aK9+EaCg9kN6hyrh3hhHRuxij6
         iEuyeeo+pnWNTBy1xV1de49uuQ9XQz/5rjFsitazFoH+0gs0DLum01KSiQkbVV9JWoZL
         wNkQ==
X-Gm-Message-State: AOJu0Yyjy32TnjreOkYPcg22k0fZ7jbaosC6JE2617wEtrS6amqFnkwt
	svA/SBV0aRBYy9vwdYVR2WKFhNEnZNtUFFFuyuD/EFbKqUx2ybMc3Ce6
X-Gm-Gg: Acq92OFytsDufsOF8Oed8VFN0+UCHlDIpiTrpDxIL3zw+7soFvR/64WjHmMgA+8fEC0
	6sxYSXfXrxk1EyGUx2WVoiqpQsfNNCsotBLju7wUzU5iBEb374RWq4rMFiyqLWAyr2LjODuwH2d
	CLdDL6HbqqaGLUKszEeZmGoI/PPwY4vQ/uVrZdX76kUFyB7w9nT/pvbXTxMsoU8hHB2j1pmndSl
	sU+ZdxAIHfSR9NkPDcBoVr/RyU5RaEO4kcTDmzOddvmIs1vgctV4+c737WEc19hf8D6K4lzZLDS
	vgISMEel+Ut4gkqtyeWMzHxxsG0xaV0ozdQ/vL/9B3QB19yFXrezVKcMMgL7fpofvdjqcoDaAzX
	qh9wF1FyF7BHlgWjeVfvMzUbJN5Kr87Y8euypfXvkDmvw0+lBJLQr70p0KvOf2HvdBHeDyBxwBD
	5xGdgEb7C0TWD0hMKggl8Kr/xXsimdwH2Hko7BVMqvIR0KicmdB/uGDxVpiSMi7C9/hTk6nWU=
X-Received: by 2002:a05:6a00:1407:b0:839:44c5:c321 with SMTP id d2e1a72fcca58-8434cec98c2mr10187137b3a.44.1781422978919;
        Sun, 14 Jun 2026 00:42:58 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acd96d8sm7869812b3a.19.2026.06.14.00.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:42:57 -0700 (PDT)
Date: Sun, 14 Jun 2026 13:12:51 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Sayali Patil <sayalip@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, 
	Peter Zijlstra <peterz@infradead.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	sshegde@linux.ibm.com, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Samir M <samir@linux.ibm.com>, David Gow <davidgow@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-next-20260610] powerpc/hash: KUAP fault during boot on
 POWER10
Message-ID: <ai5bH2tqNdFqf034@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <fcd11556-27ac-4cd7-8c77-50716dec6985@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcd11556-27ac-4cd7-8c77-50716dec6985@linux.ibm.com>

On Fri, Jun 12, 2026 at 01:02:50PM +0530, Sayali Patil wrote:
> Greetings!!!
> 
> I am seeing a KUAP fault while booting a hash MMU
> on a POWER10 (pSeries) system with linux-next (7.1.0-rc7-next-20260610) with
> commandline option disable_radix=y.
[...]
>After reverting the following two patches, the fault is no
> longer observed:
> 1.  powerpc: Enable GENERIC_ENTRY feature
> https://lore.kernel.org/all/20260427122742.210074-8-mkchauras@gmail.com/
> 2. powerpc: Remove unused functions
> https://lore.kernel.org/all/20260427122742.210074-9-mkchauras@gmail.com/
> 
> If you happen to fix this, please add below tag.
> Reported-by: Sayali Patil <sayalip@linux.ibm.com>
> 
> 
> Regards,
> Sayali

This is fixed with patch 
https://lore.kernel.org/all/20260613123831.1510474-1-mkchauras@gmail.com/


