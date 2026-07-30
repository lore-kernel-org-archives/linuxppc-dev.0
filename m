Return-Path: <linuxppc-dev+bounces-25101-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BE6C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 12:14:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9p640Xs3z2yYd;
	Thu, 30 Jul 2026 22:14:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785413660;
	cv=none; b=UfseZuEOuOWyy0oUmfPB+onC709zjn1VG/XIHUlO6KrrSeW/LxRWCUboEGD3NFlGlxhL9QVO6W2u819uM+KxSFgSbnaEgFL0cNv4YD7l9/wfn8eL00hzdpueFTbjKQkEosoL8PwPNdh1c5q1YQbl8tRoB2yRtXxuzuxC/vj/6Jb5vQ55WXxB5Qqi9t3qAEUumBIjm9nOnxlgJz85Hzlrtm5gwG6bLOypsw/qTTrPUk/fYWPgNRztk7gl808ftrns6THNSUIi9ag+gEk3m2daUgECMWhdrii1OsCu0u0XHWSieeWnjmhUbDaHJi1XZLfIGMbTVW5oUhRNWSibDP5QZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785413660; c=relaxed/relaxed;
	bh=ymHKN/BJa2+0pQ3DOlaBBtFOqaY7h/grwRM8s4BKdwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBKGPUmuoG0FsAWu+nkAcgg387H8IJsICNMliZ0y+c0gY+WNb050sRTdumQ9bavzXLbq9Asz8G+KwiFNHbX7W/ZqVoRyUd+thywgoW/xpx2oFRCDm2DbnQ0IUkIyld6UUVjXm8kTX862xBlr73yFqPKx1JUryhxT6uw3p6+W7Q4/1dxCqTyXeTkL2jnJ5mCBxp8BDwFxAGOxPTNQxdiAWt8NeDBMw8zYVF/w3KfLYo+CiNnfZ078+G3xneVcMgEuz9DA537TgtJCGqVAzFfq4UgKa86sP1UO5X5rhOpDo9hdAH8SOuMlTv+zpenEDq/682XsBXcxgaoU5E88Z+qTFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpWYFZti; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpWYFZti;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9p631yc7z2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 22:14:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B28AE42B17;
	Thu, 30 Jul 2026 12:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7FB1F000E9;
	Thu, 30 Jul 2026 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785413657;
	bh=ymHKN/BJa2+0pQ3DOlaBBtFOqaY7h/grwRM8s4BKdwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QpWYFZtiv7xvBiD8yhhxjDR2I2Pxtdoj+NdAO8DyGiiTwd4gadDiR6vxblENSgQfX
	 uFyV8YPD4UFbBzs9ONRhUpq5rNQVbgT/Dism5miL278jpJrPywtD856VCMMhPTn19g
	 AK41e+OIieKxQsCeMpzobggMAUCCe2HEFu1MyAx5Eq0bSUizDgBYHiiR32/pMNkqCu
	 6Ev5KnnDPgr8KUS+AGhS767CbP9EHAZxhAB9qlB0gG4QRR3KWK7g8jpIWzNLRTE6/X
	 B5xvZbremozqKo3xssG6J4qhtATPnModw+eXSJ21hsjYV9K+0NEs5RMWOCPI4phGl1
	 /3Se2nMv/k9qg==
Message-ID: <59156118-27b2-453d-81b9-86a3d411a855@kernel.org>
Date: Thu, 30 Jul 2026 14:14:13 +0200
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
Subject: Re: [PATCH] soc: fsl: qe: properly scan GPIO nodes at startup
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Paul Louvel <paul.louvel@bootlin.com>
References: <04dc047f8958a78a920f0a88ca3bd8bf70c56187.1785333986.git.chleroy@kernel.org>
 <e1bd8dcf-9b8e-4bc7-8ba8-6c06222e1659@kernel.org>
 <223afb76-9f6f-48a1-a5c5-beb1a641916c@kernel.org>
 <f1b4c866-6cd7-4d6f-812b-d95e94f69e83@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <f1b4c866-6cd7-4d6f-812b-d95e94f69e83@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/07/2026 à 14:05, Krzysztof Kozlowski a écrit :
> On 30/07/2026 14:01, Christophe Leroy (CS GROUP) wrote:
>>
>>
>> Le 30/07/2026 à 13:14, Krzysztof Kozlowski a écrit :
>>> On 29/07/2026 16:10, Christophe Leroy (CS GROUP) wrote:
>>>> Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
>>>> proper platform driver") qe_add_gpiochips() was walking the device
>>>> tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".
>>>>
>>>> After that commit the discovery is handled by the platform core,
>>>> therefore it is necessary to call of_platform_default_populate() on
>>>> the par_io node.
>>>>
>>>> Fixes: 156460811def ("soc: fsl: qe: Change GPIO driver to a proper platform driver")
>>>> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>>>> ---
>>>>    drivers/soc/fsl/qe/qe_io.c | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
>>>> index a5e2d0e5ab51..02ca556c8db0 100644
>>>> --- a/drivers/soc/fsl/qe/qe_io.c
>>>> +++ b/drivers/soc/fsl/qe/qe_io.c
>>>> @@ -15,6 +15,7 @@
>>>>    #include <linux/errno.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/ioport.h>
>>>> +#include <linux/of_platform.h>
>>>>    
>>>>    #include <asm/io.h>
>>>>    #include <soc/fsl/qe/qe.h>
>>>> @@ -184,3 +185,17 @@ int par_io_of_config(struct device_node *np)
>>>>    	return 0;
>>>>    }
>>>>    EXPORT_SYMBOL(par_io_of_config);
>>>> +
>>>> +static int __init par_io_populate(void)
>>>> +{
>>>> +	struct device_node *np = of_find_node_by_name(NULL, "par_io");
>>>
>>> No, node name must not be ABI. Especially wrong node name.
>>
>> What's wrong with the node name ?
> 
> 1. It causes W=2 warnings (which we might move to W=1 at some point)
> 2. It is not generic and DT spec asks for generic node names, although
> maybe this part of code follows more of ePAPR than DT. But ePAPR v1.1
> also was asking for generic node names.
> 
>>
>> Regardless, I messed it up, I wanted to use type but copy/pasted
>> of_find_node_by_name(NULL, "par_io") from quirk_mpc8360e_qe_enet10() in
>> arch/powerpc/platforms/83xx/km83xx.c instead.
>>
>> Is it OK to use of_find_node_by_type(NULL, "par_io") instead ?
> 
> Well, depends. Is it a documented ABI?

In Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe/par_io.txt:

Required properties:
- device_type : should be "par_io".
- reg : offset to the register set and its length.
- num-ports : number of Parallel I/O ports

Example:
par_io@1400 {
	reg = <1400 100>;
	#address-cells = <1>;
	#size-cells = <0>;
	device_type = "par_io";
	num-ports = <7>;
	ucc_pin@1 {
		......
	};

Is it OK ?

Thanks,
Christophe


