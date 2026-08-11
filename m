Return-Path: <linuxppc-dev+bounces-25708-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9890C5AD55
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 02:28:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJwXl6VVwz2yrt;
	Tue, 11 Aug 2026 12:28:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::52a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786415319;
	cv=pass; b=aHNWIMBod6dLXJOWYP+TZFvtIF6RwxDPco8NJG2EWfyX7dv2sGD1wAHIT3BjMBj8uy5YYNWn7LgtP/MxVdcSWipkozWs+fwaJJiQuREh/pRz3+Bu9N4Ea3oCPyExpIH9z1bE0xPrpGwOr9+15l4SouOLWVQU2FghSJ99EgrM68aFGPawP7ssrhT17xbtRocpRXqGhQf37UIFGsecfCXJsO3DTiV3liCTnB5Aodo1hFQzIxzO0iOxbwOD+bYOBDwJdtNCcaF/EGtVqk+XiSfkFJhWpLqdt3r4J6ssfmelKWoMGfKLXXUI4Izxk8GuyQf/qclEC0vN+bvKL/EyfOzvog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786415319; c=relaxed/relaxed;
	bh=FK3vmJiqb7a+gVn5qBnneGTL0Sw9n7wbleQLLjtRCmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpoN4NLLWZp2m0QBiwWRcPht+APKKr964QZN72pxZf+clT9swnNnmyV+NMcTYwI2MggrZRngfRwt1HNs0p0MGASnDnNh5MLk/RjQGGljTZuP1uEy1eAew6XCLyno6UvzmnNURKqjbpOfOa98J8gt4u9NkAb93jeynpuUHNFNI6mF1bAAPcFWnpoYDqPPfQfYrl9YXaLT4PxJ+j3xW3WQ5f7iNkqO/A+T7pcQhOzWo6s2fFi3T89Vdx0lY2Qz4ydnMHQxtdGrakUmHaaScW8aBp7wiIvnaW6CT+KM6RMNwd7oX+aSRIgT3sl2hF9dWJYcgBQ76yuscyvXwqvxLiTr9g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PmV4w823; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PmV4w823;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJwXk41TCz2yjv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 12:28:37 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so2087546a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 19:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786415315; cv=none;
        d=google.com; s=arc-20260327;
        b=Uu/XBPzqc7COFGLc9hJlrD4wSXCyKnVGYk4KYPIMT+EtCm48TUpeFFZP/vd/T4brM2
         j0lK+dNENIk+AqV9KDWuY2snHSaFzzknrvjXqtNz3UIC9vz+I7E1iTWzYx6xNV0vRCrN
         w8Kq0ePZ9+B4aED1EV3Xv8tbShB8LV3VXN3/z2MBFPAi10pp6AzdB/EA29+KM7pzdOyu
         oY9HKiAIiPsGsuonACWLPcEXFEpD5PJHB7idnqxAP9F3S28z4R+6g15dtYDHX55Z0Kbs
         BeHEmhQRUtsOP0feQpAoAHZhPp3pMTwKZQ9bkStfiumzx1GybzPe5WE0/3o3gu0v2XP6
         h0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FK3vmJiqb7a+gVn5qBnneGTL0Sw9n7wbleQLLjtRCmM=;
        fh=IrAQuFzkkK7YS660z8SW+4f+odp4JXwzoJrdW5OwjQE=;
        b=jWau2TmcX0bu9obFUavWzr3cPkG+/oqxqBuFlej9CEtj3lMOl1pyx+nbCoLRxte+XM
         fNMfCPhSKVFbcKT91ygEX+NcKFG2Vi/Wbo6NOwLgpLtmZy7BpLSU9xZ/FfPoe+Wb3VS+
         MXzcxQwGTmNGdwLUQ3lgq13eJA6lgYCh9SJZ/1HkGxyNLGoWTSGqPTqWqCDnj+A989zm
         Qt2ONs6ggYPLN8iX5Mvd08dNkeORD9Zq4wNQ+umWpdF7CmrSUHcI/z/nu7NNN8R3ES9y
         YI5bDdIy6JskkYdsvV4TnQUxdVNBTSOcs0roWlhGPmet/nh0CK6ZHb2vft915woLzaL9
         6fCQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786415315; x=1787020115; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FK3vmJiqb7a+gVn5qBnneGTL0Sw9n7wbleQLLjtRCmM=;
        b=PmV4w823OWHMKQumnnPWX+hbvVRFIFtPTmhoOXZVB7Z6FQYfKOpEWoMxzgHt0dGHH6
         xxr/5nNMMmQwaTFSxndEWOF15F/ixC4p5X+YwBgmtc7GuHRg0/lWv8re6gqEe3Zpz18+
         L9t+4bF8lZ9FS+vg61gRYngTg+w5OmSOVGEIlHgag3oA3egwe/o/YvurFyYeU/6ziAmM
         nBM9agDmUQQItDGAMlVrML+2uez6yepNx3BNY7DMMU8CLWXw4LNv1JhaVxmgnGRNlEGk
         qXla36T+uQYMcx7jfmp7rn312c2uh0HMIZYWybIrhw3T9JzxEMNiRaY4yuELVTAg74Ut
         h5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415315; x=1787020115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FK3vmJiqb7a+gVn5qBnneGTL0Sw9n7wbleQLLjtRCmM=;
        b=OVO1rNB+d0q27P0Vus17HTMBQYxr1f3fYQGvzcsr/jMsiqWyqHXeijSkFddELq7AK3
         ox/bEzw+YqLiwghDl3tkHsqHNXf1QtzkAO2d6zBBASOLFNXgSs1q6yUq3BXCNhsAAebY
         teYeimPKA86UkfLqdtNtD6hzPpEtcjybtHKdkqW3GAfKsG0YRmu3zq/g2fEV17J1wrc5
         7AioyzMi76Lmlmju9ddtJHEsAo2kfrrmoGBvi0Mhx1AVL2l1JqQRwjO81VolQPPO9zK2
         Nk2BRVT7qbxKvDnSQrKU3SYqApuclOJs1x88Sg6fXuoKAfcdhbYv4B4C2mOD6J5H1eEH
         SN1w==
