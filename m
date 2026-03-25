Return-Path: <linuxppc-dev+bounces-18771-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11AF103A9AD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 11:32:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fglBB2Qp6z2xlf;
	Wed, 25 Mar 2026 22:32:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774438338;
	cv=none; b=kK7xOqyqgiY+LCht+kpzkTpmZoe/RZ2tMpE5oQDlFsnYF/FP1EE/n4gZjDsHN70r9MRmpoxrT09oPX+KXA3clkMwDe4ebBKEPF3CgJsvab4LA0FSB/mK4f3fYXsOLwxxmaHD0TSBvFZ0E32XdVkCT8JVlqQnAA9j8qZjRNZ6OXzNCetIv/pDDo/W1ael87ZPt9fSWUO6XPN0EYNpglOeP0Dbk+2Ru2P0JPXBzDRQRUNxgTT+hLj6rkf/DSGBzOEnI4tD7RK+JNtdPhXG5Rk6llxZn2sIzgwvBTbrNvp4wd7iKJ+YrOETkgzJHOUNXFZ6tbSqRQNdvAsDV2tkIEEEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774438338; c=relaxed/relaxed;
	bh=HJIAg2huSXRf7/aVoaKjQ30vr6b0oAfPNY6cnw0ajmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llentt/TZ0cPZGQzqYnbZqQz1Vu8Yeptf5eiq0XmlgdlSnmy7cU3Rc64jOnWy3LG+TcBhPPhORJ/B8qPnwmhkC+IitN0r9YXIyf0FnmgAcurVy5wsmnNqsbTV5unKZqdXc8NLw1bJ4wWmNkAodJ4MR0go6f/DhVdZGBRDY2a5v8rVd1RX6gEJKgsi+my7/y39wxD2cY5px0SL+Y2OFmcxVM/ewjreIrkD+Q2NdZeRegl+JAI1fm28sCvRu0y4XLJGk7MpA3286lI6VuhEnw4i9m9wlp1L2D30tFjNoYVVCa+0MKGZF05ZARLf1RpQTd1RI6CbKxDrWfaH6gG7qT7+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p9xj+yQr; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p9xj+yQr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fglB93f6hz2xcB;
	Wed, 25 Mar 2026 22:32:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4272160127;
	Wed, 25 Mar 2026 11:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35258C2BC9E;
	Wed, 25 Mar 2026 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774438335;
	bh=UHl6aIxvtuzZoFfPKn0m6HqE+Ix+jQLwOiO6mcxm7gc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p9xj+yQrGXkpoAF0fY9H5IaPcoHqI+j6qFDwyvc4yO1C747biO/reuY8t3d94mmup
	 yQMdUZgPvj2v9edGgjvwa44Pe6FwmdZ43t/G8cYYldfmo7YsAt7eQsYUOQchWN8tEp
	 lxT4aSMwTa3Lg9zV/TmzInC2IVkU8yAXXMuWflmPLvFoKuR5BI2SX5CUo5rJVYT1a9
	 QJSXMoguTPIulqY0xz7WbsLHtpKTLSiyneymYrRj8U6WWUrJxGfwFv6fjWC6LeaTQu
	 meTzpjdQXm6htU8OLApZ7jlovVUK4NVBzdOcUYZm4Uly3jpcZL4fYc0zooZuxOTQqt
	 7cnUszMPYt6sQ==
Message-ID: <d7ba53bd-e484-4ea1-b90b-e44321eef4c3@kernel.org>
Date: Wed, 25 Mar 2026 12:31:51 +0100
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
Subject: Re: [PATCH 9/9] arm64: defconfig: remove obsolete assignment to
 SLIM_QCOM_CTRL
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
 <20260317-arm_defconf_cleanup-v1-9-8eecb7fdd24d@kernel.org>
 <9545b66c-f223-48a3-96fe-c906d2307654@kernel.org>
From: "Vincent Mailhol (Arm)" <mailhol@kernel.org>
Content-Language: en-US
In-Reply-To: <9545b66c-f223-48a3-96fe-c906d2307654@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 12:35, Krzysztof Kozlowski wrote:
> On 17/03/2026 10:13, Vincent Mailhol (Arm) wrote:
>> The Qcom Slimbus controller driver is not in the kernel tree
>> anymore. Clean-up the leftover reference to CONFIG_SLIM_QCOM_CTRL
>> which was left in the defconfig.
>>
>> Fixes: 7cbba32a2d62 ("slimbus: qcom: remove unused qcom controller driver")
>> Signed-off-by: Vincent Mailhol (Arm) <mailhol@kernel.org>
>> ---
>>  arch/arm64/configs/defconfig | 1 -
>>  1 file changed, 1 deletion(-)
> 
> https://lore.kernel.org/all/20251223140645.3545658-1-mikko.rapeli@linaro.org/

I will add that this was initially reported by Mikko.

> I even asked there to send it to qcom maintainers :/
> 
> Exactly that case also encouraged me to document this, since we do not
> know how to fix get_maintainers. See commit
> 6efe5322f060099c8bc51aaee83b857394e42dd5
I read the thread in which you posted that patch. Thanks for updating
the documentation, but as people anticipated, as long as the tool
doesn't do the right thing, there will be people like me who will mess
up the recipient list.

Anyway, sorry for that.


Yours sincerely,
Vincent Mailhol


