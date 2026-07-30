Return-Path: <linuxppc-dev+bounces-25100-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9BDC55160
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 12:10:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9p150DVWz2yhb;
	Thu, 30 Jul 2026 22:10:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785413400;
	cv=none; b=DD0LoY4amRmOYRC6yvnY09XMtgG9M9eg9s4HFPSkFMurgnEl9/5YMEopFR848V13iGQ9MQPf0HsOLYDKGr7+E0lgA2r40jWy+vwr65JgY07g7jY1fihA483mq/y/7sKB4yBWCHCVAc2Ube24B+QztLXe1MLAHXekqeTrlTxYQg6xdLYIoD42Qyf0FyZlW0q4lZ00viOK1XsGkSH9AvCJbdmAScTxfxQSor85zTzmT7mgptRbe1X4VzA0oVJF6AMCGIyNrILhZ96lZyOmcJ43D8xbr5jBCKjsFvoL/RQyl33qPLEWultNtMomhN1hGltavlCWSIG929bzoZr+5ening==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785413400; c=relaxed/relaxed;
	bh=VJ/yD7bE9ElkxiDxco8+gMprXLT5uuDnRcZMiLa4j+w=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5fd+rntsyRQQMKbmZ3R9+eu3yFK2XwOwylGQxs0CXEXklzysC0LfldUXMp9INswyn8YJJcNp0xzyF1GaK9+GaE/Ipt2BsOLk7+EIQ/zHkMn61mxn27JYHFq9csUyjRDoIwZoENyH9vgd6rR+s1yi6F2frJ496/yOvTy96WGYu0+Tu0k/5wyRMFhKP69wQ1TNNuIhdDRfyAgeAD60lmoCadQ8wdgB3LAG09vqbo4RHqnhoHaVYjvXfSxPZH8Iu9n3xe4BCeP1Us84fBIJlzCTPZjVb+L+87UhHjs0c6m+JYd1q0AA3usoViKcuD9/LhMsQRqwcjkAoUQV7B6z4Wkug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9RGaN9q; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9RGaN9q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9p143DlJz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 22:10:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BD23241AEE
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 12:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03501F00A3A
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 12:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413398;
	bh=VJ/yD7bE9ElkxiDxco8+gMprXLT5uuDnRcZMiLa4j+w=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=R9RGaN9qxG8rQzQTET92hake+Nl3JUKqqhAcY50GV11EAws3tNE7P5I1kNXxc3p96
	 t2zdJbf6OA4LInTeZTF8WUS3gZ+YZO/CRM/c5mHWtEEahxJb4b4sbSb/t6rJ0yafGh
	 ykgxxVE9yb2tfDidMQeaSngfT+I3IMEVIcLKaR5Mk/VC05N7lu3db/Id4QVddEjCgB
	 ZV2htEghVIMKF04iM2AYhVyQlycoKwOU8yguD2ka0oS/g0z5roLdBZWH2tHGFnt0lT
	 UIoBoP5mBe44nsx8i79BjmQkrA3E1ZkIpUWN4Gt8+ku3dVm53APqVE5t8UzGdFydig
	 odYqJ/91uwwPA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so2556551e87.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 05:09:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YwaNtfwLnGmLSMarDVpWp5WmrombhgBCexW1L6axA1ewanSq67m
	+zXOdbOUA0Z8D9c5AtWkEPmNyEkKr08O73DeHzMb64gqIW6nbNabkX9Sg30jYkaWtMCd4WfdjJW
	mLMdVeL3oo1Yom3a45FdOV3xkEs3AXVb5YN5sa85CGQ==
X-Received: by 2002:a05:6512:3195:b0:5ae:b0aa:8f07 with SMTP id
 2adb3069b0e04-5b2db34f39dmr592659e87.16.1785413397400; Thu, 30 Jul 2026
 05:09:57 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 05:09:56 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 05:09:56 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <fb520f00-1331-4136-8421-d82bdd46c48a@kernel.org>
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
References: <04dc047f8958a78a920f0a88ca3bd8bf70c56187.1785333986.git.chleroy@kernel.org>
 <178539922190.574381.1359588018451529893.b4-ty@kernel.org> <fb520f00-1331-4136-8421-d82bdd46c48a@kernel.org>
Date: Thu, 30 Jul 2026 05:09:56 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mfj_JPQiomau+WLSzb74fiYSbMLarP56zqCDfZWcgbgqQ@mail.gmail.com>
X-Gm-Features: AUfX_myTbYqVPzvlsNuejrqk3GuPKunBm_-wZJ0qoMrboKDcj4pxXoHQW0ErbbU
Message-ID: <CAMRc=Mfj_JPQiomau+WLSzb74fiYSbMLarP56zqCDfZWcgbgqQ@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: properly scan GPIO nodes at startup
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Paul Louvel <paul.louvel@bootlin.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jul 2026 13:15:25 +0200, Krzysztof Kozlowski <krzk@kernel.org> said:
> On 30/07/2026 10:14, Christophe Leroy (CS GROUP) wrote:
>>
>> On Wed, 29 Jul 2026 16:10:36 +0200, Christophe Leroy (CS GROUP) wrote:
>>> Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
>>> proper platform driver") qe_add_gpiochips() was walking the device
>>> tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".
>>>
>>> After that commit the discovery is handled by the platform core,
>>> therefore it is necessary to call of_platform_default_populate() on
>>> the par_io node.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] soc: fsl: qe: properly scan GPIO nodes at startup
>>       commit: cf91e5909e620b77164b53c9b316a5c1f11f9ea7
>
> You left very little time to respond to this - one day - and introduced
> undocumented disallowed ABI. Please drop the patch. I will be objecting
> to the entire pull request.
>

Hi,

Krzysztof explained to me what to watch out for in such patches. In this case
it's about an undocumented node name which now becomes ABI. I'm of course
retracting my R-b.

Thanks,
Bartosz

