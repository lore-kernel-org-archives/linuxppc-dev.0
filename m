Return-Path: <linuxppc-dev+bounces-24950-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAB9C53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 15:30:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8fY52v0xz2xyh;
	Wed, 29 Jul 2026 01:30:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785252617;
	cv=none; b=cclb8NtkssxBUeZ7k2uTys0JpQapRbgj7TIlGQf6nlTf/p+4B9lsU12Lf+N1a3KRF3PGdPW4FNeACIzmDvMSU9zp6dhJPgn+iRjpR0NqAI89u/aFCOz5s43NNyQERAFSAT15JK4o+rEbpSyxu8MliRQ+FbBypB6bVERZi9f9q7J6T2TsUuu4E1a7YKTq/kyGO2tmJ0cI0KMAjGlOxbNcM7TPksbbc4x44jmPVTlHQIQ+ViTK6BkNVr5zQBL95vI3pDa3O02JR4bjjoP0uew3S7cl270PJNK/O1MW5DWyOm7Emy2B73RoeKMs8OCavot0boqBSPaKedo6BOQ7QA3/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785252617; c=relaxed/relaxed;
	bh=kHMHe8DXYFbv7HkrjiopSzw/zJOF/JWl21dsP0Poq2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtcHE+SK4Fnk1AUMBOPEO3zeZ3KxUGDpR7Ym7Q1lZ1WYoa2ECI53AaHCC2LNZkx0smz/K934YLN8sSJpJnQcbT89GEN0XN/y7GtG52OQTYUk479iifasQjMuLxR6t6qInhUXZcx+r+iijm+y5IE26PCbAmIPb5EfIMGUPhc6fFtM80+tjOtiuO7N0eOkziNc3dOcCICvqWmhD4+FKySaxbldl9Z/1sNF9h3Ca621cFIrslhy0vYiEjDj2IHKtdhMA9aMor8WEsXntrIxtwCOZ43D7ZTYDCjc6tgewU8bW+6BmO2tMTMkz65kAe3VWzb5meZGJb0HQhIXX3IvsMuvgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewu4Kyfb; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ewu4Kyfb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8fY42Rktz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 01:30:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8705641AC8;
	Tue, 28 Jul 2026 15:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4301B1F000E9;
	Tue, 28 Jul 2026 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252613;
	bh=kHMHe8DXYFbv7HkrjiopSzw/zJOF/JWl21dsP0Poq2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ewu4Kyfbqhdf1jvk5L9GXGpzcB33+Eg/6yRdLcE8d1JVDXQoTvVzDBnFDVp/7c6yB
	 9hj7lZs4vQ4dmZWRWl2spgWiKe6kWE6rPE05cHxhVlMHih9pvWmaQet+wBCpbaKSi5
	 7Cv2lmpeP4xsnVG92JBsR+FooE1So3SFUv4GAnZllYkeQDY48mIIYCI5EKXrDWvoyw
	 Tk/qTuaOQwTAob3WfLD5POa/TEZCb2TGwOOtPiI/54aP+BWBAxcCQR4+JSN7cKicU8
	 UlLxfOlHeDzwpyHdKzAYa1UaPOfhHNqnZhWwgrrdkY/jV/f02u1NYHxIeqCurGVGw2
	 qNETRf1zaM8qQ==
Message-ID: <5306f685-46df-4956-9402-a86834f913c7@kernel.org>
Date: Tue, 28 Jul 2026 17:30:06 +0200
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
Subject: Re: [PATCH v4 phy-next 0/9] RCW override for 10G Lynx dynamic
 protocol reconfiguration
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tanjeff Moos <tanjeff.moos@westermo.com>, Michael Walle <mwalle@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
 <20260723150105.da2cqgtb7t5vw2d3@skbuf>
 <20260728134746.p7zqstau6376xifj@skbuf>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260728134746.p7zqstau6376xifj@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Oltean,

Le 28/07/2026 à 15:47, Vladimir Oltean a écrit :
> Hi Christophe,
> 
> On Thu, Jul 23, 2026 at 06:01:05PM +0300, Vladimir Oltean wrote:
>> On Wed, Jul 22, 2026 at 02:15:54AM +0300, Vladimir Oltean wrote:
>>> Ioana Ciornei (4):
>>>    soc: fsl: guts: use a macro to encode the DCFG CCSR space
>>>    soc: fsl: guts: add a global structure to hold state
>>>    soc: fsl: guts: add a central fsl_guts_read() function
>>>    soc: fsl: guts: make it easier to determine on which SoC we are
>>>      running
>>>
>>> Vladimir Oltean (5):
>>>    soc: fsl: guts: perform fsl_guts_init() error teardown in reverse
>>>      order of setup
>>>    soc: fsl: guts: make fsl_soc_data available after fsl_guts_init()
>>>    dt-bindings: fsl: layerscape-dcfg: define DCFG_DCSR region
>>>    soc: fsl: guts: implement the RCW override procedure
>>>    phy: lynx-10g: use RCW override procedure for dynamic protocol change
>>
>> Even though I intended these changes for linux-phy (they are also
>> build-tested there), I'm fine either with these changes taken through
>> Vinod's tree with Christophe's ACK for patches 1-8, or through
>> Christophe's tree with Vinod's ACK for patch 9, really.
>>
>> I see on Patchwork there's a minor issue in the commit message of patch 3/9:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-phy%2Fpatch%2F20260721231603.67865-4-vladimir.oltean%40nxp.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cdfcaa68452fc46a3285108deecaed436%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639208432793851204%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=AUY%2BIZEiFp3aLAO4HlHQCrJ9ZnCyFqzshPEGq6CpfmU%3D&reserved=0
>> "WARNING: 'struture' may be misspelled - perhaps 'structure'?"
>>
>> Could this be fixed up while applying, if there is no other feedback?
> 
> Do you have feedback/a preference for how these patches should be handled?
> 
> I see Vinod acked patch 9, so I guess that means his preference would be
> for you to pick up the entire series (which is indivisible).
> 
> I checked that the patches apply to your soc_fsl branch:
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fchleroy%2Flinux.git%2F%3Fh%3Dsoc_fsl&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cdfcaa68452fc46a3285108deecaed436%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639208432793877128%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=xjpwRCMIncWpW89zKzhil20%2BcUhnG4LPaFNbxw1pue8%3D&reserved=0
> 

Hum ... Seems like I overlooked your message as it was flagged phy-next 
and I was on summer vacation on last two weeks.

I'm fine with taking them via soc_fsl tree. I won't take them today 
because I'm already pushing a large series from Paul Louvel but I'd push 
them by tomorrow or thurday.

Please raise hand if nothing happened by friday.

Christophe

