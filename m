Return-Path: <SRS0=KnCP=Z2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA403C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 08:31:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D693206DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 08:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvBjg1YJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D693206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47SX9t5SHBzDqBN
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 19:30:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::844;
 helo=mail-qt1-x844.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gvBjg1YJ"; 
 dkim-atps=neutral
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47SX745ws4zDqSn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2019 19:28:32 +1100 (AEDT)
Received: by mail-qt1-x844.google.com with SMTP id 38so6846520qtb.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Dec 2019 00:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uCZKNDAWGqV6WX7WGX2zLuCaauh33mKw/9lBmVTJ0ho=;
 b=gvBjg1YJe/IrgjhMS9JhufqyINkwEbIy+RWFYHR8NZAu2kCC5HDcADIa9KOonJVUMh
 x7npQ2M1Gwtzb01zbPcFN1d4+1KPuGhN7931x+ADgxvT34FpDGlSRmRTWzKDgOgXXFZE
 yW4H9qRNanJnl1JyGi5SuSKkGCbT/3MFLiuLhzleGytWEbahqN2qHO/Ttikp4/rhPLVX
 MFgI2W3MZsQ8Bg2XD/YSh30Yl3ktzvucbKdheQMnZDcOiwr4GddhWIHvVnsENi0TGRXD
 6UV8U7GFZdjRzKAjddqxcWGaxBxUQ+rTHYcacIHRLMig57fygCtyIb8nGXoTTddswSIW
 Fp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uCZKNDAWGqV6WX7WGX2zLuCaauh33mKw/9lBmVTJ0ho=;
 b=Gv/tN+P1zsDkPMHC/BZ64bUkvTTtFJdLmv86PH+HhieDY2Tk4jblv+8f5PFPpNq1cr
 BMMt7Q38g0aQgr+p1awSQBfaF+1XHjnOL0KnQ353SoDs0hlxXZr/Y0bwyLgde67S6t3j
 qzPtMprCDrjT7tAy6TOnpJ0hm+t2clcg0vEL1t2VmcIwS1V4JgAbbpX4Ptq+2xv3C31i
 v/VdqH6qZIIHqI+7qP/lXPdMJwqzrjPlnq5x0jnexRYr3dN8AOb+fbxCsEbDZ//JoETb
 QuFCJEoBUpxxMeXyIKTRrQI27Y8qYouU42/yg7aTJCuH+bxyFLSrJ6t6WCDlALoYgRef
 Puiw==
X-Gm-Message-State: APjAAAVS31jAkA6mb3lMZEnqzF67SJdqbN2PI4/3TAmHJHzl+Rin8qJ5
 tUbveEbY4at/OQqgl0axZKZeUqAjT74DZc7HRp8=
X-Google-Smtp-Source: APXvYqy42lrbvBO0PxmylNsnUOfkNboxvBZlj0DuNVhD+5LgfpHEOmahKkd9pLCkOj8ycJdUS1RZFPe6vl3a7cNcC9M=
X-Received: by 2002:ac8:7652:: with SMTP id i18mr1580423qtr.292.1575448108482; 
 Wed, 04 Dec 2019 00:28:28 -0800 (PST)
MIME-Version: 1.0
References: <45ef9ee8c6265743a9c30d8e4d9dcbac1ee3aabe.1575286886.git.shengjiu.wang@nxp.com>
 <CAOMZO5AXnw7QDdfKkZ+FBwuWWvr+t0rRsHQ4muW-T00he2f73Q@mail.gmail.com>
In-Reply-To: <CAOMZO5AXnw7QDdfKkZ+FBwuWWvr+t0rRsHQ4muW-T00he2f73Q@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 4 Dec 2019 16:28:17 +0800
Message-ID: <CAA+D8AN-UrAyixp+cOw3h=V7xLfCNQRB0XDhxCeYAmnZo9UWBw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v4 1/2] ASoC: dt-bindings: fsl_asrc: add
 compatible string for imx8qm & imx8qxp
To: Fabio Estevam <festevam@gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi

On Mon, Dec 2, 2019 at 8:58 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Mon, Dec 2, 2019 at 8:56 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> > -  - compatible         : Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
> > +  - compatible         : Contains "fsl,imx35-asrc", "fsl,imx53-asrc",
> > +                         "fsl,imx8qm-asrc", "fsl,imx8qxp-asrc"
>
> You missed the word "or" as in the original binding.

will update it in v5.

Best regards
Wang Shengjiu
