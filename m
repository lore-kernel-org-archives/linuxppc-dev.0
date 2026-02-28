Return-Path: <linuxppc-dev+bounces-17455-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C66FEE4F2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 17:56:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNXtW6wJCz30BR;
	Sun, 01 Mar 2026 04:56:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772301363;
	cv=none; b=P7+KGJ6M0KAOvQ1fXu8uCxtFdCdR0aokmS2vEIpE8VvsmEkTZplA/ILSYa8ptN7GzXAUxH3lIcP07+6DlFCT+OCX5v0/IeMVtT+cQXaHwSxgPBWAtO00VUlJgLma7rgeH3qO78jSrIekmmqgYdie3jUyAsC1rfYRkbGw6MjdTaEFgittMLJCnT4pAGovxDGjWLasNAaZNafYvsKXJRNPGQJfTnH8k9sROAPBbMD1dBJNuoPQLgFNz01JUdDGP9ZbFoebdqopnHqKZckMDUow6SzKJIKACFIWKkN5RrE+BmQVEv0ma2Iz+TuZrKM8HuugfiQowxWIDBO07E4XQOiBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772301363; c=relaxed/relaxed;
	bh=fDA6fINhoG19nlLDNAxKdZSYU9C7hnrjgxA7avQ35o0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=X5JJtf4Rfhf2zNLPIYJeErR2XR03mFkpzccI7OrDRqneVPiplaT4lOLYd+EdpMol5UBG5CEZmwQKLCXsDKqy+x8pR9U3dzksZ39xi/nb6vnzCgJGfmXojeI/gBCSx5h0bYapzVww2KBmJPUUvTsvSgF3QQlVF6EmsYkbLi8MPX6DAcfwD4B7rChrf8zH3cPiPonDEhHjMkFg5zRpPP4MKsrgeIO5dNislAbfNAGRpLkEErl1+wG/kumvLR3hvlId8duotfovLk43MoUSfSSn3kSMLzEuxYVnO2dfJKzba1eZ7a2wiMGHvfBMBq1mxGDCVQbyLAAUsDIRQoPxaVfdUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fXbUn+0U; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fXbUn+0U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNXtV0Zmgz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 04:56:01 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-824b32875e7so1579754b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 09:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772301354; x=1772906154; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fDA6fINhoG19nlLDNAxKdZSYU9C7hnrjgxA7avQ35o0=;
        b=fXbUn+0UuFd4M/d4zOzbZuIkUBeePWV2oQTWxP9zRO+Rfx1yjttEGWeADU+YOOI/m6
         GvQJHTTQO3SE+J3IVhNnUu4Pd2J+eZIK1ud2Ze5ptYCa9x5C2fQgG6GOe43SulqTG+XH
         VXBEWZ981vb3LdzeqdpL1X/oh8/BwA5Jw86q/6No+j1txLNx+rgIpYw77pryUEBFNOcE
         VH5TSsGPMJyIM7bcwf6XjNANBeNu3nK8hXolMGYO6ejfdHvrdJCp+GQmj8WQlCp2SOoE
         jBVPdc2sIm+YZ+zKgs9HCHoQsz2L7+bKnDKkHeQsTsQv1meqHMeseywD58Bm2FLOsSg4
         gf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772301354; x=1772906154;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDA6fINhoG19nlLDNAxKdZSYU9C7hnrjgxA7avQ35o0=;
        b=GhNh0boXYMfhx0lneGI2H0QeROmsMUK0ARJaJn3j7FltKnhSoh4xkglVr+BKWMSExU
         6Ls3ovPXKOjNogCSAbubCCGf+5WySWXicli8yCJrtY7wQ2JRcZhHNnzjqJFwb8nc6XO0
         UEp962lHkGN3spYXJFuHlmFkIln3D11GL0nbMPdpZfrvkLSyZaTqT2VaJIKvgcISAlt1
         Gg5ZETkFOMdLx0v2SZtvrgoiSVNU3eB+hDFF+2cB06wRrjeY5978kLBoBIsxun6bB2Vv
         9qZg/g858YnuzCyCUJ+cJBaPA6vUBMQNFgjP0gOt/THebzAhytr2ZGxMSVQ6Aoo5BaPu
         Go4w==
X-Forwarded-Encrypted: i=1; AJvYcCUa3SlT6FBlPEyfWMmmCelnjOM6sEBnPvzIe4/LBJ1T3tTnIu0ebnWzso4yNuvIQb9+c3WxEcFY4mKqGoo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw73CcwTAUrZmz4KAptkS32XUMdhGoI5AepijAbbLfmoSicBxFT
	VVPovAkZhXJugKqdG6aMFGXw8uvfjl8eJzgbuJ9VDQwkuMa2sH8rorfV
X-Gm-Gg: ATEYQzx2t1Wvh13cYrRk0p5zvNSdZ6RLmJU4BcxvM3z+3VSGPEJ+QBQPT9hBnB+w/SU
	h1TPaIJ4mnnXmcfAG5IRUb6rUJvNiYiKviW9SXKSK3514vj75iOSKSNTgbLENGwjMB6VpQ89QxT
	k3Pc0WmGHE0y99mlB1/ihj3lgPDeW0avFNiuQCWPDrxedVrFN1rnbcFuxXRiiydzzlzEJX0lZHp
	cFfhFW73YePbKCoIEmjvW84Hw68DeQgBVNk1n743Zt8ny0XbN9Ac0GZYBaZkFTxeyWuMd0EUnF+
	5A4ud+Y2H27UUQEQkCcu3M9iRFvnNEqGq/5pyChD54RsUT2Pap4A6kdhmG5GHydhl6KOAl1WMkf
	xWfiV3P86jhedEuy3g8ox6NxYBrNiUOtrIXdT4C6+6RNtpKujEij/TUBTal8AXGDqeYqYU6ru11
	HRnN7LjbOhaVnPKhUc
X-Received: by 2002:a05:6a00:3d55:b0:81f:17b:c70f with SMTP id d2e1a72fcca58-8274d979671mr6142851b3a.29.1772301354054;
        Sat, 28 Feb 2026 09:55:54 -0800 (PST)
Received: from dw-tp ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db4955sm8884208b3a.29.2026.02.28.09.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:55:53 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Donet Tom <donettom@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, linux-mm@kvack.org
Subject: Re: powerpc/fadump: CMA init is failing
In-Reply-To: <6a0fc7ec-591e-4f23-b0f2-aec9aea88621@linux.ibm.com>
Date: Sat, 28 Feb 2026 23:24:22 +0530
Message-ID: <87v7fgiwj5.ritesh.list@gmail.com>
References: <4c338a29-d190-44f3-8874-6cfa0a031f0b@linux.ibm.com> <87o6lagljy.ritesh.list@gmail.com> <aaIDkB2xLABDyV1y@kernel.org> <87ms0th9xt.ritesh.list@gmail.com> <6a0fc7ec-591e-4f23-b0f2-aec9aea88621@linux.ibm.com>
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

>
> The above changes fix the issue. CMA initialization now works for both 
> kdump and fadump.
>

Thanks Mike & Sourabh. I will soon share the fix.

-ritesh

