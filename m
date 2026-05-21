Return-Path: <linuxppc-dev+bounces-21332-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5348ACD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 13:41:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLqLm0RFDz2xl5;
	Thu, 21 May 2026 23:41:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779370879;
	cv=pass; b=ZLjS5Ajsv9sWCTREqhTIIhAG+TFwD+7Uaf2JHtFJRvBTzneMLwJjB+N4mcbn+lTM5huIxLKI2cRwEaznifBgj7HAwnwDo4TTBr+0bcKiWnL+8DT2Jouy+cz8K6Bh9GEiB6YaWX9zxrdp5dNVLygfsHXuZtjT2WEwgD79wIMg6W5Ey6Zy1y9bNyWBufMM8heVVRcGKiNP+b+w9xGsRXlpHSqVTEx6VOVpTDf8KTXKlr7E5ErBusRmWonCdciYeyaNyCX7dvpK6PoNI6BfCXPV6K/unA3Tcb0Vko4/9+irHfdiWjOxsPrr5uq0mX0ZlVBPJUQcqP6w6S+B2K03eqIU8Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779370879; c=relaxed/relaxed;
	bh=Iztqdv46z3L/RfMJPUbTwKC4ovY74G3OQJ4DxuJSyZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRFIbJcEM6sm93CsU23OC/ONy9/mTRw1UQ/HAobU9aRnRZVV8ieWKZjKKthPk6e40IHbjiLlj6zDpWacuy1DHtldpkHA8VvpnyjxCIJe4zEh6TyFeErIYEr0Q9sByc7FM+CoDKvOUOX70xlm6oR7jPcd6ohQWu9f+mQXfSGQ/43glnkuZwSoFF/wUtWN/oujvtrU3DwlJIc/cKld6GR8/KcA6AwBlURjABnGBIA3lmldfRfvZ3Irob41CNM4eYc+DMxcrelfz40Ww5J3eGrHkmmb/xPcLj7AoiS9uJR5YKJgcP699h/DkZZ6zGxZfZ7k1mvb+wOJfvLzPKvny81BjQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KOHfK6DW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=edumazet@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KOHfK6DW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=edumazet@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLqLk38qzz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 23:41:17 +1000 (AEST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-50fb1ad3734so75170411cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 06:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779370875; cv=none;
        d=google.com; s=arc-20240605;
        b=Lvb24+lpH/6MjXV5cAbHCCx7QWtDq1xAkM3e/JGfpy5lbHKwOrDnZytWkju/P5CyV0
         yLu/G3JZAiufpT868ghYr5o+ouY0RJ6I8FdNSO7VbaYpIJe0ut26KWbrCIHJ7wXJ9lrq
         xjCKnW+HbS9zOtGU+7bmhsisFCTw8+TmwWDqElmsvduklz+WRa7UdHMhbNN50AQCwJGJ
         q1sXuvuRW0Fm9kHsD/qJBXmMvjB3oPK6v3BnGfcrFfcR4fdJh6zVmfsY+PVROzvE3R22
         SCsGKR19yBeAqT5xfx0LSoA11iKSb8UGFYeS8JT2s6NN2e3tyVbwbKR8QfH6gEqosWi9
         SoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iztqdv46z3L/RfMJPUbTwKC4ovY74G3OQJ4DxuJSyZE=;
        fh=lqQdvjh1VMdnDURa58aFj8P5O1XIAMqj4bxXSvmnJxc=;
        b=QZd9YHEys9KfRVzK4YUh1lCfejxjvCagnGwPERGQ2iuARcSlpSj1v4VmIKhHTkAQYK
         9oFO1VTIapF9YoURKbjp2IPkFhtpRnbBmmzv1STB9DEBOdNSJrqf3Y9tnxOnK9szaIcE
         aQx7XXQmqXuqEKcdGLxaanBWsoRhhRO9N/RTnQjVlIprtqgrWfCbacc935mzN9/tAle9
         GC8CpT5kSZjDbGelV0Y88CPI8hoMstXdIGd2QnJ0u1Q9XY93tb6gQ4lK4pfdjPDTLN2f
         AFhxU7RUwvkncrLSjLZuXDsLlZZl5KRFhzfxrly6ex6T80z+Xz1vTMzLqN4ceM3eTmTL
         /stQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779370875; x=1779975675; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iztqdv46z3L/RfMJPUbTwKC4ovY74G3OQJ4DxuJSyZE=;
        b=KOHfK6DW7zoiEyoeLhkyH6f2yU1/ooIBDf1yMCZXfgxxpPeJdQ+3gv3p/5NQMsFPtI
         yAA7+ZMa9I0t52fvwGDVKjN1aJ8acp5yosWFUKB2UqEaJVcTKO1WRKhx/qWHueObTwlz
         t5FnyIOvU1O+T3F7yOwrGEo7t2yTEknl8a30HPx9LTO5Z8uVlyBg767TPMJ9iCeapp7j
         vE9hzJA7oPirz+xJQEefRC+f6KEIem2c5gup4OE1Er8ds7Gm0ANMaGeiiySC8H1xwiSD
         +8mz5+FvGFps5t1VaRHohP2nIcIrK11F4FXIAC51s4xsu79Ex2F5syOVJE1ahARutXAp
         1u7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779370875; x=1779975675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iztqdv46z3L/RfMJPUbTwKC4ovY74G3OQJ4DxuJSyZE=;
        b=ZYQX9Z1ccb0N9qv8jLqRIUJtCQWkh6mp1P9jgYExgB8wL/5/DJPgI77eTVBipMd69u
         grkbZTabhpiTjyg0vugJRU0AjNDMH6hMvaf6PCac18t/u93UQZcy/zPhPq/TufUcDpoA
         jmR+6ZWnh/SJZcAeeL2Q3xAUl2fVO5X8AofnkehfCSJ34K96Nr6N4FcAcfRgxjTmM5Mt
         3JtWD1YnKvhcv0i3tS/LXV50F5cQwpWRzzoPm/aFTZtnB3T51185T0aa1lzklrNFFp/X
         0IDtxm/id+JNMzskYGgyKNxTJbnNxdLHsL8A1XhV/dKmZo5U+mrjUqk8/CkTiFAN5+Cg
         ytmQ==
X-Forwarded-Encrypted: i=1; AFNElJ97A4EBboe6B64kJjJd/tkufJP5rQeSqZLFIMOh5VWBWg1onE6hZRlwlLdSKDAiyTApen2J8aRHTiDlcfU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz5tL1/kOusjWmzAGHtyP5Y07qfTWXL/MhpdmuFjwif0BrVkC+F
	Jv31NQo3nmRanHXYo/isjfosejyLwy0C4iTwy5cf76tMYKZCuxUuaSiIup5l/4539WmNk1sgKzK
	YlxGvnNflBtTXjz9vJRODQY88vvgYUb+gssqeHEr4
X-Gm-Gg: Acq92OGpgwgkWgQRBwA0cYrbQBuEugd8geEvQ6Vt937uUKdjxM161p3+dexG/bxpztF
	0wJkxq+Ur36cGYGHiU0KqMJbBuaxoOSY7USLIKKIPQaFJfmO42o43STX76mrLAS1W+QTpE0rqEE
	gs40Kai+t5HEp4iDGD66O0Dr0HVwh2FrtptnL5Pvwm8/xScgf/3AzPzXD4qafEA4Ndc2VFOvv8V
	CDsLcy2LI8laNNjCjadQJzecjZkLHzLyw+x94L3GAt5r8rSxxi8lGygE0GCpwCYGWAlbJG7xSOD
	oppZzjGH6oLSl677o/QW6HJwWizs3+wRHEuqFvrOdVgIg+zaAjqIsOSERtbd74o239lnxiQVkTr
	mo+ludUcd9OR+jq8H+Pkld+LogqZP04Lujo0yY18Lfl4UWattvm3haS8KNvsQfT5T
X-Received: by 2002:a05:622a:5c89:b0:50d:6fd3:421 with SMTP id
 d75a77b69052e-516c5847b1emr35783761cf.6.1779370874163; Thu, 21 May 2026
 06:41:14 -0700 (PDT)
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
 <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
In-Reply-To: <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 May 2026 06:41:03 -0700
X-Gm-Features: AVHnY4KJHFfpbD1HQt-b9agKuVmI3qI3wyMZwjK6KWYSJA-YQqQ9wKOAjm-1zko
Message-ID: <CANn89iK7i4u5nWxQCuURmSCJt8Sn+Q9x_ME8X+J0pF2_4OGuZg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Rosen Penev <rosenp@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 5:39=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Wed, May 20, 2026 at 4:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> > > Collect received skbs on a local list during RX polling and pass the
> > > completed batch to netif_receive_skb_list(). This lets the networking
> > > stack process packets from a poll cycle in bulk instead of handing ea=
ch
> > > skb up individually.
> >
> > GRO should be even better.
> GRO will result in slower routing performance because there is no
> hardware checksum.

Then provide a knob or something, instead of trying to avoid GRO.

For end hosts (forwarding not enabled), checksum will need to be
computed anyway.
GRO should be faster for them.

Note that GRO also uses netif_receive_skb_list_internal()

