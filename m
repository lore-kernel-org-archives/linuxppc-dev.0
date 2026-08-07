Return-Path: <linuxppc-dev+bounces-25544-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625E8C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 06:34:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGZBQ5KMPz3bps;
	Fri, 07 Aug 2026 16:34:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786084478;
	cv=none; b=lZjkQ7W0I5tiUTUwEHeaySI7JNjX7IoiCKXFPirQMubK6A4DN3G+DnUuW6aXNDXA2baF/Lyff60JsoteQrrZQbwWqORuHKAZov71cJ6wAYBuSaoAEjfht3qpyienxM5zgDKB6PF7UZKYImA8uYdqUls4trnYlzna1HcHs+878hCWTdyHVtenmjowQdr1UjxtTmQU3oOAUhQIbAC7puVa7nUDi+XoLWVN/jEZWnHdCTenSUDznfbJq93iAxvhaFlSgExN4SG0M9gSfyvqgzMdURnDSU8/GmUYMd0LwKtRDuiy/0jj5+DbaPYvDFHi6leBVV7oJMWPnK1jQbD0M9NKng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786084478; c=relaxed/relaxed;
	bh=l8xVvU2F/fFUSSpqRZVrd3WQpwZlkQIJEg0DhUYBh/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARdKZqWRXOwrSB3jhpmcUWj8hZsrnMznQ2b8FrhhYgXQ4tzoUh7z3iPMczgriPhqNC+/2bWNnCl4fKqEU8reExrrcww6aJmxjIeAamW5VBSqI7cqUGCZF9+ZT435ofUQR1IrvapX8DjpD550xgs46tITIFBjJ3qbUWeyATVROlkbQPcoos+DhxKyILzs/RpwDTbmWLgL6ZS3q9HcNiPvgHQdtK7lhXgesjLl5uBigGLjh0+OPI65pJFClgMOWEk/m0ZGR2S7LWxRfBiYtozQGsmYZT1GL0LcY+lRiGq5U/CT1zmTIC7nm21EXEkWvDlmgqPgid1uqDL3NMn9bxYg4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=QP9ZUTzS; dkim-atps=neutral; spf=pass (client-ip=212.227.17.11; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=QP9ZUTzS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.17.11; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGZBL1wkYz306N
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 16:34:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786084411; x=1786689211; i=markus.elfring@web.de;
	bh=l8xVvU2F/fFUSSpqRZVrd3WQpwZlkQIJEg0DhUYBh/o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QP9ZUTzSxbdWcX/FMZWWnAgKd53KsdXOKzEMngTw3BxKwolo786Zsc3ANczc/9AV
	 7rscfect2zFMVrSYQ4QtrsmxfyFV0k9J8BblesceVaX88LrqyepX1pgGxGlF+ihIc
	 8uzymRoxzxoNQcvYzIZ9MpVoPwrbU8ID59WrWbXGlQ7omD1ECBJ3UdUHO0dgI2NOZ
	 42NagQOd7/R2TeFstj4MMVp5v0eD8Tvnq3pdzQ28TT1JAvm1st3OpRq/ALvRxaUAU
	 qooBMYW5uN11BHNZBMgdsvZyF+P9vyOK0IANpe1zrl6tnf/XrNPS8Pw40lSYsMsqe
	 cVsuINAl/XaweGfwNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1xEJPG3iXQ-00kazQ; Fri, 07
 Aug 2026 08:33:31 +0200
Message-ID: <c27214da-4e76-4b5d-ab86-ab03beba8f6f@web.de>
Date: Fri, 7 Aug 2026 08:33:08 +0200
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
Subject: Re: tools: Use fputc() calls in some functions
To: lkp@intel.com, acpica-devel@lists.linux.dev, bpf@vger.kernel.org,
 coresight@lists.linaro.org, kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, virtualization@lists.linux.dev,
 Adrian Hunter <adrian.hunter@intel.com>, Alex Mastro <amastro@fb.com>,
 Alex Williamson <alex@shazbot.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Ankur Arora <ankur.a.arora@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <48f2d61f-d468-49b7-881e-f00777db073f@web.de>
 <202608070547.MRKfa3bH-lkp@intel.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202608070547.MRKfa3bH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:heSIkINqyeiTt9/TVU/2HaIToPYra83aIuf0AvbOJOpmzGssabi
 2pB+Q4N00ikWy96JtYbAI4l92VxDK1eIhjSpkmWDfXgFHRUQ7AnWMM14fXBeSUbUtrPT8vY
 ocQ8Oavw5OBRE5CCpreC0Xu8PbI7O1BHO5Y74x3WyR2UhRH9v5EgfFH9wSGPOPrV+FzK6Z/
 XIXRX7oHnEmzadhHoTc1g==
UI-OutboundReport: notjunk:1;M01:P0:faf1dCpquYU=;+6tK6j/uCs8jhR5JHZVE/TXw00j
 iZl5oiCQHx85oMHmPJAFXOiyUlameMce0cu7hnsBUCGKxDTMBwq31o4Rd/VwJ8FNDvFe3sXU2
 aALP1GkZ+xRoPzqC2charSoR2DGA/czOChuhCn5h9kOUQlmX1taeXcDabX0GCOl0BSrZJ05g2
 auGhF2m/1hiNDLFBC2bTsAZskJoXwDyzJ9Zi40kYINqKYBWqjmSWZXJry+1qoMqkCHv4/2gl0
 krKQ4Ot6WKVfo0dnk9AstPb8yW/mKJXrLJiGGgiqt1etDVCwQsv1k02GAXgTlVgcDV8eErbXD
 KOHSR2RCFlLLHRflAhOafF0muYf1hpDe6HTlhuzMTPlxhZ9DTnVweOVQDA0e/LeaypYQlMPqe
 E9dKl+CYaO3YekS6+paBkejwykVdhJviDbzoGs0YLDMz5SlxLM0tLbWbZZluM+z5hQTPYqTTD
 EphqJouleuXKKN9nGuvEe3QowlVikSHghmisnhzo+qDnn3aySeZgjXcRYNgd5OtHamh3MYe7I
 XiwwJZc8XPeki5IanzAIk1BfmodTHcey8t610A/SNEILgKVc709cfQOb7nY1utS23KnxNjZ1w
 Pky/xHDqlV8rLRHO2vVCuZO8Kqitcv1iJ2xOUzw7LcjrUz9tv2S2gadMdLGRyQl1oadc1z6EQ
 GmZxRDrY8g/6qQD1ZJpbKsgBYlSpN8uSgzljj/AzHA+gV4YVJ3H+YidPpcbpRQqRpP16zwMAC
 97i++AjVahQ5DVDDJiu1XcAbd0t+jnRuISHfvqpbo+FqoOvpPvNqHwf4hO5hkPH8og3ECbavP
 KcJHBiTh+LwqzgQAHikWHUODS00NGtWzAOwww1X3FphT2xVTwJM7AdJjfkAEvZQL6HVUeHfl9
 xw4OrIEOTafCY8FDhCOFqU1QcqJWx0UmZQC6SSXQzhu8io9+egQc0ub11TAoFUhjxWP9MobW+
 oZSzyEyZvkAJ2kr9eGB5I28VJrdZTaMdQnx9B+dVGrrx49qL5QS2umuWY1AU+4GSTMuh1YWOo
 q+bcok7KMDDQZJssnJyJGRx9LFsmS+X8c2144vRcBGfDDX/MLKoyBI09o0ZH6gwJlauwP8mqz
 qvUyLX7Z30T9BpdSoBbQ4I3mjibybFSfxemkjR0E5fPKWIXkR2YRn08K6jCxDY8zas6LTidf5
 Z0gi4DZT1JcyXGcMf+SEppR5tDQrxUWKKxmeKUhlAgB3VOzePoX4K9KmP0cn0FFLqC3o/38/P
 yfFlJgIu6oLF8BDhMkKgo2YgMmuDVGBBgQNXjmHK0aXmME5IK3mfRccatmSBeLvbT4XSPz+7D
 c6GDQs/m9k4gaul2P+sON6ZVd0sISFcKogcp4Ge+t33kOy4e6MHDnu2LykcRUcVAMneiC4ImK
 F1Bpv7tmg5FsXRV9RTiguOL+3iyywzj3Dw+yEKl1q3LznnfGDjZ1VMz+nZVZNE8JrWK22Ig45
 4p5fcL3cB9rTDM2L5TzmEZYtl7MQmxFPH7f290cuYbNKvviJ/okUJuE7AabWcdVPHHkrx6RkQ
 mlR5X4x4PBCv0D1aEesPFBox0X7maZixhf3e2SgOndHrIXm8M3mM7Rljwp6T9C+hkUb0L1OQl
 UHgEkmiA1a3B+Xr35H+XijKOCSdKTsQugDXtW6/5cR8v3tPjB1rYlLlrOYYNArcPrC03DDsf+
 JOkyssqSKXiLOC+GcTiESuhKwJqQOCCYrmwIljUODRQGO6rcf3yOpv0iX5/AoFadWTe4atmyP
 t3gcP5CMSAJ+WGNRqnzhFDMijuEEbnKvXGHWKeMLUDOXllxiayyYPwCd27iUxCO8NfgESwMyl
 VN8FuWg/83zqvuxP4NVz1sLLQpb0dowxJqV93X/9pUfkE47RUuozScCxEbTrqmZ3x1fCtXOxG
 BZKaBizpmqKDfpMyGhNv8ZRNuEvfFbFBZI1nF0MrFpn3bVhdIT4uCY1MWDL+qUhFkK67oLuGm
 +RwPdQcR9aOfEknJmAi87u+REiXRzrvmGpQbylsxlKjmAa3V3MXvyIE/qILN1ymq2nnCk2ldA
 +FL7OYDHLrA4EnIUp8V0KOEaRgdy0X4QsbPFEjMciDLaqylkNwXbZXH9sey4lGElGD34GOm25
 C0TtGMfuje09er74L0NteA504JtagFKf7BwR0jSYjU1xQcZLhWsVixfhNnOsx8vpYNRJw1w9E
 LJD0KCroTY9TJAkkKcdDxplvQTP+N05WXwW4wuMtqHQdgxW4sVF21AKSME75lnn3ZqSaqP+n+
 e7W7FiwInz0Q5mOfH8YXkcpn3Nn+/CDRS5fufoqtsFaHWZhhNtatDptJtDpoGkWQKZXACf1az
 nfbS82gbxKU1NVdcHRYEvf/Zao90aQs+x3oUDE71dXmuf9byPHrjHcCP7FiK/6o6biAb9Mzut
 /CzwuAFrvYmIE+jq4CsvbuFU4d6yGyr8poNA9iTXxRxtFrXNEiLB5Vh8517zv9WAgpp5bobWq
 EoiycY7DPpv8EGNGIjP2Eg7tzVWWExozk5gDK7Sg03RflHCuJ6wpbnyy1CBaCgUkgNepbu9yx
 9TkY4PwdERrAkicJnjdV4vuVgdHaNnebI9HRHORtcLByFq7SVkYYIKdioa/e1Y3/l/KQeoijH
 Qq8I/fGGJ8EKk4tlmI2M52khm3B4KWdB+TLvEtfJTjhyhO/K+De5F9T5HToROVmNW3DQoJXev
 aoGjQ9JF7ahqKTIJqAm6ua+vG4wFkVVyNF32hRyskyZO876cZdtTrTJ/oIhoLcbogfU0OaUmP
 IMbKO7x6UvRwHXymGSUhsAr62RhDmpMeo2MFlxPefdBA1q2WUyCExE+jb7DjCldfTaUxiuzzL
 OpX5P/8r7ishVu7v6NSuAj+eouyopUUffQHPVXZVdkPM/4WS1C4UgflGdrpXXoz0degruWJuK
 c1IFPhKVmz2Y+h+EZHXiqZyj1ppFQGNTzoNBEOMhIYo1c9LRi3nHYdVvOr3gOBhNRkaTZxBaq
 xlZVnW4GAuIYjFihBi6ESxlFavIICNHCW20WanDcyiApIPvjGbYtIUVAZnAwjZEekF3+o7YCd
 H6wTQeJpQZBmR6d7Ou7bMNh/Jz54qicJbEGwhg2Muyu/l8SAZ1BeianOsaqXS5CQEaEk8xfuX
 XUP+573Hp8hWzlyI88FH2B0ib75tpCho2tt9ZF9YSfDL+DSBXFAi+lbFzFkvnDExoi1rK1pwY
 rxhdRyauNvgV+FoRenHwVl7AnzJneJlfpKxruvA78zEb1kP9kJuFb3Kidt8yxNAXQ670wk/7v
 EyYMZpX0/RR/clH8y59emxreKmAlnLF/p6u9Qa4772Hef/C4cpnf7tjIPk6q0tPTs7uEDXTAq
 i+0BpvVTFhPkRRSPRdbpCFXNYVq/uSEo5M7vbKtWBVzccH5ZbDeyZDo8Lh8vfnJS0mLIsK+22
 Lwx8fAkA3vceSpkW1/UDEzqpbEuyJqBFPwubRTwJ+UV4HiPMAG38A1b5g113652twDnVWeYKK
 E4yOqQ3iedFzZe/AbunLZgufYe3w44Ds9VyoqU+2RH/59C5AQ6b3tvx7IQwrx8i2F9kRF4eTz
 CLVIE7RPhkAyOJ4nXrmZkuoXJvoSA+Xt5hhP8ytKyGhIJ4OKsJLsGxRVc6HapqENST6G4AFGM
 s+jCTbhAGd4D8dSu7pbxtm+1LqcApT8t70U2dWohJ3Uh3OHkxxzgxaa2+M4mn0tW/J4I4ooFP
 0RptvqVMmy+L2h1EKsC08c7aJIfe0azLI9rCxCMFjoxUdqykH/v4FXkKUYGwpw4a/oqBfhLmo
 82aoZxGLgh7zQoK7VLFQq60276s1zLumN+qH9/TEU7PLA0NIbqEwuvnZ47QXxWMEht3ok+/tL
 7VD1JN+hqRF6C/ViqUNl27m0BtgLkYQ8z9u/S4xImn1zpQesqKc9S/2+zBcoee2/H+FHQScmc
 +08xi4+wGwsAClw0mpr4V7qVhkxJPCuqemfoEg62n2HT7Q1vYnWmNok8ew1qNOJH6Lqbba/VJ
 9FYFPdbsRG7C+jTCTpm1w73RWfMfy2hk3Ap4d/Qg3YaOPQfazmXVi/zzC+Vg/abER5sURXAjU
 RdX2RiLk5mcXprygpjTflyDmrrPXYppFqtRW4kpFNEoLfoi6YXy/ifObT+3SPlaRGACnBcPgV
 P2ofASZm5lzHinRgYOugUY7cgJMgNjwj2Bphx4/Xd3DW6r3dVEsPCxp30TADmr1XzQcs18EjI
 3T9ZBbh3yRnzKVV6HGzKQ87hz0OGWrUt8uAcbe1H+NCcNFaOmJySn+IqQLFxZ31X/b/AGvSc0
 qkdFOXAfMxovHTAU+AiZGzG4l3zO5ZnYn8mv+MxmyOGiXs43OE8xcaSUlpH3w8BhAZuT5GH1n
 vcML64CCMQT2pDjHFjZBTRRH4oCuUMtfsFWQyKUOogcKyPZ2w6+skTFlbel7WwONxSVjjckYb
 dj6qPG/TNNUIlbuMtksRDHYeEqKMFsQYYV1SpRor30bgVTlcpoQ8uBt/uLPYOvhNueHwhJQqg
 viU2VHQA9H1Fa5isIoTIFumiYFlNH/PXFzL5dkshJmHA+WmIiKTE/yPDa4JWCFKHsp4K4Zurh
 0ohXljIgXAyg3rDb52yIUbdKoTsBAgIbEew5wX7SJRvG06HvKO4sSspRgCtd/GSaCu9aLWDze
 A8noUZid9sGmKw8k/JSUDlOv2glqGC9iSs898Y+i0enB60CjlLHweAGOBoZoQjErRqjBsD/p9
 3cqbYUIPTj1oTqdieNpx/snQlefcF0t+EN7Y7lDNsDPgieSX++4jct/bAtMfyUhkiQjhtuhKz
 wKBHzlc30xAlzW+H7Fhd3Bzmb0MC7SixxtoOHXjgSkjpyI/uP0uH2LEbRa5qUxWRXA8aOuX2/
 qsNojGxq29yM12/9G5JvlaJ0nbY47vquKwzsRN1dIaA7MAn0ik73E/J25q30XSnv0CDE1IkJP
 N1kLB3usU0oPStfMCDgXvnISJelD9tpttxYXTXiv/e1mn/ypalz1iGYQaDBcA9ynwGUkDn2Bi
 MnHPIjV2pjBO1rQyHys7ADcM3Uzu2flOBl1/SZh/40fpjw5IYZksezgQKpimfh9yLa1mrjrwe
 pu5YS6npiGzrHSES6T54VossZCCyosjB9rTtwTq4qojisJ8K3/axN8tYJ4M8qgEzMfhyPSdaH
 yVdU463E7wEvR9BJeKtDYt1AcSx7+apqXUQrs5MXSL00d//qX3NNzaQvib0d2JCFlFLkJWw2d
 9mGoJgEAZ71IHonSTkbVqHAUCE4rf4/kBZ2PrkYw3i3QsynPKJmAZI9MUzk34d+/NWK7/lKir
 SZvqkfJR//PXeCiWxVYgkn4Ob+yntzBb5dgig2a/KiXXMxzGbDJ1o4TvS22jlCFsT9kMtjUfl
 oldWktNo+By4sv7Ueq3ISsK/Hwczzye9o0pFudKWRDxujvP4nFWGCxIhpeSD5lm6ORhL4Acq6
 UcwqQjKq8fhM3tH4ZDrUemtmg2IeO28K2BUtCip/nl0WzBhnpf4lHw/QnlQsexBG3f0h2rpWJ
 WPAumk/aOSXorYhzA5ueVEGwLfgtvMUWLplkl1XBeKwRnFt3+P9v2BDSqK2hUpdiGK7Gdeswg
 BG66ALb0f5dAYLaU12fmQ5LIDWX5+XD8QVXHXj6p8g7fU3N2mhRPb9uK/Z3yaFWPzgbpJAn2k
 S2hhH7PK9aHdriKmnTuWADSrLZ9WuA0Jh2kx2PxL6IQ5XOUaGH004/d9QW6V7FuWoJYzNy9qx
 teWv8o+Bx6NDpKvUy1bdoSgQiJnKkTVu27MJJ5ZGunkfnB4VpwknNWLpz129UjJiMG4JLGbX5
 tGHvO9T8N+Ul+dKaVt7BPwPKakq33Kd0dPjqxYr+g7RbLgRQUKsu3280pI0RLzNUBt638kHoD
 j16q98Ztjg1hZuQBhUSQkXF+UPhqhPKdCs/2jMfmTOtKihdn3MqmmjrLgat4VzljMwe8Yr7jI
 CPu5coqe/pbtrVRPaSWnitGYOIbBRi39bW6iejEZfYquC22OQCEZ1tpOFZbKZEA4U92dUns01
 gIZ8G8biP+t7ISibcp42FcufxVgise2IaT0DCt9+9icABtKPLRjgFFEwZhuHRkVhBU0NsIDla
 IFJ+FFQ==

=E2=80=A6
> All errors (new ones prefixed by >>):
>=20
>>> builtin-check.c:300:8: error: incompatible pointer to integer conversi=
on passing 'FILE *' (aka 'struct _IO_FILE *') to parameter of type 'int' [=
-Wint-conversion]
>      300 |         fputc(stderr, '\n');
>          |               ^~~~~~
>    /usr/include/stdio.h:155:16: note: expanded from macro 'stderr'
>      155 | #define stderr stderr
>          |                ^~~~~~
>    /usr/include/stdio.h:611:23: note: passing argument to parameter '__c=
' here
>      611 | extern int fputc (int __c, FILE *__stream) __nonnull ((2));
>          |                       ^=E2=80=A6

Would you become interested to take another look at a corrected source cod=
e transformation approach?

Improving output for single characters (with SmPL)?
https://lore.kernel.org/cocci/406093f5-ee7d-4ae9-808b-2b42d4846eab@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2026-07/msg00055.html
https://lkml.org/lkml/2026/7/23/2205

Can similar adjustments become more helpful for further software areas?

Regards,
Markus

