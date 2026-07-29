Return-Path: <linuxppc-dev+bounces-24977-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E540BC53219
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 08:25:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h954J0ysZz2yDr;
	Wed, 29 Jul 2026 18:25:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785313520;
	cv=none; b=KXikbM8mGW/lePrrq1lSQH8XQSAodc3d7iZ4DY+7xVEOMoy1hSM6Zc8vdw6ge9ApA33gjUG0DJFVuK2ol9xY7dEO5tx0kfRc8yCUzjIDIjRorJVxO1D6RyF1Q5dV6kBqFrhfA+coOVuqPHglQmatlW/4/ZvV5D7ud9kyENnF2T+jIwrx7QZPY7S2KMeoM06nl3ZG5Cky/CQLLcEl30cayPpuVDjtSDRGxiV9h3yFZBeRIhRU3SZ22SuG+mnuSvB70/dRRGfnGF3T0nEpeOdUFNvVVuUddA9qD+K7hAYTiKRDEspyfubDyDQKNk59LJdjTAd4+VZayt3adyeX3Vx02g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785313520; c=relaxed/relaxed;
	bh=8JYL+RTPpZr6pSZ7cHRtkecPpLyhLgLldTl1fBtQvsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnLtQMMTOJtqKWEwXXapkQTreWCgCYTajIOYoxXDBuZbZbe6qUM9EMOFCYW5qySZGkw7IdBbrK7tM8Xe2eHdSOWdHguG7ot3qX4uzYRJo8zPrFMX3etK/4C1Ks2fsupMyKclWE+AqrYvExt6VLxQrg6mV5Zeq8HFaxnLDTfM1+3ZL+jCfbYQ/FpLpI5B1eCfNXQY3jhGWdg5aVDLYVtomz5OYb4ZS2KNmM5GKUF7vCmP7ZOUvE+n2+JikjqScgE7Vz47qPtn8FqhDwpI7gG+wZPfUt4aNH2eEPgUkoc4pERw49LUWZ7/HjaEeXdiL2mNUIU6EeP2Mj6WvtWYpwRrgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=i9TLnh68; dkim-atps=neutral; spf=pass (client-ip=212.227.15.3; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=i9TLnh68;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.3; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h954D4CFgz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 18:25:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785313508; x=1785918308; i=markus.elfring@web.de;
	bh=8JYL+RTPpZr6pSZ7cHRtkecPpLyhLgLldTl1fBtQvsw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i9TLnh68Ljnt7U5o1qZP6cdOlsUE2HJR8AGw0SgRWsYfYJ0Fy4gpXdf5uIbc7ktx
	 8HPJllG+E2tfkurxJ2fd8dALalbWrK7ASVu2TdP8AgDjFSyzjjzozvJNapQmZmA6d
	 f6EiZoNkhGwxAgn7cImnJXg6KB6oWqLDD5AKVgsqXlrIgUIQ5W7sVnLZSX3b5RyKg
	 sg147EL+itzG76PPYPok8VMTRaG6UiPXQjDTRSlk+q1OFHTfUhALbWAsYzSzeLBMN
	 dlLzz9IuWrBHWXch9x11IhNIWL2GmbBbLpXzzDBS1sWJ71gSb8JnBk6ziAKIbEv7J
	 +d8F/ucEJqw7W7m0kA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpU1w-1xIUrH427Y-00pKEm; Wed, 29
 Jul 2026 10:25:08 +0200
Message-ID: <1764334d-7f3c-411e-be52-a3ccfd3a23b4@web.de>
Date: Wed, 29 Jul 2026 10:24:32 +0200
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
Subject: Re: [PATCH v2 1/2] soc: fsl: dpio: Use scope-based resource
 management in dpaa2_io_store_create()
To: Dan Carpenter <error27@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <chleroy@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Roy Pledge <Roy.Pledge@nxp.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
 <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
 <6607bb4e-a747-4791-b93f-f82f26e4a334@web.de>
 <amdBqQfIsAjxMsqX@stanley.mountain>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <amdBqQfIsAjxMsqX@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ObDRxJtwkZ4LCGeru0ZHe2PWh988gwAImJx6FDvaZeyIpkHBVlN
 0rncOg+3yDoHxhq7akW6NyexpOo9KTtreY7YOLx2eWYinc8pyHb0enTZx3s87Hkb4ol/a58
 7K3yTlkV8I3wYE27nRTj75Xb2T00fc6BBQcBVMwuANm9Z7aUaS9VcgqtHqEH2XJJ+WFsM9o
 mCEUQisuiGebCWJV9wmGA==
UI-OutboundReport: notjunk:1;M01:P0:tqFxq9AEN4k=;xe3j96KpqLKEXRXIVblYxIZOhLz
 Fsws9o6YXIBtzdTRrM4+fMJDNUiPY6xZ64TSy5stIdI3BPttCM9IcSmBskXdljvbnnd8OBX8t
 WOrrP817IhzrvBa3EV6IzTWEmRv72vmyv8ubS08Dndb7rt6XU0eodL+mxqZ4LI4kleWzE/Qgf
 Mstls5Rrtd2XK24PQIU1LAHXER2upYu6yojthhaWMaHaa2fOU48Vzw2cHz0HEH3293ebRfv5v
 KL5OoiL9W2ldf8a5YAezxGF9VVwPQ4Pcv6s+be0OYPf81ycN5LanX972VSNiCiqRkRAUAPAtk
 uUgVbQsaeHbWr3jQDHW8JB0yPBDyE5W3RL0z1wviGY6l15W/JbJQ+6y9kctV4EB7edbLoe+jU
 ferVVDw7sbuR5IiT5AQ5cD7XFN8iBjwz6uCvbcAEcOqXK5ECGmwvA47AVRSeft107eiplXgBb
 ZVWi6NvIPJY/ngnY5gW80rot+/TKpUK7Pa+NdXTyrlq9/TzrEsFvdaaRpEY7uxT5kSDXzrICO
 tFibxXfbQcvyJwzZE6NlgUETaOk354PdVlnL0GWG64deKaKy5QveLk2yLFU8c6tsqzAknQvI5
 FoM6hCbsWGEAyUrhoGqJu5IHxtQ7pLBtKLP7SV0rfIoHinG6dSLwzZToRX5luWS7x9zAi3pJa
 m+dPOM5YdjcKvvgr27Dksi3zExLeRjoAJ3t8QTL+EVuQ378YDr/JPJ/QZ40xQ46TEcLlfZ+tN
 6BxQHZLL75zUCmBH6BZBA6AABRckHrESwW14aQ4v78aAWQ3cisKLaaOhol3W5FBkab8/9bHPq
 cmQIz5QEWIV1y7UjULmyi+R5KpvDSLJyIZBnmzBeE5dUTRMrAKfustNkw827jTZ5cgpUEFV/F
 /mJ8HOaSKEMfOBCqxq3yVHRmeofJ50pQd7ySurzYgyFAj/bMbA4NqYIn6atigJhZmQkwQI1dq
 9e7WZTUA4Pls36boiWCztsQWHpW9yI78HGWe5qKuBRrIByQKvF6qtF8tt8et7TjVyougRNwIz
 2LOkymLkFk5h4n8X0H8PQPlo6XFyKEQpJdia1nIEbOTWgcxChytTxetTaXidrL3X1QCkADY4z
 laxXVN8vbWl3J6ln5cB8fMlTkJckxy+MjkwL/0FtbLDwQ3oHoNMb+H/pXKwKtp2Dc1Z/iqDRb
 uFaLZ/7VYR2ucD/XThiZNruY3AL+aWAdW5qx7tCiyZ+4w8cQm+CjRM0awn+oQj3cz5/MP7tPV
 p6rGrBX8+IQsQnlUXyTt52MIe7R17m6YWOhodIm1SlsVdsItoCfGwek6bu5zlNN3cmW7U0ift
 2QrCdSd/dgPoZPPUMzoAZwmvDajsYs5BCZVO5ZxnQtYKwxZyQd74XIarVCFH2Io5clmdnpfbH
 mvB8ZSbd4LuN7a5Ty7nS+6urx8voO08L8/7v+9HRpANf77WueiosICvwUYDZNvzNMZnQTWPAF
 mVHx3kKT+I5rwW2vsTqmpkBs+JlRnWpt9zjxSPuVXSc1XK7Gw4XSM2hGYG9kMgNEDSdCAVn1b
 MQxVN+bB84FNIKBO5SENhz3dDadoZOoEVkytNgxTRKojmWVB32mZGYKP91qO2WWvAlOLj4PRJ
 g5Sl0s7KHkdu3WDrmUqoApSd29n5Jr+SeuX/hZMnT/AlH/j/2Ir4rk33TlGMrVSVPoR518GZu
 m7os01Pr/ruqrtPsoAGXLctkQGo+vT3ejhW7HI7Akxz0N7VzAN6X+dTHGnsMqyOU9E4cqV1bd
 SMeVr70prg6AQAjc8zR4PdNSAJAh6Q3AS14jPceanAY9EMzQUUpim/nuqXVI3LoixWDcQh0B4
 ywfsB7/m9FqDnCzfzjHH+vV/Yv0zIvLzANKh3MDFhtTxFsSyb6YX1wmoCEXOYQaqqX1DAVdGf
 c0pNvbJMCxghcjK45w0CYZZKYv5LTLq0H5O3C8t6ob06XqMgiZmf1jnCahaKjJKWrbZvxIPF2
 TRsfbLu7sGyY6B73Y/fOk2xCZ7Igl37VfoaxVT2VdebAbF4i1OoXVCVi/z5hKzcGfoKydHV9R
 Kxd2kD/rbiG7Ku2YlGjvkxhWRUBVlFzEPzlVIfW9cTDdinvV4bg2GUqLIwDV0DQmSAaNzRYeG
 vp9aV0jtrdDZzKDij0AwrgvlZeZw4A0IYWfCuHzMhxDK3zdRSMyiDnVIYIakLFiC5n+BAe7sq
 59sVbnK9CsDZs5h8LHl2Q+rucj8gyt8f5SOZlUvXWkDTKaIYM9M7BNhkRS4OYlgyeSVVN+sBt
 WT/FTQwnJSZJZHEICs3CvE3aBR06xvJYfjmI4kXU40eb8Le3NH2gNk+xF5fPKl0x5sfDdo4/K
 DWee7Y+9Nh5wICG41S7YA2xXEwX0ySooACByqxeG1/Wu5Sq6T5iCKqGRacNtitjsUs0xF6n+6
 275O0v5pdsz7R8hDsyT6WkGfSwdQc3YBnLyxaxmZaa2HYs/cElzbu3Dq2MDXcx0GE3hGnApd4
 xqf5BegGfw4K6mjjoKfFuC0c2y3i8GJ+aJASpZ/0iVb8Jm0k/VcNJmosPOR0L0rq5Nm9iEETD
 S4s+xN7w9XWlXNV/2cr3/BKJ3nEWdVS9/d1d5n32EidivRdDe0VtPoU6DIO2qjRbgac4xzyF5
 XakY3IbXzNWwow81zlj8YqlMHRZyCaHoezyrgXGeqzGT+E0owHF0cejiiIbW8rGsdal0tcsev
 pvmyxy5k6Kzy2MULKH0f/eLe+1J4ku5hL7nzhEcLgeOmnwBlAK8n7pmAHX08kdlaW/129iKp+
 M75rIItm4s3zOkcaj2DqeiZq1/65+FeKdexoYdBrinxzha+LUXucqhF0eLDiBMfEcQtCvBA17
 oCeJWFOVxc7TJvwBE+9kzIMO5mXsrfSeDNlJdmiH5khY1fq6WAupifRHGKrpBv+jF60VU8ZGI
 wFuZg8f1FhGYFd5r7ZzCYgeSmh4kddBwjpg1qpTLzW6ZCCVFKKC8Ksspcvgf2Tg8gNpKr3/JV
 vSz2MA5uYIcjB/I7lpixO4S5+NG3psys+MKBiA6Ljlr2uY7zLSHEeQVdlTxRkMvVGkMK6tuA5
 IlL06SkLPLSfTsacDecfnW4hNQRkkcBpNveeh8KXkGl3wuZxLFZXcSynMvluvN0EQsEbi3tfI
 AZ+Ac57XF3VCBbOghrLvO9ToO8GFSrpoWfLksnucUijRkZHLHZ5isqUTiLd82nOMpPx8UobuG
 pXmM0b54XWE74OdMK5BGeWmvvpjXjAKQZ8iZkeSgjwPk9+ZbyxFdFc2o2dZaZXR25wim4bpSY
 lCJuCcGAzs5SW2ZdveycNP3k205u03YycaN8JVZEySs1eCa/8UfxEhCkBxdcY1NR67a58GpUS
 IqHsRrTTspcE8s9KcklCLJB8cNFFraMXzi7wyelbApwjLUGxSreqLHpsuF62lIxso6YHDMMua
 ZOYZ+zBxdSL+vV8qR1lplL3yt0/x0z7f1oocEuh42r4U2oXE9nBqkcOnQSpviq5mthlQolUfl
 R/xVuRfRqGB3IZbeIHfrOJqRNPsx6FJ4+1lM3WfCTwSBflyRwjlgjeFU61K1+KcCrcwxvE4s4
 OnefhFgvIuWs0QGId7BNQbeCAAtThybesKtzF6l5yZ2FruRzasWZHQ38xjh1jbnctbLANRxBM
 o04NzUqxOuIUpKje0GnSWqE5vPKLK1Lcsv/nH1mq65uwL+hYLYcTVm8NhT/VdS+oXkIiV7PKC
 WUS4xCN6Y/9bifMEf5m9Ao5B0g+pEabULFo8rivWdIRYg6Bdax1cS5Wt/e02jztDEtjvHSMZg
 ppa+7W5Ye0OvMk7l7IqvV3RzLBuHR6kLNPsFtQBsPEHXl+RWAk2kRqbVD3FbBys+3iSmP6yyG
 YlTYIIKreBNZFND0W5KSoFW+S9AaOukEpBHTVkDtX7GeplPsA/Yyyo8SB4R6+hyRrKo6/wrLg
 BGntsAcYaMHEROwMXNtR2LzTju9SFL3R8FaQgpsdGFg2k6q/kKOtsicS0zm3w33VLwjLAYSBB
 V9P8ng1N8Ud/fTRlK0s8rNSUXu2kw4NE3RHgL06TOgfJ4nQsfxfQ9aFQrW/CMezh5ISrXONgJ
 bhkOHcaJlGw8KObR1RsMDdpUVnqe/3Ve/Cn/zIXvXYsW49xoNIYyGWdTBbF4rtGSjZPVU9XqR
 MbAbPc/4uIYMbuVMKFCbY6dT9huOcWBWnLdaTDnqjFke96t4EYktDZmHX+/74Ah4lP9RbuHVx
 U1WH6L0hqmRhtDsj+rJdZFWnCbIpsMxiglOYo5FylXBghbZyZ0QnX7e3kBmWxh3bFQbxZktvm
 T3n+H98paK/U891eTPCVxg9C+mwuaG+4M65SyaYYd1dE+QTj2Qr53Sme1mfWwTZpzDUHTjziB
 McUYabdeIcRNyshpn0voDEcTmWM9UL9abuU+9MYgSTLzktbNEFLDIIC1a3RKt44Bb9CfT96tE
 1Kiwr4YC2iO65cjdgLbBYCvO96tsEoa7vURlWm6qqWu2pT2RkB2gihiBQOEAVrpbdSy0L+mVF
 OWi5XOV8fE918utqgjervEvIPEzKTeohm5DbVZ1teDQoDdMXJ4S67tNnkhQZUaUT7YJT/Pj8n
 9RDKOacvFsk2ZLRG+L2BbvLd8mFFGzKCoNlLbeLF0PwfF8Trfu7NXU9fykHOo7nJPob3OYM79
 9tp8qGrOCc0aQirS0tHNiYrsZ0efGU6rpKmF3UtTfdLfh/hI1Ix99c46bT6zwneGA8pv/GpZS
 hEp9uHZ+wlcOnHLbw6ULnmoU6HxP4NmvjmfBLvSiHV2XNdkAXZH3jUYLxocbGQ6q2OYFMVszb
 B6Y6EFSsgkOvmo1oLP9RSYdl45hNAMNJGZnGo449ThTOeXmUyUj45Ef15co0Xa2jhQBZMdbGe
 UK6nTSdlCt5N4WNSvXfuUK5ynpelK4hTJshWl9C7kaAE0MoskURm3HdxGOXTAPpmIXZ33f67U
 u8rgMTuDKzDyU5Fjn1VuQoIKYUCIZbWb39mnf2dkKHxceO8l1/YanDs6Eeq3x3z+7ZwrANT/P
 ud+1oX6pZ//OE66lboRsEe3pRvRDBFQJGa6KedI9xz6R3MT6T0uVRSKRNkLWgiGEkRU7dUIp9
 WhJ8P+Jam6LGErWgPO3mftBGQSrqHo2SegNOews6hP5N1QGl178OWzHGx/sd4d2u2R4olgqaG
 L05p6Foysgu+iJNJWTscYzTJahDIm6dIFnGmRL93r58cUW/rjOZRywjdszamVI78T8Wxbozj+
 ZC3PPlMNvvaZV7fsHEvXIM8pkWDgP5Nk+LoBYvTbSZxFnpnusQLKtmVppu5V2C0ICabfE3Pye
 EEyhZZhfHHNPM28t2LuZQ5jE2feiOeylheWcQRbSF6XR4ypFm0ybPxNe2GQQOj8FrYaTwDNOw
 aULym2/svrAv6DYeMqhqcR8tYXzNLTS1iAtrnGn5pqbX88YgmIQLbVvQ8KqVn9UBcjw9e//xw
 0q6/LwEfnzPUVSfp/K2p/6ICxOcmaQ2NULviNeKlHaiCbhg/JVrfVtVCTyIL5GlBa3Gygwwhf
 o05saxQOcv5ixHpdJzA87hQcUmowhTnarpjl+wGz9whQHvEUe62TiKveSaVNOFRwH29qyEExv
 DQ+IET4wc3rQQ7SKIh/vc9js7kj8/IsLA+41s/bKjqPTKH9EysmtGrIjR/yXTHSJjMstoMgZy
 GAQD4Cz6gNklhP2h3YqeOk3AlBcrYQDPNDMkN1DyVaW0/t+kpQktLBUJC/p+5CdYNxPWYVtRV
 2Y3Zo1iftkRiUheNo7XvRPH0cPeHU+

=E2=80=A6
>> +++ b/drivers/soc/fsl/dpio/dpio-service.c
=E2=80=A6
>> -	size =3D max_frames * sizeof(struct dpaa2_dq) + 64;
>> -	ret->alloced_addr =3D kzalloc(size, GFP_KERNEL);
>> -	if (!ret->alloced_addr) {
>> -		kfree(ret);
>> +	ret->alloced_addr =3D kzalloc(max_frames * sizeof(struct dpaa2_dq) + =
64, GFP_KERNEL);
>> +	if (!ret->alloced_addr)
>>  		return NULL;
>=20
> Why convert the ret allocation but not the ret->alloced_addr allocation?
I suggest to reconsider the suggested influence of the attribute =E2=80=9C=
__free(kfree)=E2=80=9D
once more also according to data structure members.

Regards,
Markus

