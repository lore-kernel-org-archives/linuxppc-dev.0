Return-Path: <linuxppc-dev+bounces-21264-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FDBCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 00:55:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLVLh5Fgjz2yQH;
	Thu, 21 May 2026 10:55:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::533" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779324908;
	cv=pass; b=P4+YkUWiFpd81inKOTz9Dk2XbZT2Jm7Lt4mA10skJw+Kq0TRPLGFPtqKcPB7H8Iyi6pcBs7Xs4jeh/ktXXfornOL2TJ2vSKUEnK3+f5JD3gIL6g3B2Db/5NyjoLllRNw45CP3DEo6+GDjCEE2wDV2yGyuwEI9khH6xh3lZRRjE9hD4b0VziZObqDsomQ7uSrFSmVUxnw5F8xwFKER7hJ8oLkhQZlXU7D17lQZ8zD74Fu1KaKZpuZXH/JXU0oxMtPqS9gFSsMCPs3hxBOfqaz0US41aN+1KjuPgia0aguWYXaSI0jJE54Lu13vic/+TZw9C4lSVIdMJmKM1k9Tmn0Qw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779324908; c=relaxed/relaxed;
	bh=AE1Go39rNIx4vy0a911O8dZSEl9bBMfMiRIm156eQ8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+SPzed8grlp76o4oZCfiWDBM4qVRMeEdbJdqzSHmK2emMM64YMP2OWj3GmrdxJemC9/AewgdX3yEvC/keW51w5MArbAjzUhV1IOmJg6Lhc5vAR4eu6Jx9uHuHzzE4jM9D4o3Q+37/n5iMp37WPC3Fj31CIjAbxR9zBEDHgJtrv0YmSyvOKguW3KcE2yFw6o7KFpNVTyX03PLEUDzxcY2aX9niJHg6mbs2bacFwMg4l0QkiQE7+MVzeiqYMWCjxtZyu7FfCAtBIV3EJ4AJOzsTojPwIkAAA1g5bKXuitznHmHAb12QLgcjw0TajtggDAhlgWIf6//zD1H2v3rNZPMg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZzJn4tgx; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZzJn4tgx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLVLg4RjNz2xlh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 10:55:06 +1000 (AEST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso8871010a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 17:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779324903; cv=none;
        d=google.com; s=arc-20240605;
        b=AZPkgrzHSwoJ6KXPlObUp3m0tdK78PrDLhPHgrZH0tM+UD3+6R9aX/w0inh92Punz0
         MNmza2ErE1JARH2xnsZ57rz/8hH/fdPzumTGktwKeD9u0o1Xu/AQq0DhvU17QR/uzJLM
         zfgZdDPq9FnQnqsVQ/SxfRUEcPRbQ82crAkdxIGHOzlctEoQnqjQSChODgocxbOVuxtu
         a0+1gsOKoV4xBiuzFy/OkykVU7E31zLEejcQLFRVSFsN97Ekt6zpy+0Xi8ukPE+muzU8
         LY+kz5G5DeotCemgfOS4hSnE4wwnB0yqIwH3NAmhyYZAF8or0ldKohbnUItbgQbrWtze
         4VKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AE1Go39rNIx4vy0a911O8dZSEl9bBMfMiRIm156eQ8k=;
        fh=7CIAHelTTtT6KK9p10N9ChA2nFNRF3j5IQwS8Vb2YXA=;
        b=FQtIsKat3IrPr0lrxNDnEv/BD9pCgpj51Ml+7XDHpIumrVlJjnKuszVDm8bOo4vaNT
         u9F+qIytvwupP7gOrG3CqRTH7acbugt7raAI2xHmaY7WQRwFet1zZVrXAX6kr0qw5W/d
         +jtKZM/xqGE/DPsI3SZTlivHLPc1m/6wrhtFAbzonlEfxUblxjk7HulUiGzDuDYQCGvm
         hEPL660W7L5CpX92LRU46GZHGnoJLE/bboSCu+yQTwr5F1oePyVx2uFmrgpKdnrkcmpv
         yLOdJGQ7Qc4SZGJy3hKCw6WN4+9Ivt/++Fx2fcPoPrQwAJqZTNqE3yBP4xPmVYdPSd39
         pZtQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779324903; x=1779929703; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE1Go39rNIx4vy0a911O8dZSEl9bBMfMiRIm156eQ8k=;
        b=ZzJn4tgxs/FzyosiopxWYIlTaI7LO/GXGeZnZyU3d3XR8Lkx+aORK2G/KS8BGmi6jj
         XhICJFM2LBLEyQwixJydWKpMHNEDxO0I7XUlGK4S+z4eXNmFiCWNFN0+x+OHFw4OZK2r
         CER2qDP1+JclOUTjIoiUKhEjCMmywb/Jg0XgqIDhpt2qjJnTUefjoZvYK62xWq++HYJT
         3Z7rssKbecLscLaw1/jEwI90sie36dew5LVkt/0P4/+n3yJao+ObLXK6peOKRQ3eCL1I
         pUXnIYpdb9JwXVZ8Hly6kl5ngdf5Nz3AVWyxYhzpZuXq9RT+RBEoDyouTd8dgX2+h2lT
         zJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779324903; x=1779929703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AE1Go39rNIx4vy0a911O8dZSEl9bBMfMiRIm156eQ8k=;
        b=UI7a7hqvOEV8zP3Q6kJ7hIZifeXwzThIn4/zLHg8YR63qicKDHPDLTSqAJhwyj2tRt
         vsPMhrDOL6CAbaXtFRdilb9/TkycyjDY33jtiKLZVB0OXOo1e4Sx+82JY7zWyDGdLDsl
         crVeClczjofwDq6lPozvJV5TRqViMTyl2UJdEjj/1H2TINFlGrfyGcYgSbxJHjgCJy4b
         Xgzn+j7ZyTCVpn/X2b/ppnVA1RqkZU3GGQ3oQRhuAmUJ0/oc9GcY4JlmpIAzt/xGLsYp
         h0HX4GZaDyJl8j+Ja65zw2Y5kIYlGTx9m+7fuOM76ZKcGFu40Kqi2OHs7sdJg7IwwCy5
         z9GA==
