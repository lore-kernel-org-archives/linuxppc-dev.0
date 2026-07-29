Return-Path: <linuxppc-dev+bounces-25021-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6E4C53219
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 15:14:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9G8Q5Cbxz2xwP;
	Thu, 30 Jul 2026 01:14:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785338070;
	cv=none; b=HeJPrJwyBo8oT4B8wM9M5fXIR5Er8YElaZHqRUdjm/fDSYMdfqj8zsVF9Ur7tpLPLH2MHby7aePdAm4/jzPmfKbRBtEl44VoZgksvWNXZLgzJECZ3Fnu9l9yBMBjAcqYKCDj0dHglgkYZ1AAXyhC5fMWTZXuPS2BBhPGTsgm85hp6DDLyX/ZTX7m4OWxGRuwmHQWamV/dZ4SBXo3FmNCnBmv6hFSJMzhGlEinRqTUpilhjeQg4n0l+79EyEFkpMI/REJks7yi2DxQ0jiDuZiK028wSoGeOSlGLdMlOxxE7vTw0TrMR3BTD5KPAn+2vkoj/0ew039UbZLu7L910q8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785338070; c=relaxed/relaxed;
	bh=Pjb1vpRxRg6idVjUGQ6jYMC5oC/fHi4m7ISfSHpWDj4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkAbKg8uZMe1eCQjYGpr96Axq8A/JKLupjqvFuoleex2oogjHsU/VBL/j8wRhhh77/rS3FU5kPtGGWR6fuKVv9VjIcROgjYa79qpG1hwjllGrzKE+uWFMlh1sRHPb2NxMoteuNFYnAN3aL37nG+xrJDuPWslP3O/l9Vro6Gj2in1XUNkKhT0o3gxfGb5eGRYmH0A8POI9tdp3hSsmoNcor16q6cGhT/lIEuC+of/pi0Rqh6aYz/YrMQAOrbVt1gBPRDcmV71Y1Vk4ZYq080CQq5760+CB+JZuCsYT0z+9qOv9zgtcIi6UdAfck4lMg8Mrl2lTkJa4wkmFZG6NEl+wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiC4qDhG; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiC4qDhG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9G8P5fXWz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 01:14:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 75E826001D
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 15:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2851F00A3D
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785338066;
	bh=Pjb1vpRxRg6idVjUGQ6jYMC5oC/fHi4m7ISfSHpWDj4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=TiC4qDhGeGugJluJmFdqS2DloAvtqigdBJGEUTdS5+tPI2P37u1YLNqupYJKmMpCk
	 txfbV96Y1eY5OmlLq+hF/P0nl/lA5Luvle+eFzrBlRh7sbAxjsAottBZaRUFStPgOM
	 d6VlqHU4mi/DQe5QgFcZmgp6HPb20WMaCg7q1SY91BEapGLkA/04rPKsaaxYdHvV0V
	 bWwd619V+RGx3FTzyRgkIncQSD6A2ByOBiyAoZavqMgOiTefVD4KPvSPLTWA43N3r4
	 Ml3BrxHQpjLsnx9rBQncvGvXDI1ZoMf41hemERgivF6pcB82MqEoFzVtiYdHA2ErXF
	 vPSMwy2AYqRgw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so1345395e87.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 08:14:26 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz43Oqi6ziMZewlfoyHW73wlOdIVA2YrvoIsXLoJnyiuJUB9DzP
	sV9biUd/AW7YDeHufl6Ia+MAkWSAh9Vb+/LwmJECsX7HPLgS62XDigehR63bXhIeaUmchZ2Krl5
	ve8ifWjifmWfUEXQE40eZGXvea4pXkFyoVRgwMrILBg==
X-Received: by 2002:a05:6512:6181:b0:5ad:55f6:1ec3 with SMTP id
 2adb3069b0e04-5b2d0213884mr1392852e87.5.1785338064921; Wed, 29 Jul 2026
 08:14:24 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 15:14:22 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 15:14:22 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <04dc047f8958a78a920f0a88ca3bd8bf70c56187.1785333986.git.chleroy@kernel.org>
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
Date: Wed, 29 Jul 2026 15:14:22 +0000
X-Gmail-Original-Message-ID: <CAMRc=MdFhcarvziP=jQwOKubJPe-v0W6Xck_S8mhm8327F7tsw@mail.gmail.com>
X-Gm-Features: AUfX_myblFT7OCuXOW4dHEmx6cmElNBqUeZuq2_eLJUx_Ak4F74FLfotacPCQ-k
Message-ID: <CAMRc=MdFhcarvziP=jQwOKubJPe-v0W6Xck_S8mhm8327F7tsw@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: properly scan GPIO nodes at startup
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Paul Louvel <paul.louvel@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jul 2026 16:10:36 +0200, "Christophe Leroy (CS GROUP)"
<chleroy@kernel.org> said:
> Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
> proper platform driver") qe_add_gpiochips() was walking the device
> tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".
>
> After that commit the discovery is handled by the platform core,
> therefore it is necessary to call of_platform_default_populate() on
> the par_io node.
>
> Fixes: 156460811def ("soc: fsl: qe: Change GPIO driver to a proper platform driver")
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

