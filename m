Return-Path: <linuxppc-dev+bounces-21021-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB19CCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 20:45:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJXxR26Y8z2xfB;
	Mon, 18 May 2026 06:44:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::536" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779050699;
	cv=pass; b=d97sH4JPSFJWaNGBm7HhF9vl4OufcigJxFAa9ZWGnDsVoEzIlZefpgovfmEmf40DZcUPeHlGA12UfM6cHocKBJ1Zik6zUf5BTm8s9e6LNhxucriubTUv1BbxTWVWS4SSi6evyFLo+lejzysRmACAd/7h+Jamxe5lakEGj4CH7HLZU7ilgLc8o7TdC9+2HSiZ5YtvE26pdMhuhuzOpQCgrR++bTiXdMn032QUIM/tiY78rba3/txhg8w/5oFDMfbgUfVmmPtc5JnRklMgTy7RUbj+xC+iCjiNh+43SCb9BSefhJwdSSZLG6G8C3bUTXOhLn6+YxXfIEEdI7sW+cJCIA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779050699; c=relaxed/relaxed;
	bh=fmRI5awy/IsMQtPy04G4b/GKkceXWQShYolKMTFKlkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJeD6zp4ZTX+LAiURB97c4KusnOjytVfNnvj7y6i4otIBTLuzA6ahtqz4jvMkLq5yMMRBhg0HKM13QOun/Klr46Age89HysTpiBM7ht3SoGVJgG50W/gxThUvJcVkO0wqphXJC991nT2JPi9ZH7GWK6tnvmBNkO9mE7yECbqT5N8g8f6425k6V+e9/dTp727zsnAvvJmZgPQ2ntGoLecoGNLbD9BSqVfsZhLrXBOM4KYkqTtkqs30soqNKqvWGSL/5NSHWcpAPiEvCoNfaONcpw+BXgqdCqUavY7A8nkiqA8eEZYJMiFlax5cJ+CV3/+nAqv9hL68VW9yNjLY6hWgg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CeHxd/cJ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CeHxd/cJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJXxP2jnFz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 06:44:56 +1000 (AEST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso2890794a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 13:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779050692; cv=none;
        d=google.com; s=arc-20240605;
        b=Cu26V/IJuzDtPP+5KzBfxYSrH/durCGm7hiXHwyTCI7MZyPb/31z3NHn0H0DVVGd5M
         FwpcIPVdxGp0mlh80A4PsVXgUJreI/f0ygtzYA4+n+mhhoh7ItRxWFt1BKx8jAf/xXq1
         2VepJL8X9IoPkDrUh4C8YhiWnrPZ0CV29jZwjgUnGxA+WlUGQczDag0UaP1Ql+rSjyuc
         0zsGnadV+e72etlQPPOIoOlLu/7yBuMxKWYoWGxQ4Pro7ViYZY6ZOX8tkrhbJfWCeq3+
         TBvJT5MWLC5M9vPO7SFZxcxtwai7M0xvf0F2TuouKVnl1I9wu+8PpRiGlDjcXl+Xuy51
         yFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fmRI5awy/IsMQtPy04G4b/GKkceXWQShYolKMTFKlkw=;
        fh=I3nbBe0R4hUlHX3c3iugYuT1otJBjAYCHDtEQf6n/Kw=;
        b=JcVppw9zbmLntCKQBSS6RyrPc1c7gafVh51dKHh0+WM8lgvwe3DVxcs4qIiey3y21r
         ofYnk/oL0AcGLN/v7AfNsPvXNPjiPrVm7x/OdVzCADiwI/3sVRmwLIeGp7iV2zVmlC4N
         x/hJvbT2ZGv/QmSMU0yFyKB2JIElq2hnPm3e6vAtkWxGS1RtSgmI0Du998z1j4JZYf8C
         afCIkht+LMqf4XyyH6gieib1UAcqs4ZHVZNTMgtUQAQ3+brjJ25yGWpB0VkbYKNFG9DF
         EoX88Lj9RkcOwpOJVVEZlBhEqMTOfkyE7adpdeI+G+HLzvkzynZazQqEOtCFVl86avWL
         Fmtg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779050692; x=1779655492; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmRI5awy/IsMQtPy04G4b/GKkceXWQShYolKMTFKlkw=;
        b=CeHxd/cJZ1mpqlC+VBbDQG0nBcZLFdhM09awofWE9wc7UCZRAhRQQJmrP9XQuGltok
         YAupPSXpqPj4/NhY5enEiR87e5ttdUCBCEM/mCbl51rMjkTRRE4jxcai/WqixFWQKJox
         GSGar/lcC34C5S7+xalXRqKP3ARVdsF2NbDMfc7XCLlgf5uNLZ3vM2WARdHC0yq7koPy
         F5ZkQ4PqZMUR2Xxf7A86duPACNJ7jeC8A6dMCIsG+wCZ6+o8Bh5DQsfPs4ho0VyckBDM
         As7A/pxYuyKHOy7uKzVQl69HvjxzuU+fOcnZs2S/FAhBAW8iDfK8T/DnPxnwTtGO/+07
         3gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779050692; x=1779655492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fmRI5awy/IsMQtPy04G4b/GKkceXWQShYolKMTFKlkw=;
        b=OUlH9hb4w1BGpzNnEp9dnt7qHiLQJ/7qg6DHI5ZjQIM0zHQsOrU74Iir7Q3aIqYQEM
         Fm+oaZ7RS2IuaBT94tofvm5sn/Nix635C1Gt9GZiU3dkOQ5YvOYPfbhmpSatEBIBc3lt
         XcMkFSr3VK09dM3pXl8cte86iGtdftRbNGfLbK6Veu9Wj+du6DcemD/Y7tb4jLwAjqpL
         xmspolhQW5F+3MFN3XUX5zLwDI+70Sdqb2oNAupVswJmfu0VYkXCpRJz9p/eWqfJhloA
         HrK7p0P0J8FtiRcFHKr5mNzvNDgDOE0Xs2bSgP0pArGkbsqoqB/xPxMr9lIlXMAR1sqF
         nh0g==
X-Forwarded-Encrypted: i=1; AFNElJ9HOoq3i2jJREsjMRLRuv/XAp0VQurtFKY3F9+cPrJWpM595jxTgMnmMk8wQwovGgdC43mmXE4dHlTf7H0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyaUvUprYLwYHUFfr8gdcJjQmiAvf5SxF69j2bOkD7YfvnBWB/x
	xGyFvH4fxMgDIRQE9NZApTnUxM1+QwHHGmkWnIZ75CPQWyiFNjf2CxXBHqb2eLOM615N9+8Hzam
	SeIDIFI6BwWQG4tfphw+OmCXx/7x0nuY=
X-Gm-Gg: Acq92OEblTbYtGrsZbkrmD+0tCWtLaZkWHcAePqWCg9CSW/ytGVS6VvMEod9Dmk5UNh
	igdu/XshWBdM1lJ2jofu/ev59TQcZuxjXLAYieCaw0cJo/y5lecqMVEATFWx5CEXdzfMCBs0jjt
	m/ZF7EiyV+aOqGCUc+mHnpZV9zsYG7GsCPrQ4BEQi3Q177BwgcGa/xKbzVUoWqx6nNXb1keb2AG
	cMqY/zHoe+9Me6Mqzne4oSJiY9Rl5out7GVbJ/1zHrZDxffVeHAPlHtvdDC0LmduftbpKvB4bvx
	jO7UevCrK/SJ7xDKo7qJJ/h5Jh17c7B9OWbNXtUgKsdKDnTX+zhq2lqVdndN9ouP8dIlKDRI7b9
	HbI9H8bzgAM7ZB1fnWWnrUBha/bPcYRQBlGePs1dGGQSPI+9rR7H8IwQnlg==
X-Received: by 2002:a05:6402:40c3:b0:67c:5a2e:18b8 with SMTP id
 4fb4d7f45d1cf-683bd18c6f4mr6445415a12.18.1779050691596; Sun, 17 May 2026
 13:44:51 -0700 (PDT)
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
References: <20260517192856.3925-1-rosenp@gmail.com> <5ac9f5ca-4706-4617-a5fd-d3e6dd3b254a@lunn.ch>
In-Reply-To: <5ac9f5ca-4706-4617-a5fd-d3e6dd3b254a@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Sun, 17 May 2026 13:44:40 -0700
X-Gm-Features: AVHnY4JiaYR3WrZAxUy-DcVUwF8ojrxL8XGkQvWd1mkI9m_lJ9TkC5LVysMD-g0
Message-ID: <CAKxU2N_SygFAKQuhwnZG7SP7jiRdkmwS_R+VwHap33UUfbQmAg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 1:24=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, May 17, 2026 at 12:28:56PM -0700, Rosen Penev wrote:
> > Collect received skbs on a local list during RX polling and pass the
> > completed batch to netif_receive_skb_list(). This lets the networking
> > stack process packets from a poll cycle in bulk instead of handing each
> > skb up individually.
>
> So my first through was, why is the core not doing this? The core NAPI
> poll code can initialise the list. netif_receive_skb() withing the
> driver poll would see there is a list and append to it. And when the
> poll finished the NAPI core would pass the list up the stack? Maybe
> this already exists and this driver is just using the wrong API?
I do not know. I know several drivers are already using
netif_receive_skb_list, some even which support hardware checksumming.
See 0a25d92c6f4facaf2852f1aac4cebfe01dd57a91

The core seems to use netif_receive_skb_list_internal. I do not know
the details.

Anyway, the performance difference is real.
>
>         Andrew

