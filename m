Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E706AC282C4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:15:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA99218D3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOphQDJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA99218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w4j0243kzDqP2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 15:15:00 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w4gK5BgBzDq99
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:13:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YOphQDJB"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43w4gK4B0Cz8tRw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:13:33 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43w4gK3nKnz9sMM; Thu,  7 Feb 2019 15:13:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YOphQDJB"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43w4gJ5jQ8z9sLw
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 15:13:32 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id s198so3946700pgs.2
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2019 20:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=dRRf6zV6aw3QOzVxN82hiIifYFw52JzOGckGDPnpV0o=;
 b=YOphQDJBX2/SvqtOUUOI1pzA1w5ZX8iP1WlIYlrceKsV4jA7qzo/jX/Igc08/ZcGjU
 URqO2np4WGMmJ2X19OrA13/4fIzTbijT9YZsE15jLS7c73WLacb+CKYLAVpF0z3EFFYq
 notOShUwiQufnh1h1d3bR8kBLE/OAtlvYeWZM0cl+gYJ9Y93hikZ6xba6xzqsRQAsS/R
 /OZ6z+rKjJIUzqA8vYiVeqfxc6vRPrPIkvlVLiMm8UrR2KWmdLkSnuCZU5hrAUKP9Xoi
 vqGi0j2lKfZ/hkaIhk+nBczyFxbqBFRqrvoI+s4pCE1ZjoEcrYDJBdCBXauOvjMZ8UPm
 u+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=dRRf6zV6aw3QOzVxN82hiIifYFw52JzOGckGDPnpV0o=;
 b=O5Jp8MI/4qBK8+uMg9TqQKXccBj7nmfCj495/YCWeN9hnclgeoHg+30ZjW4N3K4vkn
 eAEZJM1m67An8YuUoCbNnXJU7W/BWynRyWU9VtJnzrTR4qRzpwKkbFJpaP2n1G6mOZk3
 O25eSEME2zz9QUGns626jv2ODabmg3G6AXxefR104dxBTPY6rzTfqYBWEa/z+twAKUtd
 TP+59zax+HA8xc/s6xDFUOqHdzLeIRY1kaUMogNeESWLSxiQpd6Ew1rh5Z4hoDTyOg+/
 HHlLMBXxEcJ+rJQ1FzbN2Cmj/R7Fq4abWdd7xGYSPDSPiTjzWFNFPx4sb8QpIZ6Bq2EK
 18Vg==
X-Gm-Message-State: AHQUAuap3Gay3j6CP5UfNgqNGULceCQRY0lxeH3xdUMUubMfwQGVJDNI
 DjT+r/gYwAuAdbecmyPKLbs4zB4maWE=
X-Google-Smtp-Source: AHgI3IbA06sDsWBVIN6v9bz9dQF1MWe9QGsGU3QwCCEQU9cgywieCMSDHP+DM/TRoDkb1mOEwQ8SXA==
X-Received: by 2002:a63:bd51:: with SMTP id d17mr13108821pgp.443.1549512810992; 
 Wed, 06 Feb 2019 20:13:30 -0800 (PST)
Received: from localhost (193-116-103-101.tpgi.com.au. [193.116.103.101])
 by smtp.gmail.com with ESMTPSA id m20sm9146687pgv.93.2019.02.06.20.13.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 20:13:30 -0800 (PST)
Date: Thu, 07 Feb 2019 14:13:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v16 14/21] powerpc: Use task_stack_page() in
 current_pt_regs()
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
 <20190205113219.17903-15-mpe@ellerman.id.au>
In-Reply-To: <20190205113219.17903-15-mpe@ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1549512740.q2u07l17nn.astroid@bobo.none>
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

Michael Ellerman's on February 5, 2019 9:32 pm:
> From: Christophe Leroy <christophe.leroy@c-s.fr>
>=20
> Change current_pt_regs() to use task_stack_page() rather than
> current_thread_info() so that it keeps working once we enable
> THREAD_INFO_IN_TASK.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> [mpe: Split out of large patch]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

=
