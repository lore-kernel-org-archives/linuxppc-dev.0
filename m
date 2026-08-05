Return-Path: <linuxppc-dev+bounces-25413-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EF7C55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 06:58:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFLpf2wvJz2xpn;
	Wed, 05 Aug 2026 16:58:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785913098;
	cv=pass; b=D4JZ6f8puh4tO4CE6lKIF8PlKiZluzVefTAfIwrt5tUQU7RtQzlceDLCtYB3sg+//QIRua+vsMB4ORSa6DYT3o+Ygnq3kMntOQ/BlC5TnnJw3MYdmqQZf0Z7GvOWiXx4SEHFE5njgbRiwojm0SqwuudllfhOz7u/103UfxMiI3LXYkISzdaRkCvYAwUVrHJhhLwshd4zjhPFMlZfA2U8ab1jWNa1A6ppnv1UORSD39TQbAAQjbKcHYNpbHqkTYwjiOk7fkhoSgnAjQTS+7utyE8BTF/mwCKlcSgVaQWZDi9G7p/jhP075HrPoblUCvPNVcADNGLSAFlMqOJShxRrnw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785913098; c=relaxed/relaxed;
	bh=DS3y93XU+UV4dALPduKnv8HEZ3Qoa8U7PDzyKjP+lKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVzXPy/jLTNqBtkVLO99mSCX/AWEvNcKWV5xsdEHqpftNhAGcO+XM4rZGcmBgpx1Npye0KaU5uZnuYqGhn526DnEIi0SHSNI3isCH0zb02EgvDI9nvJ+G8gzwQwKT5hmmNFQzNMb2W7/9/zuVttXZxB1Hz9/Q5JiRKM1euiGul4GqwGaQGdZxOqzKMpvN8rf7i+2fzAYUatRL7xr33HrzSA+mUn0cQJwTwAQ+u7X/XGpvJu1aAV8dqLDteA8Hgiut3Zl/njw/lYYRr3bCHYCKlBGsFHhlEeKc4EwfkE0rzI4VYuXC7qv7xFVDsmFQI1bV5rVvFIlGwo3868aOXhdzQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UdJ72+aX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UdJ72+aX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFLpd2RzFz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 16:58:16 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2caea3f742bso10173225ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 23:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785913093; cv=none;
        d=google.com; s=arc-20260327;
        b=cD6oVZwxKL/3ruCIWda3s7dnhdQ9x/lS7M4O+e+7Gluh/Nfa1qjY8JgErBQ1HDFWgH
         gTBF9MDJAEE6eK/CfcV/GnFYTt3C6jK2cN9CAl5xIQkhL+dQSvKxMqswbO0fAWXyZlNb
         n5L9q6JPxUtWY9lw/azgEdkk+QHVrs1uIRLv9OfzlWSM+oIBo/w/V/+P+4kIx4JdrC6p
         pyjilEFl+N74jxPFInzshNYemqoi6gOfHTC0Osp45vqgQgcNQuqH9eBFWvWkU14tltVG
         DwxIEZYeoNaDEOw0W3upu9ePOvNzfO76SSg/NCRAVwWdl9EP0+ocfZ1UHtqQvupdK3Qx
         dToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DS3y93XU+UV4dALPduKnv8HEZ3Qoa8U7PDzyKjP+lKM=;
        fh=VWESqtiZjG/CNkOwZsxyEZj5siSayCZD6fJIgndA3TY=;
        b=VQOIJ4wMtsxYNZNmXuR2Kb+dolkABcnmbaCpA3/+4qOlK2OODLVDlPQafTYlQwckHn
         qMFfB8N6LkvI5my5RB95IqpiX6LoZgNNYIETsBplROJBrl0oQzN//7cf2UTYqFszfVgS
         RlBBjMGtmfoRFPZh9HIpyZbtxkgUqbAAyoq1wauW64kcpsWj9IPRFcKYUmZS/CLTokRw
         OVJLkLHnsraIegPVtG/9b/H5oLceCJpH2UKBWfRA5tNw1ym4nibTOdGcON0lTlsd3LLb
         2wASyTUm0HCPCc46eIrxLhIktLec2VbDtgxh/XwhTpTY+zcBMSC00ZSztaFPFIkkXnjy
         gGEg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785913093; x=1786517893; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DS3y93XU+UV4dALPduKnv8HEZ3Qoa8U7PDzyKjP+lKM=;
        b=UdJ72+aX5sMOhOn2X77bFdepZaliXrGA8tVrpKP1sjMPIaDwYL9gW45j1r/B1OhFTE
         s40NwZFgjmaVAaHH4VH1S1k4Obj4O/K1sa5CYkE+MPgqJumh1gjU/33WykvA1bAV+jGw
         ZQENYcQE0HZ2OBVLFZ+Oty2u/Kyxj7qcJpSSjl73FM60SA1dOx/POUjAKVbM8SaErSm2
         POjTYPqksPECoDB3EJ+ar6syqEh0XfTjROmHGWAI4TGxcsGGSbkyCXIIu+em4IY/j++7
         xG3iKVph+AD2JUPCiM8vHVtEeeH/ybks959TrVHs62F5xhIf6PQYpFovzGcrMtJi5D0C
         jdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785913093; x=1786517893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DS3y93XU+UV4dALPduKnv8HEZ3Qoa8U7PDzyKjP+lKM=;
        b=T4VfuBzdnXL2R2RNUuD4cxNq8Ky2cx+rtk4xJ4k9LdXfPX5V/uy06efBamZVC8KtsB
         SZc66blb0suHsjvqERkOgtZPgtJjxjDCqyu6lN8XTmudoJEoXtO4iwLtCKKOJ/Cy68GI
         6r9xzQkVBftFqjQ2dAo2GQkOG14FafZMIr/vF2jNFHo2jz4xuer47Hy4Urub35W9M9MH
         5zMsXNCWCD6rdQAaVXAZJhz3ZAABc4dtYsX267qz2SJLbMmINuNbXC8YyqlgXXEtZvX3
         ayummODwxQNSlwzJ7/mpd0GBNLPYkOF8pOzXOves4JpgihOv4DbopheVpG2K2Gx14Sta
         /Mqw==
