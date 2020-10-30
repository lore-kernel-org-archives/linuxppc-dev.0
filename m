Return-Path: <SRS0=J6Sm=EF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA14C00A89
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 08:31:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB79A2075E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 08:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1bDXsBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB79A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CMwWS1NcCzDqtG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 19:31:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::842;
 helo=mail-qt1-x842.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=i1bDXsBm; dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CMwTT6zCTzDqsL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2020 19:29:30 +1100 (AEDT)
Received: by mail-qt1-x842.google.com with SMTP id r8so3523096qtp.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2020 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2SmP2XG2z3yyrdfUO9SkbT5PkhpXi9KOLge2mZeMb5U=;
 b=i1bDXsBm1niQ4dkdDbmR9gg6PC1JZxcVuqDMoIU0x9yV4eCKiO7o8WT1gLVhGbua+W
 VSQZz/9X1dfTZK7P3wLdKlpscV6K9QmiH3GTCxZkVydSulOWMgGtX1r8H2KdukRelmYV
 edizOroqwJafVC6nOIPEiBOx37tjE8bEon36kr6517o7gv5RrScCd7ln8wa8xhnpGqsU
 b3auk81D2jZttt3Ztoa/HIhlJh3DakWKMdVWiXa85ZDKeLn4IAPgv7Zo/hpuTilTU9gA
 oyW+WpiGsqHa2x3pWM0/xE7mMhPGN5KP4Gb11NEJo4XszZzED+eirG1lNWhaHn4vo1Dl
 upGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2SmP2XG2z3yyrdfUO9SkbT5PkhpXi9KOLge2mZeMb5U=;
 b=RY5eQR6COGvn5rP6OWZTF2XI1LrjvVXa4wzzY1EFmzPHfHuCxCiTI0JATrwfk1teWG
 tskiwEj0Az/GsNAEwN3U1+k8p/80Q6a+agKfo0Gw1ZVYtMew7r8JYvRgHsMPytwpLYqk
 TmevMwjlPKkun09RLVRnUYckF8KTj804+nbUA44JXDCHKAA8zVzjBwvCr/CZauf5CUJR
 Xsoh+iAFYALIl3g/h1snt+0NlkTSyLxlX9+6TKE3MgdQfsNP9Ua3iElqvb16l7P+SDjt
 DXxMDRbQ69bogbMiULILleogmJjiZekKbr9+AqxtJQzE6vu4swBfY8dGmlIbSvgDrFkf
 Z2oA==
X-Gm-Message-State: AOAM5339qSeKtIGnrWBE9CT9chgxVh5++69pgech7qh+3pQP0bpbWsfC
 q+CjpEcJ5WmOBflAmi0vwYLkcCjHoa0eXDUmSY4=
X-Google-Smtp-Source: ABdhPJzkbx+wUo5qTc/A5mLSgJdG9vfP6tbrvgVQoe1Oj4ip/QKJPl/1/B4em0IUQc5bqYk4VWdgJWXeCNWIuiLyc9s=
X-Received: by 2002:aed:26e3:: with SMTP id q90mr947606qtd.121.1604046566560; 
 Fri, 30 Oct 2020 01:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <1603877930-10553-1-git-send-email-shengjiu.wang@nxp.com>
 <20201029152721.GB1901783@bogus>
In-Reply-To: <20201029152721.GB1901783@bogus>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 30 Oct 2020 16:29:15 +0800
Message-ID: <CAA+D8AOC3FSCH48p8e61W7Vz5Ri9Hhz_Hbw24cXtEp0OO2gT8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc
 for aud2htx module
To: Rob Herring <robh@kernel.org>
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 29, 2020 at 11:28 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 28 Oct 2020 17:38:49 +0800, Shengjiu Wang wrote:
> > AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> > IP module found on i.MX8MP.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > changes in v2:
> > - fix indentation issue
> > - remove nodename
> >
> >  .../bindings/sound/fsl,aud2htx.yaml           | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> >
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml: 'additionalProperties' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml: ignoring, error in schema:
> warning: no schema found in file: ./Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
>
>
> See https://patchwork.ozlabs.org/patch/1389813
>
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>

ok, will fix it.

best regards
wang shengjiu
