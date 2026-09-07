Return-Path: <linuxppc-dev+bounces-26632-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7120DC79F89
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 03:34:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdXk74Mhkz2yvY;
	Mon, 07 Sep 2026 13:34:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788752063;
	cv=none; b=ev6StnRoUIHZgzYxPzsTBKMK6sMB3xp3SfQcxsEoWGxSsPPIFGJpS5yEJ7hkoLFLF6BSR9qJe+6E/35ZUBC6ymrOAB5Bz5GbYkv81rmVcJt4gu9kXYwHOvOlMvaAZ9sei6aVjeNqMu54TQnTr8vYizB/qaW0S6xMU2HsiwAqNPJFe+pP8r+JeUPEIfs3FqZl9p9MBqb6WIo5GpteNOsZMGM5smD0GuzskSUaOQgZKNQNq4Xzc+hsUVsC5e/hZK4rM3/vEy7U36cdtrFNPnvxUPXP5dLQ9CswJe/beiwotUHmEMX87PE/azUNjcRDDcPwZvWby50sLv7uba0crU9akw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788752063; c=relaxed/relaxed;
	bh=NzmalEi7I+odeLr+4a2zjjF+oU8PtMSru9tMm7bbxXs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=irtfY8judN59lJrHKH0YdccQJxjBvex7au3JFZ3lCDao3RTNkszz5Vv1awrGD9hK9n88n8J5FTsacdGXUpH170Qr9XO5aDVmAJgJeOtsgLgjLdLG0iIdBydR3pjYBS+EbfsBObGB8ywU9M+mzVimySSZuRodox26p6/B3D2VoDacaYaGHb+vMGirpFMZP9HabJswQH0dpwUq5YXEWxnlmMMhvWxv9T2w+WWXQkTB31UNK1fTVV4zSwiwWDq2qAXR8OS2/KXj9c7ncGZ4nQcy9JP72ppU5CSAWOnoppsPCxhU6AHYvgrXTjafTZEWxoNsGhc2u8THA2xGnhGySYYBeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rh3hYBrM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rh3hYBrM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdXk65DFLz2yvX
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 13:34:21 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-86265451beeso1216343b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 20:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788752059; x=1789356859; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NzmalEi7I+odeLr+4a2zjjF+oU8PtMSru9tMm7bbxXs=;
        b=rh3hYBrMMXY4TrmXH+6cUD0mMr6ONV8I5YcZPfg3qv0LoKIDjXhyJM2urGSRePwd/i
         oEjTN1+efyg35Di8dCZDK1S7Wt7AUIZHHUPRj6YxDeWdiK4VR234Hef7Yro75o0RwHX+
         X5SiBH7JwGaRqSht88UPeKvqzxk+8nm4T7nmVI7o8H+Fwg1oCsnf5MEMhK/7C7GU3L3R
         Idwp2RjPylPI+9ix0dKSeT9nbWH57BA1imgsUz+i+yyGA8DEhpuVkSGJ+VTyzN0FeLCg
         7kpQFhTObq5uwK3fPYIEsOAzvRNlAzxsx+ulXGFIoxwxVLhitmtgizsD1Smv4C48reEi
         oVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788752059; x=1789356859;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NzmalEi7I+odeLr+4a2zjjF+oU8PtMSru9tMm7bbxXs=;
        b=Jgw3jzrBkgdlZKxoSNK+zbD0frZ9izzsibswtwG+CCVv9+CXsvAMkjd3lPfo5Yn0b0
         eHL1a6Lb8vqP4HmKXY2xMtxM8aSK2gS1jRmKnKXglMXHit3dKEiHQKbe414bOynUg/bW
         C7UIJK3Q+gi4TSciO/MOhs5leb2v/idZBNvCOEiyfupU25zKCat558HHy77DUV2FRW8a
         7gvWKe2IbcIb/XAHxeoo48MFW/HiKNP1lw+eQE0j0j9KHsWSTST+O1RAKD+jUkxD1L3q
         KGH9d6EDYBdNA0vDU4IxCeqkrg/vSkMub/dPD5RhAQ0tuLYNwRtpRB0NJ+Ng1S9it0d5
         ao+g==
X-Forwarded-Encrypted: i=1; AKwUvBzDExTOph46NX1NSv6FD0nZ96DNZpcUFN1EvdmbJkHBjvD8cSwSZ4Mh058m1KMYKSwK/Jxs6CieHWiS40Y=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lW/xtN6LjbyLyjv+z8OB3XkzCY7ekW9p2JPPbkNMnc53nIki9V
	Vxaar1cZT+bcMuUMWiy84mC0jzkYED8W5RR8IT3/ruJO2kXT3SyFQgQo
X-Gm-Gg: AYBFou13PQE3wOhyzvIKEJR+HvTwqWnfq/PEBflAXwCXSF9PWYvIFvUfPqyl2WqS9F5
	5ipi1CWgVzg6PzadokLELMFNhI4mjtWb1dq2WtGSANh68kZFzaFXmnc/LSsSxpRdIMVSSbiFUbL
	zq6Pha8nn0sI3Iv2PzSRZ5QlJxvwqPsnDDHzWMPkcX9LA44UF4/WLO8zKCEYZAXYAFB2rmk3LP9
	G4q52NixmJIT5b7qkitdd1xJiqXxDu/JncI/eNXbHHYkA2d5eYuHcskQZ7UFGdFL67PbfJdmZbb
	Lp6s92mPnusefvV02NM88CLr1OMDO4ruiUgsF+aHzmua7/B2DAPQ5ZLFSZaqK1J5yN2dpU/4Tiq
	XRHd9mITPkJrEyEOCv75wkU6uuKVFGtyeamnCpU3CCB2yHV/+lULHDqVsLQrYeX2DJFfsaGLdL1
	i22lRsv2Aq30yjmqoUviANjEAoMcUGR7DgcBufnEAYEwPv1jbnG6IVn8WAf9wn9Mc4+5LAhTFxs
	YcIF3KiTHyFjEOZgEGAvOO9lKXnrM1xl/YC/FJrYxmW
X-Received: by 2002:a05:6a21:a97:b0:3d9:3626:1326 with SMTP id adf61e73a8af0-3da39b57edemr30922369637.2.1788752054700;
        Sun, 06 Sep 2026 20:34:14 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14340a69666sm3658473c88.9.2026.09.06.20.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 20:34:14 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] powerpc/mpic: Point the comment at the surviving binding
In-Reply-To: <20260907013357.22885-1-kmehltretter@gmail.com>
Date: Mon, 07 Sep 2026 09:02:52 +0530
Message-ID: <h5k120t7.ritesh.list@gmail.com>
References: <20260907013357.22885-1-kmehltretter@gmail.com>
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

> Commit 326d25198112 ("dt-bindings: powerpc: Drop duplicate fsl/mpic.txt")
> folded the fsl,mpic binding into the chrp,open-pic schema, so the file
> this comment refers to no longer exists.
>
> Point the comment at the chrp,open-pic schema.
>

Make sense. LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

