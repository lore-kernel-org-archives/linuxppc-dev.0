Return-Path: <linuxppc-dev+bounces-21748-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3842FCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 18:23:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRsDW0ylYz2yQH;
	Sat, 30 May 2026 04:23:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780079003;
	cv=pass; b=XfbdYEb0tOaDo3yI6HAjp/s+aDl5P/WR2ktyyHFy6QbRuJSeuqGx3TTgsy0vaPMGbhPf0JV+fLMpjXjCJ9cKqjVnRhCM9lpL4kf7WB080VkYYpwYbdJMTWpQ9q+w+e/QBmfb8Of5/dQhgIZt/kEPR1yh406gmK9V/oOfYiHAe0yyTLIP4dAFzMn0RgKDXSZikun5OSwsUSsJjCrLe2K7l45Cesg6ryltH85PktjzhZ03f5JKXxqWVUAGVMgdEkt+oU0xxF1Svq0HRSshUY/aFS2eiXQio2mvMHcaHLSnHcSxUC5UG/+Kg0yDlx2A9F3RVNnRAwt5uFvCoiTPu69FKw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780079003; c=relaxed/relaxed;
	bh=6dC+9xrOT3fgTxc8ls+prWRQG2kCX3O7CMMA4vKRipE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vk5cBLChLZbWfdtMDrp5viT81s8q1+SZeE5GSPAM66JhChIpf3yCmM1NohacCNNUTmweenIHNoEJLt5b07P60hEDG/4csz7xxKQdRR0O6872BpttOhJLONn7tbP2/ROwWAS79Uavp5oHYWbAL72vjeIhhHS6pak9Ztj+Uh3hoOFM1RzDesdYLtnYATcA6rpK/XQw4Dpb7N1cVqU6+0GWpAGxJblO/AQmudN8WqlwFSf4V++s71vOslAbaqS8jIU5GpiKkqLAP+nOVwYJSX2GfKGqKusWo4YMBbudp9UBrxCNVVUcIRVi/TTvP+1cJZdImx8i68byTg2PVroEyWAVIg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YHEP+qaB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YHEP+qaB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRsDV0hcTz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 04:23:21 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-36b903567fdso1873896a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 11:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780078998; cv=none;
        d=google.com; s=arc-20240605;
        b=edMQYLMnNe0PrcD8aV1iP1dYNW8Q3ZWPXSX+xoJFI+jVhiWrJxfivJrEtyfD47SUfG
         QqYYh+4yJ5/B+dsauPd1VdY3n+ZBaqhI9vYgaokyShht7gCZnjRSIYKFPrJq2HBUWKQG
         ZA++Wc8Hh+uHT8PQOlRDmLXQFLeI5m0idSsRUsc3csg3yHb6zwHzCAyDZRTiBz/d0e5/
         avheYc76590prcyRza/VYiDMoPkbJ2gcS3NxF8ES2Jun1eDKRF+TxiUPxM3kQrtDvgn+
         KGIzXli5i2NZpiTnpNw1EfDNes3FY4yCfdpYi/ISNx3U+m0PN3K8JBrOuMT4z/6G4t1A
         r7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6dC+9xrOT3fgTxc8ls+prWRQG2kCX3O7CMMA4vKRipE=;
        fh=X2yZjrTqwZgUu3aeCzRYi/M+TAr0qfPg0ZiqhewwXF0=;
        b=IW4ztkwIw0t+3MKloRzdJVNsNyOdztJWLMUrbELE4t2AawqSGTZWFr3K0u/wzQDnUY
         NRoU47cr+GxwVqdQim6Z2bJulMlMVyL8RWvZNVJT3dcoxg94lIjInMH8DM+to80HFNug
         LWfE9MIaE7TleSgtYDL4Xb5TY1KguAIgZ/EIZBIbtKaZG+S8NItdv6cSejXIMXRYGF3J
         Qd0c9ez1sgkQeDrzzZ8bCBOkay/ClRNn0OKkeF4RkVMFrf45fN9t189RSefsi0ItZY9o
         BbbDlvEcFTG2Q3yXt268OB9ohcsaGHoqXK4peCJ2p05zX598EP+0SPR2pvYCmzQD/nuk
         I0ZQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780078998; x=1780683798; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dC+9xrOT3fgTxc8ls+prWRQG2kCX3O7CMMA4vKRipE=;
        b=YHEP+qaBx+337V7LVUQCeMY6fzDgN+tNkFsSe+d+4mvLZ4Q9/6TddfmXyP/K2Du/LB
         fQgZxEKJQ8Zoz5UyfNpsYH2ufFDKmqJSvzMzAFORMnILdFhPxhipuvie1cq9cV1uZmtP
         dT6sOdxPIUns+WKzHAAnFGK97JOth7+50QAaqIZWkXxs4GTKzSEtSa0avhY8mMVOSL1u
         +8tiVeg+xMPI1yRQQcz+IEd8H6HRwVaUXv0TVwrAQ50EpwcUsCEPG1u3qvpUDvhoKZTG
         btKVo+GWBWnYWUXTOvye+aIZh5AQHLrphUxlOkef54+HjqBBDS87Gw1/ZskkBQTzphQe
         KJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780078998; x=1780683798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dC+9xrOT3fgTxc8ls+prWRQG2kCX3O7CMMA4vKRipE=;
        b=WuR2U/qE9+MUpjgrSw9EJsfM1dymUyZELM40WPkZAU/c0VvCaKPMflSW0nSf5ikvWJ
         KJgzJOfvNO8ST4GE5JaMFBb4R51EATlB4snCbji6vFtrUAPlcwOmZ3BAVxaVmm98wT+y
         uffgREA4eNooF+fNzSXIMl3mJtqlRzvzFBKqiRHi4R7RXJIUTwPGErTSCdYGzoPr2CVR
         d3tWSmRyz9sVX/75Ex35YNFVkMLHn5ayXCGXYhHKuV/nhAJ0BNZjd3cV8FUiJCeROZWw
         sfJXt3ZkIC0RzEbax0zyL8VDioHSH+8QQclWP8D2umIfX0HgarbJ3AZy1ujSpyBH0QnJ
         7NLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Ck1U3eRCxOZU9G6mECpko1uFiIO4gPJ6R/Voq/nvYng2eMawTw36OpMulUSae6hIfikhDAJ/C6fL9pBA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZ+jUCcukKUW4sJbiuYTMBR8N66fzYQQHf3uUu8Ne5XBVqWZIg
	IMUGWz4N0uejiDHNOjGwA3ypHacJtx0uVHp95aB4G3fmPIJnZTudj6VK4QauqiL+X2OuG0llX3r
	/x3KsOT/W9v0MhmfKh/PR0JsDRJjny1ByEq1tDEn1
