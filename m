Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42AFC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 17:56:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3587521872
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 17:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IodDgUPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3587521872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WXX80qlZzDqN3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 04:56:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="IodDgUPX"; dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WXVF2XgqzDqM1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2019 04:54:25 +1100 (AEDT)
Received: by mail-lj1-x241.google.com with SMTP id l15-v6so33071192lja.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 09:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XsVK1WRl7sYn7ta04iAyntHqwbf6VtSYGr1Ly5n6GNU=;
 b=IodDgUPX5dda1krHX6/lVuNBp/uDtyBokKCNh+lxSTZvP6zPoqyGOLxgUYF1UhskPO
 9G9g2vktSyeimEDKVHNnwNg3c7KauAA+po+wxydEQyDwOMhP6DuSrF+Rxj6Ag/q3fvKK
 OwW7Pun5DbkAIuHthvbbURLNLdpWlZiT1ctn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XsVK1WRl7sYn7ta04iAyntHqwbf6VtSYGr1Ly5n6GNU=;
 b=W2+mxHNV0VYtOXo9xcZFEBJWOE/MnM6iGS5OS7akcvnyKKeQmmg3nlvEkYa4aI8z1K
 Q3ZAAdFfJZ2eE8uNHPxavmK746phBXKjikx9im2RgHK3ggogEJZyk+tLfXFE+ZKFf9Hu
 H1Bzy8MCmz11fTY6nV5c9thQJBNc/6IrXiJAEJHDS7It3f2bDlVXn/p+fbCLZCGaESP8
 9cxeTlF/ykP8XFBDoUrqELy8qc6Ytu1d2r43yJAan/VbTyzYa+UgOGDhwiiTLgyRzxLJ
 sB+SUXjqkkZR83jUKt3sFI7gB8wdWkFRYgU8c6zuOAUINNYQ5ObuSiw+VaC5lQDvAad1
 1p7w==
X-Gm-Message-State: AA+aEWZzey8J5yUrG8w+80EWn+44nc5ZlGj7YJSPYTIDdoh4p2/F6BFO
 JgfD+VCY5zSrKN08qca8yTqhsLR1TCQ=
X-Google-Smtp-Source: ALg8bN5RFqZpA/wlJBHP1U9vfBOHFzW052P5xvetLGS7okPiD95c3WDj92fYI1u3d/B3yaomLRS5yw==
X-Received: by 2002:a2e:9783:: with SMTP id
 y3-v6mr28693669lji.167.1546624461715; 
 Fri, 04 Jan 2019 09:54:21 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com.
 [209.85.167.41])
 by smtp.gmail.com with ESMTPSA id p67sm11323474lfe.14.2019.01.04.09.54.20
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jan 2019 09:54:21 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id a16so25988938lfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Jan 2019 09:54:20 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id
 p129mr27660722lfa.135.1546624460449; 
 Fri, 04 Jan 2019 09:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20190104092758.4378-1-malat@debian.org>
In-Reply-To: <20190104092758.4378-1-malat@debian.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 4 Jan 2019 09:54:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0zJk-1manLvbFCuCduYj0JF6EWWjs_9t8M+MVMSuMTQ@mail.gmail.com>
Message-ID: <CAHk-=wi0zJk-1manLvbFCuCduYj0JF6EWWjs_9t8M+MVMSuMTQ@mail.gmail.com>
Subject: Re: [PATCH] Remove 'type' argument from access_ok() function
To: Mathieu Malaterre <malat@debian.org>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 4, 2019 at 1:28 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> Revert commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") to fix the following compilation error:

Gaah. I even *looked* at the powerpc use of 'type', but then when I
was actually going through my manual editing I forgot all about it.

So this wasn't a case of "the powerpc change was recent and clashed".
This was purely a case of "Linus screwed up".

Sorry.

              Linus
