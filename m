Return-Path: <linuxppc-dev+bounces-28706-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753D6CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 02:05:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwsYc4YcTz2xwd;
	Fri, 02 Oct 2026 12:05:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:33::c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790906708;
	cv=pass; b=g6h10pRoP1w517RIl5fKiWNrY4jIeXIQ1jK5mHGcKhFpZbKZpk8w2nG8v6PgThMnS2LJBMzkiFKQJFrrh8B6dSOmElJ8CylOVbXkL+8OSE4OERcHQFpJC90O+hR52ss7TUM39gxw41q2oh9Ul7SMZ5wrQpPFoqmPid88hhI+XKh6gGAItV1OdEbEc0EEgl4NXxXEZoAgX2lYQDpKVBTA2DIieg9llYn8qEfHVmB6nNGQdjDssVxbcEudQJZI11qDV11MgUXqNhGu7I5Vc+VqQyBDxgzwwOXN8LRiYjtK1cwtPrFUibysqVjPFOdbFczc5jOoWui7/ku+6WGG6c1tkw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790906708; c=relaxed/relaxed;
	bh=BNObIucQZt6XOuG/l142nh9+U24Ab7g3KvjwszYIWFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6WZWb2f/iGUfvAnxmz2ExQCiKIQ0JxjkfDMkdWT7UADhbOTg2sluz1OpMSS2uKsJnaex5qXnP386lb3rFeRnvjBqBN69bA7YR17pxaSacdmcSXEkVP86jDGu8ZF3xNBoeu3uow1I3TUiLUFtoI+ITcy5O8h9wT0W4F+qVXEA3/yGDBLo1Xqdrs3lFxlcW5vAR42b4D54X95pivlRlgApThZdOgEDd5wDZSxZYe7054wPjLwBRk1Sj/OzVJaYZAqAznmlz06soHv0ScGAyTD4nPIq3/oU8VAhmyBgUpe0nAGpLEDvVEjTnlB3DEH6w2lpm8eiaUz85G5RqCzueV/nA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hcfXadQV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:33::c; helo=mail-ed2-x0c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hcfXadQV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:33::c; helo=mail-ed2-x0c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com [IPv6:2a00:1450:4864:33::c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwsYZ5lQBz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 12:05:05 +1000 (AEST)
Received: by mail-ed2-x0c.google.com with SMTP id 4fb4d7f45d1cf-6acb88abebdso4392043a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 19:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790906701; cv=none;
        d=google.com; s=arc-20260327;
        b=eV/6PL2W+C8v8hVB+Rq66YHzot6yhXVbl+it/uBrUK8P9bfSVrbi5dN1wIckA9mDSA
         1vFWj4+mEwtmx7MFEHk9lbQpveQq6/gQabap0LOztT0GGJnIizEQqFHSK+djm1pKr5H+
         xspoBigSxUdzSdUjesA/T+C4WHQESIgf8Vf4z1HjAzJpIBdic1k/7TPSzGGfqI9jf216
         1i3j8ktoV4lvkdXlE69HA9qe4GyoNjqEQgUMROMxjQHqknhKr4zAE2Ml0g93pG85FTKa
         cVRp/9HO7NyUQwt/Gp2EoFdSQjKXnqjW2a4/OrCBU2sczLUZpFIolGT8NHZ/iJv8ctEd
         TG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BNObIucQZt6XOuG/l142nh9+U24Ab7g3KvjwszYIWFQ=;
        fh=sRZK+vQHwVcsxsiYqqbx1ABJIQlLcduBUyoI4KTk6Es=;
        b=N1fnIhoUp5iIAW7JZ5CCluXcf6NR7JwOkHYS67/guZuKXCrudt3vCYHkEZCh9m1Is/
         evEq0GnZ8Z2wb9a8qj4f3xJ5GtnNESg/QuspNDhom2GmTyUdLeDIzRv6EiH902Rh2ulb
         sD7bEZPOHxfvL57RboGnPhgGu1cPdSAEZGgIaLXQ7u7u5BBKJ+EUz5smF8NXPzQhBckz
         oqGmnX3z0+ycg+g5ZCNtM+RSr30/TrAOUNYXnSyvMRReeR4QM6GXA0qPguSQQ7oR3DbY
         YPw08RiZs7rP2yOQhWXJIWvRGyi1CbsaGEkig8XSECpcY0GL5SgaxxNl+P76jaMjfExX
         Gmrw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790906701; x=1791511501; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BNObIucQZt6XOuG/l142nh9+U24Ab7g3KvjwszYIWFQ=;
        b=hcfXadQVUQ+n5RuvxCbAk2zVd7zsPbiMzEOplSZoMR+VC4W12Way/U1WzITmFAeoGo
         uVm2hBpXBAEHqQhoI+qAjAmNInxoo2ujndHKYkyZNjfj4Myu8opuqFKGLfD9HLVgNbz3
         pP9U5GX03AT+ifmEa8xOq4bKUSZDxHz3AJjShwSxKnuddt84WIDrWZi7BUEaU+5/ksNQ
         a1byDaS6fabOmTnwSyslLxPhr2hPFPi/LNJuzC0GmzgCRUmEadHCx/hZNTzRy8g5/yDI
         eN71wR1NvzRkubPsKYoaVX+T0P4e6LZ99oHj5LZpxceKYGoWls/WCJr0ybKS82/ixqu8
         GGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790906701; x=1791511501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNObIucQZt6XOuG/l142nh9+U24Ab7g3KvjwszYIWFQ=;
        b=RDwdVWMbCnRciABNQPtz9ngbCaLwlLVu7dN7A4LiemqzQqRqYCHjdnehFgDNZpGckd
         ulfwgJWmcd9Xl3iJ5i9S/BBr8MBqjmwaxPOzHh+tm/lSDss/rvQWsWb+soeWCeQo2vow
         ARiS6u2DY6UTxHCLND9qZ/PobyYhq+WrcTxgU/qRcYv8O5TWX2NVRtmS9RFsQDFzk6kU
         hNUjD7d2fsK3hd4q8+dvUNseQ8x+K5XWVUwHFQD4tkDgh1MGGIVfVNA6yRPCMtPbBvcy
         FzhFtZYABt0ZXJWd8bwSeCtJ275koTYlY/WZt4ADNt93RUPRW4yveRrYu3kCZVey29AI
         QSNA==
X-Forwarded-Encrypted: i=1; AKwUvBw8V5u0ENu70Z42rLb9F/cMsegMzOklnYUvcnG+jAb0cNe4JYpI27O9rlOPn5emrTGcZpVK2BzHht0OJyw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIaZFRLWFRRSl4eiJContf8hF3l4d3pB+jPO0yn8QMTRtVcSrbt
	qJ1nRatgRbbM+/3Bk5piSbhYD1bFq3n5H5tTEWzt0Drm1WcC8vjcsNcGWEXC88HlSd4Ku+Yk5V5
	lqEhV6vBOM9sv+SC0K6gYPHp8O8On2PA=
X-Gm-Gg: AYBFou28YNKnpo9h3gisecNqfL1ua+mNzBknGaMTgmFdx3hHkp1JXOP7n6h6uBFmctl
	aWgf2eIiu2OCgUP7OFDvk2ETfCTRpz8H5SLHRyhYhGyPSMTPItTByczz3SaLucFPuI3bN88NyP/
	Q7+IhdHo7WDQR5EbYh23D7GhXUKuw/K/P/aJrRdZTxAhuzqjC1zPh1Hz2vO7lNpjvF4N6tB7Z+U
	/g6oa2fVMttlrJszxoXAnPVObsBTgw19xefmDWFdTIOU5/X4Yj50M/u1g7GekVIDDlIWbSktPLX
	KfNTFjUgFHUmNm9rCYWmGKKCU+4MI7RCEHxqDQvTm3D/KxNIStAFLUa73zj4f5IgQhluH0OGZTh
	LWAHgu4uQfPjOd2KJRenc181CXV4QGUtFwf7TzUl3hOfLLouTUEZ6NbPlJKvOkGqwBKJIgss6JI
	uFR46VWjamJubOzV8uUresh283mXt+RnQZe5JB1gOx/+TlgCuhIa+KySkfwMF+HbACRA==
X-Received: by 2002:a05:6402:3253:b0:6ae:1a0a:ae9b with SMTP id
 4fb4d7f45d1cf-6af9e2ddbadmr526637a12.25.1790906700698; Thu, 01 Oct 2026
 19:05:00 -0700 (PDT)
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
References: <20260927204317.21546-1-rosenp@gmail.com> <2026100132-geology-shingle-d005@gregkh>
In-Reply-To: <2026100132-geology-shingle-d005@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 1 Oct 2026 19:04:49 -0700
X-Gm-Features: AclHuK_Edka22cv7pAp_46c1jQz2-5jdqpjLkkUTPn-yUOquVWu1-dC2o2nF6g4
Message-ID: <CAKxU2N-_kZM9LF2s_1kwZ-0visnuCH9f7c3b8+iEeCH=RgK2QQ@mail.gmail.com>
Subject: Re: [PATCH v2] serial: ucc_uart: Use platform IRQ helper
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Timur Tabi <timur@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, 
	"open list:FREESCALE QUICC ENGINE UCC UART DRIVER" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Sep 27, 2026 at 01:43:17PM -0700, Rosen Penev wrote:
> > Avoid calling irq_dispose_mapping() by letting the platform_device
> > machinery handle it. Also enable possibility of handling -EPROBE_DEFER
> > and other errors. Handle before any allocation or anything to avoid
> > dealing with gotos.
>
> I can't really parse this, what is the bug here that you are fixing?
>
> > Assisted-by: LLM
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: move platform_get_irq() earlier.
>
> Why?
this was reported by sashiko in v1:

[Severity: High]
If platform_get_irq() returns -EPROBE_DEFER here, does this leak the
asynchronous firmware load initiated by the preceding call to
soft_uart_init()?
>
> thanks,
>
> greg k-h

