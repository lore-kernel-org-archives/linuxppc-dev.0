Return-Path: <linuxppc-dev+bounces-25725-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17531C5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 05:45:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK0vL3RHhz2yvG;
	Tue, 11 Aug 2026 15:45:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786427102;
	cv=none; b=AnSyLR/QgesT6rtGB+AWP/9k3IGHqj8gdMs35H5P9dk4N8ubJeOMeVNWs1Vsl+Qm0HKilnes9n2W8fPzKO08tTnLWFyrwko2SSozxFHJanl5llpXzGtFz90UayKlyBxT6PK8SCjPeOlY0RO3Tf67JbIQ4TYUphDZVtFM6cE3N2at/O/VXR+JKxKI7OH0useCTuSbNv7iMdQFBK1s3jURllnuHjS4DocjpGiJDPXAL/QoQdvneWYm5q7b2LVY5vIfX4AzN0fWC13uXCvWOPvcVGs9xkVRxWsxeMSeMHr30MUQgx/CE/P761lz3+TTF0x3ixmtbfeAa4rKvhL9oKC1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786427102; c=relaxed/relaxed;
	bh=GcCRuQu47XbS/YabNwNF7zEFiZjwtTPut+beTDpS0dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DarWYja9AR8GIqQ4JZHCRrSQshDzrRZKh65lUDLYdcUjcLcKqUniJ+J5f/1SJ5rkDisvs1ge6YdVzhtc/vhkSQjjEQds71OJOl9+S8cn6xdfvuGFuO5FnZMCoRZe1tw5Qvmmc3DbliObWNWUH4khleDs3WieR9cqBMAeAHKrZosvbRMSjxCJeZs8JG4BTk5A9K4qg5qDsEeqWfYUVnsUCKNdfyGWeCDqf1jO3p6uqJCeNYpazyP9GNdf/Wdf2l3f+5geL/XOaaK65uCYkb8KH3XS93/apl9uxX5jUhHmuBcekRbM4g8r7rSLePlonrWoFmCXV7Bzi4w4BT62LTnb4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezmmLbMW; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezmmLbMW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK0vK2tBpz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 15:45:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 43A0A41793;
	Tue, 11 Aug 2026 05:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2CE1F000E9;
	Tue, 11 Aug 2026 05:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786427099;
	bh=GcCRuQu47XbS/YabNwNF7zEFiZjwtTPut+beTDpS0dc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ezmmLbMWtbTQ10MqU7kjAysMd36nQLrQhc1zGs7TwsT6ee9sTrc5hzZF36tqemNxP
	 f8Cjha/6JeZViNIRVricIFAP7WI+CtYHe7Ei1J9agThhTb52YcRx1/ZVMh+fGScG+J
	 beE7eNA8SzUqSHxBeFZ+qkKM9+6vwaY0DGAIGuTiTYINeMlhbA9w2OnHyafrvrSY8k
	 Cwbcv/yrvnjC+Q091v6uhJSR0SGsWfrU+mkaJfskaHrb9AF+iwIMxkLrhzkrAz5P5m
	 rPfwUi+PNSJLUo4ja5bMlRdh55XgS0jupQ8ihj+HU0t+bb8iLV1fQPLKYVhZ/gMls4
	 xktpa0syUJjWA==
