Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29354606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBF4TsmR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jb5CP6G4Qz2y2h;
	Fri, 27 Nov 2026 05:48:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795718881;
	cv=none; b=Lvw+0DggUlEpzZKhw+8GkC0/dX7HP6zzHDsaaSU7+E1CgLCLhmNYgisKJocLXs639mz+p0Mb/QVTAo2oDXQHqHA/0NFcMEai1yUW5kT080A7H39MQ3nskzS7NaqTq02nOU0wgh5m+sdReqUfGxKbYEKCKEU96s78jSVkAxubvb8NYjDmP7IUS9iHTayBrkKcUKZduQnqT3IUkNib3K7fawH2uj0iWXP6Hrr1dIUUPXJUiHPwJHguqPjI983JHKX6jlDjfMG6coWBaZgmviCUqigfS3N48z3Dir0uMMgvBG1PQ6nPmVmMmcEf+sQdfptBttpJtm5mj7OOM15HsTUUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795718881; c=relaxed/relaxed;
	bh=DkUy01y7xEbf/+LpBM+I9BkjCedA7NkFboIBCgJYdX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbgNKfG7WaQOjvoo0K/736wCWx4faqf91oQtFx3Cl7GlOUD9OKo7KkGQtVvs4mWo+rPxqYfveMr9vzmMwpT2D2XrUqnVG2rwdEsamiITQ6Wwm5MP9F7+VtUPmAFXOuY+3ZCdw7RCmjJ7viUtWwn8pvdMlrRs4FjDYfm9ZtoNzgs9Ne0whG+q4/NdNQuc2w8qVcL1Ii3u0FnDjdKfPOTxZjFkzCyAlANt0cgiUMLHZGoJTgVF6NPg7qETrODgi1RGROBTHVnGrk0hLDKBEFudEmTpWQyRINpB7q1jEMVifGtDKoWIRnq7Fmm/15DgSY8YxNVRxf0BYNN9qmZpVj2+JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBF4TsmR; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBF4TsmR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jb5CN5JDwz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 05:48:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A69614399A;
	Thu, 26 Nov 2026 18:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96E01F000C4;
	Thu, 26 Nov 2026 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795718877;
	bh=DkUy01y7xEbf/+LpBM+I9BkjCedA7NkFboIBCgJYdX4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jBF4TsmR7GFh0k+NboYQnFAM4Y9gkAG1djVNMrQN9KWPX/AVg8obZFA8aMlb1vSBF
	 RFXE+SgvQW6oO617L66UefSjI5+Gik4HBNMhBLbx8qSb4SXhxFatRXaZMfhUI2cK2k
	 YASGpLIcsWeP8Qec2WYUrQc5K1JouNMPZkjtTCCyW3b1GfRV0ptfopc9X9AQFcIuFm
	 pbqFcvQiCeGUyrhZiu4js0k1W+cESSxlFxtoeahqRnvCCpQ6i0WKbyp6YOJm8CVYbZ
	 A/sZjS4dVvEiJy7q3qWWJ3svug03JcZNwXzevVScebjbg5dopXjvb0DctlWO6ogOSH
	 3mTYNeHIVBkqw==
Message-ID: <cdc5f00b-380c-4c8a-800d-967008c16a4f@kernel.org>
Date: Thu, 26 Nov 2026 19:47:47 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/6] lx2160a: change the pad muxes through the RCW
 override
To: Linus Walleij <linusw@kernel.org>, vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP S32 Linux Team <s32@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
 <CAD++jLnRWZrLfyBGGOikx_eeYXirahuB7E7yuDhB6KoSAQoA5w@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAD++jLnRWZrLfyBGGOikx_eeYXirahuB7E7yuDhB6KoSAQoA5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

Le 26/11/2026 à 13:53, Linus Walleij a écrit :
> Hi Vincent,
> 
> On Wed, Nov 18, 2026 at 12:00 PM Vincent Jardin via B4 Relay
> <devnull+vjardin.free.fr@kernel.org> wrote:
> 
>> The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
>> fields of the RCW. They are read-only in RCWSR12..14 of DCFG, and are
>> changed at runtime through the override registers in the DCSR view of
>> DCFG, which read 0 until written.
>>
>> Since commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c
>> gpio to support bus recovery"), fsl-lx216x.dtsi drives the override
>> registers with pinctrl-single for the I2C bus recovery. Its first pin
>> state clears every other field of the word: a board whose RCW programs
>> a non-zero pad mux loses those pads at the first I2C probe.
>>
>> This series reads the fields in effect from RCWSR and writes RCWCR, as
>> fsl_guts_rcw_rmw() already does for the SerDes protocols:
> 
> Once the review is complete, can I merge all patches except the DTSI
> patch through the pin control tree, i.e. does it have the right ACKs?

I acked patch 3/6 as maintainer of drivers/soc/fsl/ and include/linux/fsl/

Christophe

