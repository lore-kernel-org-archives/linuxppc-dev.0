Return-Path: <SRS0=hK36=HL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919E6C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 01:06:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE3664E9C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 01:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE3664E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DZPpf00ZqzDvW0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 12:06:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=j5O/lJoB; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DZPln0l79zDvWB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2021 12:03:32 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id fa16so617916pjb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Feb 2021 17:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=MfcsXfncKqwyZqj9wo90IfUK1Xuq26ciFpVmdsqb4sw=;
 b=j5O/lJoB6fWuGf5SzkH1gnTYbuONd+VGpxE2jrItYctPzNsUxG8mTGMkmrLluJHy/n
 y7VeOhTqRYO5GyfJ7ssgtNKjOo7/uBC6kOplsSlMDX+JeVtMRF/6zlpOHy9N8GBkMNad
 l3DgNqaSbgzNtR2wQm5SgpzzwlTiDAe6KXxAow5huNWk74TB07u75O61RPaef8g5mwZ3
 RuazMLkeM9ZaGiRENWKve6/j0E7UCcTiXfpOAtpfed21vZ6xQsgJ6d3aeKS9QBegcIzM
 2Tug/R8gr2E/1+Y+ObF77ZS0JXhJFIlLllsIXK7F1c6KqrGXcvKRLGUbeUbMNID9Y12z
 lwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=MfcsXfncKqwyZqj9wo90IfUK1Xuq26ciFpVmdsqb4sw=;
 b=oRzFsmAhipwLaxpd2rDi5Y7Z4w6Kfpy00bkCX+mP5c7fhSvoTQq6SOHH+lxD3WGFlM
 91WUuuRISCv2N8xMppGYk9JuPEzPYugI8A/dmDvRhEC4x5YbilyUq4kCHM3mCwOD/Xk+
 8BaaxaHW7VN1yNoiJ5lNMrNqfsAlM21O25AWIEQwuoU/TImkSSyTFiV9vbpTYdj4Kfnq
 kOaW/drDdLl8Cor+6CZaFBHaEUvkDNpjFnPQ3DMcQF/IyEwIR5OI4ilQ/5v+UhPquny/
 u//7ibbvIt+kofZDa15i/8I0urdiWjANgLRhHMCzCJl6nMGIU3TJakwAKqonpweYZtYa
 HJyA==
X-Gm-Message-State: AOAM530LWHvBcLQ+NvofvGSUUxe2A1QGbtF699rk1ebV8ukBJEt4Ge0A
 tkbh4hBF4SQzDW53TYEnG8Q=
X-Google-Smtp-Source: ABdhPJxBFTNVbvcjXcaw2456OCXzobbFg3C8PqR3Wy1L83G9v50cVL32RYMQWVwFOK18iqh+ckrFRg==
X-Received: by 2002:a17:90a:da02:: with SMTP id
 e2mr1438717pjv.173.1612832608592; 
 Mon, 08 Feb 2021 17:03:28 -0800 (PST)
Received: from localhost ([220.240.226.199])
 by smtp.gmail.com with ESMTPSA id f18sm442920pjq.53.2021.02.08.17.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 17:03:27 -0800 (PST)
Date: Tue, 09 Feb 2021 11:03:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 00/22] powerpc/32: Implement C syscall entry/exit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>,
 msuchanek@suse.de, Paul Mackerras <paulus@samba.org>
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612832388.bbrfxby1h0.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> This series implements C syscall entry/exit for PPC32. It reuses
> the work already done for PPC64.
>=20
> This series is based on today's merge-test (b6f72fc05389e3fc694bf5a5fa1bb=
d33f61879e0)
>=20
> In terms on performance we have the following number of cycles on an
> 8xx running null_syscall benchmark:
> - mainline: 296 cycles
> - after patch 4: 283 cycles
> - after patch 16: 304 cycles
> - after patch 17: 348 cycles
> - at the end of the series: 320 cycles
>=20
> So in summary, we have a degradation of performance of 8% on null_syscall=
.
>=20
> I think it is not a big degradation, it is worth it.

I guess it's 13% from 283. But it's very nice to use the shared C code.

There might be a few more percent speedup in there we can find later.

Thanks,
Nick