X-Gm-Gg: Acq92OFJPw1zxGXEx50a2yZ6uTxzRoX38iKSDBbi4DtQKjYAppXzVeC3JU5/dRxeW05
	LG5YdQn4ywpwwou9RwgH31dYHY3K0nEHy87mgbDRCEOQvCl8Ze677z7alw/OSlTbYKJUFWbBcxR
	kOaN23bVUeJ5VqVGWRxl8KQ0DsBIjQpmAM9UhZsyXyf4UCfAfeslh9U12E1LDOGQGG9BfvHCo2j
	OKUQzVQjrugaOmU0Vb9HH/tOCwOiwUSTgwXVmw1bHe0Tvi9nKRG5eSGM3EiREl1HmseHB1WDrgx
	ClpTxeo+xCP16PAGaA==
X-Received: by 2002:a17:90b:2d4d:b0:367:cb53:7435 with SMTP id
 98e67ed59e1d1-36c50211c27mr291718a91.24.1780078998658; Fri, 29 May 2026
 11:23:18 -0700 (PDT)
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
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
 <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com> <20260529171855.7966b752@pumpkin>
In-Reply-To: <20260529171855.7966b752@pumpkin>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 May 2026 14:23:06 -0400
X-Gm-Features: AVHnY4LkrqqXg3z6cLc0b8TGCe9ixXYqrmd1DAmZLfW-cIHP9o-9OV932XiG6Rg
Message-ID: <CAHC9VhRAbCAxg4swOCBT+nAUaqRPsdBuOa+nm=539ejpN4wmWQ@mail.gmail.com>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
To: David Laight <david.laight.linux@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, selinux@vger.kernel.org, rppt@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Ritesh Harjani <riteshh@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 12:18=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
> On Fri, 29 May 2026 19:07:22 +0530
> Venkat Rao Bagalkote <venkat88@linux.ibm.com> wrote:
> > On 29/05/26 12:20 pm, Venkat Rao Bagalkote wrote:
> > > Greetings!!!
> > >
> > > Kernel 7.1.0-rc5-next-20260528 crashes randomly on IBM Power11
> > > hardware. Attached is the config file.
> > >
> .
> >
> > Git bisect is pointing to 54067bacb49c selinux: hooks: use __getname()
> > to allocate path buffer as the first bad commit.
> >
> >
> > # git bisect good
> > 54067bacb49caeada82b20b6bd706dca0cb99ffc is the first bad commit
> > commit 54067bacb49caeada82b20b6bd706dca0cb99ffc
> > Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Date:   Wed May 20 11:18:56 2026 +0300
> >
> >      selinux: hooks: use __getname() to allocate path buffer
> >
> >      selinux_genfs_get_sid() allocates memory for a path with
> > __get_free_page()
> >      although there is a dedicated helper for allocation of file paths:
> >      __getname().
> >
> >      Replace __get_free_page() for allocation of a path buffer with
> > __getname().
> >
> >      Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >      Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> >   security/selinux/hooks.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
>
> __getname() is kmalloc(PATH_MAX) aka kmalloc(4096).
>
> The old code was:
>         buffer =3D (char *)__get_free_page(GFP_KERNEL);
>         if (!buffer)
>                 return -ENOMEM;
>
>         path =3D dentry_path_raw(dentry, buffer, PAGE_SIZE);
> only the allocate was changed.
>
> PAGE_SIZE is not the length of the buffer.
> Should be PATH_MAX.

Yes, as discussed earlier in the thread some additional work needs to
be done, and verified, but since we are at the end of -rc5 I simply
reverted the patch.  We can chase this down next dev cycle.

--=20
paul-moore.com

