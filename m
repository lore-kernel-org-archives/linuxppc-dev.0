Return-Path: <linuxppc-dev+bounces-25339-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36639C5518F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:29:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDmtT0HVTz2yMl;
	Tue, 04 Aug 2026 18:29:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::42a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785832176;
	cv=pass; b=OGYwZmjM4zSesMweIDHcWanV7jYc7pssaB07thyy1wDVOelGo02QexftEyCO5+7ypO9A4kgcwl36T0J16T9hO8XGAxto2OU6addYeHKqx7vNfv8wv/cw9E0jSNZR5UE8iJd4ZbtxrmxzG8EPHut5tXIjM4hzsi2fru4wTe+FDdv5mdf3cX4s7ojHOpeQ+vQcNiHp5k4XMbb0SqNfJ45ojaVVXIo/qLEs16uDcGyIl8PRoRMZIhwwZquXzqq6l7CjTh0JOOux2QJyF3HA18tTF49U7b7YxRpDreKYwxWCQ9X9WiygVkOKUTtpm02S45NpdctPasHV3r8zHjx12RYl7g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785832176; c=relaxed/relaxed;
	bh=KkuWY5Hua0QRTwIBGaEIrRJQVtnuHK0Pb4GBlrZuFaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhKGtilCXPlHpra5J1+2oLCYXTneedaJ1M4hV2L0VjdXwwAgOncIJuAnarMcYrV/+CZyJ1W9FLlLsCI1F4VU3MqfaRozUh6rvzxEUHMRoL4dMD1UWqfNfADF7/X+Kjzx9W/4S0KC4YaFBZDmGLjF4uxlI0hsSI3PBbtwyAlCT896zbq6jtbSxakpoNsiGjwSrhCHiWTbp1ZIlkrKuEvLxCny/thmNEjGfC9Q3jMpiUIuyTfmBxuwuReQIH6jgMD4PEe2Kj5dqlBBCx4DYhmcs/+szmOHWvlpsWt+8qPZCODb7IbfWrRhowDxqU8NYmepY7RStSYkbA0l2O99S4G+8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DoErG81D; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DoErG81D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDmtR2Zs6z2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 18:29:34 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-8485b358552so4458163b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 01:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785832172; cv=none;
        d=google.com; s=arc-20260327;
        b=EEVXhEPjWMZxxCS4cYBjmklL979Hv7p1tzI5WyRiCoT+oKfOsNlktCEtZ4RD0N8DPp
         UZgq8akSxQCAlj/2t35MW+zbVBBO2d453NGEpreK9Tq7/jhY+uKOO/1lTbHVssfreBqH
         LUbWJyqLNjUr6fgL3oNse1ai7X3U9iwrkP3+YAZ/tykWCPQJCz+R4EEVK/4ATYilghHT
         6+4+hD6z7xn1POcIjSYZWxTwGVbEq8QJqDGpXU2wd4c9mWfK1ktey7GvcyT7wj3Wm6Ph
         RP4gLzU4y/N3RePIq/9qYG7U+fWtE31AdrGJhvSFLz0vSgFi8cBqWDEes7JAdP1rY5gb
         xiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KkuWY5Hua0QRTwIBGaEIrRJQVtnuHK0Pb4GBlrZuFaQ=;
        fh=qYty2zov8agttLmuM/h8YgvLpAhYc7psuAwzM89cHhA=;
        b=d0mE83qeP4Bv7ocQAAilXXMPEyaAclabpVgElnAWHqqy0TxDeFFjLs8F/t4snFI2sH
         rs23HHQIYNNHXHxYQ2gWUGCX0D2ygui/zRiIA7Ny+u7JNfXOCrFW0te3JSGi9v75yeQa
         +TnN/0duI/StymmLq3Ze15lW2uceHEellpIGesnmdl9HHdY2IIcXoBdTc1d3+myaMkoK
         AliAMs1R7UsOcGVtVhnS5a2B5uFLDIzJa2Dg+faE/BzXK16qgMrNJ6+ATRaKixR3Z0m9
         jtkEWWKKhN3CLTb2UGkXuy+BcrmUjgKTf3pxjbdAk+iK91NIgOL/1UTHc/BNTschVG0E
         /0jw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832172; x=1786436972; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KkuWY5Hua0QRTwIBGaEIrRJQVtnuHK0Pb4GBlrZuFaQ=;
        b=DoErG81DQGd4ejZKr6FzuV/iba9RfaUyne8YD/Xn2is2rirADlyiflczKX54jTHY28
         iVhtrMPW5xBifjXYS0wMFoYZv65OPgVBZ5ns/QYc0gI5usVmBbzOQzOKJv8eVkXF4/l8
         W0QT8MNQYyv57UBPItv4W33uLbjTmaC6hrhM+QsNKg6qiGGEj8VZx6JU2g8PDlk12dQ3
         0i6ab3l0VpnNoYcr63J42z+ezCGg1/wsE0Bq1IkP8ClElOYVZtNeQI/NcGMQe5MKBqPj
         oas8Jhhc4HOVsrHI+bjQoHgqFCVKR6RSRXvFlFcIPSu+hPD6WEq9RxoZiKSJP7z8q4CV
         /MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832172; x=1786436972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KkuWY5Hua0QRTwIBGaEIrRJQVtnuHK0Pb4GBlrZuFaQ=;
        b=Ih/GLAjUF//z8MepS7YfebhefMDB/Vsjs1Gj85BuMh7GeP4hb0GU8hAzbHzs/K6rwL
         qUVgjNiOcvQcSJ+BGO/bN+3h7re4QQeFvHQjrtS41y631/XpkSj+EkKLlZzPzwlElujs
         KiE1z7sPQUZJKGcWmhquMySeMYwPgkaCxKG9KiwjeAGisK2fnTE8zGkmHLcaMvmyei1E
         NPKe+K2qnde8CwRE9yJ/bTpD+S91VoXW6RikZtN6YhHKYCruG+Nia1j0uT1+m8ktm2Ni
         zwoFsI3u88qsHEGKsx3Kq6O5UpnX/DFdtqClQ4mSFPBcuRuMsKNMaQP/CEjqSgq6VFV9
         vJEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrLbnQdwhAs3owJKHG+UDoSFh3lTaJuONMlWiSrny088EeBUmqgBBCIa63kXDvmWNeDFuCc2Vj7E60h2o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyMQJXRQz0lldTXbVEcmhySMSt/OrDJVlILATezp4egIkCVMd7E
	RUDTcA1K0Q4MP8g+mCANY5yR2eKDpuq4mtlE+3242o+Dd427apNAKlu2eqo5HFYkX2wZZp+/BFa
	nb4/S2+FsNA0pDT7ujRnyGTRRvqwCBh8=
