Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394F3C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 14:51:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0EB2075C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 14:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ODY/PULu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0EB2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VcVK4grbzF2Dx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 01:51:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ODY/PULu";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VcPp3QQMzF1Yq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 01:47:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="ODY/PULu";
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42VcPp2lKmz8t7b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 01:47:10 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42VcPp2VmYz9sCh; Thu, 11 Oct 2018 01:47:10 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::c42; helo=mail-yw1-xc42.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="ODY/PULu";
 dkim-atps=neutral
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42VcPn6prLz9sC7
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2018 01:47:09 +1100 (AEDT)
Received: by mail-yw1-xc42.google.com with SMTP id d126-v6so2264171ywa.5
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2018 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=oJF0eik45Aimb38q8RXN/jdoPdx1WKxKmhT/OPkvZ60=;
 b=ODY/PULuOwAWBlGg27fm9QRtnCi4i7zSFh95Zs31UPfKvCJ6nCgvcMGpMkSpw9vXhH
 dPU7/1MWrNPDeFgLjo8+nK8GTp0Lp8bX0JALuDSqPNJ5YCp9AiTbidCixQWVWMuAl/Wz
 V+7jU0i3hLrh4vLZbpaUfq11xIxnprjkB0+QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=oJF0eik45Aimb38q8RXN/jdoPdx1WKxKmhT/OPkvZ60=;
 b=ajYR4zxtoEXPYcEAS4tBdXzSuhvqiZtuA+Sg2eginofjI9Mwk3WTHqpzXPPMO17+cm
 36PeaJlmWVgy3WZpOr7sc4QX/rFgS6iTuruMKJN+W0RtbfW48kuYQV0GmfuzpStWNK7U
 pGyb5NXHjcbUe6uKDq71bDPXWFL5diDO4pXHDFMBdDi3AeE8br9qiHjZQl3Ot6XZcTkX
 Fwl8NtBchCozCv6oOvhBI3zDXF9KyDptMHT/BPGvQXq9JnVNbKsQ7qmmmNxnUoqr4jDo
 VQjr7UpImemZVOQPH7k9GiNSi60DMqfyidzjEPl9QRALFNcGNq9v8IDLUOVBPpHvVDPC
 JUWw==
X-Gm-Message-State: ABuFfoiszsUdjCRDnbM03XRTRIPp4aZfoNXLvebcN3GeqyDd+ihBTMlB
 EFQFsEx8vapb73rum9WVSReVnmLNvJ0=
X-Google-Smtp-Source: ACcGV630nDAu4laYad9AM1lGXM7Gxcomj1iLq2Vg+xKN260DJ017D0Z/1z78IzoYDfrAl5mHFKSJ3g==
X-Received: by 2002:a81:ac0f:: with SMTP id
 k15-v6mr18220476ywh.309.1539182827826; 
 Wed, 10 Oct 2018 07:47:07 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com.
 [209.85.219.179])
 by smtp.gmail.com with ESMTPSA id q2-v6sm11579140ywg.87.2018.10.10.07.47.06
 for <linuxppc-dev@ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Oct 2018 07:47:06 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id e16-v6so2298860ybk.8
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2018 07:47:06 -0700 (PDT)
X-Received: by 2002:a25:640a:: with SMTP id
 y10-v6mr19333819ybb.421.1539182826158; 
 Wed, 10 Oct 2018 07:47:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:47:05
 -0700 (PDT)
In-Reply-To: <20181010051308.25422-4-mpe@ellerman.id.au>
References: <20181010051308.25422-1-mpe@ellerman.id.au>
 <20181010051308.25422-4-mpe@ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 10 Oct 2018 07:47:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJqX6ogFgX1q9czwWtufK_nvzUnfN3Xf-74eOBOpcXWVg@mail.gmail.com>
Message-ID: <CAGXu5jJqX6ogFgX1q9czwWtufK_nvzUnfN3Xf-74eOBOpcXWVg@mail.gmail.com>
Subject: Re: [PATCH 4/4] powerpc: Add -Wimplicit-fallthrough to arch CFLAGS
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
Cc: linuxppc-dev@ozlabs.org, maddy@linux.ibm.com,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 9, 2018 at 10:13 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Warn whenever a switch statement has a fallthrough without a comment
> annotating it.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Yes please. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/powerpc/Kbuild | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/Kbuild b/arch/powerpc/Kbuild
> index 86b261d6bde5..ef625f1db576 100644
> --- a/arch/powerpc/Kbuild
> +++ b/arch/powerpc/Kbuild
> @@ -1,4 +1,5 @@
>  subdir-ccflags-y := $(call cc-option, -Wvla)
> +subdir-ccflags-y += $(call cc-option, -Wimplicit-fallthrough)
>  subdir-ccflags-$(CONFIG_PPC_WERROR) += -Werror
>
>  obj-y += kernel/
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
