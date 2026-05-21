Return-Path: <linuxppc-dev+bounces-21262-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634ADCD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 00:40:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLV1H54Wvz2xlh;
	Thu, 21 May 2026 10:40:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779324003;
	cv=pass; b=LkAaM15qnwnoDKkyx9kEv9ulwgkDq/PDYtxCVM3jFLdk8dTA8G+1d4psxpF4kj+DSoELNWd4Hph7Etn7HPLJrLfx+UWyLsvrA5sjaSff6B44wmWvjctDMUtJSA+XAg3jZseh5hOhpLu+ryluItNV+WSoDayt3+TE8E+oyNfqVTDHGBF08ls4G136AuSJ7k19nRvOdC5fF9Ok7/V41kGEe+sCet6v67MI+l2RapmQu4lIHVvb60Nnpm9l1L8KS/BjipFPeLD7/rOM3OGXsarmQs76O6ZikKKgxMxrqSTbNN9hF8BHfYo8nnNOrMX3vry3hn6d3GbD10sqQbZ7Zk8cbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779324003; c=relaxed/relaxed;
	bh=G4NtzPCJXMi+6LprF4DgBxJXqA2YlW57AUksc3SiBUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQZMeSsRmFCt67/IK4vtaK7ebLpWGcdWHoLIbNNnyDVXJYPZwNqLKLx859Yd0LjjPa7GtZMusMxgh0y7im0604dXLwqTzPwPrawM1hVSVTRpEylhf2L3IARUtOr2SFLqwI12NzYXh930/iFU13dd8iVvpYSMXrIfT3m3iwdGxk/XSxvKkalZ1/1AH9SSETapkXJqGhIBf1QalJvyQwwjPCpc8AlJM/CJUpKahXg3rjdazXMzpUAiBD2z8MfPLvrdmukj5r+CH+9mMNxp49fCSEnnurwLL72IW5mTb8uoLa97xRaiQ+6v3VzFSAHqjB6/3ef6zjipmLxDK8TqcwQXCQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=djhGX9al; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=djhGX9al;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLV1G1vlHz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 10:40:01 +1000 (AEST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-67be41d5eeeso9244504a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 17:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779323993; cv=none;
        d=google.com; s=arc-20240605;
        b=RU9AXy/aYwWr+D7hGjL7hAokgwUprY4019FufRJnmeMNYGT+5d6qkgJnBivbznV+z4
         T1o96FVMwzAwShuPZ8pFd++3cV1edZ6eW0Z+yi77uWOLoCNOpz8zXBRFtqC3sq5v7s/n
         jsaX+/6QkEXtzEzCq5souqJB+CSVf5gM7fWapo0/tmllBwv+cNTVu77ZnEN6nT/Xt5/4
         8o0xM8OPBJhEw/sZVWmFe8+UofzzoNqA5fOTayCGFpxAvYwYeJqqp3u+SNPLc0nX4XYl
         mQW9NF6rOTZu0abf1zDmd0lYqTAeiLVIYNRHJh/PloCCiSoeNXxgCXhK4RwZ21b2zl8t
         Ecww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G4NtzPCJXMi+6LprF4DgBxJXqA2YlW57AUksc3SiBUM=;
        fh=pO4epyzkxIUpf5A5pOvgbgaqZw5csqW1ZY9wAC0ImLs=;
        b=GwTfiSPCAA3LlpbZ2/RWSez8490tmsWMlZhoFirP3CVBLQbB5p1W+3CidYEcr1RiFC
         bgn2H+dPOiDfWei9I82GZrKE6M9mZDCaGKOKbhO99MS5uZPEI29mmQYmWi7ah0RtVME6
         vhsQ0rxnXaD2CzsuWuFtPhIu0NwVNSrNaUSG3kNqygRryMnv0rmglkzxsY3xdRZVv8VT
         Cp7K374BucQr5aOF2HvkxDEQyLozwQMB9yz+yfwAOez9hWNU3OsKLy+IuTfNeTJ+V4t/
         n7COhjCG/IpIB5Asg82sAVsuZKhGloFGj/TsuXntecdvuX1ZjrEUdY8Ket+em5oCHdm0
         9UyA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779323993; x=1779928793; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4NtzPCJXMi+6LprF4DgBxJXqA2YlW57AUksc3SiBUM=;
        b=djhGX9alRzMTlCov2/VmpZ92sleBICSiNFukpgvX8dDfBn5OsOveVlF6d8ime0XUWN
         YctXwP5zozWUyVVzlIQwadB+bAFdhJIZBCFRtHOlyRXSEVD7AjcTanfj9ByOC1HA6wwO
         JFT2YCLK2+KuobQkI5X08kbahce2ZuhMrKTS6liEPzdaYOfvKTw08pUN+FlZlr7ImdsC
         myLc9VQa/4BxHm+tDKr+Cqa3A1XwXB16meIPRSRcVa7Pp09uLXCVk7Gw6AfMm47tp9jS
         hIkAiiHHasT7Nr8Gc8tV3tyheXcIRKWEeqr9DfXekZBiv1MgwoC+eGExqsC/9R2gitM0
         S1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779323993; x=1779928793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4NtzPCJXMi+6LprF4DgBxJXqA2YlW57AUksc3SiBUM=;
        b=ockQBJ0xqoBZMtatmT3kB+wrG1XO8bPLEufyqaxungs8rzzJyQdW+VkGtVRCXBCyxM
         bHRVB3V2ArO47whAIuCOX7geXtf3BvbC0T1TOOgbUhV7uONyOHqrIhU4j8OM9HxA7qjY
         y55iACCV6puPeck5HQidjHXsSqZ74wYzUwZYAjLGnBcTRQo3dmNcP0AZsuPQ0D0Fg7Gq
         H+X/mXMDbeZLRk93Q2nLffBA9ULbP7Bmz251O4NeOy2DUrj+byZ6ALD04wxDnTTjV2lU
         xi8S5QBMW9lKAB7iJkIrsXHuIkmuzXmTIbANIgaQQJSm5WsBT4wa+Nr+8fT4gDlf6Pq4
         mxVg==
X-Forwarded-Encrypted: i=1; AFNElJ9Ok8RyLMLGbsS0ib+WRbVfmpKVW5dLkFQHUEdeUiXIdky4wHVmHjkLDQhvUDM2dO5kg/6lay4f209BuHU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYbLX7db/uqVUepS0ZEQqpDyjKnZP8SferQvNpkstK0bB72Jg7
	Fiuiy/SFLWykXarbCJWmyidvnJCpP4zl1doUfFv1skOth4elvU7vemdcb1XTEbQi5oQQZ4pOEwM
	G5psixembru4o6MG+kuZB3e8npDxicPk=
X-Gm-Gg: Acq92OHiLzOauej6YxToUq17WxMuec2JZHQ4F5hvDw7UF7plBOJ1OGMeu/xy0peCD5W
	lbHsoDA7iOu2YFL3gP270aVEiUA1B9aynY0F5gQsXHes+Cu3TlmcTgEFA+atGIwaV2Qtnd+y5j3
	6IL3zQKqE0O1CNtLw23xaIlGUI9Do8Guk4ECZ91MFmc2Oiv8Z0xf9sYySDhqSEyKbohRnlFV1Y1
	rGY1o0y0U1vlzMF5T3bBWbgmFTWcQy4YwOt8NlGVV15mNbFQbRzi1qTAG/3ckxSA9UWxEiSANqR
	7mhVSAResLh2uVEaLPfcvYl8nmMzGqcgzFflthrmH1M/bPfz+owmidUyhkdUgHsmnPY/MoJRPMq
	AzAh+wkfFp0ykjU735CDUql0BBrcUzLN5td1bqIOwtiT8IxJhlMloPj330g==
X-Received: by 2002:a05:6402:5291:b0:67e:2624:b8ab with SMTP id
 4fb4d7f45d1cf-68836ecae4dmr158915a12.24.1779323992766; Wed, 20 May 2026
 17:39:52 -0700 (PDT)
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
References: <20260517192856.3925-1-rosenp@gmail.com> <20260520165746.7ed10c7b@kernel.org>
In-Reply-To: <20260520165746.7ed10c7b@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 20 May 2026 17:39:41 -0700
X-Gm-Features: AVHnY4Lw5Emq_uEem6jfDTwz2sycS-YazTsfYTjdFg9T3qH_c0M9lLZeDT6_kDE
Message-ID: <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> > Collect received skbs on a local list during RX polling and pass the
> > completed batch to netif_receive_skb_list(). This lets the networking
> > stack process packets from a poll cycle in bulk instead of handing each
> > skb up individually.
>
> GRO should be even better.
GRO will result in slower routing performance because there is no
hardware checksum.
>
> > Speedup tested with bidirectional iperf3.
>
> Please mention the platform / board as well.
Will do.
> --
> pw-bot: cr

