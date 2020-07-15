Return-Path: <SRS0=XJaO=A2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD9EC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 01:43:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF4720674
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 01:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQnQahgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF4720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B60Xd6ZkmzDqXR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 11:43:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d43;
 helo=mail-io1-xd43.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=GQnQahgR; dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B60Vl0rg5zDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 11:42:05 +1000 (AEST)
Received: by mail-io1-xd43.google.com with SMTP id v6so528451iob.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2020 18:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5w5uZZRu+2oJs4rSZNehedLTBvfBd75aOvkoRuUyex0=;
 b=GQnQahgReIKwLeGiDlyQbMv1Rqq+gjnZ57wGww8aKVSfNA1n3+sSB5Ch+SOtKi42ar
 bWOWANWKT6mz1iZgg9gsBS3dsFA19D7UCM1l1N4S+hdz/xXR3r2478p30Xg2sm5qikim
 3yxQq7kXLmX8OOzi36A33VRC0rQlL/n+HW1slDMfMobNZLkyvYdBgFcLHGJwYytI2Wbv
 gBpZd5Ix8+Lx7+9tQ+jrJmBySOQO/UHqC5Ij04yZsTYnu9d/ZGJRcWUR3wPkn5QBIrYs
 LG6oMQPbXFBR8oKQDjaRxOeJ1ulQP4Jx+n7FweV3OMTHT+xtjI+RutITvI7l5fCSXf1q
 qGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5w5uZZRu+2oJs4rSZNehedLTBvfBd75aOvkoRuUyex0=;
 b=oRnYi3fidIGqcxaC1lt93LbJ8tWz7ZWSu97aflZNCS7gG+JJVY3tx/WYgtKQykhfUN
 4NBZCFMOzSxoAkJSofgHqDyhPIhH0lWpi+wO6D7jgUFQsWd1xrCOAMqrxxyowpcB266q
 PjgqXuoVY9Pr55Jm36sd8I28lvdXQouEXzvYWp4GEBhmFkO2swOHDFt8Y3513hd6232J
 /+Wj9COzt0Dj9jW+PBuKEEdkyY2N77jsQqmIWZKFvWHltoJ97nTp11U0snSaPYTuc+Sv
 HJkMvekc8RTPmXnJ9TA4Rhuctc/8pDuGoBX8RykUZgfiCRVWoKRaLpRgi+bEwlFKNkJo
 8ikA==
X-Gm-Message-State: AOAM531ecoKfhIWpvVdUWF/T4sCKPDJkrbUn6cDnucShaPqCRMkM0J0v
 ymOby72SSpD5eexUoOfcbk9vGz+pZxf1iyJfDNw=
X-Google-Smtp-Source: ABdhPJxG2fmlinhuxeajl8bimfKX3eQsuASkqCDiyHFNrmCYf7UMWTc6MAVjapQq+Cv114Cer6RZ7zO+QSyB5BgGG0Q=
X-Received: by 2002:a6b:c410:: with SMTP id y16mr4296107ioa.75.1594777322413; 
 Tue, 14 Jul 2020 18:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200710052340.737567-1-oohall@gmail.com>
 <20200710052340.737567-9-oohall@gmail.com>
 <86273d91-6c38-6d63-4f5b-1ed0d619f465@ozlabs.ru>
In-Reply-To: <86273d91-6c38-6d63-4f5b-1ed0d619f465@ozlabs.ru>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 15 Jul 2020 11:41:51 +1000
Message-ID: <CAOSf1CGR06ZMpUAfDX7vhD7fSHG4G9oKAVFpS_vg9+f_VBZyhg@mail.gmail.com>
Subject: Re: [PATCH 08/15] powerpc/powernv/sriov: Simplify used window tracking
To: Alexey Kardashevskiy <aik@ozlabs.ru>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jul 15, 2020 at 11:34 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> On 10/07/2020 15:23, Oliver O'Halloran wrote:
> > diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> > index 0156d7d17f7d..58c97e60c3db 100644
> > --- a/arch/powerpc/platforms/powernv/pci.h
> > +++ b/arch/powerpc/platforms/powernv/pci.h
> > @@ -243,8 +243,11 @@ struct pnv_iov_data {
> >       /* Did we map the VF BARs with single-PE IODA BARs? */
> >       bool    m64_single_mode;
> >
> > -     int     (*m64_map)[PCI_SRIOV_NUM_BARS];
> > -#define IODA_INVALID_M64        (-1)
> > +     /*
> > +      * Bit mask used to track which m64 windows that we used to map the
>
>
> Language question: either "which" or "that" but both?

Uhhhh... I don't speak english
