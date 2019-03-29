Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AD9C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 21:52:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A94421773
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 21:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A94421773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WFp70YBNzDqKL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 08:52:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WFly721hzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 08:50:38 +1100 (AEDT)
Received: by mail-oi1-f194.google.com with SMTP id 3so2849595oir.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 14:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rs7S2foonqwWEFVwaHGYfcLOLiZaazzWH2lQCi+hjMA=;
 b=po5U2DgSM702oLmPS4vmD2Z3Whm+pjRYVEiu2TyiT8hjnUbEE9qr/7EEpx+PWsyZys
 Mq5AKdjjn1fZujwFF4elpkjjcHhU5cE6asNSeyc0wByLHni5AAa2SRvWtf8GFoY1TzZK
 jEZPDp9T4m4oc3MDqSKK5Jgz4mtEI954v3vCEfxyPGKLDBUySsQIl79yQCRPLdEa9DBo
 dCEwkPkU5M+iW+BQnItRVdS03n+pT43yQczgP3txsIu5iEFQRqeBL/sj8J2I1eyDQL4Q
 Ag1R0V1vNpe+PPpj9gi9pkyzWSOAsUTMbZr1ZahSGy8D0SMV+3tzaRYyrw2PELPcr1ml
 TLbQ==
X-Gm-Message-State: APjAAAVg9DaPPIAGAVO95oDy58MuGVx48uhJt2mEh5EM8ZvddxSjs4AT
 Vkxxq3Oho03eZEO5TsZJwDmQIrWyoQo=
X-Google-Smtp-Source: APXvYqx7du6KySI+ozM2w+LZskDtOVAPDVHA8uNyzEyuwcpPtkRshNSPbcL6lR41/+eifhqFKBubuQ==
X-Received: by 2002:a54:4390:: with SMTP id u16mr5246170oiv.32.1553896235374; 
 Fri, 29 Mar 2019 14:50:35 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com.
 [209.85.210.52])
 by smtp.gmail.com with ESMTPSA id j14sm1338364oih.28.2019.03.29.14.50.34
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Mar 2019 14:50:34 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id k21so3509266otf.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 14:50:34 -0700 (PDT)
X-Received: by 2002:a9d:6d92:: with SMTP id x18mr20780140otp.112.1553896234713; 
 Fri, 29 Mar 2019 14:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-2-laurentiu.tudor@nxp.com>
In-Reply-To: <20190329140014.8126-2-laurentiu.tudor@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 29 Mar 2019 16:50:23 -0500
X-Gmail-Original-Message-ID: <CADRPPNQ9AGRvq8XDjeTerUBry+_hO-U=shCXFaqHhtc9QvMvng@mail.gmail.com>
Message-ID: <CADRPPNQ9AGRvq8XDjeTerUBry+_hO-U=shCXFaqHhtc9QvMvng@mail.gmail.com>
Subject: Re: [PATCH 01/13] soc/fsl/qman: fixup liodns only on ppc targets
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
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
Cc: madalin.bucur@nxp.com, Netdev <netdev@vger.kernel.org>,
 Roy Pledge <roy.pledge@nxp.com>, lkml <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, camelia.groza@nxp.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 29, 2019 at 9:01 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> ARM SoCs use SMMU so the liodn fixup done in the qman driver is no
> longer making sense and it also breaks the ICID settings inherited
> from u-boot. Do the fixups only for PPC targets.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/soc/fsl/qbman/qman_ccsr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index 109b38de3176..12e414ca3b03 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -598,6 +598,7 @@ static int qman_init_ccsr(struct device *dev)
>  #define LIO_CFG_LIODN_MASK 0x0fff0000
>  void qman_liodn_fixup(u16 channel)
>  {
> +#ifdef CONFIG_PPC
>         static int done;
>         static u32 liodn_offset;
>         u32 before, after;
> @@ -617,6 +618,7 @@ void qman_liodn_fixup(u16 channel)
>                 qm_ccsr_out(REG_REV3_QCSP_LIO_CFG(idx), after);
>         else
>                 qm_ccsr_out(REG_QCSP_LIO_CFG(idx), after);
> +#endif

According to the Linux coding style recommendation, it would be better
to put the #ifdef into the header files
"drivers/soc/fsl/qbman/qman_priv.h".  And I'm not sure if this is
needed on PPC when IOMMU(PAMU) driver is not compiled, if not,
probably using CONFIG_PAMU as condition would be even better.

>  }
>
>  #define IO_CFG_SDEST_MASK 0x00ff0000
> --
> 2.17.1
>
