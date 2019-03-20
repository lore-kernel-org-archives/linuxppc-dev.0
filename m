Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69BEC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 08:58:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFFF2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 08:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3cCxiYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFFF2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PP2y0Kr8zDqQB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 19:58:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=omosnacek@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="D3cCxiYi"; 
 dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PNgB4v7wzDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 19:41:10 +1100 (AEDT)
Received: by mail-lf1-x143.google.com with SMTP id y18so1238054lfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=avaSil1GRyz0VCmDiB3yq1bjN6KNstBnhCuDZzSeAzY=;
 b=D3cCxiYix+3mzjRCPgsu3d6dyD6/CSsKCwHvXHzfljCPhv4av1wj1eHU5qIon/cBjA
 G3xD3ZOmlhTV4H60VeDtF+t/GTJan8xZ3vTJ3b9ufP1ZDzsgZDqMfvL/h6w/cGEC7maH
 JihSXGbaAagP3HtgmEE8VHVEvG3MTKi6g1PN2TjL9AyWqhhKCmcbs6+rQYfKB6w8znBc
 G7lJcQdKvzLMZ23X883xtBZ98iM67rIzq98OFKEn9XmFkcQUVZ97bNnwf/1hjzsgCoVc
 XHgOIIVQfRyHK3nRKoOXxMWPreHojbsMmKVRf9ZtHWiHizOM3sZDCwwpKvq2V10ry6z8
 0jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=avaSil1GRyz0VCmDiB3yq1bjN6KNstBnhCuDZzSeAzY=;
 b=quR6BfFiNnsOmIK9RIir/U/YD7SuUrXQdWs38DY60yFtGZ1Pu1Gq5GkJjqF0TDEpE8
 IeCuyzyIdmGKKCVGjqaqb4lOAImLvv8rHjTbxgBzIzbfBXAMtU3T88FkH9wNP2jlCefS
 bZFRyA07ytdRy5peNm/N/bsCT/5d6HqFxZzaACyCQSLQIjZ+Fx8FzUe9iUnE4D5hVIFK
 ki1Dy4Rz9GJ/6i6RIwpw5I+5xCgC0HonbujXvxKeuh5ZscRtLunLoViuK/suqqKbGQUD
 l2djty8WuUqP6y62BumhM16ER7BN79ucOqfad3QXUTVKVYtj15mW48zV4+o8OGI4kiEQ
 BJFQ==
X-Gm-Message-State: APjAAAXOPggfFqnWrpvMVvSb8VNf6TypfkqeKmPyr3ySvCcDI67B6mAd
 3A5A+jorMKR+QFzFgIYeJtSwVxlNxucVUiznnZ8=
X-Google-Smtp-Source: APXvYqyat5nQ8HlqQH7JKCWkZ/vTgXz//OfnE7K2GSLkdO96ucUAPRXfvtcIgkR15XdMa366h/P0QJ2s32OTRlkKOI8=
X-Received: by 2002:ac2:530a:: with SMTP id c10mr13687465lfh.45.1553071265755; 
 Wed, 20 Mar 2019 01:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190315020901.16509-1-dja@axtens.net>
In-Reply-To: <20190315020901.16509-1-dja@axtens.net>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Wed, 20 Mar 2019 09:40:54 +0100
Message-ID: <CAAUqJDs8kCc5CbFpf_oV_v1HOiLYd1TYyx_KATt8e3fbrJG_Nw@mail.gmail.com>
Subject: Re: [PATCH] crypto: vmx - fix copy-paste error in CTR mode
To: Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: leo.barbosa@canonical.com, Herbert Xu <herbert@gondor.apana.org.au>,
 Stephan Mueller <smueller@chronox.de>, nayna@linux.ibm.com, leitao@debian.org,
 Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, linux-crypto@vger.kernel.org,
 marcelo.cerri@canonical.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Daniel,

pi 15. 3. 2019 o 3:09 Daniel Axtens <dja@axtens.net> nap=C3=ADsal(a):
> The original assembly imported from OpenSSL has two copy-paste
> errors in handling CTR mode. When dealing with a 2 or 3 block tail,
> the code branches to the CBC decryption exit path, rather than to
> the CTR exit path.
>
> This leads to corruption of the IV, which leads to subsequent blocks
> being corrupted.
>
> This can be detected with libkcapi test suite, which is available at
> https://github.com/smuellerDD/libkcapi
>
> Reported-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> Fixes: 5c380d623ed3 ("crypto: vmx - Add support for VMS instructions by A=
SM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Thank you for looking into this and for posting the patch(es)! I
tested the patch yesterday and I can confirm that it makes the
libkcapi tests/reproducer pass.

Assuming you will want to cover the other failures from the new
testmgr tests by a separate patch:

Tested-by: Ondrej Mosnacek <omosnacek@gmail.com>

> ---
>  drivers/crypto/vmx/aesp8-ppc.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/crypto/vmx/aesp8-ppc.pl b/drivers/crypto/vmx/aesp8-p=
pc.pl
> index d6a9f63d65ba..de78282b8f44 100644
> --- a/drivers/crypto/vmx/aesp8-ppc.pl
> +++ b/drivers/crypto/vmx/aesp8-ppc.pl
> @@ -1854,7 +1854,7 @@ Lctr32_enc8x_three:
>         stvx_u          $out1,$x10,$out
>         stvx_u          $out2,$x20,$out
>         addi            $out,$out,0x30
> -       b               Lcbc_dec8x_done
> +       b               Lctr32_enc8x_done
>
>  .align 5
>  Lctr32_enc8x_two:
> @@ -1866,7 +1866,7 @@ Lctr32_enc8x_two:
>         stvx_u          $out0,$x00,$out
>         stvx_u          $out1,$x10,$out
>         addi            $out,$out,0x20
> -       b               Lcbc_dec8x_done
> +       b               Lctr32_enc8x_done
>
>  .align 5
>  Lctr32_enc8x_one:
> --
> 2.19.1
>
