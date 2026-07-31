Return-Path: <linuxppc-dev+bounces-25175-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E54C5516D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 10:04:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBMB35RDVz2xpn;
	Fri, 31 Jul 2026 20:04:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.163.59.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785492283;
	cv=none; b=c/trBs5DkH0NxYKqmFsPV8LSQdLMSzCIlPBK5QxeKokcDUI6Zuz2h80yyE4ivwRihV0V+YA2f7Ydk0VNGY6K9oqnFMS8O62EhldLLpGigzIM3EHkP15GYEJlePyC0IuRRcYMQ50Xovox9ee4TGd1qVPtz/rbDdn7pXI81S98COUeYC3/w4vCdF0oYxDW++QFFXNU82mXPF+r0qgdkiqo7lm9yG16F2M3X01VuucGA+V8Qn7gjF9LKkE+9GZKFnj8bkif8RAoVQv4z6m2l+lmq46Uumoerv1e2TpbqQPVr25pZ6MzSsSZG0GWXN5aKQpusGzsA9NTPveLgmOZEdEapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785492283; c=relaxed/relaxed;
	bh=rbmJlLA3q3nQT7gHesv0aQMb+y3lROiAZrmQ+DGtwCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2ZfZeeqDRuTW/gnnu0dx3tVl86ROQCM6fr85vY2hlj5xdlpaq0Ebacyr6iVmHdI8qPIyKNw3Pk/oWATPBtqn883B0smycAxbBreoE67B8zdZvBCHB4/JFzHqbBmG8EDrSM6yW8aCuXsnFvTLjG7jtYD/ZzNnppyCTHIFIWIsNV63es/Tjd4HtFttnra2e2EOO7YeZ4ec/pO4KAujPiuMYCPupubluY8/cUdGuFT9+Y8+wVFSM/YEPgapl0USyt/OG0GOA9Ept88Vh8eqMN38ZjlGjVhwZf5lMjW42xQNV3g9qIJ5lVE1U+GlUpxgxHMirpRHF3HAc2po8KleGbpzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; dkim=pass (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.a=rsa-sha256 header.s=mail4 header.b=PtYSZNIM; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.a=rsa-sha256 header.s=mail4 header.b=MnNS7MFK; dkim-atps=neutral; spf=pass (client-ip=95.163.59.9; helo=send170.i.mail.ru; envelope-from=fido_max@inbox.ru; receiver=lists.ozlabs.org) smtp.mailfrom=inbox.ru
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.a=rsa-sha256 header.s=mail4 header.b=PtYSZNIM;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.a=rsa-sha256 header.s=mail4 header.b=MnNS7MFK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inbox.ru (client-ip=95.163.59.9; helo=send170.i.mail.ru; envelope-from=fido_max@inbox.ru; receiver=lists.ozlabs.org)
X-Greylist: delayed 914 seconds by postgrey-1.37 at boromir; Fri, 31 Jul 2026 20:04:40 AEST
Received: from send170.i.mail.ru (send170.i.mail.ru [95.163.59.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBMB00Ny0z2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 20:04:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=rbmJlLA3q3nQT7gHesv0aQMb+y3lROiAZrmQ+DGtwCU=; t=1785492280; x=1785582280; 
	b=PtYSZNIM8/bzJbWftfxjGo2fA1Ay0Rh2Ra7bhdbqz1gtT+xtPItc7Wn7qHyFKl43+6nTO+ONlf6
	y1TkEB6SEbySTCs/wkUw3O15S/E95CfdrbszgT3DPPZONd36K5tzSle/1Kw8jWD7znMGfxKVqcNmy
	7gOUvMTvpbpn/qJbJuILx36HsMBzOmQdNeeNgn5p7aLUzzxZi+dcl20H7Unwb98eoWFvKzcUwAkn1
	1HUiagXihEHiZNQruy5dO4I4yA223KMiIvQ0jVjcM1k//cujsdcjBA3jjxqX2qguSBOjjkhJtyeEd
	Y8NkDqt2QHc+i8YKYeblsS/5hD9HK+zCUj1A==;
Received: from [10.113.163.241] (port=41188 helo=send105.i.mail.ru)
	by exim-fallback-67c48d97fc-p4v8n with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1wpjrh-000000009Ww-3uou; Fri, 31 Jul 2026 12:49:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=rbmJlLA3q3nQT7gHesv0aQMb+y3lROiAZrmQ+DGtwCU=; t=1785491357; x=1785581357; 
	b=MnNS7MFKybXjNOa0ZzdzjgLZqxfU2Mhyv9sdey5G7glli1xXHAKzSrCVvu0UJLgMI5rVD3VI44L
	RNpe4D4UvqCYSDteojwearCYbaxA9AQIhOWryfXJ/9W4NxVZozR6H1NNXbrsD2r4XWonS0qXOLNBF
	R9KApvEJwy7nr5pJl8h50GyRgFQGzlQ0AMF3fypRzp+h2o6SmoIz5Kh62gPIbKwstcJybvSYDvN/A
	8Tm4aaJUvrAtVevWehHtTwDwnE+ZxeuamJ+VDId3M0HK0b0NSUXEEC2Me/CJwQcifsf1jzqQzPtCJ
	Kcs5YafcvpXrrabrlfH5ysoMcvFJy1AcpRBQ==;
Received: by exim-smtp-7f4897b4d8-sdvfx with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1wpjrT-00000000CKv-3y9d; Fri, 31 Jul 2026 12:49:05 +0300
Message-ID: <eeded0ae-2373-4f4c-916b-fc7ef69d1181@inbox.ru>
Date: Fri, 31 Jul 2026 12:49:01 +0300
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
Subject: Re: [PATCH] soc: fsl: qe: check platform_driver_register() in
 qe_ic_of_init()
To: Linkai Gong <gonglinkai@kylinos.cn>, Qiang Zhao <qiang.zhao@nxp.com>,
 Christophe Leroy <chleroy@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>, Saravana Kannan <saravanak@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260731094608.1883391-1-gonglinkai@kylinos.cn>
Content-Language: en-US
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20260731094608.1883391-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9DFD0580A18F85590CECAA203DE555ADC8ADBF53EAE2F439F182A05F53808504043A30FDA614BD1E53DE06ABAFEAF6705D13E1232761ECEED5A7357720D433CC0FC108E89ABB85EB9
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B9D6DADD6B53929DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375663F17BEB63674488660C219CB252CB0048386F7D7E49B163DB0D8299AED515A848EEF46B7454FC60B9742502CCDD46D0DFE4D9CDE3FF759CFF6B57BC7E64490618DEB871D839B73339E8FC8737B5C22494854413538E1713FCC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0A3E989B1926288338941B15DA834481F9449624AB7ADAF372E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3335407143AA9223635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A50C39E6D6EF5E25495002B1117B3ED696E9C16A86A627A6650E58516B1639A14B823CB91A9FED034534781492E4B8EEAD37F46C620FF2CAEEBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6595D1FD8CAF8722B1002B0D202F763F675C0D2A39E2DE76B6CFC2FB42B26F389790ADDBEB1EC8FC7FBB8341EE9D5BE9A0A76F26694F9F914075F9CEEA7BFDACB1FA6981F0E138A44E239A4D55D2591C6014C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVczkDsfooUjf2LE7naJC7AQ=
X-Mailru-Sender: 689FA8AB762F7393520AF17B8A65FDE2630AB746A780DCB0BC4FCA5E43424B5667FF164975FC828890DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4744A1B435A106E18CA368C651CDD1605D3B4A11B352889A6049FFFDB7839CE9EADF18B409CF19A3AD33FFCEF67FDD76CA1A9A2D66682FB76D1629247AA733D88F85783329D7F497F
X-7FA49CB5: 0D63561A33F958A5CC948B3DFE7EBD245002B1117B3ED69623F046FA435D584B7F318CC1AC4EAD5F02ED4CEA229C1FA827C277FBC8AE2E8B7D2904CD0E3E5B04
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZPuthde2QaJYbDILL1DecLg==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

31.07.2026 12:46, Linkai Gong wrote:
> qe_ic_of_init() ignored the return value of platform_driver_register()
> and always returned success. Propagate the error to the initcall.
> 
> Fixes: be7ecbd240b2 ("soc: fsl: qe: convert QE interrupt controller to platform_device")
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

Reviewed-by: Maxim Kochetkov <fido_max@inbox.ru>



