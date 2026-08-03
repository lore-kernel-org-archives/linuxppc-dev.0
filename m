Return-Path: <linuxppc-dev+bounces-25277-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D536C55179
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 15:03:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDKgK4g4Pz30F3;
	Tue, 04 Aug 2026 01:03:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785769405;
	cv=none; b=elX9PjpfLuj2lFPPs/BmSH7oKMZ7W5+geiXV0Ii9wib+B5fXULDp9DNmOkMwMqe5mloKod5nJGxUOH/HqUCkbT71P5FhMVVj2zacC0TyM3Y6IMKy223movfME7SASM9B8JzcnZxvh+9o6mYMDTNgNGk24qEyf5J4NbFV1csTrTGLJuv6eJHDfse6BhzNpNKhzCvUoSHOx4De3R9usbkrWnuZonOKdqnKds/xzz3g3XOeX775UfDr/ln1JP1+q1AjRSaNPLLASHOOUn+ER8/A9dwZn6o8HwTCpjYX4rENNGmfDe87pkYff1KwGvHkpr0FHW+z7ieLzpYVlHsirU59pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785769405; c=relaxed/relaxed;
	bh=Bv/5UCLd1dIUorgqwAbxHjEFyoaSxIeYFjxIhGJoihM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wdrrq6d4YqZI5KzmYaFCiqQB5AK5Updr0PNdyunWC9NslotOhhFI33D0yQZMVzCgJfZrpbvcV4E57fuPosjOqIcwMA3+xm3N/G96wcwDXQ0JiYObdN5hDI146YnxGWkDZOubfWCAC4n4HaBslnHNusC8/NX1SucCeM5Bf3v1pjnbuLB8Aysq1JqxmBnJ+og7nWG0vD5HT/a+r52BlkZ/AKdMX5sh4/ehPPSd+Z/2yW+NlXLMZquXMogne9wf+YO6iAT77VgMoAA1TyEo9ekJaok9Ukdq0sX8lGWbqGlG7RdGsjxBlvjC9U53Hcua7GTPFN16K7nWAabehyFCyRJl9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEPItdHX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEPItdHX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDKgJ47rcz30F0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 01:03:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A6B64166B;
	Mon,  3 Aug 2026 15:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292731F000E9;
	Mon,  3 Aug 2026 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785769395;
	bh=Bv/5UCLd1dIUorgqwAbxHjEFyoaSxIeYFjxIhGJoihM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SEPItdHXk9NWXbVczWwSggvG5CNVE7BjqtKavfbCyGE9dCarOisk/+OGgF1KedBKM
	 GQ2JRwcJ4RLVfm/jtLLALsAzYqjr8QVy2X3r9H8RrhS+3Ong+Tir8CRf9DWwf/xxu8
	 L3RgEX9rl9XdP1PHV0MsA2OUV6JRuT81Q77LJwonVw0y3ZB+imFT1cmoHlLjR61o3U
	 kcay+9G1LDa+tkgeuk7mcMzyjrlaOjLQVB/KOOFAVbOcAcw0S5WkxHcu7GPv3DpQ8i
	 aouOVkEhkJaF3iXoHwJRq6aLY9bcJVmty8btvnQCn2beuZHkaJxEJNvLPbkfXkRT5q
	 XMkcSvrRczMoQ==
Message-ID: <c6b54353-69f3-428b-be9a-266081564421@kernel.org>
Date: Mon, 3 Aug 2026 17:03:12 +0200
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
Subject: Re: [PATCH] net: wan: fsl_ucc_hdlc: allocate enough MURAM for HDLC
 PRAM
To: Matevz Langus <matevz.langus@borea.si>
Cc: Zhao Qiang <qiang.zhao@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <C736AAC7-5345-4B3B-BA33-299ED9566F65@borea.si>
 <03365777-874e-4e5a-be18-5e546b172db3@kernel.org>
 <066899BE-9B23-4FCC-BBE1-6CB3BC8CD196@borea.si>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <066899BE-9B23-4FCC-BBE1-6CB3BC8CD196@borea.si>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/08/2026 à 16:42, Matevz Langus a écrit :
> [Vous ne recevez pas souvent de courriers de matevz.langus@borea.si. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Yes, this patch is for all devices with QE / QuiccEngine.
> In reality also for CPM based devices like MPC8260 even MPC860 on all cases 256 Bytes should be reserved for PRAM.

Please don't top-post

For MPC8260 I don't know, but but MPC860 it is not right, on MPC860 PRAM 
is fixed and you have another PRAM at offset 0x80 so the SCC PRAM is 128 
bytes max, except when using it for QMC.

Christophe


> 
> 
>> On 3 Aug 2026, at 16:18, Christophe Leroy (CS GROUP) <chleroy@kernel.org> wrote:
>>
>>
>>
>> Le 03/08/2026 à 14:58, Matevz Langus a écrit :
>>> [Vous ne recevez pas souvent de courriers de matevz.langus@borea.si. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
>>> More MURAM needs to be allocated than just sizeof(struct ucc_hdlc_param).
>>> We have noticed MURAM corruption outside of struct ucc_hdlc_param. It was
>>> caused by QE UCC HDLC microcode. NXP QEIWRM.pdf Rev.9 05/2018 chapter
>>> 14.2.2.1 HDLC Parameter RAM says 0x6c-0x100 Reserved.
>>> Even looking into QE UCC HDLC microcode source code reveals it actually
>>> stores data beyond 0x6c.
>>> Tested on LS1043A, T1040 and MPC8569 boards running UCC in HDLC mode on kernel 6.12.
>>> Signed-off-by: Matevz Langus <matevz.langus@borea.si>
>>
>> Same in MPC8323 reference manual, it is marked "reserved" until offset 0x100
>>
>> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>>
>>
>>
>>> ---
>>>   drivers/net/wan/fsl_ucc_hdlc.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>> diff --git a/drivers/net/wan/fsl_ucc_hdlc.h b/drivers/net/wan/fsl_ucc_hdlc.h
>>> index 71d5ad0a7b98..e170d3ac9116 100644
>>> --- a/drivers/net/wan/fsl_ucc_hdlc.h
>>> +++ b/drivers/net/wan/fsl_ucc_hdlc.h
>>> @@ -60,6 +60,7 @@ struct ucc_hdlc_param {
>>>    __be16 haddr4;
>>>    __be16 ts_tmp;
>>>    __be16 tmp_mb;
>>> + __u8 reserved[148];
>>>   };
>>>     struct ucc_hdlc_private {
>>> --  2.34.1
>>
> 


