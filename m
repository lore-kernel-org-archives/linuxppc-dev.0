Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98453C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 17:46:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D3D2173C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 17:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D3D2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4485p65pFqzDq5W
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 04:46:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4485lt5bSqzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 04:44:10 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id j135so11039978oib.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 09:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z1OS+Lzpj3DeHAi3lqfkSXwSW4LD8wDRWAjP9wzKHak=;
 b=OLENk2JTKMdPOOI8AvvVR3zCF1gm9ekHlsHiLSlGHOUxGHr0rd+4P0l3K8Uvwff2is
 Fxa7ORANKp3vSWnmhAdnqx+MoohbGMArYrQsFvyDqXgi44iUyirvw0n7SJVgi+jQVOPE
 +BqTPzKskjm2qWr+3zMJCjxHdANMSHNdUxZmjsPL4SGVFJptJFm0qU+FKZRMOtC8UOEg
 mZuZU/SoV9I6vfONt4jlHYXBzCGpx4EO/a6Hl6xQHNzOn+tW79SuG48O8d5W2zqOUbCu
 A2rf6KSJGOP1xlEbsZrVMul479qrGIo3Gj6//ZhHfl+Tv6WVsVU2uLtxbrn+co3B6B9v
 8n8w==
X-Gm-Message-State: AHQUAuaw2y+Djx8s8Y5uLkUmPcEkPSZZRE6EZ2POILPh5G/Fd0YsS5VO
 V3Ibw5Tr/0lRZzWjOwBLI8uaJkvE
X-Google-Smtp-Source: AHgI3IZT071BLik3XREZdNEaucJoZxvmx1wcV9KzUJ/MF+VpA/fsmGS+nE08P9ZCyvbVY1U+nePV9g==
X-Received: by 2002:aca:5dc6:: with SMTP id r189mr3143505oib.132.1551203047474; 
 Tue, 26 Feb 2019 09:44:07 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com.
 [209.85.210.51])
 by smtp.gmail.com with ESMTPSA id o205sm558759oia.53.2019.02.26.09.44.06
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 09:44:06 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id b3so11823134otp.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 09:44:06 -0800 (PST)
X-Received: by 2002:a9d:4708:: with SMTP id a8mr15251874otf.51.1551203046342; 
 Tue, 26 Feb 2019 09:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20190221103731.28978-1-horia.geanta@nxp.com>
 <VI1PR0401MB2237C56CD38D546E83218C8FF87F0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB2237C56CD38D546E83218C8FF87F0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 26 Feb 2019 11:43:55 -0600
X-Gmail-Original-Message-ID: <CADRPPNSPpYdvCqDh+m0J7VtuRsYx-nP6_20JvPrb1yt93gmPxQ@mail.gmail.com>
Message-ID: <CADRPPNSPpYdvCqDh+m0J7VtuRsYx-nP6_20JvPrb1yt93gmPxQ@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: guts: make fsl_guts_get_svr() static
To: "Y.b. Lu" <yangbo.lu@nxp.com>
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Horia Geanta <horia.geanta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 22, 2019 at 2:09 AM Y.b. Lu <yangbo.lu@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Horia Geant=C4=83 <horia.geanta@nxp.com>
> > Sent: Thursday, February 21, 2019 6:38 PM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: Y.b. Lu <yangbo.lu@nxp.com>; linuxppc-dev@lists.ozlabs.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] soc: fsl: guts: make fsl_guts_get_svr() static
> >
> > The export of fsl_guts_get_svr() is a left-over, it's currently used on=
ly internally
> > and users needing SoC information should use the generic soc_device
> > infrastructure.
> >
>
> [Y.b. Lu] Acked-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next.  Thanks.

>
> > Signed-off-by: Horia Geant=C4=83 <horia.geanta@nxp.com>
> > ---
> >  drivers/soc/fsl/guts.c   | 3 +--
> >  include/linux/fsl/guts.h | 2 --
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c index
> > 4f9655087bd7..63f6df86f9e5 100644
> > --- a/drivers/soc/fsl/guts.c
> > +++ b/drivers/soc/fsl/guts.c
> > @@ -115,7 +115,7 @@ static const struct fsl_soc_die_attr
> > *fsl_soc_die_match(
> >       return NULL;
> >  }
> >
> > -u32 fsl_guts_get_svr(void)
> > +static u32 fsl_guts_get_svr(void)
> >  {
> >       u32 svr =3D 0;
> >
> > @@ -129,7 +129,6 @@ u32 fsl_guts_get_svr(void)
> >
> >       return svr;
> >  }
> > -EXPORT_SYMBOL(fsl_guts_get_svr);
> >
> >  static int fsl_guts_probe(struct platform_device *pdev)  { diff --git
> > a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h index
> > 941b11811f85..1fc0edd71c52 100644
> > --- a/include/linux/fsl/guts.h
> > +++ b/include/linux/fsl/guts.h
> > @@ -135,8 +135,6 @@ struct ccsr_guts {
> >       u32     srds2cr1;       /* 0x.0f44 - SerDes2 Control Register 0 *=
/
> >  } __attribute__ ((packed));
> >
> > -u32 fsl_guts_get_svr(void);
> > -
> >  /* Alternate function signal multiplex control */  #define
> > MPC85xx_PMUXCR_QE(x) (0x8000 >> (x))
> >
> > --
> > 2.16.2
>
