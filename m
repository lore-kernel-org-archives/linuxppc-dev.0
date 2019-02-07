Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EE7C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:43:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220FB2084D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Edt3JNnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220FB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w5Kb20HnzDqQG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 15:43:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w5Hz3ZsqzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:41:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Edt3JNnK"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43w5Hz2jpqz8tPg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:41:51 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43w5Hz2Jnzz9sMM; Thu,  7 Feb 2019 15:41:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Edt3JNnK"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43w5Hy327Nz9sLw
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 15:41:50 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id b5so4217211plr.4
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2019 20:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=31/Xmb/GU7iAEDGS1igke46kX9BYMX3fQcNNVug920w=;
 b=Edt3JNnKNvsLWb47bMxFv0jB5fjncjdg/YJUvIK6ocV/XKCY6BavXzQGJqmggmScvO
 ggF1AQYHJd4ROVDmUuMTfndTKpJx6C5u9QhiUcVDbmn++LlXjRN9TuQHdwLyYKY7/gqx
 9dC5m7iFi2Qk2xX/1KVIzrAMvR5lshadorB02v6h6YRoHF/gZa5C2qDprJ8lw+I5+x4i
 dz8lHJKMDduPv6UZzq5xNYwUyugHyUf7lZ5AcFN2TFFNRW/Up0MsqimNJKPBiurSKnML
 wSoQEDg2oPhiuZF0Oga4oNY0ZSm4g6SRRiP+5vyuGO1T3Z57Ti08ffomctCRB7iqwJtk
 ZiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=31/Xmb/GU7iAEDGS1igke46kX9BYMX3fQcNNVug920w=;
 b=N2Akj0oiR0ILmTRH94FcfYuFVdLq+Ov3co1uMBex66XATxyyW/fan1WfjQ/8S9O8Qu
 6Nijw3ZdHD93yFVUEee5OnKao0FNLL5Jp927ykn44VVaWsUVBhXD5K7/hkRIMp0f/h/R
 ozuNJA77Lq4l1pmXzGjwAJ+Z5eVatR4F0CUxhkQVhsQMd6JgUxQKOArBaO14BPfGmVnX
 uG/Ho7Mx3JZYDA9GAk9gl81YZfOJA+rAerVrOqsrdZE2quyg/1E+cXQ8bf6FJGD4YbLZ
 ccPKdFVRyn1iWnRlqSls5jw5ycZF3LkGMJSaYPVzq34zf3QjEkHaZTEauS94x3Ld3e3j
 Cw1g==
X-Gm-Message-State: AHQUAua1q52+OK99SFFqXXsd0JaRZ1Mf6dJBX2zNE0tKpBV3x1HMx6Hz
 sqE8y7070VsyNxfpizMs049KjAV2
X-Google-Smtp-Source: AHgI3Iar/NvPTXaE7TKG45yIAOx2m7PYcmzOAB9XYzXSVj47bs7pFbdL2HX8NEhNxEoSpmZVSFXYYA==
X-Received: by 2002:a17:902:6b0c:: with SMTP id
 o12mr14689018plk.291.1549514508627; 
 Wed, 06 Feb 2019 20:41:48 -0800 (PST)
Received: from localhost (193-116-103-101.tpgi.com.au. [193.116.103.101])
 by smtp.gmail.com with ESMTPSA id v9sm11942730pfg.144.2019.02.06.20.41.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 20:41:48 -0800 (PST)
Date: Thu, 07 Feb 2019 14:41:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v16 19/21] powerpc/32: Remove CURRENT_THREAD_INFO and
 rename TI_CPU
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
 <20190205113219.17903-20-mpe@ellerman.id.au>
 <1549513559.eo06g2mjtn.astroid@bobo.none>
In-Reply-To: <1549513559.eo06g2mjtn.astroid@bobo.none>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1549514388.9uo0adenu4.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin's on February 7, 2019 2:27 pm:
> Michael Ellerman's on February 5, 2019 9:32 pm:
>> From: Christophe Leroy <christophe.leroy@c-s.fr>
>>=20
>> Now that thread_info is similar to task_struct, its address is in r2
>> so CURRENT_THREAD_INFO() macro is useless. This patch removes it.
>=20
> You wouldn't want to keep CURRENT_THREAD_INFO(r2) to mean get the thread=20
> info out of current, as just a no-op for documentation purpose? I don't=20
> know /32 code at all so it's up to you.

I see that I said roughly the opposite last year, if that helps to=20
determine the importance of my opinion.

Thanks,
Nick

=
