Return-Path: <SRS0=oWcN=6N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E0EC83001
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 02:56:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7358A20737
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 02:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxzFk6AL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7358A20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49BjnZ4Hb4zDqvW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 12:56:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::344;
 helo=mail-ot1-x344.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=cxzFk6AL; dkim-atps=neutral
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Bjk65YF5zDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2020 12:53:02 +1000 (AEST)
Received: by mail-ot1-x344.google.com with SMTP id z25so447511otq.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2020 19:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wtq4lJ0T+c05GDMazabcQ80acou9UEMopy/Ejdrgaks=;
 b=cxzFk6ALfuFDTtWGroHuSSBI5zGMBKAkM+lOutQQGlIdYKcRDevR1a8FrC+nDXw8Qr
 5ur9nhkcZdm3vP6b3moZTB6PvDpr9fD5kLGbmBncy8AVe0D3SWx2ZPp6zPX8HvOipVDj
 4ex0sBy9dgi5XbnjuwnuBCWRsSNp0VTklSTKaRc+H6MFEkvoxF1QYkIEf8T1nXXfVVBE
 pVRcaB/G9f0NCx6SXhcobP+VKpKzHWvP+WFFrsmISpkWYGJbdVcn0ujdIwJYQTw69z6l
 3xJdTj7+6Qicu7lrxxCZmlcJrguj/qk2UVGnODIlGxmqi1ZHieTsdcKYupZh/VJGQ81x
 ABDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wtq4lJ0T+c05GDMazabcQ80acou9UEMopy/Ejdrgaks=;
 b=dgE7c27WG1GVpHoJzhOmAiJh26mCa/glspwfkMPfEpncOfGN1qonsaXdtDWs/+8qB7
 cAlIS4egEoovsxp0wFgfklWocBV0xKc7qG/Xur8Ybe+aZnU7ztz0yIJ2budYRVWw/4Fb
 eRmBMDY7lD/tUdm4U7DpNHdXM5qjACsL7fSH3CVujsoBX09IqiyjACzGoYgKIV4aTuzv
 7MU4nlgJwrWVIyC3MNlC+vQeWJlo4UvV0Fy2MSwHVMpxAmMBXu3I9oSERe62acbbJ7g1
 8uluinz/7GlOIFtKM/lqqmWuOcPl9zFzK39sAE0nFBhnOrdHN+fa3KI0SvCx5ASzwE8h
 WtOw==
X-Gm-Message-State: AGi0PuZYZuVUSYgSSpziECBhwbME4i9GxkLmcNGRQvi6LCMX2SKIG/q9
 o7XErWojWuGsRDIDdX5EtTAUbDZFU0NX88b7nqI=
X-Google-Smtp-Source: APiQypLWA+Ppw/rtyakPMtApp+v2yWHdmjhSqw4xyJVEo9bmwkez+whjP3NQWIAPX/xk0sN/H4S5P1bQHreTrQ71SOw=
X-Received: by 2002:a9d:4806:: with SMTP id c6mr8413899otf.51.1588128778190;
 Tue, 28 Apr 2020 19:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200428015814.15380-1-jniethe5@gmail.com>
 <20200428015814.15380-11-jniethe5@gmail.com>
 <7085187.DCEHQqzOHC@townsend>
In-Reply-To: <7085187.DCEHQqzOHC@townsend>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Wed, 29 Apr 2020 12:52:46 +1000
Message-ID: <CACzsE9qjEvVcPO92KfQgwB2rfWXHc=vXwC+qp+LB402ftPs0nA@mail.gmail.com>
Subject: Re: [PATCH v6 10/28] powerpc: Introduce functions for instruction
 equality
To: Alistair Popple <alistair@popple.id.au>
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
Cc: Nicholas Piggin <npiggin@gmail.com>, Balamuruhan S <bala24@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 29, 2020 at 11:59 AM Alistair Popple <alistair@popple.id.au> wrote:
>
> There seems to be a minor typo which breaks compilation when
> CONFIG_MPROFILE_KERNEL is not enabled. See the fix below.
>
> ---
>  arch/powerpc/kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/
> ftrace.c
> index a6064e1977ca..0ad2c9d4ab49 100644
> --- a/arch/powerpc/kernel/trace/ftrace.c
> +++ b/arch/powerpc/kernel/trace/ftrace.c
> @@ -499,7 +499,7 @@ expected_nop_sequence(void *ip, struct ppc_inst op0,
> struct ppc_inst op1)
>          * The load offset is different depending on the ABI. For simplicity
>          * just mask it out when doing the compare.
>          */
> -       if ((!ppc_inst_equal(op0), ppc_inst(0x48000008)) || (ppc_inst_val(op1) &
> 0xffff0000) != 0xe8410000)
> +       if ((!ppc_inst_equal(op0, ppc_inst(0x48000008))) || (ppc_inst_val(op1) &
> 0xffff0000) != 0xe8410000)
>                 return 0;
>         return 1;
>  }
Thank you.
> --
> 2.20.1
>
>
>
>
