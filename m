Return-Path: <linuxppc-dev+bounces-16096-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B472DD262B0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jan 2026 07:59:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwxRd1Dgyz2xqD;
	Wed, 21 Jan 2026 18:59:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768982365;
	cv=none; b=g2zJvf4bY3LpeOnugoAIPHoN0zWxzTeaUge1oaVZgnkaNt2b/iWoIWZqxR2/0nC+b1yVUWmhOdDrKCdMhRgZyIxqpJVoYJ9VMmhlqpHe4jCa3sQJVmDfJX8k6FnstGZxO9B1j+khW8rsDhcPaPB/06QNeAzyBDbTTGjt8sXHmLU1q2JT+sACIieQrxAAM4rs0117QtqBTkhu8H5+beK/D2lnWwqzDHkg2tpWkAJ0jxkoQANUCurpmDGXFCnjVEOpIi1sN73EYVt1/lORT2uSVE9/nMyq9/WWuS3NPpg0yRJdpcAONSeKYiX8sAS+YUkAOtFKSwNqesGgp7oyllmllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768982365; c=relaxed/relaxed;
	bh=mo+56ot4Mgg4hIzQrB+wLbvM7WfSiDIFC8Wgrgljn0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwf0j9Ebqm7MAEP1QD3bCY1ByP1LmOMFaHbkS/hIGNjcnSWUP+iZ/bsly+dyCDhH+9e2Ux/JRMptRLvJGErSnt0gqKlnpz4meWv9XftItc+rsIWbG5P+VyUI7OZxP6RQRz97zdwZ0kL4C4a6B65NXeKSDZtb0+8lHxmlPWdSVzeyOuw0ZnJZ3hvJ8lk7Z7j7DaAgq7gqAUmSE/MaHXC9iHHjCPfTHVJYB2ugqtMfHjZCplUMYlPojoGklQkoRFy7IDteRWMQmboRF05RsP/AA8CfYGu/sfg2NLJOOVuNP2o67hAZMNrWJdOo/VkKoLeeqfuKLruxzA4Bj4cvtl//hQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RZddl4+4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RZddl4+4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwxRc34lCz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2026 18:59:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E09D941B64;
	Wed, 21 Jan 2026 07:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3865CC116D0;
	Wed, 21 Jan 2026 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768982360;
	bh=B/7SxcFDchYAOxBFM3nekD6F3BNUoh6xpZYaOFcjPWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZddl4+40tnL7hWPWTaNGYdQMXa2Iw5iaLuiEt06W7iElk1M3kUOr+OXOXVx+SLuh
	 6ZemwgMGYVzfaH7MS9JcRXM4ZE6blUG8ZB8iwrRs0DcDft/A8L9S+eh2A4u91jvGG0
	 TZS7Sn24xKexfKOqcrX84UhWlZEJEcnjt5eeEPM3i0w1njHAEX8FkAohIwT8H17FSW
	 Sz6NxzyJclSwoct9qszl2ONMxltY9ItMshi0FcyIhD6fMy8vP2ILkQA2fKOU/l6rOW
	 PNttevoIvyYCZRzpkLo+xGlAgA5xdAe4Aao/LK/Atv3h/jnshApMG5Q+ZAsJCPJTsz
	 OFg02BDz+AhZQ==
Date: Wed, 21 Jan 2026 08:59:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com, 
	festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: fsl,audmix: Add support for
 i.MX952 platform
Message-ID: <20260121-uber-adder-of-radiance-0ebda7@quoll>
References: <20260120035210.1593742-1-shengjiu.wang@nxp.com>
 <20260120035210.1593742-2-shengjiu.wang@nxp.com>
 <20260120-fractal-lemming-of-chemistry-6f21df@quoll>
 <CAA+D8APePw6BnRP=Wnw+zna+oc4_aoMWZewYC7yx-XYLBrSKbQ@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA+D8APePw6BnRP=Wnw+zna+oc4_aoMWZewYC7yx-XYLBrSKbQ@mail.gmail.com>

On Tue, Jan 20, 2026 at 07:07:48PM +0800, Shengjiu Wang wrote:
> On Tue, Jan 20, 2026 at 6:31=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On Tue, Jan 20, 2026 at 11:52:07AM +0800, Shengjiu Wang wrote:
> > > There is no power domain defined on i.MX952, so make power-domains to=
 be
> >
> > There is no defined or there is no power domain? If the first, then this
> > patch is incomplete. Please read writing bindings part about complete
> > bindings. If the latter, then you miss constraints ":false" and commit
> > msg phrasing is incorrect (and remember that in such case you won't be
> > able to add power domains later because now you add complete binding).
>=20
> Thanks for pointing this out.
>=20
> There is a power domain on i.MX952 for the mix system of AUDMIX.
> But it is enabled by default,  AUDMIX device don't need to enable it.

This should be explained in the commit msg.

Best regards,
Krzysztof


