Return-Path: <SRS0=IFvE=LU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB7C49EA5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 17:44:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4356361C39
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 17:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4356361C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GC1T53pfNz3c2v
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Jun 2021 03:44:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=TEKJ4tT2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::52c;
 helo=mail-pg1-x52c.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=TEKJ4tT2; dkim-atps=neutral
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GC1SX3yQKz307W
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jun 2021 03:43:31 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id y14so11112689pgs.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jun 2021 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5lzS3c978KWVZhp9dx/lJ7t8+OWX7BevxD99uFCYCLw=;
 b=TEKJ4tT2dwiVznc1KdZgOX7jo1ciZgIUvxxu9uZI31WHGV88slpNhl83mHcDRZgEmu
 fU+I8MOtxrqEcg3/K+I8zC1KC4e5LA/7o7wAujjLvO5HeULS+fArZ8c4YaAx6lNR778N
 cPodhq6zKDx6tCl846+hdDKKkv8Yl2w37yCMzv5fChJNm1CHecZus8FPsTAuKEeEKX0h
 z9qgDyvIJRTK+wrEkC/HMu7YXv8sWMSsFxlorTZgnzN0lhFGyYNw7vUDBjLDvifviUyy
 2v3a5/73Osk7shpGrXgeekreL4yiUkYvs0xbavtaUynL0Gnp65k/Nj4RCk4meV6Tl9KW
 3B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5lzS3c978KWVZhp9dx/lJ7t8+OWX7BevxD99uFCYCLw=;
 b=Ke3wVUUea0GfKNbY9gJWX9yufYsdD1Sb0CI6tqO9fOihPdjKgUT7AoRdVNLnyq6QkJ
 pu/42aoenKDu/O/pRuVTcx6LRtjqEBbu1Hq4p08ab3D5q9SrSmRNxFBGwT6Zoeyve/VR
 0LlzyxocsjoXBQjxUWfHvsUe4g0WktpC52D7Om0WKwE/aLqcsE68Myrg6BioUdHY4RuW
 wDwHHbCGBKLNgkMPp4ZwAtkf2ZRiiumAYsqIeQHpJjyv0fIcyCu7dWX5D2c0mQTH7HJC
 HNuA30kLpHLTjwK2+d8KmKtl0CpSEQ0Ul4hGtl2rv5dokL6jb/cVlwSpirMTpK6r5I20
 z4+Q==
X-Gm-Message-State: AOAM533GEJgiOcWp/dOkdM6O/k+DJ9Bhs1vzZXbJ1Exduwif6HSuSJ2q
 NwIKcMoIBluXtQZP63iw22snI1DXeYNCQ5IBvkSgOA==
X-Google-Smtp-Source: ABdhPJwDJWNvFeSOl/aHQkL4aR6n+XOQLuyDu1ETB1JWNzeOgPmAjuaVlFygur/FTWNpJhjikW3TvgIaSGjr9vig020=
X-Received: by 2002:a62:768c:0:b029:2ff:2002:d3d0 with SMTP id
 r134-20020a62768c0000b02902ff2002d3d0mr16409804pfc.70.1624729406065; Sat, 26
 Jun 2021 10:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210624080621.252038-1-vaibhav@linux.ibm.com>
In-Reply-To: <20210624080621.252038-1-vaibhav@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 26 Jun 2021 10:43:15 -0700
Message-ID: <CAPcyv4g7Y0AQDWq4DN2o+=iDQAuWjd0f9DCY2jR7A-=eED=dZQ@mail.gmail.com>
Subject: Re: [RESEND-PATCH v2] powerpc/papr_scm: Add support for reporting
 dirty-shutdown-count
To: Vaibhav Jain <vaibhav@linux.ibm.com>
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Santosh Sivaraj <santosh@fossix.org>,
 Ira Weiny <ira.weiny@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 24, 2021 at 1:07 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Persistent memory devices like NVDIMMs can loose cached writes in case
> something prevents flush on power-fail. Such situations are termed as
> dirty shutdown and are exposed to applications as
> last-shutdown-state (LSS) flag and a dirty-shutdown-counter(DSC) as
> described at [1]. The latter being useful in conditions where multiple
> applications want to detect a dirty shutdown event without racing with
> one another.
>
> PAPR-NVDIMMs have so far only exposed LSS style flags to indicate a
> dirty-shutdown-state. This patch further adds support for DSC via the
> "ibm,persistence-failed-count" device tree property of an NVDIMM. This
> property is a monotonic increasing 64-bit counter thats an indication
> of number of times an NVDIMM has encountered a dirty-shutdown event
> causing persistence loss.
>
> Since this value is not expected to change after system-boot hence
> papr_scm reads & caches its value during NVDIMM probe and exposes it
> as a PAPR sysfs attributed named 'dirty_shutdown' to match the name of
> similarly named NFIT sysfs attribute. Also this value is available to
> libnvdimm via PAPR_PDSM_HEALTH payload. 'struct nd_papr_pdsm_health'
> has been extended to add a new member called 'dimm_dsc' presence of
> which is indicated by the newly introduced PDSM_DIMM_DSC_VALID flag.
>
> References:
> [1] https://pmem.io/documents/Dirty_Shutdown_Handling-V1.0.pdf
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Belated:

Acked-by: Dan Williams <dan.j.williams@intel.com>

It's looking like CXL will add one of these as well. Might be time to
add a unified location when that happens and deprecate these
bus-specific locations.