X-Forwarded-Encrypted: i=1; AHgh+RpYjFD8r3w0xk5u78vmgoqRpGSQzopDhTkqL840Jt0j3nM/pxfMQ+qsBzbl51TL0bPtbRiNUdZgxaaRSPM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywpjs0WBGujBbSsPnArcfve71OWgTpEl3b/Gfq5Vu1z88i0qo3V
	n6xRj0LktqJLpmoHov/jMnNm0RnpOQVFSR3thM8nNl57areZBJ1dg98EMKDNOY1snsfnXlGJV/B
	N4ThnZ+cPIlv66RaoUac3hWRLT07nPMI=
X-Gm-Gg: AR+sD13Z37H6VZs8KoR+czOoii14Pmuv0l7qgAovGVpy1lr8PeYmabreS/Igpylv5N2
	4uF0d6nboTGDNwhdgaYr4jAPK230RHfKtUmA3sy88yrYi0jX03whVGtqnYlfWKRQNz81SBzVgIu
	ZPQVBk5o3l1LNYo2+rVv2L9L2Y8CFFRzbbA8HUe0cvyssJrR8pJAr3VTlvVvjN/xwl4TPue+n6g
	RSFb3zImahogEcDRbHWP1oJLvRR0FUI/7Gso54/ZEmn2A2dA6+2cpb71QOJXrE3BK3raLZr6qkJ
	j9U2h68hPwk2PcEqxCpa/ZRx1asv63Kebs3yOjV/iEH2
X-Received: by 2002:a05:6a21:3a48:b0:3b4:61f:1fec with SMTP id
 adf61e73a8af0-3cb85df12ddmr5759243637.2.1785913093306; Tue, 04 Aug 2026
 23:58:13 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com> <anH5i7y3JkB1moee@SMW015318>
