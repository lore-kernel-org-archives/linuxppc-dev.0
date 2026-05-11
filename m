Return-Path: <linuxppc-dev+bounces-20663-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D05FCD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 01:10:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDM8Q4kt4z2xqn;
	Mon, 11 May 2026 11:09:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778461798;
	cv=none; b=E9egvRpBTsmODhnixDhV4y4JRNrDiljIRVnvZSc4nIQKBeCgDOXW4ut8dRr1vBt3lY9ry+EwVsaaspVXePz8BEHgv5ZeU/sboPv7RZmkAfAkMS+m/kMiOHGVffftPKZ4ZRqgNFAGrRHogfymsAb7uwVh0diADO8hMpW/McMEhFzqY/bATGMw1oGZ73sdbIoBdMECzvnhq2FQn1SamWxmF1+zZZtHkRvitzCRRqT8HNHF4fTGMEoHZvepe7JDv4+YOsOWXtRQYWz1BQ0ZPQegMZhdBwO9fKk1MNbGvhLr398cHdhLJ1CGYzqAnAzKOGKqAwHsDAhqumGUVUrewb8Kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778461798; c=relaxed/relaxed;
	bh=mfqH990mdH+IgSJnB2dubzEg0nm51/Cx4c7wzJvVDXE=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:References; b=mOSfJZLhQg0s6unlBiNCSD5IQ5hEdqRRtk6jw/QEJK+C7Wc7qM2w6VN+yiW9BqkuRhQVNjpuewiUvL1CrglLq0y/yzB1Vb/EQjC2/vbAG6VZvaDbMumsPE1+hjLCYrruNe3HbF8TMt9fVo9gMhOPBeIA8Pk1BO8THVxwX/gmL7TK1wCqX6GXkzLxaqOu6zLBvYnUKfMI+CKavApXUnWD6aBkFuagtnmp95r2WRwRyB9pmCUrcEwyCKNQGoqznKZIV57WfGBgFL1MDbDvKR4dTtgckQ1fhWVrVFOBnRF4CLHbGZix0Te/1YTlZrPsAl2cRoGVLsEAHaZwcJknjH45AA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hESMuZhE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hESMuZhE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDM8N6hFmz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 11:09:55 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-367d88b9940so744740a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2026 18:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778461793; x=1779066593; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfqH990mdH+IgSJnB2dubzEg0nm51/Cx4c7wzJvVDXE=;
        b=hESMuZhEDz3yzQs/F4EEn8yP0MwHwiCTkBPoXvUw2J8m2xlYLTGVCtHRGa15OmGtGc
         dvQBDouxDUNYE6w+pWMHF8NgoZ2C05UYRKnIuaYq2tgAZYpwUiTxiZzc2cG4Wz2A4zuF
         SBXe6fs6p2egShatGSmzcW1b+mKY4LWsHBvaXo3Aa99sH1URyiCiHUkhnMc9h7V6AmkS
         P4LiGj+SRdzYvYAbRR1RMyH9aKJY0FHFDkoe9NqYKLaKfgpxWzie5MGTaIGMKtgz4L4P
         XlkP3Q+dDVcqzhPkzca3tZOLwLZxVS+mwfYtCothpKPxBrEXs4sMrgKiRLYoex/4s7n0
         rxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778461793; x=1779066593;
        h=references:message-id:date:in-reply-to:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfqH990mdH+IgSJnB2dubzEg0nm51/Cx4c7wzJvVDXE=;
        b=LhCLzW412upDxsruWfU/xUHWsaODeAfKQ2a+oDIpitd4UZoVpUWptJeoI2qAK1nRcY
         YEleaEjCrfgaTwErR1XZrMcaIlYTHw9x6CUE7YbPoOjegcBL5BBvCfd13sF6LVboa6i4
         g0E5rE06BgHC2Wl7bCOHasntzPhEs6VFur/wWSlTPJZYFVPrVbg6SBmNEijfak/QlaWV
         KWVAnYrbjMspHy+8gOmYeQb0zDFhadaBPfQ5iEI9ulTroj6qvyvPDuNjpIFMhCKEARVM
         Fozx/vytIdDV/aR9EcqXL+bz2FInKyRXaWu+wxyh3J+QJMxEuj4+IxAPxtz0tlMd/yv8
         DXag==
X-Forwarded-Encrypted: i=1; AFNElJ+xViMR7pULyP+bpv3zBFWtyIsLLIYz5paqEVPL0oGMgLHdNP71VY2KXG35uurMk1Cj/VLcMBrdNwwMbPk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzLoxqAj+Uptnef6Vh//VNy1FIbJ8uVIU005jQ1B2AgOp07LPOR
	gBPrqWv6snTt40U3UFBJjarxpOA1/f9uCOe97Yhivq+O8fu5LLV7nKYS
X-Gm-Gg: Acq92OGOCl0FWIXw6+jPDogsipn3+xED2Vsp6RcAo05iYZlgHkVMoik8g9P2C6HXp7p
	5FxNrCRKAPmYGzRnqWJWAQ9tuzHSVKjXKN22D1U0kiZB7zQnw8hjx9yd1AJvD6zZias61kKNr/h
	JDjMyi5R9W3KMB1jeeH9Xwhps/GE0Vn2/eSZ5pNdxGY/Wkr1De957SijiCDxjeDo3VXeqdZXQZ0
	EftDtAJgCJlR2ZOvO+pESmHUVp4RrkS8fIsOX0wreaJ6m9me5h4Q4CUJnY0ltp4Wo2ZULjlgz2p
	GKFbx02azFTiSBDg4tqAbfOKH5v03ocjhLqoXBePZB2sPfwrf11O6HTS7MYprrB+UxH6qAIuMgF
	4emDU9BlZzpT6Ev7t8DuYIX8tTYyAtKV85qWCBJ0rs4EYWCL5LYdn54XA18gHib/q2QR4rOVRTT
	HCk3UgnzLOKLLKVQf4rmuYRQ==
X-Received: by 2002:a17:90b:582c:b0:364:7a37:4066 with SMTP id 98e67ed59e1d1-3664ccca676mr10993664a91.14.1778461792574;
        Sun, 10 May 2026 18:09:52 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3686a6aae94sm580232a91.0.2026.05.10.18.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 18:09:51 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Demote myself to reviewer
In-Reply-To: <87y0hspx0u.fsf@mpe.ellerman.id.au>
Date: Mon, 11 May 2026 06:30:33 +0530
Message-ID: <7bpasqtq.ritesh.list@gmail.com>
References: <87y0hspx0u.fsf@mpe.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:
  
>  LINUX FOR POWERPC (32-BIT AND 64-BIT)
>  M:	Madhavan Srinivasan <maddy@linux.ibm.com>
> -M:	Michael Ellerman <mpe@ellerman.id.au>

Thanks for more than a decade of maintainership of Linux on PowerPC tree
:)

> +R:	Michael Ellerman <mpe@ellerman.id.au>

Always grateful to have you around. Thanks for helping us from time to time :)

>  R:	Nicholas Piggin <npiggin@gmail.com>
>  R:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>  L:	linuxppc-dev@lists.ozlabs.org

-ritesh

