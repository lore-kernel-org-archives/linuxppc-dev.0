Return-Path: <linuxppc-dev+bounces-18770-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DA0103A9AF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 11:31:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgl9S5NWMz2xcB;
	Wed, 25 Mar 2026 22:31:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774438300;
	cv=none; b=Xei6DvLbTc7udKVgVLLFtNO6t3a8Z11TWlxlKwPIlpF9LXAZI9H4Rt74rZp4EWF7/xuPq49PDlb5rxfN7niYy3vkW2nlaCEE1ylOadjW6tu5rDduSxo5ssFAKL7dHNRT85C3pxfGE1tzg8ywyR4FCj+mZBOFH2oj/j7RWXs5kuBJLLO0LziYO+UziqIAA8xVuHmM7bWPOky8Yf9OoSdwv96Q5UVwRMc+5xu/nCkH8KlHVPLRgBx0tNVTE+rGiQ1PhQnghSwDH55piuVCMeUH/BKqJEWU1yXM2kERYW693fgg7lN5LzlgIAMThbOpoAbYnv1avbs9gixI4S4lyUJ5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774438300; c=relaxed/relaxed;
	bh=9EGI1scmAKm+pprVXxtWWutGI9fPw/DG3S6e9WMIiRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNe4nmfGAVzthfNHVxNglaP3U4fPSAT0s93V4Kw6j1g/JW++iwAWqCIQ3p8tWme08U20mr3dRhyKVvAyvrxaVfi3+U+FwGJT2dVCZtmxPkG9LraDeAaLDgO+psz4XhhdR/xgYs+tzAI4k8dloNnTzrJkhsLLPMkN+XU942jUTO+atmFXJsKMPoIJDaz2ieUvykpJ0CXb11aZkexU//5Ju2s448Z/BArKHapHkZBQAQePKV+BlfAR/4f+uqjTjB2NXhpaBmARQXVDBOMnLgOUlisRStYG7X5y/hTIwAgaBmVV+lXdUsdtr8Be1FdSbwnpml8r8OR4eBPwJfJhOXRXEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q7AMjbL5; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q7AMjbL5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgl9R4MSTz2xSX;
	Wed, 25 Mar 2026 22:31:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 098F560120;
	Wed, 25 Mar 2026 11:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89274C4CEF7;
	Wed, 25 Mar 2026 11:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774438296;
	bh=ylRm2gYh1SSNTms1TdIe/v1LeEn6b9whQkZPd++l0EY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q7AMjbL5W0jOhmMe9L0gOLKFEqzai/JPUxmdE2mOpoQ36iaMfFZZLITyNzxhZlevK
	 rA0SbrRURTtaztJltjjMS5YPxpAJmm/omGpFo3nDqFaJ37FJP4x4MIc5TH6RDrtCZ6
	 +nUxPxPDn0Uc4uffmUPwMTzhwm8enjtoGEKl4XHmKc0Zq0dwCdpLgIqp7d6DrOZ7NL
	 VvSnhuHBd0UkpP4vcl2ZxbmbBm0pA8yz1q/sjOs91mTiMNwSVhPHygkMwdAX3hVzTE
	 a6rHjx1MiPC03K9uIW/rbqvMgTfTHiljj5xIVSJAw2Sm/y0jE0atJzrh4/qaZiCMEw
	 TCsVxjvF/0UXQ==
Message-ID: <efec4a41-3889-44f9-adbb-c74fddd63ae8@kernel.org>
Date: Wed, 25 Mar 2026 12:31:15 +0100
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
Subject: Re: [PATCH 8/9] arm64: defconfig: remove obsolete assignment to
 SENSORS_SA67MCU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexandre Gonzalo <alexandre.gonzalo@arm.com>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org, linux-parisc@vger.kernel.org,
 openbmc@lists.ozlabs.org, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, Mikko Rapeli <mikko.rapeli@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Stuebner <heiko@sntech.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anna Schumaker <anna.schumaker@oracle.com>
References: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org>
 <20260317-arm_defconf_cleanup-v1-8-8eecb7fdd24d@kernel.org>
 <fa1e4d72-50e2-49d4-a458-1e3d300cce4f@kernel.org>
From: "Vincent Mailhol (Arm)" <mailhol@kernel.org>
Content-Language: en-US
In-Reply-To: <fa1e4d72-50e2-49d4-a458-1e3d300cce4f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 12:33, Krzysztof Kozlowski wrote:
> On 17/03/2026 10:13, Vincent Mailhol (Arm) wrote:
>> The Kontron SMARC-sAM67 board management controller is not in the
>> kernel tree anymore. Clean-up the leftover reference to
>> CONFIG_SENSORS_SA67MCU which was left in the defconfig.
>>
>> Fixes: e710b2283725 ("Revert "hwmon: add SMARC-sAM67 support"")
>> Signed-off-by: Vincent Mailhol (Arm) <mailhol@kernel.org>
>> ---
>>  arch/arm64/configs/defconfig | 1 -
>>  1 file changed, 1 deletion(-)
> 
> https://lore.kernel.org/all/20260302122540.1377444-3-mwalle@kernel.org/

Meanwhile, that patch was picked. It has already landed in linux-next.
So I will remove it from my series.

> It is said to see that multiple people did the same work twice and did
> work which was not sent to right addresses. :(


Yours sincerely,
Vincent Mailhol


