Return-Path: <linuxppc-dev+bounces-23561-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B371C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Jul 2026 10:11:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsmc44srbz2xn3;
	Sat, 04 Jul 2026 20:11:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783159876;
	cv=none; b=fErA9GdLcBrWkCn0BNbFnfuF0s/kglR17MmFER1E46E4h22k1A8k1uEW3M9r5MI9IXayzyIWaW84v0BbHVH6dMBur10ijFr0hEN8Xjwdgj9Kc7GMAks1cAYrBtf1T0uze4qY5dBDSr/zBGT+8uM9Ri8D5SGrJ/OAxCnN47SgGkMVpWUkni4VtIQfGVW96D36+W8aEdZZsBRk/+kizrgheHJxSh0HiiDXNwFZG6MzJfA7O/+NkmHtp8zITbZHc5d2EcSG/YMeuG8Ldg/L9mY1GAIUNFmAuzucXy70PxaX7zxazkf6IBK6hAmiM/9yPf3OCW5bxb5O6H4trAFaPRJqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783159876; c=relaxed/relaxed;
	bh=fD9JDDyMpWujXUzJMf3JqGYMSVEZzAn4vojbKG0WcTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKp5A1LVhAwIwgdGmhQHTLJs/fOrDPce/WrPdIGvjrBmq3O+ToMycWKaz9Go2Y6Kc7aFf0PZX4FDzlijPvdIh4vWwtGzV2GJaVFXZe/ihsi1lQzcX7Ktx5dxQB3VYJgxr7Uc6jQ65t33LdN9FLensNVz5bGG82fyat1OlOQ5X6+ZzsLXcJzpNEvuN9GpkCtmpk5C0dIXuJVTsNFjiid7i6vcRuTySLC7OG8B/3xrPqydcCBSn/eTcTjpBUW8JYuZQWMoB4B44EcwS9u+ctr2wjEshmgefI/gtxpJ4kuxKjUAa/X8uxnFWF3tMHy9hTgVS9oTasObK0aM7+wpaLTQog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=nin1sInL; dkim-atps=neutral; spf=pass (client-ip=212.227.15.14; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=nin1sInL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.14; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsmc05YT4z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 20:11:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783159865; x=1783764665; i=markus.elfring@web.de;
	bh=fD9JDDyMpWujXUzJMf3JqGYMSVEZzAn4vojbKG0WcTk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nin1sInL7Lp+y8UshoPasqihnYVWzKc5kmmMgG4uXMu1v+i9QWKastKw63zCcQKK
	 ScGLplKdWrrE99xXC/EmZ1orzEvvFuSp0l8q7ufeA3oN8Qxur36wg1mHjze5nRfmw
	 57fu5OruEy0sG/XsnKgvkbuzKCbzfNixYBD2+iGP6Wx6idCqrPrF78UY++hZIwMi7
	 N29rXsCT4Qu+gE8jufchi8FE/0P+aNZQw4dzmUen33OA3Fk3YfpAcpnr9flWo3J2U
	 H0/SMNodh94HFKHh/IPpnvGoeeTdy+4QBmgHFtMnHLSnNd9MiDMOWv7CmvqqDG0Nw
	 RCBnbwib/xODRQJEGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjPQ6-1xMC6F1nKM-00csz3; Sat, 04
 Jul 2026 12:11:05 +0200
Message-ID: <76214621-6a8d-46df-bef2-5d96923db885@web.de>
Date: Sat, 4 Jul 2026 12:11:02 +0200
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
Subject: Re: [PATCH] soc: fsl: dpio: Use common error handling code in two
 functions
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Roy Pledge <Roy.Pledge@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:r3xq4w7hkcAi9EeoaOUmwI3U2+o/7P9C+ZUFf8+s10xONg1+Hkq
 qPqbn6T3+G7PRoLpwYsmy19gSl+DIokZVE1pJ2M/Grm8/vFaCal+nyPSg3cRqQiDtYTZbDv
 YfBTVyIrf6rUORQFlCmxkjDuYTt44NEukYVIQH0LPLE3DjhbhlCvjTFipgbmO0HnwWroAmD
 kaCI840QirWbaGW1sKPwQ==
UI-OutboundReport: notjunk:1;M01:P0:NjS+jvYLy3A=;kEDJU9BD+D8t/wqj5YKD0XZukqU
 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
 D6yrLp1Omm570zdTzRkTD0Kb7wY=

Pj4gVXNlwqBhZGRpdGlvbmFswqBsYWJlbHPCoHNvwqB0aGF0wqBhwqBiaXTCoG9mwqBleGNlcHRp
b27CoGhhbmRsaW5nwqBjYW7CoGJlwqBiZXR0ZXINCj4+IHJldXNlZMKgYXTCoHRoZcKgZW5kwqBv
ZsKgdHdvwqBmdW5jdGlvbsKgaW1wbGVtZW50YXRpb25zLg0KPj4NCj4+IFRoaXPCoGlzc3VlwqB3
YXPCoGRldGVjdGVkwqBiecKgdXNpbmfCoHRoZcKgQ29jY2luZWxsZcKgc29mdHdhcmUuDQo+IA0K
PiBJwqB0aGlua8KgaXTCoHdvdWxkwqBiZcKgYmV0dGVywqB0b8KgZGVjbGFyZcKgb2JqwqBhbmTC
oHJldMKgYXPCoGF1dG9tYXRpY8KgZnJlZcKgaW5zdGVhZDoNCg0KUGxlYXNlIHJlY29uc2lkZXIg
c3VjaCBpbmZvcm1hdGlvbiBpbiBtb3JlIGRldGFpbC4NCg0KDQo+IMKgwqDCoMKgc3RydWN0wqBk
cGFhMl9pb8KgX19mcmVlKGtmcmVlKcKgKm9iasKgPcKga21hbGxvY19vYmooKm9iaik7DQoNClRo
ZSBhcHBsaWNhdGlvbiBvZiBzY29wZS1iYXNlIHJlc291cmNlIG1hbmFnZW1lbnQgY2FuIGV2ZW50
dWFsbHkgYmUgaW5jcmVhc2VkIGZ1cnRoZXIuDQoNClJlZ2FyZHMsDQpNYXJrdXMNCg==

