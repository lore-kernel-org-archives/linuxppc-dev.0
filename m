Return-Path: <linuxppc-dev+bounces-24868-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEFFC531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 09:57:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7vD50d0mz2ygn;
	Mon, 27 Jul 2026 19:57:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785146276;
	cv=none; b=PILuFHyrk7CYFFy6iIU2mywStajNb7kUli7fYrSmncMl9Si8sqe6nMDftsxIVtsVhoCWxMP3YqaFJ6tHrNSr5tsbH0mL4OlAnY95c2JkmvcaR9jJ6P/h9o4dK+cTHDcM/nYFliFtF64pzBjptXGp+OH1lYqmI38pL4170iTnUfuHN7YEKYVhQoICSXLGA6UpQ2h5RNiAdbGIx03jlowhBjecmcueJ1NrNX8b+OnxPKrOAzveUcGtuhQKn2svld5cPam+9YND+QVA3gTWgGgSGQluzOVgxA08vobXcg3MTV/jGI/MsGbE2wOIedk+hyBVidR4cx5DP8nXlfmVde7G2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785146276; c=relaxed/relaxed;
	bh=YQJDwppTbenN9i1kslHGqMMbg0eBRFfA6rG90oLttek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBiPk+5B/nwwhIRCTTQ+HeQiz3axtMQTHfadVgOHSzoCM0EmFGFuJg5GLqnoCSRQY7FJR7u9EOFy9T23w8KHZ6NSrNzUjWGjmWhYIsOcTgPdS+WUYijhh/bIq7GZjnWXbVc+ZfOS9kFfTTM4e+46I2q6lsIq4uQm893eGyDEUlIdluRbfOHpu2q0qseGLSWMSl0LnxJXh0+0zZ4dCbAVZEzGKb9P4TXzg6Cq2zkuJSYPCgWnQsY8iLO33ap1To4SaoEk52LOKIeGXU14yoXCCg8GVjRtnYd26I+N38pVPhnAAbeY0cwUUSa095aVGnofMu/jUc0hqKmEjb8t52GH7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPpOmaU0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPpOmaU0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7vD35vj8z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 19:57:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 483F141377;
	Mon, 27 Jul 2026 09:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702531F000E9;
	Mon, 27 Jul 2026 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785146273;
	bh=YQJDwppTbenN9i1kslHGqMMbg0eBRFfA6rG90oLttek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DPpOmaU0NxzDbdXd0JKhBfLhp/WSyqhSgzpKGorhp/ECw8rGNAcG6+2ZyeqZ4HdXI
	 Id2PKM+lic4xqSbPvNauVMhZYblAny5sjy53RWii2Xez6IDErVD4NvwMjeZ1n0oOK9
	 cHtuW3DTVjsOYxMfoiYDVhCud5RwdakzaS1Za1JHnPq+oVbz3wpP2aVVTqnW9HYSq6
	 x+s9sgOMXFD0RQu9KlsZ7GnCrF2upFbkwH5tqyQTpfXrAvUVsplYeV59CWHOv/4V35
	 DUBeZy/Ln9XM2TTDL/zVKiSJzHe5Q0nh4X06Ib2W24Z/IlU0zkOZnvtUucruFcJs1t
	 cY+337Pc5HZ9A==
Message-ID: <0e740755-9eab-424e-803e-a956740994fb@kernel.org>
Date: Mon, 27 Jul 2026 11:57:50 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] soc: fsl: dpio: Use scope-based resource
 management in two functions
To: Markus Elfring <Markus.Elfring@web.de>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Roy Pledge <Roy.Pledge@nxp.com>, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
 <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ioana,

Le 06/07/2026 à 12:36, Markus Elfring a écrit :
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 6 Jul 2026 11:42:10 +0200
> 
> Some adjustment opportunities were picked up.
> 
> Markus Elfring (2):
>    Use scope-based resource management in dpaa2_io_store_create()
>    Use scope-based resource management in dpaa2_io_create()
> 

As the (new) maintainer of drivers/soc/fsl/dpio, could you have a look 
at this series ?

Thanks
Christophe

> 
> v2:
> Christophe Leroy requested to apply the attribute “__free(kfree)”.
> 
> 
>   drivers/soc/fsl/dpio/dpio-service.c | 37 ++++++++++-------------------
>   1 file changed, 12 insertions(+), 25 deletions(-)
> 


