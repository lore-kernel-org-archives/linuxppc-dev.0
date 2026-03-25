Return-Path: <linuxppc-dev+bounces-18768-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86F9103A9A7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 11:27:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgl4p3fyPz2xcB;
	Wed, 25 Mar 2026 22:27:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774438058;
	cv=none; b=bzR3bpFYdZ2SU9f+4Wh5fyWVCBT5QJX5GmZ4cgGN32JH1BzRWQ/R6PEhyYjlRZbSE8/HzTPoWeiI5lRA7QwUapZff0/kVOihGv9hXKMWPQbDJiSPeAtydZ0UK2z6xvFRgJDcj5/vSX1zoRDjbUDMBC23fpfHDuKwZv2I+Va7xw1ua2ZzqTSnHtZJTAf0vgpjKQBvsT6YUR/4IP1LrrahuCj0ntLSyxGI1MQ3iXqhXg33+hzBU83BPYFUE8a/BH839g9A1vfbiKlcCk0Tr/h5cck05aSKCsYsFIXnfgjZVL4eGOPf1WXiPROGOuNAvGE1o8+Q0DJ2HMCbO8benymj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774438058; c=relaxed/relaxed;
	bh=UGWkhSBr5lAj1RpNvv7z9bND82PmguLSQqb9D4vTGCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqmWi8+npH/Qffn708VkjYhGxc/dmd4dBA9UAkiglx3zrnbT3JYhC7JGqlk4VoTXIWYkOkZahZpP3vv9NaP/HAN3MXRsmguVoqGw8ZIRB87gWPJ4AJ+k3HWCG5GgY3WW3BwKAKDCkvZD6YESZrwrBSbG6Vk1LEKudJJNsG9S8mhMAWoeleiT5RUVmCqTmZoT8EZgeW22eA7jVtNBNXOfSP9SIWyqmdSeqaKDRO8s5L32Xo4kFIHLwem7pue7YeffkGaSDlPoW7K8nEbmXvfvrAKyeo4JWTnJ3/6+cpMkGlRW7BkFyWtkArMyxAryuBRI4evWS4Mg22RbWPrJEk0dkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Gek2NIF+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Gek2NIF+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgl4n5Gs4z2xPL;
	Wed, 25 Mar 2026 22:27:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2C80143B22;
	Wed, 25 Mar 2026 11:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE08C4CEF7;
	Wed, 25 Mar 2026 11:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774438055;
	bh=aD1JvDIfq0GE0tWPZnEpoteUQl9LKVoUeLp+4KiP+wI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gek2NIF+50ZmqIFXo3Abwewv4G7+nnsW9VSMv0MJSvCqE0QYQCxE0tBmFgJRBRECp
	 Gcc7YZXcn6ZVjnnOFNPWxF9MXqXyhFMV2/rtAU9seEjQdh1t6qZiZ0is2C0JPXPhBn
	 2cYzSNQ+wv0QUFUGa/aTz2gJSJZJA4ed1dMrx9K6NARl0UOWe3qrF1pRaeGcjSPDkw
	 D4ktPFXCkzERe/9x5RNai4KmjZT+sqqQPICvXI7s+TI3/NID3cRU0cs8f4vrDqo6yN
	 THmNV9Nu9oWReHHUKBYPcvAflG6BahJmiGo3mGEaRVmOB4tsJAqcsgQbvaJ4aWQ8Xg
	 08DYkx/Hy2gVA==
Message-ID: <3ec53a2e-a8e1-43d3-abdb-c00433e7675c@kernel.org>
Date: Wed, 25 Mar 2026 12:27:13 +0100
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
Subject: Re: [PATCH 5/9] arm: configs: remove obsolete assignments to
 SND_SOC_ROCKCHIP
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
 Anna Schumaker <anna.schumaker@oracle.com>, soc@lists.linux.dev
References: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org>
 <20260317-arm_defconf_cleanup-v1-5-8eecb7fdd24d@kernel.org>
 <febd0f7e-59f3-4ba4-8706-53c7353e3fe5@kernel.org>
From: "Vincent Mailhol (Arm)" <mailhol@kernel.org>
Content-Language: en-US
In-Reply-To: <febd0f7e-59f3-4ba4-8706-53c7353e3fe5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+CC: soc@lists.linux.dev

On 3/17/26 12:28, Krzysztof Kozlowski wrote:
> On 17/03/2026 10:13, Vincent Mailhol (Arm) wrote:
>> CONFIG_SND_SOC_ROCKCHIP was removed in commit cae3cc435db5 ("ASoC:
>> rockchip: Standardize ASoC menu"). However it is still referenced in
>> some defconfigs.
>>
>> Remove any references to CONFIG_SND_SOC_ROCKCHIP.
>>
>> FYI, the suppressions were done using:
>>
>>   git ls-files -z 'arch/*/configs/*defconfig' |\
>>     xargs -0 sed -i -E '/^CONFIG_SND_SOC_ROCKCHIP/d'
>>
>> Fixes: cae3cc435db5 ("ASoC: rockchip: Standardize ASoC menu")
>> Signed-off-by: Vincent Mailhol (Arm) <mailhol@kernel.org>
>> ---
>>  arch/arm/configs/multi_v7_defconfig | 1 -
>>  arch/arm64/configs/defconfig        | 1 -
> 
> This was already posted:
> https://lore.kernel.org/all/20260313-rockchip-snd-cleanup-v1-1-77d9a953fd1b@schnwalter.eu/
> but just like that patch you did not send it to soc@ (if I am not
> mistaken... CC list is enormous).

OK, I will add soc@lists.linux.dev to the recipient list in v2.

> I think you are mixing here independent works, like kconfig and per-arch
> defconfig changes. Please split these per arch defconfig maintainers -
> patches and patchset, so you won't be Cc-ing 50 addresses.

The config issues which I am addressing are transversal problems so I
was expecting to just get the Acked-by from the other architecture and
have all this go through the same tree.

As I explained in my cover letter, this is not doing any functional changes.

But if this is not acceptable, I will just reduce the scope to arm/arm64
then. Doing a per arch split as you suggested would be too much overhead
(more than what I am ready to invest on this clean-up).


Yours sincerely,
Vincent Mailhol