X-Forwarded-Encrypted: i=1; AHgh+RoQHwKBxIyyQLdfZd2gHvzSHsQ4UF4vFo+AgkFwlO7eKC5L/rgGdsIVTQslrrDkPEAIhmox9IpxOlNsN0U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywg+r/WN4L6TqopFTHf/6BBYvwemIcpwyDZrOOYma4qEt7e14gP
	DE/xFsta9MjrG0XtzNIU9hiSeBoQz9wqrQ8O8YMnUzVNpUtaWQc5ordKQ4Y6COPeuRVYrPJIWvV
	N11qgt9skhSkWiDY3F05aaplCV9KFegg=
X-Gm-Gg: AR+sD1179If90Qrx1S9Sci8/DKIhEj9mmmvTnUCoOezmIWc2LsoTvq2fn5U9asKIoML
	+QH9HqieiWhr8pEkddUaQP+2X2oVpsbFGonlePK6XGbcKSsdXJGJ9LunGl7USQ76KAQeqZZW4RS
	VgwuRhii8ZuzHHFUIUJfs50sD9fyJgosyB6oEInhGbdlGSG4k+zLrtQ8ghrF0i1m+MMJqrFT8mj
	jjZXoY1MdgAjtbBwhogmTuArsqSHmKvKuouS2dS2nRLNtkPfUJ9Mi6TR5XHqQ3eYe/IOgPKmg+L
	u39tr9z/8cgi7YiL4qqowdPBYVSP3SuHdJc23tCKWGLn
X-Received: by 2002:a05:6a21:e0a6:b0:398:837a:7af0 with SMTP id
 adf61e73a8af0-3cc2baff1a5mr397245637.30.1786415314854; Mon, 10 Aug 2026
 19:28:34 -0700 (PDT)
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
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com> <20260810-normal-cuscus-of-argument-4b230b@quoll>
In-Reply-To: <20260810-normal-cuscus-of-argument-4b230b@quoll>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 11 Aug 2026 10:28:13 +0800
X-Gm-Features: AUfX_myaxBa_rPqdovqcCYr4z7pz2bgmNVRQ7bdnJSbreWmsZ5qeF4VRopEa4z0
Message-ID: <CAA+D8AM9s7EX-G246Hf2=DOx5q2qXWg_MjUCaoJ8RggOjp+5cQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
To: Krzysztof Kozlowski <krzk@kernel.org>
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

On Mon, Aug 10, 2026 at 3:14=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Aug 04, 2026 at 06:02:14PM +0800, shengjiu.wang@oss.nxp.com wrote=
:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
>
> Which SoC? Did you read this binding you are changing?

The i.MX35 ASRC (the original) already supports three conversion pairs
(A, B, C).
All subsequent SoCs that reuse this IP -- including i.MX53, i.MX8QM, i.MX8Q=
XP,
i.MX952, share the same three-pair hardware. This binding covers all of the=
m.

>
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
>
> Why? Did the old hardware change that it has more ports/paths?

The hardware has always supported three pairs; the original binding simply
did not expose them all. This patch corrects the binding to match what the
hardware has always been capable of.

>
> > it deprecated. A schema constraint (not: required: [port, ports]) ensur=
es
> > that both forms cannot be used at the same time. The binding example is
> > updated to show the preferred ports form.
> >
> > No existing upstream DTS file for fsl,imx-asrc uses the previously
> > documented single 'port' node, so this change does not break any
> > in-tree device tree.
>
> Does it break other users of this binding?

No. The existing single 'port' property is kept and marked deprecated
so that any out-of-tree device tree still works without modification.
The new 'ports' form is additive only.

>
> Why mentioning upstream in the first place? Either this change breaks
> ABI or not, explain that.

The deprecated 'port' property is retained, so this change is fully backwar=
ds
compatible and does not break ABI.

Best regards
Shengjiu Wang

