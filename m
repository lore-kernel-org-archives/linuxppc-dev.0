Return-Path: <linuxppc-dev+bounces-19238-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3E3D6AB16
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 21:51:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmwXV35byz2xSX;
	Fri, 03 Apr 2026 08:51:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775166666;
	cv=none; b=Orxpqu/Ig70aLr+jdj7F6bOSN03acEBpr4FqPknDKUQct8XOGOPDwKYgZ1td+KPc+HcWOMkD/i14HD14FOhl+b7r+ONNm5momGXoq0ijy4ugYfNDheuFRaM7xt8yOwa1Sl8flvV1muHvu5KLap3OB5Uf/WyjdYxOUShHjyM9n9bKSbER7+HK4VKcUCN4gtTzYEbhw+i6k59fiHurh9U4vvmjAvP4VY94QMIPEbruZcY5jkoxyrgFK1W1luYFL4k6AeddC2fNgbBhm/+IaE+TJEUY/0Evo3suDw+ct6wZwiKWXQDYsv90RYKx34FRhpPByVMjDoQZqH4gHLPq84zJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775166666; c=relaxed/relaxed;
	bh=tTFw5Jtg7uZ8zWwAcI3IYYHcQiQxS0VORKzkvmn3+m0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SWGyf3OHkeaFnQ4lZOndq9KA2/I+934zC343o/+Izt/05JVu6cl3C9bIJybgh1dmpDcBpWvY8xku+7j3Ah1uZe1/jIgBbLxgRhQTNhb4M/+27+AmJ0MmyKODvWnjhjWQo0qsi9bcjY2JFbB6K48oS1lERsPwAmm74qziFxPplp8ZQsZUvKnsdP5DvI0CQPj4x1W8yH5RjzTegd2/bmtm+khvVIq00UzQuiKBILz7iHX9GJ9Vws4pr3NZ4mtDms79tgVjFIR+zPxaGPkC2HtC/jxNe+BSeLSmE5i62sulW9QkF3WhIEW1bDpSzQXtLNUtThlE3huJvV9T1Ct0boovJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uh7N/3FR; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pjw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uh7N/3FR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=pjw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmwXT01WPz2xS3;
	Fri, 03 Apr 2026 08:51:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B02160121;
	Thu,  2 Apr 2026 21:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CFAC116C6;
	Thu,  2 Apr 2026 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775166660;
	bh=+iWo8G+lGLAR0AEWKadkwlt32LjzfIOHKPITuBCakWs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=uh7N/3FRUjqua+aPCo/hGr/AdrmusEl1H/a3Cy2K3ax/7zWAaowq7QLQao9luVbWo
	 hhp+ELOy56vNZgWo/30UXJ+R+KNwAUX+g9t5upzBm19UO38qCmclRomH9W9JilFn3g
	 1M3od6tckFksVcXsO4otmEq7oBs2ncVax1WS/48Gk7Y/jRGn5aI6Ty0S32Qrtb3v+N
	 FCfqxPCfuHXXK+tb8kOeAkmUobWREiK7V0IqzM0OnWy9oCVbOYxajs4XGYlWHY2x7t
	 AkBA5ON0TiTxqW6AtiPnUW+DWm5PHRBPUIiBBcwzXpeViYkdJ68cXcODxvoTFEl/DM
	 YZIYLd1IONOQA==
Date: Thu, 2 Apr 2026 15:50:54 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: "Vincent Mailhol (Arm)" <mailhol@kernel.org>
cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
    Mikko Rapeli <mikko.rapeli@linaro.org>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
    Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
    Andreas Kemnade <andreas@kemnade.info>, 
    Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
    Tony Lindgren <tony@atomide.com>, Huacai Chen <chenhuacai@kernel.org>, 
    WANG Xuerui <kernel@xen0n.name>, 
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
    Clark Williams <clrkwllms@kernel.org>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Pablo Neira Ayuso <pablo@netfilter.org>, 
    Krzysztof Kozlowski <krzk@kernel.org>, 
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
    =?ISO-8859-15?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    Helge Deller <deller@gmx.de>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
    =?ISO-8859-15?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>, 
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
    Anna Schumaker <anna.schumaker@oracle.com>, 
    Alexandre Gonzalo <alexandre.gonzalo@arm.com>, 
    linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-omap@vger.kernel.org, loongarch@lists.linux.dev, 
    linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
    linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
    linux-sh@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
    linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
    linux-renesas-soc@vger.kernel.org, linux-parisc@vger.kernel.org, 
    openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/9] configs: remove orphan dependencies of
 NETFILTER_XTABLES_LEGACY
In-Reply-To: <20260317-arm_defconf_cleanup-v1-2-8eecb7fdd24d@kernel.org>
Message-ID: <576cec38-a5e4-5391-2a57-b164e84a813f@kernel.org>
References: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org> <20260317-arm_defconf_cleanup-v1-2-8eecb7fdd24d@kernel.org>
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
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Mar 2026, Vincent Mailhol (Arm) wrote:

> Since its introduction in commit 9fce66583f06 ("netfilter: Exclude
> LEGACY TABLES on PREEMPT_RT."), the configurations below all depend,
> either directly or indirectly, on CONFIG_NETFILTER_XTABLES_LEGACY:
> 
>   - CONFIG_NETFILTER_XT_TARGET_CHECKSUM
>   - CONFIG_IP_NF_FILTER
>   - CONFIG_IP_NF_TARGET_REJECT
>   - CONFIG_IP_NF_NAT
>   - CONFIG_IP_NF_TARGET_MASQUERADE
>   - CONFIG_IP_NF_MANGLE
>   - CONFIG_IP6_NF_FILTER
>   - CONFIG_IP6_NF_TARGET_REJECT
>   - CONFIG_IP6_NF_MANGLE
>   - CONFIG_IP6_NF_NAT
>   - CONFIG_IP6_NF_TARGET_MASQUERADE
> 
> This new dependency caused many symbols to become orphaned, meaning
> their dependencies are no longer satisfied and Kconfig drops them from
> the final configuration.
> 
> Note that CONFIG_NFT_COMPAT is another parent dependency, so the
> above-listed symbols would not become orphaned as long as NFT_COMPAT
> is present.
> 
> Considering that these are legacy options and that nobody complained
> in recent kernel releases when these options were already missing, it
> is safe to assume they can be removed.
> 
> Suppress all these configuration symbols in all the defconfig files
> that have neither CONFIG_NETFILTER_XTABLES_LEGACY nor
> CONFIG_NFT_COMPAT set.
> 
> FYI, the suppressions were done using:
> 
>   git grep -z -L -E '^CONFIG_(NETFILTER_XTABLES_LEGACY|NFT_COMPAT)=(y|m)$' -- 'arch/*/configs/*defconfig' |\
>     xargs -0 sed -i -E '/^CONFIG_(NETFILTER_XT_TARGET_CHECKSUM|IP_NF_FILTER|IP_NF_TARGET_REJECT|IP_NF_NAT|IP_NF_TARGET_MASQUERADE|IP_NF_MANGLE|IP6_NF_FILTER|IP6_NF_TARGET_REJECT|IP6_NF_MANGLE|IP6_NF_NAT|IP6_NF_TARGET_MASQUERADE)=(y|m)$/d'
> 
> Fixes: 9fce66583f06 ("netfilter: Exclude LEGACY TABLES on PREEMPT_RT.")
> Signed-off-by: Vincent Mailhol (Arm) <mailhol@kernel.org>

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paul

