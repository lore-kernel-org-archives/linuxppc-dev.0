Return-Path: <linuxppc-dev+bounces-25096-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EF5C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 12:01:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9npr3gfPz2yYd;
	Thu, 30 Jul 2026 22:01:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785412868;
	cv=none; b=GXiV22/ynFEimocMCYgqZFDHcpXIG27R9cLBvmoWl+T/6irJCp7t3Z4OWMgIJz1Nad8gFZ8ZFkqaEuFEVUYLQhmxkG9qihocrdRTURbp5PSEO2sJjn+eCUHrRTUCfEn0IHxVytUBV5I5Wi0eJGqzrXpStqtTRfgY+n4cfqeIhlWY0k6DTG7Ym7CO/X+f0T0mUq5I4JW5lh7m55g6QudoJH9DdMWEOSKAeKD083TipDYnGkKEJavQadP3hZT/c5eSpBcwHyjy+22nF96RkKsbshiJbo0C4XkpanTj0IdpSaDybvL6Dl2PZPrAzGr8DW/qZ3dPO/xfdkCfWVlm/ERhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785412868; c=relaxed/relaxed;
	bh=DHf18rSlNZKDZKjkZzbb9NgJagDAkYivuavqTnujb3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmZy4PrDS6DZZKSIhFnnHjhXMMP7UGcBsd2a9Vo/a7Zh1W46ZsqrBsroCLsbbmkhGqwP1sFK0FbFAoQAbOqKmKjTZL9ZKKI1wFfMWdn4THsOEp/mdJTl5ZZoAxMtDhuvsvo0otWVSA8B+CMZrtFzpkAziT5FBgxaLWsmL64bTFvPcOC4TT6fUDuz4dYdwnjVR8w4Jpc5fpR1TGHW5lJ9WuSNRL/B0o/3NYfSbpeKXLW5fM3vruLnwuthRY5cSeZ/EoTHScyqb1BnTu44sYfbNNq2dAMY6HY8CblARRSMugUpss/9F6QN3kbz7luqv0j826dhxHGSA5t0Vs4Se2+pAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9VtASuf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9VtASuf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9npq4c2Mz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 22:01:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 871AC600B1;
	Thu, 30 Jul 2026 12:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C6D1F00A3A;
	Thu, 30 Jul 2026 12:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785412865;
	bh=DHf18rSlNZKDZKjkZzbb9NgJagDAkYivuavqTnujb3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=T9VtASufsi6UhkYBym/rW+7GIcQGoutZ15mvneRHOETKxWcDl45W8Yhwy6V5bQR2G
	 9RZoWt+/awfySOhU5icPHSUWu3HdhWH4YGGtLV58it9SnbVQwcyBt9Wdik+JIcE/S4
	 njdXmNbigKVKE1oytHZlvxvGONIcf7ZtJZS/bKREHbubj9mbiHxfZf9E4Ey/sjq3AN
	 3e24tBRr3ZuOrG3KzQ8RKE4kRjCjJ4KPb/kb0agLQ/6k7NTexEIDQeq6mpgOocANHm
	 5bSh1uieJUfJIerYD0L0RMoHd+YybKhy7cRsfj0d0bRznpjaARbNVZPHBW82tgOhz+
	 kKRh4qQcNM22Q==
Message-ID: <223afb76-9f6f-48a1-a5c5-beb1a641916c@kernel.org>
Date: Thu, 30 Jul 2026 14:01:00 +0200
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
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <e1bd8dcf-9b8e-4bc7-8ba8-6c06222e1659@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/07/2026 à 13:14, Krzysztof Kozlowski a écrit :
> On 29/07/2026 16:10, Christophe Leroy (CS GROUP) wrote:
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
> 
> No, node name must not be ABI. Especially wrong node name.

What's wrong with the node name ?

Regardless, I messed it up, I wanted to use type but copy/pasted 
of_find_node_by_name(NULL, "par_io") from quirk_mpc8360e_qe_enet10() in 
arch/powerpc/platforms/83xx/km83xx.c instead.

Is it OK to use of_find_node_by_type(NULL, "par_io") instead ?

We have:

$ git grep par_io arch/powerpc/boot/dts/
arch/powerpc/boot/dts/fsl/mpc8568mds.dts:               par_io@e0100 {
arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi:  par_io@e0100 {
arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi:          device_type = 
"par_io";
arch/powerpc/boot/dts/fsl/mpc8569mds.dts:               par_io@e0100 {
arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi:  par_io@e0100 {
arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi:          device_type = 
"par_io";
arch/powerpc/boot/dts/fsl/p1021mds.dts:         par_io@e0100 {
arch/powerpc/boot/dts/fsl/p1021mds.dts:                 device_type = 
"par_io";
arch/powerpc/boot/dts/fsl/p1025rdb.dtsi:        par_io@e0100 {
arch/powerpc/boot/dts/fsl/p1025rdb.dtsi:                device_type = 
"par_io";
arch/powerpc/boot/dts/fsl/p1025twr.dtsi:        par_io@e0100 {
arch/powerpc/boot/dts/fsl/p1025twr.dtsi:                device_type = 
"par_io";
arch/powerpc/boot/dts/kmeter1.dts:              par_io@1400 {
arch/powerpc/boot/dts/kmeter1.dts:                      compatible = 
"fsl,mpc8360-par_io";
arch/powerpc/boot/dts/mpc832x_rdb.dts:          par_io@1400 {
arch/powerpc/boot/dts/mpc832x_rdb.dts:                  device_type = 
"par_io";

Thanks
Christophe


