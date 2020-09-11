Return-Path: <SRS0=VWG1=CU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CE6C433E2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 06:34:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B50B221EB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 06:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8Xtd3J3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B50B221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BnmFQ3HxLzDqrM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 16:34:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d44;
 helo=mail-io1-xd44.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=X8Xtd3J3; dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BnmCC0DlBzDqg7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2020 16:32:37 +1000 (AEST)
Received: by mail-io1-xd44.google.com with SMTP id j2so9875942ioj.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2020 23:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=84XSEIKLN0MTKHx/TdQ9w/7g8A73RhP8y25/X2uVtPo=;
 b=X8Xtd3J3HyMEEwFsQvycrVUlGuGOblWxdcOJZRNSA11yCCYMze7xIXZ5XtrpV/nanO
 XDmUuhYnvXi1cNa2oVE98owf6Og0OY7+KGuFNJ0JDR6hs2jaMuFqAH/O0o72s0FP8FIM
 /gyHjOx76+6CtVROf4SDnSfXZ5OHrQKMdjI3k2i1lZIDodUPRm4gDhq+jUAU8h0BXi5H
 NpjUPo2SEqAY0E2TrFy9ulH+IdGfvudZjEOqdTQIYKbAYAzm5MRLisH17Z4e0F68+7g9
 +PZOkexodFuGxYEaEo+NwKuCSmViRHbJ84LQeA60Ldrpf+dnakmWp7tR3w9MHEaFAGSR
 n0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=84XSEIKLN0MTKHx/TdQ9w/7g8A73RhP8y25/X2uVtPo=;
 b=AUkHTGAsDkn6jDNZ+cGIKZ5J4fBvRgB6aMyLDZF0ZvKpy6fgwnuqPLXpsT/Edk6RjN
 /xGpy8crdv6WuFsXCcTlOmPuEZQcA+vsYEBpgrYAEEp7z9pDaEiWpvEMzx/6SNuIe2iW
 z2BCjHMFH+PvJFBNjTwbSjuEqCn6vMyXoF6lODVpXVhSC5bK91NF7xOBpzS/i0iWLnuF
 iefp1VurTIui5dZXlNMHjLUQPU0z7XkI9me44khYxezPd3FaRzqrxE9q7mM2o/1RuEsJ
 LWt9SdNS60HdzCqy2RgehxUt6w+yXpp8De6Uu0H+iL2tuQJTLHo9vulMLUGJLtgSUVuH
 2YJQ==
X-Gm-Message-State: AOAM531DZdjgSyf9zLn6B+t3+0hQ5fniTqlVs+Ca9tk/rlqezxCbbRY6
 SyHqeh0918I4h2qEK+x/rGA1X/k0OtCcuZYdJ20=
X-Google-Smtp-Source: ABdhPJxNJcICsUzFpeglOU9c+3f+WN3URF62m2C35Jlf2b4TFiQ3cY2mxRuaL9Rk6MdB4TNwnn8b0fBDpDH1yIeSDLc=
X-Received: by 2002:a6b:6b06:: with SMTP id g6mr611931ioc.87.1599805954504;
 Thu, 10 Sep 2020 23:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200910210250.1962595-1-clg@kaod.org>
 <20200910210250.1962595-6-clg@kaod.org>
In-Reply-To: <20200910210250.1962595-6-clg@kaod.org>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Fri, 11 Sep 2020 16:32:23 +1000
Message-ID: <CAOSf1CHg1oTK=Q__mYyLtEn7cvU_yKLtWWwy2Zq3sywk_=xV2A@mail.gmail.com>
Subject: Re: [PATCH 5/7] powerpc/powernv/pci: Fix W=1 compile warning
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 11, 2020 at 7:02 AM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
>   CC      arch/powerpc/platforms/powernv/pci-ioda.o
> ../arch/powerpc/platforms/powernv/pci-ioda.c: In function =E2=80=98pnv_io=
da_configure_pe=E2=80=99:
> ../arch/powerpc/platforms/powernv/pci-ioda.c:897:18: error: variable =E2=
=80=98parent=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
>   struct pci_dev *parent;
>                   ^~~~~~
>
> Cc: Oliver O'Halloran <oohall@gmail.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Come to think of it a fix for this might already be in -next, see
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D193967&sta=
te=3D*

If not,

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
