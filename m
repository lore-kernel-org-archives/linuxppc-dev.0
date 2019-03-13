Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C20DC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 12:51:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39222171F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 12:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWJ++1Zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39222171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KBXq3K4czDqKH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 23:51:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::244; helo=mail-lj1-x244.google.com;
 envelope-from=omosnacek@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dWJ++1Zx"; 
 dkim-atps=neutral
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KBVc1RMbzDqK3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 23:49:11 +1100 (AEDT)
Received: by mail-lj1-x244.google.com with SMTP id w6so1432094ljd.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 05:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BUxwNawH0Tkoj9W4Y+LgqMF3Dj4FNiS+G8O18fL3gz4=;
 b=dWJ++1ZxXn2kwj8bTkU3e3JpyCx56eL1eTMUrgfBLnpdkOSno3iGnO8OH2Gx2IaeiV
 W3R9j65M+P06dVVux+g+BM+TK4l1tBI3or0/nNhuw8b9NhpjErnYzZCdEtKX6HLALLc+
 sbNkHy2FFjpVLY+1GssUPtK1tB7zu5k7xzswW6dTXTkdcQJ7hk5Iwz5Gd51Br6Xulz3k
 V/NkCQCEqSAMPFLNHJynX5Nhlgi+fzi0ExrljYWJjRjDBHZkPgv4ikOoS0MAuRUvTQl2
 ANG6P0tHMoGPnIjfSQ4uzzPbKWFQOvufzu319ytU6aSyuYIxMa7kY1TXuTWXyleON52F
 FuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BUxwNawH0Tkoj9W4Y+LgqMF3Dj4FNiS+G8O18fL3gz4=;
 b=l8JoAqqlgNdY8mliJZvlw35Wcwitl1YO6iX0HIH4yHplkmeY1y1tM4lqB4Sbe+5Ssp
 eQZYwFjQ51lLOmW648MMNcya5GVf9AoWtajj2WvgFhvFhiJrlJxrYVWvFLG3gS0Zp2YO
 qrHhoxH1V+QAM7hlkU59wLE4OUVv3pbt6qDlFln7ZzFIsU+kY/AvF0mq5NnRJ3AXcMMk
 AXBJls0wpYZakzA5eNkeykg7dirY1y/U0oMsK1/9kpXhCTmoXfmht4muCHpgBWtUHmPq
 /ckZS0qx22iubkbaxtH0ofSbAz8cFGETUzYIvCMvzLP4C1Kv/gPvSRACnu9LBdlO/7fs
 200A==
X-Gm-Message-State: APjAAAUP9mUeVvWNp4+7lKFooiNvs37YtiDVJj30VE8TL0ZvWRlhPkZl
 HFWKRSNz77F3ewjo7nPS7GnFjwsHrq8j7q3JP78=
X-Google-Smtp-Source: APXvYqxiRw23DB4H+Q4RE8WR7r0uav5cgIzW2KBx6rHRuw6lGxcl8fz/JAKlfr4+f3vHrXvdQ0yK2PEp3MQ6cv8DtVk=
X-Received: by 2002:a2e:20b:: with SMTP id 11mr23199147ljc.41.1552481347202;
 Wed, 13 Mar 2019 05:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAAUqJDtsx6Sdv=6xAb1VWWjDF08y8wh2nsAypR8_x_e99a1Uwg@mail.gmail.com>
In-Reply-To: <CAAUqJDtsx6Sdv=6xAb1VWWjDF08y8wh2nsAypR8_x_e99a1Uwg@mail.gmail.com>
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Wed, 13 Mar 2019 13:48:55 +0100
Message-ID: <CAAUqJDuegy=zw3SwQ1UsV881DjLSvZ9X3joFt89HkBy7y9=7pg@mail.gmail.com>
Subject: Re: BUG: p8_aes_ctr randomly returns wrong results
To: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
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
Cc: leo.barbosa@canonical.com, Stephan Mueller <smueller@chronox.de>,
 nayna@linux.ibm.com, marcelo.cerri@canonical.com, pfsmorigo@gmail.com,
 leitao@debian.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

st 13. 3. 2019 o 13:37 Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com> nap=
=C3=ADsal(a):
> Hi,
>
> FYI, the p8_aes_ctr crypto driver (drivers/crypto/vmx/aes_ctr.c) seems
> to be seriously broken. When I do repeated encryption using libkcapi
> multiple times in a row, I sometimes get a wrong result. This happens
> more often with long messages (e.g. at 16 KiB it already happens very
> frequently).
>
> To reproduce:
> 1. Install or locally build libkcapi [1] (you will need the kcapi-enc
> binary in PATH) on a ppc64le system.
> 2. Run the following in bash:
> for i in {1..100}; do head -c $((16*1024)) /dev/zero | kcapi-enc -e -c
> 'ctr(aes)' -p test -s test --pbkdfiter 1 2>/dev/null | sha256sum; done
> | sort -u
>
> Expected result:
> All invocations produce output with identical checksum.
>
> Actual result:
> Multiple different checksums are produced.
>
> When I run 'rmmod vmx_crypto' before running the reproducer, I get
> only one (correct) checksum, so this is definitely a bug in the
> driver. Other ciphers (cbc(aes), xts(aes)) are not affected, even
> though the glue code is very similar. That leads me to believe the
> problem is somewhere in the assembly code.
>
> [1] http://github.com/smuellerDD/libkcapi
>
> Cheers,
> Ondrej

(Ah, forgot to compare email addresses with MAINTAINERS... let me try these=
)
