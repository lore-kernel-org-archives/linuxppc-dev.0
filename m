Return-Path: <SRS0=2lRn=3C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C72DC33CA9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jan 2020 16:05:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1525E20661
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jan 2020 16:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGAaulc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1525E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47xJNH6wMhzDqKq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 03:05:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=timur@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=sGAaulc9; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47xJL83cHPzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2020 03:04:00 +1100 (AEDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6040821556
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2020 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578931437;
 bh=G1kNIMTqa7t6gibSOOfsK2Fi55Z03Y6fvvNp2Knb1CA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=sGAaulc9hF2Wk7lrsnWpGusHPp2Q9IeE5sQb/EdxVvD3JAIxkJi0BrEc23mA3maym
 lXWnPuS0Ipo6qUoU/4uIloG3pA+rI8rzQP9J/Oi9mx6llEBO6S6tpjZoxEYCtWkeYR
 tzoznNvRD67i93BlPCFdinAPBRyIL1TYcHFmUwpI=
Received: by mail-qv1-f43.google.com with SMTP id dc14so4194392qvb.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2020 08:03:57 -0800 (PST)
X-Gm-Message-State: APjAAAV9GPbrTQKIbvn92f8VXwcblhjRuJpYqIB6DB92q8xYDttpwmt5
 XqhS9Djj5b05g/weOGj+bhxDDAFQa+S8KRIS4zc=
X-Google-Smtp-Source: APXvYqwahcpfWT6q4P++SVRRgi8g7aY3quiDSht89xXuEWpFAnwpFCNUO0DO66KfMGh9SCxkzKCHMOb6e5r/cdV8T5g=
X-Received: by 2002:a05:6214:1633:: with SMTP id
 e19mr12314347qvw.104.1578931436581; 
 Mon, 13 Jan 2020 08:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20200109183912.5fcb52aa@canb.auug.org.au>
In-Reply-To: <20200109183912.5fcb52aa@canb.auug.org.au>
From: Timur Tabi <timur@kernel.org>
Date: Mon, 13 Jan 2020 10:03:18 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXiKgz=hOoiaTrxgbnwzyvp1Zfn3aCz+0__i17vyFngRg@mail.gmail.com>
Message-ID: <CAOZdJXXiKgz=hOoiaTrxgbnwzyvp1Zfn3aCz+0__i17vyFngRg@mail.gmail.com>
Subject: Re: [PATCH] evh_bytechan: fix out of bounds accesses
To: Stephen Rothwell <sfr@canb.auug.org.au>, york sun <york.sun@nxp.com>,
 b08248@gmail.com, swood@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 PowerPC Mailing List <linuxppc-dev@lists.ozlabs.org>,
 Jiri Slaby <jslaby@suse.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 9, 2020 at 1:41 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> ev_byte_channel_send() assumes that its third argument is a 16 byte array.
> Some places where it is called it may not be (or we can't easily tell
> if it is).  Newer compilers have started producing warnings about this,
> so make sure we actually pass a 16 byte array.

...

> +static unsigned int local_ev_byte_channel_send(unsigned int handle,
> +        unsigned int *count, const char *p)
> +{
> +       char buffer[EV_BYTE_CHANNEL_MAX_BYTES];
> +       unsigned int c = *count;
> +
> +       if (c < sizeof(buffer)) {
> +               memcpy(buffer, p, c);
> +               memset(&buffer[c], 0, sizeof(buffer) - c);
> +               p = buffer;
> +       }
> +       return ev_byte_channel_send(handle, count, p);
> +}

Why not simply correct the parameters of ev_byte_channel_send?

static inline unsigned int ev_byte_channel_send(unsigned int handle,
-unsigned int *count, const char buffer[EV_BYTE_CHANNEL_MAX_BYTES])
+unsigned int *count, const char *buffer)

Back then, I probably thought I was just being clever with this code,
but I realize now that it doesn't make sense to do the way I did.
