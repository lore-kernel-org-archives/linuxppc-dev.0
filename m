Return-Path: <linuxppc-dev+bounces-18333-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB1DFF6E8B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 22:25:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fb6365Xp1z2ygK;
	Wed, 18 Mar 2026 09:25:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773761615;
	cv=none; b=jHTP6eU/sZ9zHSMPuYhGexXzF/cW9ZHwG2EaswozF8QhFAFSf+3QXnmAvlg5cHazcgLSvn02KW/8eq6EAFBOjI9aVu37gMVicbz8Z4UmBTJjCcl9LDcW51ene6CwbjdzQ7PuNbRGTeAJqReEc3UO34EKOm7+g4Lo+lFNsSDzg/E6K06a3geHSSCTgXu4AV1ZPjkSKm/TIPg63KEhc8ogVHsmWHnXkvI83oLqjFkF3SabvEi/bQ6OQ+EQOJbxgDrvfyeEG3CiAebhcRQXei1KbfhotPDVE4WyD/exZzrugwmJFiRPrMIFr+p+DhzOzv4vOFr5bq67yBW//4YUElWGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773761615; c=relaxed/relaxed;
	bh=rawTxtgvvbkzzbH2UV4s1WHUqEhvtXowvJ2A1NK5Dfo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=KI4EpFoSkIwgYdcMOLSNNkRtouL+zUO71cmWk9CRcNKPQbxNvpYgXQBGQHAUUctk5EXEoysbaknSVdJT2Oq6vyC7fcaV+J0KLnVt2HfBNiHlRWLbm0O/MrQoAqlGk2EyuiFG6/6sCo+h/SzTLQQbwf3cSqP5RUIQsjqSJisjdySNLoq25qdQzPyc8bOMbtrRc5I5TFgBeqj8AcEBgEe1bnbEV9AdO0jE2o+apIP3uxwGQsqB11NDMrdSlAbNmXU14OgwYHceHElkfQAP9eKeeCu4qdiHqgAyUnR5uE0oL+QHhJ6HWnm0NaBjWuXKiUXIYEByn2qNdFtIi0zC3ZzS6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AoIs2DBU; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=theo.lebrun@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AoIs2DBU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=theo.lebrun@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 552 seconds by postgrey-1.37 at boromir; Wed, 18 Mar 2026 02:33:34 AEDT
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZwwG72NQz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 02:33:34 +1100 (AEDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8D1ECC5505A;
	Tue, 17 Mar 2026 15:24:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6C52B60050;
	Tue, 17 Mar 2026 15:24:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4159410450618;
	Tue, 17 Mar 2026 16:23:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773761051; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rawTxtgvvbkzzbH2UV4s1WHUqEhvtXowvJ2A1NK5Dfo=;
	b=AoIs2DBUSiP3+bDh8ceDZ5pucIsCr73r049SuZ/HJKLAXGmyad7NTpfKNSaNVk51NUvTIH
	BgPqPlr1rDNIoyNmYsJc8ISuC3ycIUVQBissA6PEINJzL6N8BH0o8JqMgWYQdBCgi49zvl
	Rl36ZnNiln6rG+QQTga+S6KU/OOWAfvfLuGWL19TZHwCliPsRxvb67701TK9QVVKGnTpoa
	j3Xvy3JqNEig/PiitIwS73AwutDLx9LIw9v/asnkWmeV/tuNISa5PJ8YUSBzapnrkc2NV+
	NRS8gndZVMreSkSC8PDnKgeiyjCRU66WdvwKgyQf+/ugl+MnQb1DhlIwJ0DqHw==
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 16:23:45 +0100
Message-Id: <DH55T20W6ZID.1O0R8EFW6R5G3@bootlin.com>
Cc: "Alexandre Gonzalo" <alexandre.gonzalo@arm.com>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-alpha@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-omap@vger.kernel.org>, <loongarch@lists.linux.dev>,
 <linux-mips@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
 <linux-samsung-soc@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-renesas-soc@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
 <openbmc@lists.ozlabs.org>
To: "Vincent Mailhol (Arm)" <mailhol@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>, "Mikko Rapeli"
 <mikko.rapeli@linaro.org>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Matt Turner" <mattst88@gmail.com>, "Magnus
 Lindholm" <linmag7@gmail.com>, "Russell King" <linux@armlinux.org.uk>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>, "Andreas Kemnade"
 <andreas@kemnade.info>, "Kevin Hilman" <khilman@baylibre.com>, "Roger
 Quadros" <rogerq@kernel.org>, "Tony Lindgren" <tony@atomide.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven Schnelle"
 <svens@linux.ibm.com>, "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, "John Paul Adrian Glaubitz"
 <glaubitz@physik.fu-berlin.de>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Clark Williams" <clrkwllms@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Pablo Neira Ayuso" <pablo@netfilter.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Vladimir
 Zapolskiy" <vz@mleia.com>, "Piotr Wojtaszczyk"
 <piotr.wojtaszczyk@timesys.com>, "Liviu Dudau" <liviu.dudau@arm.com>,
 "Sudeep Holla" <sudeep.holla@kernel.org>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Magnus Damm" <magnus.damm@gmail.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Helge Deller" <deller@gmx.de>,
 "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, "Chris
 Zankel" <chris@zankel.net>, "Max Filippov" <jcmvbkbc@gmail.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Arnd Bergmann" <arnd@arndb.de>, "Heiko
 Stuebner" <heiko@sntech.de>, "Kuninori Morimoto"
 <kuninori.morimoto.gx@renesas.com>, "Mark Brown" <broonie@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Sricharan Ramabadhran" <quic_srichara@quicinc.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Guenter
 Roeck" <linux@roeck-us.net>, "Srinivas Kandagatla"
 <srinivas.kandagatla@oss.qualcomm.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Anna Schumaker"
 <anna.schumaker@oracle.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 3/9] configs: remove obsolete assignments to
 CONFIG_NFS_V4_1
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org>
 <20260317-arm_defconf_cleanup-v1-3-8eecb7fdd24d@kernel.org>
In-Reply-To: <20260317-arm_defconf_cleanup-v1-3-8eecb7fdd24d@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Vincent,

On Tue Mar 17, 2026 at 10:13 AM CET, Vincent Mailhol (Arm) wrote:
> CONFIG_NFS_V4_1 was revomed in commit 7537db24806f ("NFS: Merge
> CONFIG_NFS_V4_1 with CONFIG_NFS_V4"). However, some defconfigs are
> still referring the old configuration.

typo: revomed -> removed
otherwise, thanks:

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


