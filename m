Return-Path: <linuxppc-dev+bounces-25079-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AED9C54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 08:11:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9hk04DPkz2yYd;
	Thu, 30 Jul 2026 18:11:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785399096;
	cv=none; b=IL7uN4Dmi5UBduoBr9XOUMJTNDx9yMw0y3rcU/yCAM02ccQuzkye0aif/ukQiQ1SvieYbT9hb6mnHDZ1TF+UGyv6xfIe0mJ0741y+CjLoHoMk0VW+1Cbfpf+gFky5XTVDQXko5CQzTWYimYgxa76mdatM+nfOwY41NCuwcxJrJZ/06dDPQKJlXpGdJ2Pmgqgr/CPmnDfWdWZQ+Q27L7mdCy1TKqR7nsO2bpmfRZeD5o8nRZm+/NCbQfYmaphBGJvuR8uNGy7DM4FFpPaBTJYCXxzNltqCKR0ySQYdijDHitF1XUN/SSbyIVephtwDhd5jg+UYzq3h8bHwHnofavfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785399096; c=relaxed/relaxed;
	bh=gN9j8IWdr/SYE/d3Avtp8AdFxeIwpiKz5SDihtLLAM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Do+E6QgQCZ+ftoXAy979S0nynOwty4iwODR32vnUixFt6hKTcRgGs3UL/5qthi5qqGA6FfQTc4+VEEml4s4kKCq/qLvl0a4aJxv8zrvONr+e4OVM9hwPfsfUbKmkJQtzXbjzTZ0VFjJOMcpKTnLZdN4lLg79BFg6inJJcuQJ6krKTcMZSWZADzwxvRnVuUv+17DqAlfP5TMWTZQc4nW8seeRriP39EOlrgti5SXELBjFRQ8jtv33jw9BwJSE9iPWPOlwqqTpmmf2Mqpxqz9CYgM6+6xSF1tsY5/vgzDyrK7JNT5icG61gArYblgliYSpdUsMVDUdXE/hvcGAz4qJNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsYVOZ/6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsYVOZ/6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9hjz5FzTz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 18:11:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2D8FC600B1;
	Thu, 30 Jul 2026 08:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A401F000E9;
	Thu, 30 Jul 2026 08:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785399092;
	bh=gN9j8IWdr/SYE/d3Avtp8AdFxeIwpiKz5SDihtLLAM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BsYVOZ/67qQbI6QKDC+hPmUtZcXQuauzsBmkdDFYlqLb7vCKYOVxrZuTUgLuiabJK
	 PKPTCkfe3h7I2qe40fki/Ag2Wwh8RBx5pq+WNJ8QhHkkJ4CNQCSaM3jg/Mx7EzSIcX
	 pFCSzhVlZQPyFO/Mg+GacXkKyIiwCROinNKtS841uqoCiNCl36hPKrXse65hy6oicj
	 p+fqu/8cBSjdyUWnohOLamtEJu4WOdh4Dg3/4ueWoU/Jo/yQFpiEBdU9olgtSshego
	 5DtPfRC9F3i2qKOhJrv3U8BLZSNYzqV3jUu108ODWchElZa+bM6ret8EiTOeh3eZLO
	 4MPiN/rgHHmyA==
Message-ID: <0e5628ae-886a-4a8e-8a35-6402737ad65a@kernel.org>
Date: Thu, 30 Jul 2026 10:11:29 +0200
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
To: Herve Codina <herve.codina@bootlin.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
 Paul Louvel <paul.louvel@bootlin.com>
References: <04dc047f8958a78a920f0a88ca3bd8bf70c56187.1785333986.git.chleroy@kernel.org>
 <20260729172156.4371a8bc@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260729172156.4371a8bc@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hervé,

Le 29/07/2026 à 17:21, Herve Codina a écrit :
> Hi Christophe,
> 
> On Wed, 29 Jul 2026 16:10:36 +0200
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
>> Before commit 156460811def ("soc: fsl: qe: Change GPIO driver to a
>> proper platform driver") qe_add_gpiochips() was walking the device
>> tree to find all nodes with compatible "fsl,mpc8323-qe-pario-bank".
>>
>> After that commit the discovery is handled by the platform core,
>> therefore it is necessary to call of_platform_default_populate() on
>> the par_io node.
>>
>> Fixes: 156460811def ("soc: fsl: qe: Change GPIO driver to a proper platform driver")
>> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> ---
>>   drivers/soc/fsl/qe/qe_io.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
>> index a5e2d0e5ab51..02ca556c8db0 100644
>> --- a/drivers/soc/fsl/qe/qe_io.c
>> +++ b/drivers/soc/fsl/qe/qe_io.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/errno.h>
>>   #include <linux/module.h>
>>   #include <linux/ioport.h>
>> +#include <linux/of_platform.h>
>>   
>>   #include <asm/io.h>
>>   #include <soc/fsl/qe/qe.h>
>> @@ -184,3 +185,17 @@ int par_io_of_config(struct device_node *np)
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL(par_io_of_config);
>> +
>> +static int __init par_io_populate(void)
>> +{
>> +	struct device_node *np = of_find_node_by_name(NULL, "par_io");
>> +
>> +	if (!np)
>> +		return 0;
>> +
>> +	of_platform_default_populate(np, NULL, NULL);
>> +	of_node_put(np);
>> +
>> +	return 0;
>> +}
>> +arch_initcall(par_io_populate);
> 
> 
> The par_io node is a sub-node of the soc@xxx node.
> The soc@xxx node is simple-bus compatible. This child node should be
> populated.
> 
> Why do we need this additional of_platform_default_populate?
> 
> Also par_io node has a compatible. Maybe the related driver should call
> of_platform_populate() to populate children of par_io if needed. If this
> driver is missing, maybe it should be created.
> 
> Do I miss something?

As discussed together off-line, at the time being the par_io driver is 
not a platform driver. par_io_init() is called from setup_arch() by some 
board setups.

In order to fix the regression, I keep it minimal with an 
arch_initcall() function which is equivalent to what we had before 
changing this driver to a platform driver. It will also ease applying 
the fix to stable without too much churn.

It will still be possible to rework par_io driver in a follow-up patch 
and change it to a propoer platform driver.

Christophe


