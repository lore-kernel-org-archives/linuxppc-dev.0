Return-Path: <linuxppc-dev+bounces-27911-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D780C982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 10:23:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpx5j2rpCz2yQJ;
	Tue, 22 Sep 2026 20:23:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790072633;
	cv=none; b=h4mR+ZGiRZgyubE175a6L2vnQnnv3xOKoHgMWVbhV9CVcswy33PI0Ob50rMIwnM5N/iHs7OKF9ODL5i5eZZZdxiOnKAzRRiqix/iOi6YpcoDeQCacqxtybSVfnKNAJMIAwJsYAiGatvlgE8Pbtme5U2cLM+gyjAG8BCpDdCPKJp2tvalloha73z/jgIOBRDqAZwMJWaXk+83R5kCTYfhfI4MnZ35xEVzeta/PMXk44CH9Ni29msGUSzS+qFFo6TmqjNXpwXx+lt0frBZmxPKft4FTaqdsdSwtSofUeGEgErUo1WQZdeYz5z0a7rFHFrbKFNPbFEj1VCgZ8w+BgnY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790072633; c=relaxed/relaxed;
	bh=G2ZZ3jPoCQgZ035xQBboMsxg7LDoIyZLuMyVj0W21Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jI7SMTkYGPLmJTqONo5raWIjBLrCrp7OcU/VIrD4C/nv/zLt03XchVIjRb6ywP3u459UY+1v96Ocjk+L34n1LxU6ZmIBQXa5jEI3exwJoSAS+z9vgL6aZso61sEXWL4Cto/VZI6sApDikANDAJOQXiQmQeHR8c2SA8gnMX63t2xM0ZQmPwBAp51RMo6XbYW3tBmh3S53l/acYhdb3UCaGD+hAJsjnaAeWFyS3NP9d3PzenYgV1t8RiW7QGRzolRjx18LC8R2F5b8yrjDyf4WbYo0IEbwBBKKXM6rlKJD9x/jx9UGs3DBNoYBIHDdeXoIbQK7oIhH8H7Fe0Q5kQ6gbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nV69P6Wu; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nV69P6Wu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpx5h24KBz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 20:23:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 22F99431DA;
	Tue, 22 Sep 2026 10:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE72F1F000FF;
	Tue, 22 Sep 2026 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790072629;
	bh=G2ZZ3jPoCQgZ035xQBboMsxg7LDoIyZLuMyVj0W21Gk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nV69P6WumOQzOIviEfkVLpeS/fz06hZd48XOj0W//UAILYv9kAYpClfua4Hm9SEza
	 Q7bNkF/PRNGhnfovkHCs3GV5sdnGBfmZvcGJoMMBORkqXWSIHr/zPrnuj4MLMIBiQm
	 rcfct8ZaVROl3f4B5icews0AIIRKQNfPEd8wS2KnKMow+z0Sj4r+UPjk/7utKqlOaG
	 6Wg0SOojMN9dcatWViHhZMMfw0NE6UJHOUc2NVBt68yB1MqUNcR9B07p+34XAndXuQ
	 faYTabLvy09I3dOSvDbcR2fgPQsVW15MB1MULS86SNhCECtcV4e1VbgVi0WvR3gW1p
	 qov4e3CVjkw+w==
Message-ID: <59f78064-0e0d-4e3e-9ca3-f057e70b44eb@kernel.org>
Date: Tue, 22 Sep 2026 12:23:44 +0200
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
Subject: Re: [PATCH v3 0/2] soc: fsl: dpio: Use scope-based resource
 management in two functions
To: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, Dan Carpenter <error27@gmail.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Roy Pledge <Roy.Pledge@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <709fefd1-821a-4cd1-8598-b1179a95ce52@web.de>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <709fefd1-821a-4cd1-8598-b1179a95ce52@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/07/2026 à 13:36, Markus Elfring a écrit :
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 29 Jul 2026 13:28:09 +0200
> 
> Some adjustment opportunities were picked up.

Feedback from sashiko has to be adressed at least, see 
https://sashiko.dev/#/patchset/709fefd1-821a-4cd1-8598-b1179a95ce52@web.de

Christophe

> 
> Markus Elfring (2):
>    Use scope-based resource management in dpaa2_io_store_create()
>    Use scope-based resource management in dpaa2_io_create()
> 
> 
> v3:
> * Dan Carpenter requested to add an #include directive.
>    https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fkernel-janitors%2FamdBqQfIsAjxMsqX%40stanley.mountain%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C6bd2db2a294b450f9afe08deed65baaf%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639209218359212161%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=6%2F8aUajE%2B%2FNYTpo%2B09SVBa9lbZez3WYGUhtpdSTYF4w%3D&reserved=0
> 
> * Ioana Ciornei requested to keep variable declarations at the start of
>    function implementations.
>    https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fkernel-janitors%2F6woig227u5snmdsrjfuw7gfcf3vk5iwaap4yf7ow6b6s3pba7z%40yg4vmdoaak3h%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C6bd2db2a294b450f9afe08deed65baaf%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639209218359235520%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=icEeNsVtx34DKgqjmsDjR3QUqqmeSh1o7gWr5PJYFKo%3D&reserved=0
> 
> 
> v2:
> Christophe Leroy requested to apply the attribute “__free(kfree)”.
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fkernel-janitors%2Fd95d2f4c-f3cf-44eb-b61b-79ba7891674d%40kernel.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C6bd2db2a294b450f9afe08deed65baaf%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639209218359253601%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=wx8iGxIWhoBQPzSqd2fsa4eeZV9DTQ9pEBL4AWxLcdY%3D&reserved=0
> 
> 
>   drivers/soc/fsl/dpio/dpio-service.c | 37 ++++++++++-------------------
>   1 file changed, 12 insertions(+), 25 deletions(-)
> 


