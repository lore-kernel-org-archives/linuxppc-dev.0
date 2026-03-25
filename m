Return-Path: <linuxppc-dev+bounces-18767-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC135FEA808
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 10:33:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgjtk3pWXz2xSX;
	Wed, 25 Mar 2026 21:33:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774434830;
	cv=none; b=GKxjAil9ELetsSfnq2lfPZjr3FzN5M6iZKB+oba25/dZ6swkPqoKEKh5rsOPdRI+NwDW60z1H0x0tDlOwyQSYH9WPd6rlvG/YmuwXDQLuetvc+eF5xedp/LWXz6kjLCDjX89FdRtX0hSbqyhtdEt4amcClL5Xl+qRSrD7QgQLNpHJeAyTcpW2rAz3au/Foq+UHPkP+MA0MCPKSn+eaRzmhH8Vv5CxMk1lJy1gIXbdeiybc0G+bvdjJOHbwnrzAIIJCTl2RNRzgzzJobOgL/ufrUr6ecn1EswjPfyyJInkg+mRBELWPoA8aqTLIryhuFkWTJ+XTCETqEfOUPGQdpa1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774434830; c=relaxed/relaxed;
	bh=Z3/zPSJVjn1VjsxijwbZQufNq0uYPZwl/oR2Ou+Rl9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUmxDQrxRhGUQnqtWHRvRDYisi8HNudbG1CA/l2C/idwIcamYDQL7ljBRzNy0AibUwmkBUqdWyiqe6Kiml2cH/qUtNskVetn0m0f6r/eMtxknci32M/40i8q1vUo/KEh6MY1xmVduoT2lJJiWvmVISt8TluHSmY2R+CcyZX0Kb5b9dHCs1fXdJeCB1x9sQsLcprGbPuvvFGQFUhSlhGsTa6ipU6KPbKv36+SCtoHt+Xg8oHGEcFoIvVjPlE9nhJLfQYNOkW0QGhe8APdWNNL3juNzsEuNYsqLTd8COM+fVfyDRKv9kDeD2ciRklBPhoMB8k1NlNQ0IvuC1TqPpxmBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IQ7wamBu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IQ7wamBu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgjtj3cbbz2xMY;
	Wed, 25 Mar 2026 21:33:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 974C04356F;
	Wed, 25 Mar 2026 10:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D04C4CEF7;
	Wed, 25 Mar 2026 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774434826;
	bh=aJiJufwALZTrMErym90lg9xadYFrtwTh9zLM612wdfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IQ7wamBuBswIV06YMQ512/86FaeSJDO1hVJmHF15aa7lwqSBhYRoh2/xQs7mCuMVn
	 jIZx2QfPrLjG8x4HGTqwuohoFEss2YApWTN6VCPS6cZhs/Cz8meOXIe/nuz3nW3OfQ
	 sW0aKsRm2pkCRj3Tz0xlGVf6Gag2qK2q2BHc6gd5m/lWaXyDpvlRC/a6o2Y0gsRKbw
	 RfK3wED0pdnN0Lx0xk8dNqAWio6aPnfaaxOQ/5BjXGXYBkYeT67KblOmgVEwNZOcNA
	 F7WJV99ADDvaoAhrnEG8aPpXAxBYDzixJeHIYfU0n1hRsq0hJGFAKTXaXIvu5adZgH
	 fldf6DCQY3dFg==
Message-ID: <965fe446-8f91-48bf-9453-878fef4eb1d0@kernel.org>
Date: Wed, 25 Mar 2026 11:33:20 +0100
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
Subject: Re: [PATCH 1/9] scripts: kconfig: merge_config.sh: use POSIX '=' in
 test
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
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
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Frank Li <Frank.Li@nxp.com>,
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
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 Anna Schumaker <anna.schumaker@oracle.com>,
 Alexandre Gonzalo <alexandre.gonzalo@arm.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
 imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
 linux-parisc@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org>
 <20260317-arm_defconf_cleanup-v1-1-8eecb7fdd24d@kernel.org>
 <abkfJsyQSbW-VjxD@nuoska>
From: "Vincent Mailhol (Arm)" <mailhol@kernel.org>
Content-Language: en-US
In-Reply-To: <abkfJsyQSbW-VjxD@nuoska>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 10:30, Mikko Rapeli wrote:
> Hi,
> 
> On Tue, Mar 17, 2026 at 10:13:37AM +0100, Vincent Mailhol (Arm) wrote:
>> merge_config.sh yields this warning:
>>
>>   ./scripts/kconfig/merge_config.sh: 384: [: false: unexpected operator
>>
>> This happens because the script runs under /bin/sh but compares
>> strings using the '==' operator, which is a bash extension. The POSIX
>> test command only specifies '=' for string equality.
>>
>> Replace '==' with the POSIX-compatible '=' so the script works when
>> run with /bin/sh as intended.
>>
>> Fixes: dfc97e1c5da5 ("scripts: kconfig: merge_config.sh: use awk in checks too")
>> Signed-off-by: Vincent Mailhol (Arm) <mailhol@kernel.org>
> 
> This fix is already merged in kbuild trees:
> 
> https://lore.kernel.org/linux-kbuild/20260309121505.40454-1-o451686892@gmail.com/
> https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git/log/?h=kbuild-fixes-for-next

Noted! I actually started to write this before the other solution was
posted, but, anyway, this will be removed in v2.


Yours sincerely,
Vincent Mailhol