X-Gm-Gg: AR+sD1222aB42Z3OA/+IWPKKcIaZTo0vgkkS3GvaHvwRS8i3+pKxw5J1J/QwSbdvg2U
	pVKv6Xb090AaLpkg22pk1i7wm3+hNUv5a3a7PZqUMDQtANHBE1N8tC05VEQCGkma/UloVkZVoTH
	xuJVe4igya+1E7dvsmE2taxd0TDLJdX7BQRL8PfLHEhxmTdoK4qCfe23oNa97D3mhTM3hCjcBYm
	ata3Zskgs5eTBF/1hxF/1ZKChc15oGzZxowqx1Rvy3E3PWz9ln2NXMO70U5cymVClg3vkFO+oCF
	mZvsTuPO0lfIOHoRiczr7R/NwE6ZoEaezAhViRj7kCoJM7rF/zXPbMU=
X-Received: by 2002:a05:6a00:8d2:b0:845:e2da:91a3 with SMTP id
 d2e1a72fcca58-84ee480ae81mr12824134b3a.30.1785832171759; Tue, 04 Aug 2026
 01:29:31 -0700 (PDT)
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
References: <20260720095450.1618747-1-shengjiu.wang@oss.nxp.com>
 <20260720095450.1618747-2-shengjiu.wang@oss.nxp.com> <20260731225930.GA2098187-robh@kernel.org>
In-Reply-To: <20260731225930.GA2098187-robh@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 4 Aug 2026 16:29:19 +0800
X-Gm-Features: AUfX_mwxExGCC8sRpN6-vbVB9v8CNcSex_SykavnhYOluP_E46GIp0w8aQWy9oQ
Message-ID: <CAA+D8AO1D6GJ8xwuKf797rc41ymTZp2d=LD8GEQALHhdpToCUA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: fsl,imx-asrc: update port binding
 to support multiple pairs
To: Rob Herring <robh@kernel.org>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	shawnguo@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
	perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, 
	Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 6:59=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jul 20, 2026 at 05:54:47PM +0800, shengjiu.wang@oss.nxp.com wrote=
:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
> > The existing binding exposed only a single generic audio-graph port,
> > which cannot represent the individual pair endpoints.
> >
> > Add a ports container that enumerates three named sub-ports:
> >   port@0 -- pair A
> >   port@1 -- pair B
> >   port@2 -- pair C
> >
> > Each sub-port references audio-graph-port.yaml as before.
> >
> > For backwards compatibility, keep the old single port property but mark
> > it deprecated. A schema constraint (not: required: [port, ports]) ensur=
es
> > that both forms cannot be used at the same time. Update the examples to
> > show both the new ports form and the deprecated port form.
> >
> > No existing upstream DTS file for fsl,imx-asrc uses the previously
> > documented single 'port' node, so this change does not break any
> > in-tree device tree.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../bindings/sound/fsl,imx-asrc.yaml          | 78 +++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml =
b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> > index 608defc93c1e..18d252722aa8 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> > +++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> > @@ -78,9 +78,29 @@ properties:
> >    power-domains:
> >      maxItems: 1
> >
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    properties:
> > +      port@0:
> > +        $ref: audio-graph-port.yaml#
> > +        unevaluatedProperties: false
> > +        description: port for pair A
> > +
> > +      port@1:
> > +        $ref: audio-graph-port.yaml#
> > +        unevaluatedProperties: false
> > +        description: port for pair B
> > +
> > +      port@2:
> > +        $ref: audio-graph-port.yaml#
> > +        unevaluatedProperties: false
> > +        description: port for pair C
> > +
> >    port:
> >      $ref: audio-graph-port.yaml#
> >      unevaluatedProperties: false
> > +    deprecated: true
> > +    description: deprecated, use ports instead
> >
> >    fsl,asrc-rate:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> > @@ -125,6 +145,10 @@ required:
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
> > @@ -188,3 +212,57 @@ examples:
> >              };
> >         };
> >      };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/clock/imx6qdl-clock.h>
> > +    asrc1: asrc@2034000 {
>
> Drop unused label.
>
> Presumably the existing example uses the deprecated 'port'. If so, just
> modify it to use ports and drop the deprecated part.

Ok, I will update it in v3.

best regards
shengjiu Wang