X-Forwarded-Encrypted: i=1; AFNElJ88u10k7uUpzOCMsfMxZbVZMCrgLLDOFTNCkhxPwfkFwn1keTIK+QQ+TczP7UWuUrKUYLSsrjZIjINMgxM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXbg850h7l9NGxaIAyuayn429C7e+uUTGh+BqRvex80hMlRyDB
	yLiwxARgX9MfHSfmqFgwNbcKs8Tg7YWEic9l+IwZtmyI4mdKebMZAEu3h7zEqSAfIwrwQygRSgb
	nD854OqLnkHxRk+GsHdhbtAxz3GA86Js=
X-Gm-Gg: Acq92OEo2DiyNKgAFW9XzIzwRY5c68tYSEP2/A7CRKuTHHWcOpDXsz152w5ELKEcjK5
	F5Ya27bE7zzqgEBUsHpawKR8mGFNUCh5TRCPrHFBbH7Sg0bPfaSVV3MHpG1LhHX3XZ9DXWeBymg
	/ResCZ+NCT0bl/DegudHlZnN1nZSrtSbkXZaWKLjznb6dD7ne/cCqDACFz7JVVZRmmOmpS4SxY2
	QfBcYy7635BJoPi9BXTcqJ1Ill0J49HBJnGfpit1N1bbKkk92pvcgOFucmCJs2d9dTps7aS6pLo
	FYrgDIWCk3UBpMKeDB7J4q53iaXVZi4jHnOaSDYEHBxEStNCLLzjq5gGtByeGEA4lVtc6rd8zFZ
	BOL3NcxdLuxIqS6J/HA3WbLzNvTBmeZSSVaLh5IcYI+O9wsQj6NO5sWaI1Q==
X-Received: by 2002:a05:6402:28c5:b0:683:a318:a3fc with SMTP id
 4fb4d7f45d1cf-68836ec8852mr171786a12.24.1779324903313; Wed, 20 May 2026
 17:55:03 -0700 (PDT)
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
 <CAKxU2N_vHyqZK8tBbYLo49iOUJSO56rgqbSdw3CnCUZjbs1qNw@mail.gmail.com> <20260520174545.69766438@kernel.org>
In-Reply-To: <20260520174545.69766438@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 20 May 2026 17:54:51 -0700
X-Gm-Features: AVHnY4LkK9r44PwoZGpc9qKOSt4BjRg5xozweKo9ZsJP-nfQGoQ-0m2a8vIbcVk
Message-ID: <CAKxU2N-4kAmvMjodZdoPCiYzKxfjkZwewXY-sTHD54AtswWz0g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ucc_geth: Batch RX packets before stack handoff
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 5:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 20 May 2026 17:39:41 -0700 Rosen Penev wrote:
> > > On Sun, 17 May 2026 12:28:56 -0700 Rosen Penev wrote:
> > > > Collect received skbs on a local list during RX polling and pass th=
e
> > > > completed batch to netif_receive_skb_list(). This lets the networki=
ng
> > > > stack process packets from a poll cycle in bulk instead of handing =
each
> > > > skb up individually.
> > >
> > > GRO should be even better.
> > GRO will result in slower routing performance because there is no
> > hardware checksum.
>
> Mention this in the commit message too.
Will do.
> Network adapters without checksum offload are pretty rare these days.
Qualcomm continues to make adapters like these.
> Speaking of being old, do you know if this driver is used in practice?
Yes. In OpenWrt with kernel 6.18.
> Maybe we can delete it.
Way too early. I've tried previously to clean it up some but got rejected.