In-Reply-To: <anH5i7y3JkB1moee@SMW015318>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 5 Aug 2026 14:57:59 +0800
X-Gm-Features: AUfX_mxtqJzMX_WVEhniuKHoKxDYIHB5iQVu-6lJu_NKLxZB1goSegJJZEResBc
Message-ID: <CAA+D8ANCoc5qOUvTQPRNkvrfqAY3n6x_fbfUveP8Sfv+SL1NVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
To: Frank Li <Frank.li@oss.nxp.com>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	shawnguo@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
	perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, 
	Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 10:39=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Tue, Aug 04, 2026 at 06:02:14PM +0800, shengjiu.wang@oss.nxp.com wrote=
:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
> > The existing binding exposed only a single generic audio-graph port,
> > which cannot represent independent conversion paths when multiple pairs
> > are in use simultaneously.
> >
> > Add a ports container that enumerates up to three sub-ports, each
> > representing an independent conversion path:
> >   port@0 -- conversion path 0
> >   port@1 -- conversion path 1
> >   port@2 -- conversion path 2
> >
> > Each sub-port references audio-graph-port.yaml as before. Hardware pair=
s
> > are allocated dynamically at stream open time; each active stream
> > direction (playback or capture) on a port consumes one hardware pair.
> >
> > For backwards compatibility, keep the old single port property but mark
> > it deprecated. A schema constraint (not: required: [port, ports]) ensur=
es
> > that both forms cannot be used at the same time. The binding example is
> > updated to show the preferred ports form.
> >
> > No existing upstream DTS file for fsl,imx-asrc uses the previously
> > documented single 'port' node, so this change does not break any
> > in-tree device tree.
>
> if no existing upstream DTS file use it, you can direct replace with port=
s

That is to avoid any downstream use of the 'port', so not directly replace =
it.

best regards
Shengjiu Wang

>
> Frank
>
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../bindings/sound/fsl,imx-asrc.yaml          | 45 ++++++++++++++++---
> >  1 file changed, 40 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml =
b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> > index 608defc93c1e..67d2826eef3f 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> > @@ -78,9 +78,19 @@ properties:
> >    power-domains:
> >      maxItems: 1
> >
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    patternProperties:
> > +      "^port@[0-2]$":
> > +        $ref: audio-graph-port.yaml#
> > +        unevaluatedProperties: false
> > +        description: port for an independent conversion path
> > +
> >    port:
> >      $ref: audio-graph-port.yaml#
> >      unevaluatedProperties: false
> > +    deprecated: true
> > +    description: deprecated, use ports instead
> >
> >    fsl,asrc-rate:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> > @@ -125,6 +135,10 @@ required:
> >    - fsl,asrc-width
> >
> >  allOf:
> > +  - not:
> > +      required:
> > +        - port
> > +        - ports
> >    - $ref: dai-common.yaml#
> >    - if:
> >        properties:
> > @@ -180,11 +194,32 @@ examples:
> >          fsl,asrc-rate =3D <48000>;
> >          fsl,asrc-width =3D <16>;
> >
> > -        port {
> > -            playback-only;
> > +        ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            port@0 {
> > +                reg =3D <0>;
> > +                playback-only;
> > +                endpoint {
> > +                    remote-endpoint =3D <&fe00_ep>;
> > +                };
> > +            };
> > +
> > +            port@1 {
> > +                reg =3D <1>;
> > +                capture-only;
> > +                endpoint {
> > +                    remote-endpoint =3D <&fe01_ep>;
> > +                };
> > +            };
> >
> > -            asrc_endpoint: endpoint {
> > -                remote-endpoint =3D <&fe00_ep>;
> > +            port@2 {
> > +                reg =3D <2>;
> > +                capture-only;
> > +                endpoint {
> > +                    remote-endpoint =3D <&fe02_ep>;
> > +                };
> >              };
> > -       };
> > +        };
> >      };
> > --
> > 2.34.1
> >
> >