Message-ID: <dc40dcae-3017-4e61-8c6d-7e6127e4ee77@kernel.org>
Date: Tue, 11 Aug 2026 07:44:48 +0200
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
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 shawnguo@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com>
 <20260810-normal-cuscus-of-argument-4b230b@quoll>
 <CAA+D8AM9s7EX-G246Hf2=DOx5q2qXWg_MjUCaoJ8RggOjp+5cQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGPBBMBCgA5AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJp2mE8AAoJEBuTQ307QWKbeaIP
 /ihHTkTW4KsN/DQ945JJbyu5tI0J80Wue7QyyLPglyKfhgb5cLLNPpOC8cCIJsc7+W3i2P38
 s2c1cOH6CYGE7E9ur3Vfme8NW2S2I/Z8VC7bZnzyS23wT17LrsdS/qCpx4o8U+pt/xdXDKph
 EGRYrIEmMpUWvyYzyYKGIe25FtaayIIKpq8eZYyFcp2f/sG5IkOW5uZzHPMPdcm87jU7fyuQ
 rAU2vx9r+ulUfQ/q9Z2roC/ode3l7t2pN7BCBCsUDp6JCrUyZrtT1e7EbA0ZRP3aOBNk2P2E
 DQOgJGjGdO5Yx2Y9LFtltu6JbsBJHi1syGRX3AtQYOMc4Y1WGoeZJmMlvKj2ZqqXNkcWi2DS
 IQEWB0uW6CqFsBBIMGDa+6OzdaVO/uAVXWDWml02Men3CILdI1MbVjoh8ECqYUY7OQ+JJvNN
 vnliuq5WM3Ghd3jg/LZZrxXjdIginRHFQCjIJYLKpLZWm1/iDFedcfzqRNYmTtqscdCNHW41
 oT3Z7BmO9xwdjuwBS6nmS6JJwkbf5Ot2QR4pB/DRU7ZwjT1qHe+9r9gF32wXVQatHNGK/VVu
 sfwOnkdxCWkp/qb2gdQRmZh+SedStWshigH6sNfuHBloF/q+hjMRc8b2m326OZdrbSHwY1Sz
 vti8Hn7n8NjdHO9LKB7BIdjkA9DA5WsqOuVCzsFNBFVDXDQBEADNkrQYSREUL4D3Gws46JEo
 Z9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLueMNsWLJBv
 BaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6eiOMheesVS
 5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wAGldWsRxb
 f3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA6z6lBZn0
 WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9YegxWKvX
 XHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt91pFzBSO
 IpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gUBLHFTg2h
 YnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/JoFzZ4B0
 p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu4vXVFBYI
 GmpyNPYzRm0QPwARAQABwsF2BBgBCgAgAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmna
 YUkACgkQG5NDfTtBYptX+BAApg32CkxwNucNEi8WfWA8oKkW0y8YDuY6ORMo9FWNGiT/OTy0
 vyJrLocrpn86zwfjVp+eCrssPYh8eqJfnWqmYv6ACQtHPYzPZQ3mSo8H97Z01oUxITzCxpXm
 ZkLgPIqtDPcC2E3dPM/fVxcyowM8XsaMA9wcsaUYrta8toOq2b9tKcjleKMfMrm0gQ9u7wUc
 QbLkwj6TCLOwucb07GXzLTNF9PZmaDUpKAZjMjmrW+le+SFvQbhamx0rxLWPR0NWntXpbCn+
 +ACch03p/JyTBVktxFsFyCt7pTPE1kEaeuXBTe/a2D9iQvRxRW19LvuO2e59/u1wYUiH/orz
 wbIC2S4dBsPAPihL3ztOU1yE86GPyQtSE0kU+/7snnLt4QGi6PChf3t5gnNjAzjUUovO8rgI
 c+5yN5heq5loYHgK6OQ9OlHzsPHO9e9MOQcKlFycs1pyijFGzDwdNUm/SchK8iWT2QApTx4A
 K9bCVaboTA2T77QYkRcRJYSsO1alGX0ome/hMLD1daXlkrNUp1HWa3K4iytLRXjCSIorWiGs
 n+q3krnpXu3TFkA8qtOFZMdnIiFuiq1yLT8hptsV5xh1TA2nsVvSYiaCr3q4s4BKjS/KrLDb
 qoxzw8ISjdUp4pA85vb6YLCmb39NgidD+7PmAr65lBNveIFynTgsja1rRQ4=
In-Reply-To: <CAA+D8AM9s7EX-G246Hf2=DOx5q2qXWg_MjUCaoJ8RggOjp+5cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/08/2026 04:28, Shengjiu Wang wrote:
> On Mon, Aug 10, 2026 at 3:14 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Tue, Aug 04, 2026 at 06:02:14PM +0800, shengjiu.wang@oss.nxp.com wrote:
>>> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>>>
>>> The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
>>
>> Which SoC? Did you read this binding you are changing?
> 
> The i.MX35 ASRC (the original) already supports three conversion pairs
> (A, B, C).
> All subsequent SoCs that reuse this IP -- including i.MX53, i.MX8QM, i.MX8QXP,
> i.MX952, share the same three-pair hardware. This binding covers all of them.
> 
>>
>>> The existing binding exposed only a single generic audio-graph port,
>>> which cannot represent independent conversion paths when multiple pairs
>>> are in use simultaneously.
>>>
>>> Add a ports container that enumerates up to three sub-ports, each
>>> representing an independent conversion path:
>>>   port@0 -- conversion path 0
>>>   port@1 -- conversion path 1
>>>   port@2 -- conversion path 2
>>>
>>> Each sub-port references audio-graph-port.yaml as before. Hardware pairs
>>> are allocated dynamically at stream open time; each active stream
>>> direction (playback or capture) on a port consumes one hardware pair.
>>>
>>> For backwards compatibility, keep the old single port property but mark
>>
>> Why? Did the old hardware change that it has more ports/paths?
> 
> The hardware has always supported three pairs; the original binding simply
> did not expose them all. This patch corrects the binding to match what the
> hardware has always been capable of.
> 
>>
>>> it deprecated. A schema constraint (not: required: [port, ports]) ensures
>>> that both forms cannot be used at the same time. The binding example is
>>> updated to show the preferred ports form.
>>>
>>> No existing upstream DTS file for fsl,imx-asrc uses the previously
>>> documented single 'port' node, so this change does not break any
>>> in-tree device tree.
>>
>> Does it break other users of this binding?
> 
> No. The existing single 'port' property is kept and marked deprecated
> so that any out-of-tree device tree still works without modification.
> The new 'ports' form is additive only.
> 
>>
>> Why mentioning upstream in the first place? Either this change breaks
>> ABI or not, explain that.
> 
> The deprecated 'port' property is retained, so this change is fully backwards
> compatible and does not break ABI.

So why? Drop redundant parts.

Best regards,
Krzysztof

