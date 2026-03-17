Return-Path: <linuxppc-dev+bounces-18314-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAED4FD8763
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:10:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZskz2rB5z2ynW;
	Wed, 18 Mar 2026 00:10:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::132"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773739823;
	cv=none; b=n/Bca3N+BJEkSIllM1tbuHC/OiQqLtRpUJu2SV71oyrZ4MXU9LoqLjEkU63PxL9h/huDPyiqT7voIXW2/I37uXmgoVirY+659UWOQgZCSqxvw3QLa/rio5v43k9QhDgDhgo3NgKmy/B+XwSKiLGN1GzIA5b4JPlBxh8CHhYNkhWV1q7po/CTfkIIQL7B9Y4CeQZNi6N9Eacp1ADs4wHBe3HUzyH1l3sWUjvXlfHubYDzvcIT1EK5zwwGCf4eM5F1yLJffrpz2+fUDqr5G5aP2369UobH66/GjNm0v4QEypv5J4R4BWHDO5ylyrrCfHIhoR1ueZODLsJtLeJ66j7JwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773739823; c=relaxed/relaxed;
	bh=x1Y0fq+nOdX5B9Zlv9rWb/FlWGr7tCSJEoVxQK36Zz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMf9rYCln1tT2XH75DSxmEslZPOcr9abtc8IP+b+vTH+82wvdpfAWVSZXZmDxcXcbJqJ1b6AEufT8bkegWfabkeRiGlN8K/YrfUAvK2Q5RsBSN++8ss9wvx70c5RbeZ1aIYsFxryloCYvF0hI8AUv9l0fLcYfIvbBUz0gaehS6i685yMDvokPiux7NT+JAVYj3qf1cczXnF4Ce0+5c3aSzGlXblmsmTTCbX2zGEveSlmmJjGRAlbizpUXFzQVz50BHd+BO3edYPese3U5zFiCDM8h4jjfrdcS1ITbJlkYdANdgMTNSOaOdm/84zgh8L5V7NBfXxABEvx2cmhBK7U+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=r6TBO9pV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::132; helo=mail-lf1-x132.google.com; envelope-from=mikko.rapeli@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=r6TBO9pV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::132; helo=mail-lf1-x132.google.com; envelope-from=mikko.rapeli@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZms953k2z2yfP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 20:30:21 +1100 (AEDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5a1307438ddso5457869e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773739818; x=1774344618; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1Y0fq+nOdX5B9Zlv9rWb/FlWGr7tCSJEoVxQK36Zz4=;
        b=r6TBO9pViLC5kHReICZamE2t8m7DNWGdfqi/Y37vqIMeBEo6TEj7/HP7jocOuuwMiG
         iEMOgYyxPeFi2qrBiITHfL3hryej/wzYH90GNrmI5MG/eGjXXewWCjUQvQQsunvvjCkv
         GD+Z0/rbP7eoI6hN+SEiptvp7na+9Hi/fMqk9JCHoBRfIzbVBof8sw5boTzAk0sXWcKM
         UE1NViETNwHOfK2bYO/c8GXMwCkMCR/HP8Ag+JSoiRIFVxN45kGBmrM9K1QOtddUEIsv
         C0P+VRZc3o4ltvBcN8kwc3MKiLXPgrXdtFYX9MlfSbLAim6ixZlYWSuIgW3V7AwPGxUx
         LM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773739818; x=1774344618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1Y0fq+nOdX5B9Zlv9rWb/FlWGr7tCSJEoVxQK36Zz4=;
        b=TzL0WSFMkZ4CnSko2ilxduqTW3lZ0nPCGMr8tQJp7EyIvDMFn8qGL7i39tzTf+cdDd
         o+O6o6WZ/S0+dtgSufP/3W5p5t1u8lFw37AT1i0giZCJJqxOs4ajT+WPvrHsIRuJqgHl
         l8x19EyAcZGSQEx6SBMvZlYaWsHWLqhX7wKtI36jzWHFWluqvg9PV8qoMw86P6zxl3MC
         Cr4Wl5n8CkMo04ozEGXn8mQXk0e4yExova/XJWbjNcNh3QsuqmTcJxHoZbsTaw47VpXN
         nvz4A06s4oKczhUtyJHDN2TXFfToqJejmQOocnCEwUOw5n5tkqQWfu5YixeXMehMFUgl
         q6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSceAjJqhKb9LVSNYMeuBbA8QQURd4k/YA0OPR9tX2UwNSlfnSzRDM87OknuTADLKF1o7NI8ey+TF9Uz0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxBjSZcdprd9sZVujCs016gseBo3C0xPtg44gMf6BPn+Or6OuhF
	zo7QwbmXh9s0gXIa9QWNmbMaR5VmBXaV/oTltUFu4kVTjMN/ep2X8wLMJ+aHkF4/rWk=
X-Gm-Gg: ATEYQzzgSjnYE9sXqHYY6NKljZFHOl5fgkXzGdEGo5lhpE/JKUtiW9ZaiHKfXXtl7gb
	Zh7m2Kqt680A6WhRnYlUP+L4KgqNqdRgx9eVVGQip3cgthJjqV7cpDDD4WTpLSlDsXXdgDoXyUo
	CTJy3YkmdtLRbp4du1lM/VX0YoCTrw1WZJY5MovXvz7o+Sy25Jrru+Q/Re9zXKdCa63U9Pa0Ar6
	E8ceBYTZjIW8tPtgLbDaRp1K3sCg7362oOJuHjEEHVRNczcVlG24LHbICs5qk3eBHfC7/VYHasf
	0wyTQMLC97VgJoHPacOKL/jMGFNhO3vsYYZe4LBqTqqDr5uiF9QaQjJx3VDoZLVupaFfSMWF7kq
	+o8FpAKSpNogcJwau4cpweLZ3hjSHhR2rSViNcj0jEF0XKI/F0sq3eiBqPZdon/AUDXbITfzAq3
	/Q67Vb6KTRtpE73C51PU7d0ID0J5lCphdyNj9NDmfUbZKScbth2EmZzHDc
X-Received: by 2002:a05:6512:31d6:b0:5a1:3e11:2963 with SMTP id 2adb3069b0e04-5a162b13fe6mr5199056e87.39.1773739817876;
        Tue, 17 Mar 2026 02:30:17 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15602e713sm3977671e87.32.2026.03.17.02.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 02:30:17 -0700 (PDT)
Date: Tue, 17 Mar 2026 11:30:14 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: "Vincent Mailhol (Arm)" <mailhol@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
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
Subject: Re: [PATCH 1/9] scripts: kconfig: merge_config.sh: use POSIX '=' in
 test
Message-ID: <abkfJsyQSbW-VjxD@nuoska>
References: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org>
 <20260317-arm_defconf_cleanup-v1-1-8eecb7fdd24d@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317-arm_defconf_cleanup-v1-1-8eecb7fdd24d@kernel.org>

Hi,

On Tue, Mar 17, 2026 at 10:13:37AM +0100, Vincent Mailhol (Arm) wrote:
> merge_config.sh yields this warning:
> 
>   ./scripts/kconfig/merge_config.sh: 384: [: false: unexpected operator
> 
> This happens because the script runs under /bin/sh but compares
> strings using the '==' operator, which is a bash extension. The POSIX
> test command only specifies '=' for string equality.
> 
> Replace '==' with the POSIX-compatible '=' so the script works when
> run with /bin/sh as intended.
> 
> Fixes: dfc97e1c5da5 ("scripts: kconfig: merge_config.sh: use awk in checks too")
> Signed-off-by: Vincent Mailhol (Arm) <mailhol@kernel.org>

This fix is already merged in kbuild trees:

https://lore.kernel.org/linux-kbuild/20260309121505.40454-1-o451686892@gmail.com/
https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git/log/?h=kbuild-fixes-for-next

Cheers,

-Mikko

> ---
>  scripts/kconfig/merge_config.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
> index 735e1de450c6..073c6bec5245 100755
> --- a/scripts/kconfig/merge_config.sh
> +++ b/scripts/kconfig/merge_config.sh
> @@ -381,7 +381,7 @@ END {
>  	STRICT_MODE_VIOLATED=true
>  fi
>  
> -if [ "$STRICT" == "true" ] && [ "$STRICT_MODE_VIOLATED" == "true" ]; then
> +if [ "$STRICT" = "true" ] && [ "$STRICT_MODE_VIOLATED" = "true" ]; then
>  	echo "Requested and effective config differ"
>  	exit 1
>  fi
> 
> -- 
> 2.43.0
> 

