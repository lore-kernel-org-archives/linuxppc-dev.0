Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B1CC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 14:48:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56EB2087A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 14:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OOPSBOw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56EB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VcRF3mWMzF1Pw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 01:48:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OOPSBOw0";
	dkim-atps=neutral
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VcNN1YxzzF1Pp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 01:45:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="OOPSBOw0";
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42VcNN12jDz8t7b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 01:45:56 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42VcNN0rlSz9sCh; Thu, 11 Oct 2018 01:45:56 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::c41; helo=mail-yw1-xc41.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="OOPSBOw0";
 dkim-atps=neutral
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42VcNM1DMNz9sC7
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2018 01:45:54 +1100 (AEDT)
Received: by mail-yw1-xc41.google.com with SMTP id m129-v6so2270091ywc.1
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2018 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=51PI37LRLqDUZzoWqPCdRdbaP/JlYkO7fxDvlA3GKxc=;
 b=OOPSBOw0RhBKvW+P8e2ywCYbXN+AdDYCgaoJaT1TKcA/ni2srssUFjTqD4nXBrYJgu
 ZbUQnf0TfnfM7qadQzKYqOsnYp+JloFcRpESzdqxevUjUnuoMo4eazSyhkbdg3LyBLmB
 sJK1+zo34RgCAoU/z8q6dZpnM/SrsavGaTKIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=51PI37LRLqDUZzoWqPCdRdbaP/JlYkO7fxDvlA3GKxc=;
 b=D+qyzDiaeDcGHY9zvUfdKVBbHPxR2C9IPaudzPNjqe2xuNoEZk+2Wbsx5oXMTF1M1Z
 DOPzkitceEVOfMYMtAV+tadBJnaH/znqUdbUuISafhsW+tHetZSavhKO9zXJO1KtDzif
 rbGYVPkviil8Xs6UT/SaxcATNgcCdauFk91L9U5JcZJTD/oyWN6hUZBp0IaTMw+NAw83
 057+6+Ayoa62jeA9cLzvOVu2OzqOZn3anzfpMcDrRkM4Rn8L2YigvL+J7DfzZRoP/HGZ
 b/WmGxw2PQZaPnxtOR0K0MQWze5oma5Ew3roEGX5v2Oq9BUm8ZMc7Kfvr/ZcdLATz24Y
 WLIg==
X-Gm-Message-State: ABuFfoj4Qs04cC1hjh8KMzCSeoTi8T0HEpN+f+nnGu3yp5WMRV879p2s
 cz7SMacYitNouUvUD7Yk8e7+H4qMTTY=
X-Google-Smtp-Source: ACcGV63ztzwTTqqzu/IoG/+uR95R/jtSDo1/VZuQEns/tyC44Cti3KjxoZLjw/OI4C7kVpYbQmphzQ==
X-Received: by 2002:a0d:d54c:: with SMTP id
 x73-v6mr19397340ywd.130.1539182752405; 
 Wed, 10 Oct 2018 07:45:52 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com.
 [209.85.219.174])
 by smtp.gmail.com with ESMTPSA id o63-v6sm7638679ywc.36.2018.10.10.07.45.50
 for <linuxppc-dev@ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Oct 2018 07:45:52 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 184-v6so2306737ybg.1
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2018 07:45:50 -0700 (PDT)
X-Received: by 2002:a25:2395:: with SMTP id
 j143-v6mr18738794ybj.137.1539182750135; 
 Wed, 10 Oct 2018 07:45:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:45:49
 -0700 (PDT)
In-Reply-To: <20181010051308.25422-3-mpe@ellerman.id.au>
References: <20181010051308.25422-1-mpe@ellerman.id.au>
 <20181010051308.25422-3-mpe@ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 10 Oct 2018 07:45:49 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKUP573d2PFnGchT_uE=YmO83sdBUWOyAR-1UfskE5m9A@mail.gmail.com>
Message-ID: <CAGXu5jKUP573d2PFnGchT_uE=YmO83sdBUWOyAR-1UfskE5m9A@mail.gmail.com>
Subject: Re: [PATCH 3/4] powerpc: Add -Wvla to arch CFLAGS
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, maddy@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 9, 2018 at 10:13 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Upstream has declared that Variable Length Array's (VLAs) are a bad
> idea, and eventually -Wvla will be added to the top-level Makefile. We
> can go one better and make sure we don't introduce any more by adding
> it to the arch Makefile.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/Kbuild | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kbuild b/arch/powerpc/Kbuild
> index 1625a06802ca..86b261d6bde5 100644
> --- a/arch/powerpc/Kbuild
> +++ b/arch/powerpc/Kbuild
> @@ -1,4 +1,5 @@
> -subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
> +subdir-ccflags-y := $(call cc-option, -Wvla)
> +subdir-ccflags-$(CONFIG_PPC_WERROR) += -Werror
>
>  obj-y += kernel/
>  obj-y += mm/

-Wvla will be going into the top-level Makefile in the merge window
(see linux-next), so this will be redundant.

-Kees

-- 
Kees Cook
Pixel Security
